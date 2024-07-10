//! Implementation of the link layer. The link layer sits between the upper
//! transport layer and the lower physical serial device. The link layer is
//! responsible for grouping multiple bytes together to form a *frame*, so that
//! the upper transport layer can perform error recovery at the frame
//! granularity.
//!
//! The link layer prepend a [`PREAMBLE`] byte and append a [`POSTAMBLE`] byte
//! to a group of bytes to form a frame. During receiving, the link layer
//! identifies the beginning of a frame by the [`PREAMBLE`] byte and likewise
//! the ending by the [`POSTAMBLE`] byte.
//!
//! If the payload bytes happen to contain the [`PREAMBLE`] byte or the
//! [`POSTAMBLE`] byte, the offending bytes must be escaped to avoid ambiguity.
//! The escape works by appending a [`ESCAPE`] byte before the offending byte,
//! and then xor the offending byte by the [`XOR_PATTERN`]. Similarly, if the
//! payload bytes contain the [`ESCAPE`] byte, the offending bytes will also be
//! escaped.
//!
//! The following figure shows the frame layout. There are at most 64 payload
//! bytes. In the pathological case where every payload bytes need escape, the
//! number can double to 128 bytes.
//!
//! ```plain
//! |<- 1 byte ->|<- 1~128 bytes ->|<- 1 byte ->|
//! +------------+-----------------+------------+
//! |  PREAMBLE  |  ESCAPED BYTES  |  POSTAMBLE |
//! +------------+-----------------+------------+
//! ```
//!
//! Note that the link layer does *not* perform any error recovery. However,
//! care is taken to handle as gracefully as possible the case where the
//! special bytes get lost.
//!
//! Specifically,
//!
//! - A byte may get lost, get duplicated, or get arbitrary bit flips.
//! - The link layer starts receiving a frame when it identifies a
//!   [`PREAMBLE`] byte and discards all previous bytes.
//! - The link layer stops receiving a frame when either it fills up the
//!   provided buffers or it identifies a [`POSTAMBLE`] byte. When the buffers
//!   are filled up before identifying a [`POSTAMBLE`] byte, the link layer
//!   continues to read from the serial device and discard the freshly read
//!   bytes, until identifying a [`POSTAMBLE`] byte.
//! - The link layer reports the [`Overrun`](LinkError::Overrun) error when
//!   the number of bytes received or sent (after removing escape) surpasses
//!   the maximum payload size 64.
//! - The link layer restarts reading a frame if it sees another [`PREAMBLE`]
//!   byte before getting a [`POSTAMBLE`] byte. This can happen if the
//!   [`POSTAMBLE`] byte is lost and the sender starts to send a new frame.

use super::{
    serial::{Serial, SerialError},
    timer::Timer,
};
use static_assertions::const_assert;

/// Enumeration of possible link layer errors.
pub(crate) enum LinkError<RE, WE> {
    /// Error occurred during serial read.
    SerialReadErr(RE),
    /// Error occurred during serial write.
    SerialWriteErr(WE),
    /// Operation timed out.
    Timeout,
    /// Frame overrun. The incoming or outgoing frame is too large.
    Overrun,
}

/// Implement conversion from [`SerialError`] to [`LinkError`].
impl<RE, WE> From<SerialError<RE, WE>> for LinkError<RE, WE> {
    fn from(se: SerialError<RE, WE>) -> Self {
        match se {
            SerialError::ReadError(e) => LinkError::SerialReadErr(e),
            SerialError::WriteError(e) => LinkError::SerialWriteErr(e),
            SerialError::Timeout => LinkError::Timeout,
        }
    }
}

/// Outcome of reading a byte (after removing escape) from the serial device.
enum ReadByteResult {
    /// Got a data byte, possibly after removing escape.
    Byte(u8),
    /// Got a preamble byte. Should start or restart reading a frame.
    Start,
    /// Got a postamble byte. Should finish reading a frame.
    Finish,
}

/// The maximum number of bytes (after removing escape) that a frame can carry.
pub(crate) const MAX_FRAME_PAYLOAD_SIZE: usize = 64;

/// The byte prepended before each frame's payload.
const PREAMBLE: u8 = 0xaa; // 0b1010_1010

/// The byte appended after each frame's payload.
const POSTAMBLE: u8 = 0xcc; // 0b1100_1100

/// The escape byte.
const ESCAPE: u8 = 0x99; // 0b1001_1001

/// The xor byte pattern to be applied to each byte that need to be escaped.
const XOR_PATTERN: u8 = 0x88; // 0b1000_1000

/// Return whether the given byte needs escape.
const fn need_escape(byte: u8) -> bool {
    byte == PREAMBLE || byte == POSTAMBLE || byte == ESCAPE
}

/// The escape procedure is sound if escaping the bytes that need to be escaped
/// yields bytes that need not to be escaped.
#[allow(dead_code)]
const fn is_escape_sound() -> bool {
    need_escape(PREAMBLE)
        && need_escape(POSTAMBLE)
        && need_escape(ESCAPE)
        && !need_escape(PREAMBLE ^ XOR_PATTERN)
        && !need_escape(POSTAMBLE ^ XOR_PATTERN)
        && !need_escape(ESCAPE ^ XOR_PATTERN)
}
const_assert!(is_escape_sound());

/// The struct representing the link layer.
pub(crate) struct Link<S, T>
where
    S: Serial,
    T: Timer,
{
    serial: S,
    timer: T,
}

impl<S, T> Link<S, T>
where
    S: Serial,
    T: Timer,
{
    /// Create a new link layer instance.
    pub(crate) const fn new(serial: S, timer: T) -> Self {
        Self { serial, timer }
    }

    /// Return a closure to get updated timeout based on elapsed time. When
    /// the returned closure is called, it returns the remaining time until
    /// timeout. The timeout counts from the creation time of the closure.
    fn get_timeout_update_func(
        &mut self,
        timeout_ms: u32,
    ) -> impl Fn(&mut T) -> Result<u32, LinkError<S::ReadError, S::WriteError>>
    where
        T: Timer,
    {
        // Record the closure creation time.
        let create_time = self.timer.get_timestamp_ms();

        move |timer| {
            // Get the time of closure invocation.
            let cur_time = timer.get_timestamp_ms();
            // Calculate time elapsed after closure creation.
            let elapsed_time = cur_time - create_time;
            // Calculate remaining time.
            let remaining_time = timeout_ms.saturating_sub(elapsed_time);

            if remaining_time == 0 {
                Err(LinkError::Timeout)
            } else {
                Ok(remaining_time)
            }
        }
    }

    /// Send a frame composed from multiple byte slices. The byte slices will
    /// be flattened during sending.
    ///
    /// ### Parameters
    /// - `buffers`: Array of byte slices to send.
    ///
    /// ### Returns
    /// - `Ok(())`: Frame sent successfully.
    /// - `Err(LinkError)`: An error occurred.
    pub(crate) fn send_frame(
        &mut self,
        buffers: &[&[u8]],
    ) -> Result<(), LinkError<S::ReadError, S::WriteError>> {
        let mut byte_cnt = 0usize;

        // Send preamble.
        self.serial.write_byte(PREAMBLE)?;

        // Send payload. Flatten the byte slices. Continue until either all
        // bytes in the byte slices are sent or we overrun the maximum frame
        // size.
        for &buffer in buffers {
            for &(mut byte) in buffer {
                // Escape as needed.
                if need_escape(byte) {
                    self.serial.write_byte(ESCAPE)?;
                    byte ^= XOR_PATTERN;
                }
                self.serial.write_byte(byte)?;

                byte_cnt += 1;
                if byte_cnt > MAX_FRAME_PAYLOAD_SIZE {
                    break;
                }
            }

            if byte_cnt > MAX_FRAME_PAYLOAD_SIZE {
                break;
            }
        }

        // Send a postamble. We send one even if the frame is overrun so to
        // better guarantee that the receiver side can terminate early. In the
        // extreme case, we the sender overrun the frame but some payload bytes
        // can get lost. In such case, if we do not send the postamble, the
        // receiver side must wait until a timeout instead of terminate early.
        self.serial.write_byte(POSTAMBLE)?;

        if byte_cnt > MAX_FRAME_PAYLOAD_SIZE {
            Err(LinkError::Overrun)
        } else {
            Ok(())
        }
    }

    /// Read a byte with a timeout and remove escape if necessary.
    ///
    /// ### Parameters
    /// - `timeout_ms`: Timeout in milliseconds.
    ///
    /// ### Returns
    /// - `Ok(ReadByteResult::Byte(byte))`: Byte read successfully.
    /// - `Ok(ReadByteResult::Finish)`: Identified a postamble and no byte was
    ///    read.
    /// - `Ok(ReadByteResult::Restart)`: Identified a preamble and should
    ///    restart reading the frame.
    /// - `Err(LinkError)`: An error occurred.
    fn read_byte_with_timeout_remove_escape(
        &mut self,
        timeout_ms: u32,
    ) -> Result<ReadByteResult, LinkError<S::ReadError, S::WriteError>> {
        let update_timeout = self.get_timeout_update_func(timeout_ms);

        // Read a byte from the serial device. Just use the provided timeout
        // since this is the first read.
        let mut byte = self.serial.read_byte_with_timeout(timeout_ms)?;

        match byte {
            // Got a preamble byte, so we need to restart the frame reading.
            PREAMBLE => return Ok(ReadByteResult::Start),

            // Got a postamble byte, so we have nothing more to read.
            POSTAMBLE => return Ok(ReadByteResult::Finish),

            // Got an escape byte. We fall through for additional processing.
            ESCAPE => {}

            // Got a normal byte. Just return it.
            byte => return Ok(ReadByteResult::Byte(byte)),
        }

        loop {
            // Read the next byte with updated timeout.
            let updated_timeout = update_timeout(&mut self.timer)?;
            byte = self.serial.read_byte_with_timeout(updated_timeout)?;

            match byte {
                // In rare cases the actual escaped byte is lost and we see
                // another escape, loop over again to get the next byte.
                ESCAPE => {}

                // In rare cases the actual escaped byte is lost and we get the
                // final postamble byte. Return that we have nothing more to
                // read.
                POSTAMBLE => return Ok(ReadByteResult::Finish),

                // In extremely rare cases multiple bytes are lost starting
                // from the actual escaped byte to the postamble byte. We now
                // see the preamble byte of the next frame. Restart frame
                // reading.
                PREAMBLE => return Ok(ReadByteResult::Start),

                // In normal cases just remove escape and return the byte.
                byte => {
                    return Ok(ReadByteResult::Byte(byte ^ XOR_PATTERN));
                }
            }
        }
    }

    /// Receive a frame with a timeout. The buffers will be filled up in order.
    /// If the total buffer size is smaller than the received frame payload,
    /// excessive bytes will be discarded. The return value always reflects the
    /// number of bytes received in the frame but not that stored to the
    /// buffers.
    ///
    /// ### Parameters
    /// - `buffers`: Mutable array of byte slices to store the received frame.
    /// - `timeout_ms`: Timeout in milliseconds.
    ///
    /// ### Returns
    /// - `Ok(usize)`: Number of bytes received (after removing escape).
    /// - `Err(LinkError)`: An error occurred.
    pub(crate) fn receive_frame_with_timeout(
        &mut self,
        buffers: &mut [&mut [u8]],
        timeout_ms: u32,
    ) -> Result<usize, LinkError<S::ReadError, S::WriteError>> {
        let update_timeout = self.get_timeout_update_func(timeout_ms);

        // Wait until we see a preamble. Discard all previous bytes.
        loop {
            let updated_timeout = update_timeout(&mut self.timer)?;
            if let ReadByteResult::Start =
                self.read_byte_with_timeout_remove_escape(updated_timeout)?
            {
                break;
            }
        }

        // Keep reading until either we successfully read a frame or timeout.
        loop {
            // Number of bytes received after removing escape.
            let mut byte_cnt = 0;

            // Whether we should restart reading a frame because we see another
            // preamble byte.
            let mut restart = false;

            // Fill the given buffers in order.
            for buffer in buffers.iter_mut() {
                for byte_ref in buffer.iter_mut() {
                    let updated_timeout = update_timeout(&mut self.timer)?;

                    match self.read_byte_with_timeout_remove_escape(updated_timeout)? {
                        // Fill the buffer if we get a data byte.
                        ReadByteResult::Byte(byte) => {
                            *byte_ref = byte;
                            byte_cnt += 1;
                        }
                        // Restart reading if we see another preamble. We will
                        // read the upcoming new frame.
                        ReadByteResult::Start => restart = true,
                        // The frame ends. Return.
                        ReadByteResult::Finish => return Ok(byte_cnt),
                    }

                    if byte_cnt == MAX_FRAME_PAYLOAD_SIZE || restart {
                        break;
                    }
                }

                if byte_cnt == MAX_FRAME_PAYLOAD_SIZE || restart {
                    break;
                }
            }

            // Restart reading if we have seen another preamble.
            if restart {
                continue;
            }

            // If the buffers are filled up but we have not reached the maximum
            // frame size, continue to read bytes but discard them.
            while byte_cnt < MAX_FRAME_PAYLOAD_SIZE {
                let updated_timeout = update_timeout(&mut self.timer)?;

                match self.read_byte_with_timeout_remove_escape(updated_timeout)? {
                    // Discard the read byte but still increment the counter.
                    ReadByteResult::Byte(_) => byte_cnt += 1,
                    // Restart reading if we see another preamble. We will read
                    // the upcoming new frame.
                    ReadByteResult::Start => {
                        restart = true;
                        break;
                    }
                    // The frame ends. Return.
                    ReadByteResult::Finish => return Ok(byte_cnt),
                }
            }

            // Restart reading if we have seen another preamble.
            if restart {
                continue;
            }

            let updated_timeout = update_timeout(&mut self.timer)?;

            // The number of bytes read has reached the maximum frame size. We
            // expect to see only the postamble byte.
            match self.read_byte_with_timeout_remove_escape(updated_timeout)? {
                // Got the postamble. The frame ends. Return.
                ReadByteResult::Finish => return Ok(byte_cnt),
                // Restart reading if we see another preamble. We will read
                // the upcoming new frame. Possibly we lost the expected
                // postamble byte.
                ReadByteResult::Start => continue,
                // Still getting data bytes. Report frame overrun error.
                ReadByteResult::Byte(_) => return Err(LinkError::Overrun),
            }
        }
    }

    /// Return a mutable reference to the timer.
    pub(crate) fn get_timer(&mut self) -> &mut T {
        &mut self.timer
    }
}
