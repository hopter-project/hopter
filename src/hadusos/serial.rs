/// The trait that a serial device must implement to support the transport
/// protocol built atop of it.
pub trait Serial {
    /// Type of error that can occur while reading.
    type ReadError;

    /// Type of error that can occur while writing.
    type WriteError;

    /// Read a byte from the serial device with a timeout.
    ///
    /// ### Parameters
    /// - `timeout_ms`: Timeout in milliseconds.
    ///
    /// ### Returns
    /// - `Ok(u8)`: The byte read.
    /// - `Err([SerialError])`: An error occurred.
    fn read_byte_with_timeout(
        &mut self,
        timeout_ms: u32,
    ) -> Result<u8, SerialError<Self::ReadError, Self::WriteError>>;

    /// Write a byte to the serial device.
    ///
    /// ### Parameters
    /// - `byte`: The byte to write.
    ///
    /// ### Returns
    /// - `Ok(())`: The byte was written successfully.
    /// - `Err(SerialError)`: An error occurred.
    fn write_byte(
        &mut self,
        byte: u8,
    ) -> Result<(), SerialError<Self::ReadError, Self::WriteError>>;
}

/// Enumeration of possible serial communication errors.
///
/// NOTE: When the read operation on the serial device times out, it must
/// return the [`Timeout`](SerialError::Timeout) variant rather than the
/// [`ReadError`](SerialError::ReadError) variant.
pub enum SerialError<RE, WE> {
    ReadError(RE),
    WriteError(WE),
    Timeout,
}
