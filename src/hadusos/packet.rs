use crate::{
    link::{self, Link, LinkError},
    serial::Serial,
    timer::Timer,
};

/// Use 4 bits (`0b1010`) to encode zero (`even`).
const EVEN_4BIT_PATTERN: u8 = 0b1010;

/// Use 4 bits (`0b0101`) to encode one (`odd`).
const ODD_4BIT_PATTERN: u8 = 0b0101;

/// Use 8 bits (`0b1010_1010`) to encode zero (`even_even`).
const EVEN_EVEN_8BIT_PATTERN: u8 = (EVEN_4BIT_PATTERN << 4) | EVEN_4BIT_PATTERN;

/// Use 8 bits (`0b1010_0101`) to encode one (`even_odd`).
const EVEN_ODD_8BIT_PATTERN: u8 = (EVEN_4BIT_PATTERN << 4) | ODD_4BIT_PATTERN;

/// Use 8 bits (`0b0101_1010`) to encode two (`odd_even`).
const ODD_EVEN_8BIT_PATTERN: u8 = (ODD_4BIT_PATTERN << 4) | EVEN_4BIT_PATTERN;

/// Use 8 bits (`0b0101_0101`) to encode three (`odd_odd`).
const ODD_ODD_8BIT_PATTERN: u8 = (ODD_4BIT_PATTERN << 4) | ODD_4BIT_PATTERN;

/// The session packet is the unit of transmission at the session layer. A
/// packet is devided into a fixed-length header part and a variable-length
/// content part. The length of the content part can be inferred from the
/// `type` field in the header.
///
/// The following figure shows the generic layout of a packet. See
/// [`PacketContent`] for the specific layout of each packet type.
///
/// ```plain
/// |<- 4 bits ->|<- 4 bits  ->|<- 8 bits ->|<- variable length ->|
/// +------------+-------------+------------+---------------------+
/// |  SEQUENCE  | ACKNOWLEDGE |    TYPE    | ..VARIABLE CONTENT..|
/// +------------+-------------+------------+---------------------+
/// |<--------------  HEADER -------------->|<----- CONTENT ----->|
/// ```
///
/// The packet can detect transmission error. If a packet losses bytes or gains
/// spurious bytes during transmission, or if no more than three bits get
/// flipped, parsing the packet will result in an error
/// ([`PacketError::Clobbered`]).
///
/// The `sequence` field has two variants: `even` and `odd`. A sender
/// alternates the `sequence` between `even` and `odd` when sending data to the
/// receiver. For other non-data packet, the `sequence` is set to `even` as a
/// sanity check.
///
/// The `acknowledge` field conveys the confirmation from a receiver to the
/// sender, which can be either `ack` or `nack`. The receiver replies `ack`
/// when a received packet is well-formed, otherwise `nack`. The replied packet
/// carries the same `sequence` as the previously received data packet.
///
/// The `acknowledge` field is meaningful only when a receiver replies
/// confirmation to the sender. In all other cases the field is set to `ack` as
/// a sanity check.
///
/// The `type` field has four variants, representing four packet types:
/// `send_request`, `send_clearance`, `data`, and `reset`.
///
/// A prospective sender initiates a session by sending a `send_request` packet
/// to the receiver. If the receiver is ready, it will reply with a
/// `send_clearance` packet. This procedure forms a handshake. Additionally,
/// the `send_request` packet conveys the totel length of the data to be sent,
/// so that the receiver can allocate a buffer accordingly.
///
/// After the initial handshake, the sender and receiver then proceed to
/// exchange packets of `data` type. The `data` packets from the sender have
/// non-zero content length, which is the data being sent. In contrast, the
/// `data` packets from the receiver have zero content length, which is used to
/// deliver `ack` or `nack` confirmation. To reduce confusion, we call the
/// `data` packet from the receiver to the sender as acknowledge packet.
///
/// A `data` packet always carries as much data as possible, up to the `data`
/// payload size limit ([`MAX_DATA_PACKET_PAYLOAD_SIZE`]). Since both
/// transmission party know the total data length, they will also share a
/// consensus of the total number of `data` packet.
///
/// The sender terminates a session when it receives `ack` for the last `data`
/// packet from the receiver, upon which the sender sends a `reset` packet.
/// The receiver does not reply to the `reset` packet.
///
/// If a session cannot be established or proceed due to serious transmission
/// errors, either the sender or the receiver may send a `reset` packet to
/// abort the session.
///
/// Since the correctness of the header is critical to the protocol, the
/// header uses 4 bits to encode every 1 bit, so three or less bit flips can be
/// detected. The data content is protected by a crc32 checksum, which can also
/// detect up to three bit flips.
#[must_use]
pub(crate) struct Packet<'a> {
    sequence: Sequence,
    acknowledge: Acknowledge,
    content: PacketContent<'a>,
}

/// The sequence number alternates between even and odd. There is no
/// pipelining in sending. In other words, the maximum number of packet in
/// flight is 1. Thus, it suffices to have two variants.
#[derive(Clone, Copy, PartialEq, Debug)]
pub(crate) enum Sequence {
    Even,
    Odd,
}

impl Sequence {
    /// Alternate between even and odd. This is *not* an in-place update.
    pub(crate) fn toggled(&self) -> Self {
        match self {
            Sequence::Even => Sequence::Odd,
            Sequence::Odd => Sequence::Even,
        }
    }
}

/// Whether or not the previously received data packet is well formed. The
/// receiver informs the sender to either proceed to sending the next packet
/// or to resend the previous packet.
#[derive(Clone, Copy, PartialEq, Debug)]
pub(crate) enum Acknowledge {
    Ack,
    Nack,
}

/// The enumeration of contents of different packet type. See [`Packet`] for an
/// overall description of the session packet.
#[derive(Clone, Copy)]
pub(crate) enum PacketContent<'a> {
    /// The sender wants to start sending data. This is the first packet of the
    /// handshake to establish a session. The figure below shows the content
    /// layout.
    ///
    /// ```plain
    /// |<- 2 bytes ->|<- 2 bytes ->|<-  4 bytes ->|
    /// +-------------+-------------+--------------+
    /// |   DATA LEN  | SESSION NUM |   CHECKSUM   |
    /// +-------------+-------------+--------------+
    /// ```
    ///
    /// `data_len` conveys the length of the data that a sender intends to send
    /// in a session. `session_num` is an arbitrary number identifying the
    /// session being initiated. These two fields are protected by a crc32
    /// checksum during transmission.
    SendRequest { data_len: u16, session_num: u16 },
    /// The receiver is ready to receive data. This is the second packet of the
    /// handshake to establish a session. The figure below shows the content
    /// layout.
    ///
    /// ```plain
    /// |<- 2 bytes ->|<- 4 bytes ->|
    /// +-------------+-------------+
    /// | SESSION NUM |   CHECKSUM  |
    /// +-------------+-------------+
    /// ```
    ///
    /// `session_num` identifies the session being initiated to remove
    /// ambiguity of which session was cleared to establish in case there is
    /// packet loss. The `session_num` field is protected by a crc32 checksum
    /// during transmission.
    SendClearance { session_num: u16 },
    /// The sender wants to deliver data or the receiver wants to `ack` or
    /// `nack` the previously received data packet.
    ///
    /// The data packet transmitted by the receiver contains no content. To
    /// avoid confusion, such packet will be called acknowledge packet.
    ///
    /// The data packet transmitted by the sender has the following layout.
    ///
    /// ```plain
    /// |<- 1~58 bytes ->|<- 4 bytes ->|
    /// +----------------+-------------+
    /// |      DATA      |   CHECKSUM  |
    /// +----------------+-------------+
    /// ```
    ///
    /// The `data` field has variable length. A data packet always transmit as
    /// much data as possible, thus only the last data packet in a session may
    /// have a `data` field shorter than the maximum length. The `data` field
    /// is protected by a crc32 checksum during transmission.
    Data { buffer: Option<&'a [u8]> },
    /// The sender or the receiver wants to terminate or abort the session. The
    /// sender sends reset to terminate the session after all data packets are
    /// acknowledged. Either side may send reset to abort a session if fatal
    /// error occurs.
    ///
    /// The reset packet has no content but only header.
    Reset,
}

/// The enumeration different packet types. See [`PacketContent`] for the
/// details of each packet type. This enum is used only at an intermediate
/// stage while parsing a packet from received bytes.
#[derive(Clone, Copy, PartialEq, Debug)]
enum PacketType {
    SendRequest,
    SendClearance,
    Data,
    Reset,
}

/// The overhead in bytes of a data packet. The header contributes 2 bytes. The
/// crc32 checksum contributes 4 bytes.
const DATA_PACKET_OVERHEAD: usize = 6;

/// The maximum data payload size is the maximum link layer frame size minus
/// the data packet overhead.
pub(crate) const MAX_DATA_PACKET_PAYLOAD_SIZE: usize =
    link::MAX_FRAME_PAYLOAD_SIZE - DATA_PACKET_OVERHEAD;

/// An opaque type that the receiving client should pass in while receiving
/// a packet. It contains several buffers to facilitate packet receiving. For
/// better performance, the client should construct one scratchpad instance and
/// reuse it for every receiving.
pub(crate) struct Scratchpad {
    /// The header goes into this buffer.
    header_buf: [u8; 2],
    /// The crc32 checksum goes into this buffer.
    crc_buf: [u8; 4],
    /// Used when the buffer provided by the client is not long enough.
    backup_buf: [u8; 4],
}

impl Scratchpad {
    /// Construct a new scratchpad instance.
    pub(crate) const fn new() -> Self {
        Self {
            header_buf: [0u8; 2],
            crc_buf: [0u8; 4],
            backup_buf: [0u8; 4],
        }
    }
}

/// Enumeration of possible packet errors.
pub(crate) enum PacketError<RE, WE> {
    /// Error occurred during serial read.
    SerialReadErr(RE),
    /// Error occurred during serial write.
    SerialWriteErr(WE),
    /// Operation timed out.
    Timeout,
    /// Received a cloberred packet.
    Clobbered,
    /// Received a data packet but no buffer was provided to store the data.
    NoBuffer,
}

/// Implement conversion from [`LinkError`] to [`PacketError`].
impl<RE, WE> From<LinkError<RE, WE>> for PacketError<RE, WE> {
    fn from(le: LinkError<RE, WE>) -> Self {
        match le {
            LinkError::SerialReadErr(e) => PacketError::SerialReadErr(e),
            LinkError::SerialWriteErr(e) => PacketError::SerialWriteErr(e),
            LinkError::Timeout => PacketError::Timeout,
            LinkError::Overrun => PacketError::Clobbered,
        }
    }
}

/// Public functions and methods.
impl<'a> Packet<'a> {
    /// Construct a send request packet.
    ///
    /// ### Parameters
    /// - `session_num`: Identifies the session which the sender attempts to
    ///   establish.
    pub(crate) fn build_send_request(data_len: u16, session_num: u16) -> Self {
        Self {
            sequence: Sequence::Even,
            acknowledge: Acknowledge::Ack,
            content: PacketContent::SendRequest {
                data_len,
                session_num,
            },
        }
    }

    /// Construct a send clearance packet.
    ///
    /// ### Parameters
    /// - `session_num`: Identifies the session which the receiver clears the
    ///   sender to proceed.
    pub(crate) fn build_send_clearance(session_num: u16) -> Self {
        Self {
            sequence: Sequence::Even,
            acknowledge: Acknowledge::Ack,
            content: PacketContent::SendClearance { session_num },
        }
    }

    /// Construct a data packet for the sender to deliver data.
    ///
    /// ### Parameters
    /// - `sequence`: Alternates between [`Sequence::Even`] and
    ///   [`Sequence::Odd`] to distinguish between new and retransmitted data.
    /// - `buffer`: Data to be transmitted. All data packets from the sender
    ///   must have a buffer size equal to [`MAX_DATA_PACKET_PAYLOAD_SIZE`]
    ///   except the last packet in a session.
    pub(crate) fn build_data(sequence: Sequence, buffer: &'a [u8]) -> Self {
        Self {
            sequence,
            acknowledge: Acknowledge::Ack,
            content: PacketContent::Data {
                buffer: Some(buffer),
            },
        }
    }

    /// Construct a data packet for the receiver to `ack` the previously
    /// received data packet.
    ///
    /// ### Parameters
    /// - `sequence`: The sequence number of the previously received data
    ///   packet.
    pub(crate) fn build_ack(sequence: Sequence) -> Self {
        Self {
            sequence,
            acknowledge: Acknowledge::Ack,
            content: PacketContent::Data { buffer: None },
        }
    }

    /// Construct a data packet for the receiver to `nack` the previously
    /// received data packet.
    ///
    /// ### Parameters
    /// - `sequence`: The sequence number of the previously received data
    ///   packet.
    pub(crate) fn build_nack(sequence: Sequence) -> Self {
        Self {
            sequence,
            acknowledge: Acknowledge::Nack,
            content: PacketContent::Data { buffer: None },
        }
    }

    /// Construct a reset packet.
    pub(crate) fn build_reset() -> Self {
        Self {
            sequence: Sequence::Even,
            acknowledge: Acknowledge::Ack,
            content: PacketContent::Reset,
        }
    }

    /// Send the packet. This operation should not block.
    ///
    /// ### Parameters
    /// - `link`: A link layer instance.
    ///
    /// ### Returns
    /// - `Ok(())`: Packet sent successfully.
    /// - `Err(PacketError)`: An error occurred.
    pub(crate) fn send<S, T>(
        &self,
        link: &mut Link<S, T>,
    ) -> Result<(), PacketError<S::ReadError, S::WriteError>>
    where
        S: Serial,
        T: Timer,
    {
        // See the documentation of `Packet` and `PacketContent` to find the
        // layout of each packet type.
        match self.content {
            PacketContent::SendRequest {
                data_len,
                session_num,
            } => link.send_frame(&[
                &self.header_to_le_bytes(),
                &data_len.to_le_bytes(),
                &session_num.to_le_bytes(),
                &Self::get_checksum(&[&data_len.to_le_bytes(), &session_num.to_le_bytes()]),
            ]),
            PacketContent::SendClearance { session_num } => link.send_frame(&[
                &self.header_to_le_bytes(),
                &session_num.to_le_bytes(),
                &Self::get_checksum(&[&session_num.to_le_bytes()]),
            ]),
            PacketContent::Data { buffer } => match buffer {
                Some(buffer) => link.send_frame(&[
                    &self.header_to_le_bytes(),
                    buffer,
                    &Self::get_checksum(&[buffer]),
                ]),
                None => link.send_frame(&[&self.header_to_le_bytes()]),
            },
            PacketContent::Reset => link.send_frame(&[&self.header_to_le_bytes()]),
        }
        .map_err(|e| e.into())
    }

    /// Receive a packet or timeout.
    ///
    /// ### Parameters
    /// - `link`: A link layer instance.
    /// - `client_buf`: Buffer provided by the client to receive data in case
    ///   the received packet is a data packet. Set to `None` if the client
    ///   expects a packet type other than data packet. Also set to `None` if
    ///   the client expects to receive `ack` or `nack`.
    /// - `timeout_ms`: Timeout in milliseconds.
    /// - `scratchpad`: An opaque object that the client should pass in while
    ///   receiving a packet.
    ///
    /// ### Returns
    /// - Ok(Packet): The successfully received packet.
    /// - Err(PacketError): An error occurred.
    pub(crate) fn receive<'b, S, T>(
        link: &mut Link<S, T>,
        mut client_buf: Option<&'a mut [u8]>,
        timeout_ms: u32,
        scratchpad: &'b mut Scratchpad,
    ) -> Result<Self, PacketError<S::ReadError, S::WriteError>>
    where
        'b: 'a,
        S: Serial,
        T: Timer,
    {
        // Use the client provided buffer if it is long enough, or otherwise
        // use the backup buffer. The client provided buffer is the preferred
        // choice so that no further data copying is needed for a received data
        // packet.
        let (active_buf, backup_is_active) =
            Self::pick_buffer(&mut client_buf, &mut scratchpad.backup_buf);

        // Read the packet bytes from the link. If too many bytes are received,
        // the link frame overrun error will be automatically converted to a
        // clobbered packet error.
        //
        // Note that the link layer fills up the following buffers in order.
        // There is a chance that the crc32 checksum is not filled into the
        // `crc_buf`. We will later handle this corner case.
        let byte_cnt = link.receive_frame_with_timeout(
            &mut [
                &mut scratchpad.header_buf,
                active_buf,
                &mut scratchpad.crc_buf,
            ],
            timeout_ms,
        )?;

        // A reset packet or an acknowledge packet has a length of 2 bytes. The
        // next smallest possible packet is a data packet containing 1 byte,
        // which has a length of 7 bytes. Packets smaller than 7 bytes but not
        // 2 bytes must be clobbered.
        if !(byte_cnt == 2 || byte_cnt >= 7) {
            return Err(PacketError::Clobbered);
        }

        // If the packet cannot possibly be a reset packet or acknowledge
        // packet (i.e. length is not 2), then the packet must have a crc32
        // checksum field at the end. However, the `active_buf` may be longer
        // than the received content, causing part or all of the crc32 checksum
        // to be saved also in the `active_buf` rather than the `crc_buf`. So
        // now we copy the last four bytes into the `crc_buf`.
        if byte_cnt != 2 {
            // |<-------- byte count --------->|<- offset ->|
            // +------------+----------------+--------------+
            // | HEADER BUF |   ACTIVE BUF   |    CRC BUF   |
            // +------------+----------------+--------------+
            let offset = (active_buf.len() + scratchpad.crc_buf.len())
                .saturating_sub(byte_cnt - scratchpad.header_buf.len());

            // Perform the copy if the offset is not zero. If otherwise the
            // offset is zero, it means the crc32 checksum is already in the
            // `crc_buf`, thus we should skip the copying.
            if offset > 0 {
                // Copy in reverse order to avoid overwriting existing checksum
                // bytes in the `crc_buf`.
                for idx in (0..=3).rev() {
                    if idx >= offset {
                        scratchpad.crc_buf[idx] = scratchpad.crc_buf[idx - offset];
                    } else {
                        scratchpad.crc_buf[idx] = active_buf[active_buf.len() - (offset - idx)];
                    }
                }
            }
        }

        // Parse the packet header.
        let (sequence, acknowledge, packet_type) = Self::parse_header::<S>(&scratchpad.header_buf)?;

        // Parse the packet content based on the packet type.
        match packet_type {
            PacketType::SendRequest => Self::parse_send_request::<S>(
                byte_cnt,
                sequence,
                acknowledge,
                active_buf[0..4].try_into().unwrap(),
                &scratchpad.crc_buf,
            ),
            PacketType::SendClearance => Self::parse_send_clearance::<S>(
                byte_cnt,
                sequence,
                acknowledge,
                active_buf[0..2].try_into().unwrap(),
                &scratchpad.crc_buf,
            ),
            PacketType::Data => Self::parse_data::<S>(
                byte_cnt,
                sequence,
                acknowledge,
                client_buf,
                active_buf,
                &scratchpad.crc_buf,
                backup_is_active,
            ),
            PacketType::Reset => Self::parse_reset::<S>(byte_cnt, sequence, acknowledge),
        }
    }

    /// Get the sequence number of the given packet.
    pub(crate) fn get_sequence(&self) -> Sequence {
        self.sequence
    }

    /// Get the acknowledge field of the given packet.
    pub(crate) fn get_acknowledge(&self) -> Acknowledge {
        self.acknowledge
    }

    /// Get the content field of the given packet.
    pub(crate) fn get_content(&self) -> PacketContent {
        self.content
    }
}

/// Private functions and methods.
impl<'a> Packet<'a> {
    /// Get the little-endian byte representation of the header field.
    fn header_to_le_bytes(&self) -> [u8; 2] {
        let sequence = match self.sequence {
            Sequence::Even => EVEN_4BIT_PATTERN,
            Sequence::Odd => ODD_4BIT_PATTERN,
        };
        let acknowledge = match self.acknowledge {
            Acknowledge::Ack => EVEN_4BIT_PATTERN,
            Acknowledge::Nack => ODD_4BIT_PATTERN,
        };

        let content_type = match &self.content {
            PacketContent::SendRequest { .. } => EVEN_EVEN_8BIT_PATTERN,
            PacketContent::SendClearance { .. } => EVEN_ODD_8BIT_PATTERN,
            PacketContent::Data { .. } => ODD_EVEN_8BIT_PATTERN,
            PacketContent::Reset => ODD_ODD_8BIT_PATTERN,
        };

        [(sequence << 4) | acknowledge, content_type]
    }

    /// Parse the given bytes as a packet header. Report error if the given
    /// bytes does not match recognizable bit patterns.
    ///
    /// ### Parameters
    /// - `header_buf`: The bytes to be parsed as a header.
    ///
    /// ### Returns
    /// - `Ok((Sequence, Acknowledge, PacketType))`: Parsed header fields.
    /// - `Err(PacketError)`: An error occurred during parsing.
    fn parse_header<S>(
        header_buf: &[u8; 2],
    ) -> Result<(Sequence, Acknowledge, PacketType), PacketError<S::ReadError, S::WriteError>>
    where
        S: Serial,
    {
        // Get the received bits for each header field.
        let sequence = header_buf[0] >> 4;
        let acknowledge = header_buf[0] & 0xf;
        let packet_type = header_buf[1];

        // Match the bits against recognizable bit patterns.
        let sequence = match sequence {
            EVEN_4BIT_PATTERN => Sequence::Even,
            ODD_4BIT_PATTERN => Sequence::Odd,
            _ => return Err(PacketError::Clobbered),
        };
        let acknowledge = match acknowledge {
            EVEN_4BIT_PATTERN => Acknowledge::Ack,
            ODD_4BIT_PATTERN => Acknowledge::Nack,
            _ => return Err(PacketError::Clobbered),
        };
        let packet_type = match packet_type {
            EVEN_EVEN_8BIT_PATTERN => PacketType::SendRequest,
            EVEN_ODD_8BIT_PATTERN => PacketType::SendClearance,
            ODD_EVEN_8BIT_PATTERN => PacketType::Data,
            ODD_ODD_8BIT_PATTERN => PacketType::Reset,
            _ => return Err(PacketError::Clobbered),
        };

        Ok((sequence, acknowledge, packet_type))
    }

    /// Parse the content of a send request packet.
    ///
    /// ### Parameters
    /// - `byte_cnt`: The number of bytes read from the link layer.
    /// - `sequence`: The parsed sequence number.
    /// - `acknowledge`: The parsed acknowledge field.
    /// - `buffer`: The bytes to be parsed as the send request content.
    ///
    /// ### Returns
    /// - Ok(Packet): A send request packet.
    /// - Err(PacketError): An error occurred during parsing.
    fn parse_send_request<'b, 'c, S>(
        byte_cnt: usize,
        sequence: Sequence,
        acknowledge: Acknowledge,
        buffer: &'b [u8; 4],
        crc_buf: &'c [u8; 4],
    ) -> Result<Self, PacketError<S::ReadError, S::WriteError>>
    where
        S: Serial,
    {
        // A send request packet must have a length of 10 bytes.
        if byte_cnt != 10 {
            return Err(PacketError::Clobbered);
        }

        // Read content fields.
        let data_len = u16::from_le_bytes(buffer[0..2].try_into().unwrap());
        let session_num = u16::from_le_bytes(buffer[2..4].try_into().unwrap());

        // Verify the checksum.
        if *crc_buf != Self::get_checksum(&[&data_len.to_le_bytes(), &session_num.to_le_bytes()]) {
            return Err(PacketError::Clobbered);
        }

        // A send request packet must have `Sequence::Even` and
        // `Acknowledge::Ack`.
        if sequence != Sequence::Even || acknowledge != Acknowledge::Ack {
            return Err(PacketError::Clobbered);
        }

        Ok(Self {
            sequence,
            acknowledge,
            content: PacketContent::SendRequest {
                data_len,
                session_num,
            },
        })
    }

    /// Parse the content of a send clearance packet.
    ///
    /// ### Parameters
    /// - `byte_cnt`: The number of bytes read from the link layer.
    /// - `sequence`: The parsed sequence number.
    /// - `acknowledge`: The parsed acknowledge field.
    /// - `buffer`: The bytes to be parsed as the send clearance content.
    ///
    /// ### Returns
    /// - Ok(Packet): A send clearance packet.
    /// - Err(PacketError): An error occurred during parsing.
    fn parse_send_clearance<'b, 'c, S>(
        byte_cnt: usize,
        sequence: Sequence,
        acknowledge: Acknowledge,
        buffer: &'b [u8; 2],
        crc_buf: &'c [u8; 4],
    ) -> Result<Self, PacketError<S::ReadError, S::WriteError>>
    where
        S: Serial,
    {
        // A send clearance packet must have a length of 8 bytes.
        if byte_cnt != 8 {
            return Err(PacketError::Clobbered);
        }

        // Read content fields.
        let session_num = u16::from_le_bytes(buffer[0..2].try_into().unwrap());

        // Verify the checksum.
        if *crc_buf != Self::get_checksum(&[&session_num.to_le_bytes()]) {
            return Err(PacketError::Clobbered);
        }

        // A send clearance packet must have `Sequence::Even` and
        // `Acknowledge::Ack`.
        if sequence != Sequence::Even || acknowledge != Acknowledge::Ack {
            return Err(PacketError::Clobbered);
        }

        Ok(Self {
            sequence,
            acknowledge,
            content: PacketContent::SendClearance { session_num },
        })
    }

    /// Parse the content of a data packet. This might be a packet from the
    /// sender to the receiver carrying data, in which case the content length
    /// is zero. Or it might be a packet from the receiver to the sender
    /// carrying `ack` or `nack`, in which case the content length is zero.
    ///
    /// ### Parameters
    /// - `byte_cnt`: The number of bytes read from the link layer.
    /// - `sequence`: The parsed sequence number.
    /// - `acknowledge`: The parsed acknowledge field.
    /// - `client_buf`: The buffer optionally provided by the client.
    /// - `active_buf`: The active buffer picked by [`Self::pick_buffer`].
    /// - `crc_buf`: The bytes to be parsed as a crc32 checksum.
    /// - `backup_is_active`: Whether the `active_buf` is the backup buffer.
    ///
    /// ### Returns
    /// - Ok(Packet): A data packet or an acknowledge packet.
    /// - Err(PacketError): An error occurred during parsing.
    fn parse_data<'c, S>(
        byte_cnt: usize,
        sequence: Sequence,
        acknowledge: Acknowledge,
        client_buf: Option<&'a mut [u8]>,
        active_buf: &'a [u8],
        crc_buf: &'c [u8; 4],
        backup_is_active: bool,
    ) -> Result<Self, PacketError<S::ReadError, S::WriteError>>
    where
        S: Serial,
    {
        // If there is no content, this is an acknowledge packet.
        if byte_cnt == 2 {
            return Ok(Packet {
                sequence,
                acknowledge,
                content: PacketContent::Data { buffer: None },
            });
        }

        // Reference the client provided buffer.
        let final_client_buf: &[u8];

        // When the backup buffer is active, we must copy the data received
        // by the backup buffer back to the client provided buffer.
        if backup_is_active {
            // Copy if the client buffer is provided.
            if let Some(client_buf) = client_buf {
                client_buf.copy_from_slice(&active_buf[0..client_buf.len()]);
                final_client_buf = client_buf;
            // Otherwise the client is expecting a packet type other than a
            // data packet, so it did not provide a buffer. Report that we have
            // no buffer to store the received data.
            } else {
                return Err(PacketError::NoBuffer);
            }
        // If we were using the client provided buffer as the active buffer,
        // nothing needs to be done.
        } else {
            final_client_buf = active_buf;
        }

        // If the client provides a buffer expecting to receive data, the link
        // layer must fill up the buffer exactly. Otherwise the packet is
        // considered to be clobbered.
        if byte_cnt != final_client_buf.len() + DATA_PACKET_OVERHEAD {
            return Err(PacketError::Clobbered);
        }

        // Verify the checksum.
        if *crc_buf != Self::get_checksum(&[&final_client_buf]) {
            return Err(PacketError::Clobbered);
        }

        // A data packet carrying data must always have `Acknowledge::Ack`.
        if acknowledge != Acknowledge::Ack {
            return Err(PacketError::Clobbered);
        }

        Ok(Self {
            sequence,
            acknowledge,
            content: PacketContent::Data {
                buffer: Some(final_client_buf),
            },
        })
    }

    /// Parse the content of a reset packet.
    ///
    /// ### Parameters
    /// - `byte_cnt`: The number of bytes read from the link layer.
    /// - `sequence`: The parsed sequence number.
    /// - `acknowledge`: The parsed acknowledge field.
    ///
    /// ### Returns
    /// - Ok(Packet): A reset packet.
    /// - Err(PacketError): An error occurred during parsing.
    fn parse_reset<S>(
        byte_cnt: usize,
        sequence: Sequence,
        acknowledge: Acknowledge,
    ) -> Result<Self, PacketError<S::ReadError, S::WriteError>>
    where
        S: Serial,
    {
        // A reset packet must have a length of 2 bytes. All is the header
        // but any content.
        if byte_cnt != 2 {
            return Err(PacketError::Clobbered);
        }

        // A reset packet must have `Sequence::Even` and `Acknowledge::Ack`.
        if sequence != Sequence::Even || acknowledge != Acknowledge::Ack {
            return Err(PacketError::Clobbered);
        }

        Ok(Packet {
            sequence,
            acknowledge,
            content: PacketContent::Reset,
        })
    }

    /// Pick between the client provided buffer and the backup buffer to
    /// receive data. The backup buffer will be used only if the client
    /// provided buffer is not large enough. The client provided buffer is
    /// the preferred choice so that the received data needs no further
    /// copying.
    ///
    /// The backup buffer has a length that is enough to receive a packet of
    /// of type send request, send clearance, acknowledge, and reset. The
    /// backup buffer will be used if the client provided buffer is smaller
    /// than it.
    ///
    /// The backup buffer may not be able to hold all bytes of a data packet
    /// However, when the backup buffer is used, the client provided buffer
    /// must be even smaller. Thus, as long as the client provided buffer is
    /// able to hold the received data, the provided buffer must also be.
    ///
    /// ### Parameters
    /// - `client_buf`: The buffer optionally provided by the client.
    /// - `backup_buf`: The backup buffer.
    ///
    /// ### Returns
    /// - `.0`: The chosen buffer.
    /// - `.1`: Whether the backup buffer is chosen.
    fn pick_buffer<'b>(
        client_buf: &mut Option<&'a mut [u8]>,
        backup_buf: &'b mut [u8; 4],
    ) -> (&'a mut [u8], bool)
    where
        'b: 'a,
    {
        match client_buf.take() {
            // If the client provides a buffer, check its length and decide.
            Some(buf) => {
                // The backup buffer is just large enough to hold any packet
                // content other than data. If the provided buffer is larger,
                // use the provided one.
                if buf.len() >= backup_buf.len() {
                    (buf, false)
                // Otherwise, put back the provided buffer and use the backup
                // instead.
                } else {
                    client_buf.replace(buf);
                    (backup_buf, true)
                }
            }
            // If no client provided buffer, use backup.
            None => (backup_buf, true),
        }
    }

    /// Calculate the crc32 checksum of the given byte slices. The bytes slices
    /// will be flatten into one to calculate the checksum.
    fn get_checksum(byte_slices: &[&[u8]]) -> [u8; 4] {
        let mut hasher = crc32fast::Hasher::new();
        for &slice in byte_slices {
            hasher.update(slice);
        }
        hasher.finalize().to_le_bytes()
    }
}
