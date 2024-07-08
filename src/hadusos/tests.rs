use super::*;
use core::time::Duration;
use crossbeam::channel::{self, Receiver, RecvError, SendError, Sender};
use std::sync::{Arc, Mutex};
use std::thread;
use std::time::Instant;

struct MockSerial {
    send: Sender<u8>,
    recv: Receiver<u8>,
}

impl MockSerial {
    const fn new(send: Sender<u8>, recv: Receiver<u8>) -> Self {
        Self { send, recv }
    }
}

impl Serial for MockSerial {
    type ReadError = RecvError;
    type WriteError = SendError<u8>;

    fn read_byte_with_timeout(
        &mut self,
        timeout_ms: u32,
    ) -> Result<u8, SerialError<Self::ReadError, Self::WriteError>> {
        self.recv
            .recv_timeout(Duration::from_millis(timeout_ms as u64))
            .map_err(|e| match e {
                channel::RecvTimeoutError::Timeout => SerialError::Timeout,
                channel::RecvTimeoutError::Disconnected => SerialError::ReadError(RecvError),
            })
    }

    fn write_byte(
        &mut self,
        byte: u8,
    ) -> Result<(), SerialError<Self::ReadError, Self::WriteError>> {
        self.send.send(byte).map_err(|e| SerialError::WriteError(e))
    }
}

struct MockTimer {
    start: Instant,
}

impl MockTimer {
    fn new() -> Self {
        Self {
            start: Instant::now(),
        }
    }
}

impl Timer for MockTimer {
    fn get_timestamp_ms(&mut self) -> u32 {
        self.start.elapsed().as_millis() as u32
    }
}

#[test]
fn send_receive_test() {
    let (send0, recv1) = channel::unbounded();
    let (send1, recv0) = channel::unbounded();

    let serial0 = MockSerial::new(send0, recv0);
    let serial1 = MockSerial::new(send1, recv1);

    let timer0 = MockTimer::new();
    let timer1 = MockTimer::new();

    let trans0 = Arc::new(Mutex::new(Session::new(serial0, timer0)));
    let trans1 = Arc::new(Mutex::new(Session::new(serial1, timer1)));

    let _trans0_cloned = Arc::clone(&trans0);
    let _trans1_cloned = Arc::clone(&trans1);

    fn client(trans: &mut Session<MockSerial, MockTimer>) {
        let msg = "hello_world!".as_bytes();
        let mut large_msg = Vec::new();
        for _ in 0..1000 {
            large_msg.extend_from_slice(msg);
        }
        trans.send(&large_msg, 1000).unwrap();
    }

    fn server(trans: &mut Session<MockSerial, MockTimer>) {
        let msg = "hello_world!".as_bytes();
        let mut large_msg = Vec::new();
        for _ in 0..1000 {
            large_msg.extend_from_slice(msg);
        }

        let len = trans.listen(1000).unwrap();
        let mut buf = vec![0u8; len as usize].into_boxed_slice();
        trans.receive(&mut buf, 10000).unwrap();

        assert!(buf.as_ref() == large_msg.as_slice())
    }

    let t0 = thread::spawn(move || client(&mut *trans0.lock().unwrap()));
    let t1 = thread::spawn(move || server(&mut *trans1.lock().unwrap()));

    t0.join().unwrap();
    t1.join().unwrap();
}
