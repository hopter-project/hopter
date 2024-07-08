/// The trait that a timer must implement to support the transport protocol.
pub trait Timer {
    /// Return the current timestamp in milliseconds.
    fn get_timestamp_ms(&mut self) -> u32;
}
