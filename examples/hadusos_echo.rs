#![no_std]
#![no_main]
#![feature(naked_functions)]

extern crate alloc;
use alloc::boxed::Box;
use alloc::vec;
use core::cmp::max;
use hadusos::*;
use hopter::sync::Mailbox;
use hopter::time::*;
use hopter::unwind::unwind::save_and_clear_isr_unwinding;
use hopter::{boot::main, debug::semihosting, hprint, hprintln};
use stm32f4xx_hal::pac::otg_fs_global::gotgint::SEDET_W;
use stm32f4xx_hal::pac::USART1;
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::uart::Config;
use stm32f4xx_hal::uart::{Rx, Tx};
static G_MAILBOX: Mailbox = Mailbox::new();
static mut G_RX: Option<Rx<USART1>> = None;
static mut G_MAX_SIZE: usize = 0;
const TIMEOUT_MS: u32 = 10000;
static mut G_RBYTE: heapless::Deque<u8, 128> = heapless::Deque::new();
use hopter::interrupt::handler;

#[handler(USART1)]
unsafe extern "C" fn usart1_handler() {
    cortex_m::interrupt::free(|_| {
        unsafe {
            let _ = G_RBYTE.push_back(G_RX.as_mut().unwrap().read().unwrap());
        };
        // hprintln!("{}", G_RBYTE.len());
        // hprintln!("Interrupt");
        // Notify the mailbox that a byte is available to read by incrementing the counter
        G_MAILBOX.notify_allow_isr();
    });
}

#[derive(Debug)]
struct RError;
#[derive(Debug)]
struct WError;

struct UsartTimer {}

impl Timer for UsartTimer {
    fn get_timestamp_ms(&mut self) -> u32 {
        let tick = get_tick();
        // hprintln!("Timer: {}", tick);
        tick
    }
}

struct UsartSerial {
    tx: Tx<USART1>,
}
impl Serial for UsartSerial {
    type ReadError = RError;
    type WriteError = WError;

    fn read_byte_with_timeout(
        &mut self,
        timeout_ms: u32,
    ) -> Result<u8, SerialError<Self::ReadError, Self::WriteError>> {
        let result = G_MAILBOX.wait_until_timeout(TIMEOUT_MS);
        if result {
            let byte = unsafe { G_RBYTE.pop_front().unwrap() };
            unsafe { G_MAX_SIZE = max(G_RBYTE.len(), G_MAX_SIZE) };
            // hprintln!("Read byte: {:02x}", byte);
            Ok(byte)
        } else {
            Err(SerialError::Timeout)
        }
    }
    fn write_byte(
        &mut self,
        byte: u8,
    ) -> Result<(), SerialError<Self::ReadError, Self::WriteError>> {
        self.tx.write(byte).unwrap();
        // hprintln!("Write byte: {:02x}", byte);
        Ok(())
    }
}

#[main]
fn main(_: cortex_m::Peripherals) {
    let dp = unsafe { stm32f4xx_hal::pac::Peripherals::steal() };
    let clocks = dp.RCC.constrain().cfgr.freeze();
    let gpioa = dp.GPIOA.split();

    let usart1_pins = (
        gpioa.pa9.into_alternate::<7>(),
        gpioa.pa10.into_alternate::<7>(),
    );

    let (tx, mut rx) = dp
        .USART1
        .serial(
            usart1_pins,
            Config::default().baudrate(115200.bps()),
            &clocks,
        )
        .unwrap()
        .split();

    rx.listen();

    unsafe {
        G_RX = Some(rx);
    }

    unsafe { cortex_m::peripheral::NVIC::unmask(stm32f4xx_hal::pac::Interrupt::USART1) };
    hprintln!("Starting");
    let usart_serial = UsartSerial { tx };
    let usart_timer = UsartTimer {};
    let mut session: Session<UsartSerial, UsartTimer, 150, 2> =
        Session::new(usart_serial, usart_timer);

    const send_size: usize = 2048;
    let mut data: [u8; send_size] = [30; send_size];
    for i in 0..send_size {
        data[i] = i as u8;
    }
    match session.send(&mut data, TIMEOUT_MS) {
        Ok(_) => {
            hprintln!("Sent data");
        }
        Err(e) => {
            hprintln!("Error: {:?}", e);
        }
    }

    let size = session.listen(TIMEOUT_MS).unwrap();
    let mut rec_data = new_byte_slice(size as usize);
    session.receive(&mut rec_data, TIMEOUT_MS).unwrap();
    print_data(&rec_data);
    unsafe {
        hprintln!("Max size: {}", G_MAX_SIZE);
    }
    semihosting::terminate(true);
}

pub fn print_data(vec: &[u8]) {
    for (i, byte) in vec.iter().enumerate() {
        hprint!("{:02x} ", byte);
        if i % 16 == 15 {
            hprintln!();
        }
    }
    hprintln!();
}

fn new_byte_slice(size: usize) -> Box<[u8]> {
    vec![0; size].into_boxed_slice()
}
