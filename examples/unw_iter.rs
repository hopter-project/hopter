#![no_std]
#![no_main]
#![feature(naked_functions)]

extern crate alloc;
use alloc::boxed::Box;
use alloc::vec;
use core::cmp::max;
use core::sync::atomic::{AtomicUsize, Ordering};

use hadusos::*;
use hopter::interrupt::handler;
use hopter::sync::Mailbox;
use hopter::unwind::unw_table::{UnwindByteIter, UnwindInstrIter};
use hopter::{schedule, time::*};
use postcard::from_bytes;
// use hopter::unwind::*;
use hopter::uart::*;
use hopter::{boot::main, debug::semihosting, hprint, hprintln};
use stm32f4xx_hal::pac::USART1;
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::uart::Config;
use stm32f4xx_hal::uart::{Rx, Tx};

const TIMEOUT_MS: u32 = 10000;

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
        G_UART_RX = Some(rx);
    }

    unsafe { cortex_m::peripheral::NVIC::unmask(stm32f4xx_hal::pac::Interrupt::USART1) };
    hprintln!("Starting");
    let usart_serial = UsartSerial { tx };
    let usart_timer = UsartTimer {};
    let mut session: Session<UsartSerial, UsartTimer, 150, 2> =
        Session::new(usart_serial, usart_timer);

    unsafe { G_UART_SESSION = Some(session) };

    // let extab_entry_addr: u32 = 24;
    // let data = extab_entry_addr.to_le_bytes();
    // unsafe {
    //     G_UART_SESSION
    //         .as_mut()
    //         .unwrap()
    //         .send(&data, TIMEOUT_MS)
    //         .unwrap();
    // }
    // let size = unsafe { G_UART_SESSION.as_mut().unwrap().listen(TIMEOUT_MS).unwrap() };
    // let mut unw_iter_bytes = new_byte_slice(size as usize);
    // unsafe {
    //     G_UART_SESSION
    //         .as_mut()
    //         .unwrap()
    //         .receive(&mut unw_iter_bytes, TIMEOUT_MS)
    //         .unwrap();
    // }
    // let byte_iter: UnwindByteIter = postcard::from_bytes(&unw_iter_bytes).unwrap();
    // hprintln!("Byte iter: {:?}", byte_iter);
    match schedule::start_restartable_task(2, |_| will_panic(), (), 0, 4) {
        Ok(_) => {
            hprintln!("Task started");
        }
        Err(e) => {
            hprintln!("Error: {:?}", e);
        }
    }
}
fn will_panic() {
    static CNT: AtomicUsize = AtomicUsize::new(0);

    // Every time the task runs we increment it by 1.
    let cnt = CNT.fetch_add(1, Ordering::SeqCst);

    // hprintln!("Current count: {}", cnt);

    // Panic and get restarted for 5 times.
    if cnt < 1 {
        hprintln!("Panic!");
        panic!();
    }
    sleep_ms(10000);
    semihosting::terminate(true);
}
#[handler(USART1)]
unsafe extern "C" fn usart1_handler() {
    cortex_m::interrupt::free(|_| {
        unsafe {
            let _ = G_UART_RBYTE.push_back(G_UART_RX.as_mut().unwrap().read().unwrap());
        };
        // hprintln!("{}", G_RBYTE.len());
        // hprintln!("Interrupt");
        // Notify the mailbox that a byte is available to read by incrementing the counter
        G_UART_MAILBOX.notify_allow_isr();
    });
}
