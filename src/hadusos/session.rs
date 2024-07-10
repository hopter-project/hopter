use super::{
    link::Link,
    packet::{self, Acknowledge, Packet, PacketContent, PacketError, Scratchpad, Sequence},
    serial::Serial,
    timer::Timer,
};

/// Enumeration of possible session errors.
#[derive(Debug)]
pub enum SessionError<RE, WE> {
    /// Error occurred during serial read.
    SerialReadErr(RE),
    /// Error occurred during serial write.
    SerialWriteErr(WE),
    /// Cannot send because the other end was not ready to receive.
    NotClearToSend,
    /// Operation timed out.
    Timeout,
    /// Received clobbered packet. Retransmission did not fix the problem.
    Clobbered,
    /// The other end actively wanted to abort the session.
    Reset,
    /// A session was established but the sender did not send data for very
    /// long time.
    Disconnected,
    /// A session was established but the receiver did not acknowledge the
    /// data sent.
    NotAcknowledged,
    /// The other end likely has proceeded to a new session.
    OutOfSync,
    /// Cannot send the data because it is too large.
    Oversize,
    /// Buffer provided does not match the advertised incoming data length.
    BufferSizeMismatch,
}

impl<RE, WE> From<PacketError<RE, WE>> for SessionError<RE, WE> {
    fn from(pe: PacketError<RE, WE>) -> Self {
        match pe {
            PacketError::SerialReadErr(e) => SessionError::SerialReadErr(e),
            PacketError::SerialWriteErr(e) => SessionError::SerialWriteErr(e),
            PacketError::Timeout => SessionError::Timeout,
            PacketError::Clobbered => SessionError::Clobbered,
            PacketError::NoBuffer => SessionError::Clobbered,
        }
    }
}

trait IntoTolerable<T, RE, WE> {
    fn into_tolerable(self) -> Result<Option<T>, SessionError<RE, WE>>;
}

impl<T, RE, WE> IntoTolerable<T, RE, WE> for Result<T, SessionError<RE, WE>> {
    fn into_tolerable(self) -> Result<Option<T>, SessionError<RE, WE>> {
        self.map(|v| Some(v)).map_err(Into::into)
    }
}

macro_rules! tolerate_error {
    ($name:ident, $error_variant:pat) => {
        fn $name(self) -> Self {
            match self {
                Ok(v) => Ok(v),
                Err(e) => match e {
                    $error_variant => Ok(None),
                    e => Err(e),
                },
            }
        }
    };
}

trait TolerableError<T, RE, WE> {
    fn tolerate_timeout(self) -> Self;
    fn tolerate_clobber(self) -> Self;
    fn tolerate_out_of_sync(self) -> Self;
    fn tolerate_reset(self) -> Self;
}

impl<T, RE, WE> TolerableError<T, RE, WE> for Result<Option<T>, SessionError<RE, WE>> {
    tolerate_error!(tolerate_timeout, SessionError::Timeout);
    tolerate_error!(tolerate_clobber, SessionError::Clobbered);
    tolerate_error!(tolerate_out_of_sync, SessionError::OutOfSync);
    tolerate_error!(tolerate_reset, SessionError::Reset);
}

/// The struct representing the session layer.
///
/// ### Generic Parameters
/// - `RTO`: Retransmission timeout in milliseconds.
/// - `RRC`: Retransmission retry count.
pub struct Session<S, T, const RTO: u32 = 50, const RRC: usize = 3>
where
    S: Serial,
    T: Timer,
{
    link: Link<S, T>,
    tx_session_num: u16,
    rx_session_num: u16,
    rx_data_len: u16,
    scratchpad: Scratchpad,
}

/// Public functions and methods.
impl<S, T, const RTO: u32, const RRC: usize> Session<S, T, RTO, RRC>
where
    S: Serial,
    T: Timer,
{
    /// Create a new session layer instance.
    ///
    /// ### Parameters
    /// - `serial`: A serial instance implementing the [`Serial`] trait.
    /// - `timer`: A timer instance implementing the [`Timer`] trait.
    pub const fn new(serial: S, timer: T) -> Self {
        Self {
            link: Link::new(serial, timer),
            tx_session_num: 0,
            rx_session_num: 0,
            rx_data_len: 0,
            scratchpad: Scratchpad::new(),
        }
    }

    /// Send the given data with a timeout.
    ///
    /// ### Parameters
    /// - `data`: The data to be sent.
    /// - `timeout_ms`: The timeout in milliseconds.
    ///
    /// ### Returns
    /// - `Ok(())`: The data was successfully sent and acknowledged by the
    ///   receiving end.
    /// - [`Err(SessionError)`](SessionError): An error occurred, including a
    ///   possible timeout.
    pub fn send(
        &mut self,
        data: &[u8],
        timeout_ms: u32,
    ) -> Result<(), SessionError<S::ReadError, S::WriteError>> {
        let update_timeout = self.get_updated_timeout(timeout_ms);
        self.initiate_session(data.len(), timeout_ms)?;

        let updated_timeout = update_timeout(&mut self.link.get_timer())?;
        self.send_data(data, updated_timeout)?;

        self.finalize_session()
    }

    /// Wait for a send request with a timeout.
    ///
    /// ### Parameters
    /// - `timeout_ms`: The timeout in milliseconds.
    ///
    /// ### Returns
    /// - `Ok(u16)`: The length of the data the other end intended to send.
    /// - [`Err(SessionError)`](SessionError): An error occurred, including a
    ///   possible timeout.
    pub fn listen(
        &mut self,
        timeout_ms: u32,
    ) -> Result<u16, SessionError<S::ReadError, S::WriteError>> {
        let update_timeout = self.get_updated_timeout(timeout_ms);

        loop {
            let updated_timeout = update_timeout(self.link.get_timer())?;

            let packet =
                match Packet::receive(&mut self.link, None, updated_timeout, &mut self.scratchpad)
                    .map_err(Into::into)
                    .into_tolerable()
                    .tolerate_clobber()?
                {
                    Some(packet) => packet,
                    None => {
                        Packet::build_reset().send(&mut self.link)?;
                        continue;
                    }
                };

            if let PacketContent::SendRequest {
                data_len,
                session_num,
            } = packet.get_content()
            {
                self.rx_data_len = data_len;
                self.rx_session_num = session_num;
                return Ok(data_len);
            } else {
                Packet::build_reset().send(&mut self.link)?;
            }
        }
    }

    /// Approve the previously received send request and receive data with a
    /// timeout.
    ///
    /// ### Parameters
    /// - `data`: The buffer to hold incoming data. The buffer size must
    ///   match exactly the size previously received in the send request.
    /// - `timeout_ms`: The timeout in milliseconds.
    ///
    /// ### Returns
    /// - `Ok(())`: The data was successfully received and stored to the given
    ///   buffer.
    /// - [`Err(SessionError)`](SessionError): An error occurred, including a
    ///   possible timeout.
    pub fn receive(
        &mut self,
        data: &mut [u8],
        timeout_ms: u32,
    ) -> Result<(), SessionError<S::ReadError, S::WriteError>> {
        if data.len() != self.rx_data_len as usize {
            return Err(SessionError::BufferSizeMismatch);
        }

        let update_timeout = self.get_updated_timeout(timeout_ms);

        self.accept_session(data, timeout_ms)?;

        let updated_timeout = update_timeout(&mut self.link.get_timer())?;
        let final_seq = self.accept_data(data, updated_timeout)?;

        let updated_timeout = update_timeout(&mut self.link.get_timer())?;
        self.accept_termination(final_seq, updated_timeout)
    }

    /// Reject the previously received send request.
    ///
    /// ### Returns
    /// - `Ok(())`: Rejection successfully sent.
    /// - [`Err(SessionError)`](SessionError): An error occurred.
    pub fn reject(&mut self) -> Result<(), SessionError<S::ReadError, S::WriteError>> {
        Packet::build_reset()
            .send(&mut self.link)
            .map_err(Into::into)
    }
}

/// Private functions and methods.
impl<S, T, const RTO: u32, const RRC: usize> Session<S, T, RTO, RRC>
where
    S: Serial,
    T: Timer,
{
    fn get_updated_timeout(
        &mut self,
        timeout_ms: u32,
    ) -> impl Fn(&mut T) -> Result<u32, SessionError<S::ReadError, S::WriteError>> {
        // Record the closure creation time.
        let create_time = self.link.get_timer().get_timestamp_ms();

        move |timer| {
            // Get the time of closure invocation.
            let cur_time = timer.get_timestamp_ms();
            // Calculate time elapsed after closure creation.
            let elapsed_time = cur_time - create_time;
            // Calculate remaining time.
            let remaining_time = timeout_ms.saturating_sub(elapsed_time);

            if remaining_time == 0 {
                Err(SessionError::Timeout)
            } else {
                Ok(remaining_time)
            }
        }
    }

    fn send_nack_packet(
        &mut self,
        sequence: Sequence,
    ) -> Result<(), SessionError<S::ReadError, S::WriteError>> {
        Packet::build_nack(sequence)
            .send(&mut self.link)
            .map_err(Into::into)
    }

    fn wait_for_clearance(
        &mut self,
        timeout_ms: u32,
    ) -> Result<u16, SessionError<S::ReadError, S::WriteError>> {
        let packet = Packet::receive(&mut self.link, None, timeout_ms, &mut self.scratchpad)?;

        match packet.get_content() {
            PacketContent::SendRequest { .. } => Err(SessionError::OutOfSync),
            PacketContent::SendClearance { session_num } => {
                if packet.get_sequence() != Sequence::Even
                    || packet.get_acknowledge() != Acknowledge::Ack
                {
                    return Err(SessionError::Clobbered);
                }
                Ok(session_num)
            }
            PacketContent::Data { .. } => Err(SessionError::OutOfSync),
            PacketContent::Reset => Err(SessionError::Reset),
        }
    }

    fn initiate_session(
        &mut self,
        data_len: usize,
        timeout_ms: u32,
    ) -> Result<(), SessionError<S::ReadError, S::WriteError>> {
        if data_len > u16::MAX as usize {
            return Err(SessionError::Oversize);
        }
        let data_len = data_len as u16;

        self.tx_session_num = self.tx_session_num.overflowing_add(1).0;

        let update_timeout = self.get_updated_timeout(timeout_ms);

        for _ in 0..RRC {
            Packet::build_send_request(data_len, self.tx_session_num).send(&mut self.link)?;
            let updated_timeout = update_timeout(self.link.get_timer())?;

            match self
                .wait_for_clearance(updated_timeout)
                .into_tolerable()
                .tolerate_timeout()
                .tolerate_clobber()
                .tolerate_out_of_sync()
                .tolerate_reset()?
            {
                Some(session_num) => {
                    if session_num == self.tx_session_num {
                        return Ok(());
                    }
                }
                None => continue,
            }
        }

        Err(SessionError::NotClearToSend)
    }

    fn finalize_session(&mut self) -> Result<(), SessionError<S::ReadError, S::WriteError>> {
        Packet::build_reset()
            .send(&mut self.link)
            .map_err(Into::into)
    }

    fn wait_for_acknowledge(
        &mut self,
        sequence: Sequence,
        timeout_ms: u32,
    ) -> Result<Acknowledge, SessionError<S::ReadError, S::WriteError>> {
        Packet::receive(&mut self.link, None, timeout_ms, &mut self.scratchpad)
            .map_err(Into::into)
            .and_then(|packet| {
                if packet.get_sequence() == sequence {
                    Ok(packet.get_acknowledge())
                } else {
                    Err(SessionError::OutOfSync)
                }
            })
    }

    fn send_data(
        &mut self,
        data: &[u8],
        timeout_ms: u32,
    ) -> Result<(), SessionError<S::ReadError, S::WriteError>> {
        let update_timeout = self.get_updated_timeout(timeout_ms);

        let mut sequence = Sequence::Even;
        for bytes in data.chunks(packet::MAX_DATA_PACKET_PAYLOAD_SIZE) {
            let mut acknowledged = false;
            for _ in 0..RRC {
                Packet::build_data(sequence, bytes).send(&mut self.link)?;
                let updated_timeout = update_timeout(self.link.get_timer())?;
                let ack = self
                    .wait_for_acknowledge(sequence, updated_timeout.min(RTO))
                    .into_tolerable()
                    .tolerate_timeout()?;
                if let Some(Acknowledge::Ack) = ack {
                    acknowledged = true;
                    break;
                }
            }

            if !acknowledged {
                return Err(SessionError::NotAcknowledged);
            }

            sequence = sequence.toggled();
        }

        Ok(())
    }

    fn accept_session(
        &mut self,
        data: &mut [u8],
        timeout_ms: u32,
    ) -> Result<(), SessionError<S::ReadError, S::WriteError>> {
        let update_timeout = self.get_updated_timeout(timeout_ms);

        Packet::build_send_clearance(self.rx_session_num).send(&mut self.link)?;

        let buffer = data
            .chunks_mut(packet::MAX_DATA_PACKET_PAYLOAD_SIZE)
            .nth(0)
            .unwrap_or(&mut []);

        for _ in 0..RRC {
            let updated_timeout = update_timeout(&mut self.link.get_timer())?;
            let packet = match Packet::receive(
                &mut self.link,
                Some(buffer),
                updated_timeout,
                &mut self.scratchpad,
            )
            .map_err(Into::into)
            .into_tolerable()
            .tolerate_clobber()?
            {
                Some(packet) => packet,
                None => continue,
            };

            match packet.get_content() {
                PacketContent::SendRequest {
                    data_len,
                    session_num,
                } => {
                    if session_num == self.rx_session_num && data_len == self.rx_data_len {
                        Packet::build_send_clearance(self.rx_session_num).send(&mut self.link)?;
                        continue;
                    } else {
                        Packet::build_reset().send(&mut self.link)?;
                        return Err(SessionError::OutOfSync);
                    }
                }
                PacketContent::SendClearance { .. } => return Err(SessionError::OutOfSync),
                PacketContent::Data { buffer } => match buffer {
                    Some(_) => {
                        Packet::build_ack(Sequence::Even).send(&mut self.link)?;
                        return Ok(());
                    }
                    None => return Err(SessionError::OutOfSync),
                },
                PacketContent::Reset => return Err(SessionError::Reset),
            }
        }

        Err(SessionError::OutOfSync)
    }

    fn accept_data(
        &mut self,
        data: &mut [u8],
        timeout_ms: u32,
    ) -> Result<Sequence, SessionError<S::ReadError, S::WriteError>> {
        let update_timeout = self.get_updated_timeout(timeout_ms);

        let mut expect_seq = Sequence::Odd;

        let mut buffer_iter = data
            .chunks_mut(packet::MAX_DATA_PACKET_PAYLOAD_SIZE)
            .skip(1);
        let mut cur_buffer = buffer_iter.next();

        while let Some(buffer) = cur_buffer.as_mut() {
            let mut acknowledged = false;
            for _ in 0..RRC {
                let updated_timeout = update_timeout(self.link.get_timer())?;

                let packet = match Packet::receive(
                    &mut self.link,
                    Some(*buffer),
                    updated_timeout.min((RRC as u32) * RTO),
                    &mut self.scratchpad,
                )
                .map_err(Into::into)
                .map_err(|e| match e {
                    SessionError::Timeout => SessionError::Disconnected,
                    e => e,
                })
                .into_tolerable()
                .tolerate_clobber()?
                {
                    Some(packet) => packet,
                    None => {
                        self.send_nack_packet(expect_seq)?;
                        continue;
                    }
                };

                match packet.get_content() {
                    PacketContent::SendRequest { .. } | PacketContent::SendClearance { .. } => {
                        return Err(SessionError::OutOfSync);
                    }
                    PacketContent::Reset => return Err(SessionError::Reset),
                    PacketContent::Data { buffer } => match buffer {
                        Some(_) => {
                            if packet.get_sequence() != expect_seq {
                                Packet::build_ack(expect_seq.toggled()).send(&mut self.link)?;
                                continue;
                            } else {
                                Packet::build_ack(expect_seq).send(&mut self.link)?;
                                acknowledged = true;
                                break;
                            }
                        }
                        None => {
                            return Err(SessionError::OutOfSync);
                        }
                    },
                }
            }

            if !acknowledged {
                return Err(SessionError::Clobbered);
            }

            expect_seq = expect_seq.toggled();
            cur_buffer = buffer_iter.next();
        }

        Ok(expect_seq.toggled())
    }

    fn accept_termination(
        &mut self,
        final_seq: Sequence,
        timeout_ms: u32,
    ) -> Result<(), SessionError<S::ReadError, S::WriteError>> {
        let update_timeout = self.get_updated_timeout(timeout_ms);

        for _ in 0..RRC {
            let updated_timeout = update_timeout(self.link.get_timer())?;

            let packet: Packet = match Packet::receive(
                &mut self.link,
                None,
                updated_timeout.min((RRC as u32) * RTO),
                &mut self.scratchpad,
            ) {
                Ok(packet) => packet,
                Err(PacketError::Clobbered) => continue,
                Err(PacketError::NoBuffer) => {
                    Packet::build_ack(final_seq).send(&mut self.link)?;
                    continue;
                }
                Err(PacketError::Timeout) => {
                    return Ok(());
                }
                Err(e) => return Err(e.into()),
            };

            match packet.get_content() {
                PacketContent::SendRequest { .. } | PacketContent::Reset => {
                    return Ok(());
                }
                PacketContent::SendClearance { .. } | PacketContent::Data { .. } => {
                    Packet::build_reset().send(&mut self.link)?;
                    return Ok(());
                }
            }
        }

        Ok(())
    }
}
