#![no_std]
#![no_main]
#![feature(naked_functions)]

extern crate alloc;
// use alloc::vec;
// use core::cmp::max;
use core::sync::atomic::{AtomicUsize, Ordering};

use hadusos::*;
use hopter::interrupt::handler;
// use hopter::sync::Mailbox;
// use hopter::unwind::unw_table::{UnwindByteIter, UnwindInstrIter};
use hopter::{schedule, time::*};
// use postcard::from_bytes;
// use hopter::unwind::*;
use hopter::uart::*;
use hopter::{boot::main, debug::semihosting, hprintln};
// use stm32f4xx_hal::pac::USART1;
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::uart::Config;
// use stm32f4xx_hal::uart::{Rx, Tx};

// fn new_byte_slice(size: usize) -> Box<[u8]> {
//     vec![0; size].into_boxed_slice()
// }

#[main]
fn main(_: cortex_m::Peripherals) {
    // for remote unwinder to work, this section must be executed before any other code
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
    let session: Session<UsartSerial, UsartTimer, 150, 2> = Session::new(usart_serial, usart_timer);

    unsafe { G_UART_SESSION = Some(session) };

    // now we can panic and get restarted
    match schedule::start_restartable_task(2, |_| will_panic(), (), 0, 4) {
        Ok(_) => {
            hprintln!("Task started");
        }
        Err(e) => {
            hprintln!("Error: {:?}", e);
        }
    }
    sleep_ms(40000);
    hprintln!("finished with restarting tasks, exiting");
    semihosting::terminate(true);
}
fn will_panic() {
    static CNT: AtomicUsize = AtomicUsize::new(0);

    // Every time the task runs we increment it by 1.
    let cnt = CNT.fetch_add(1, Ordering::SeqCst);
    hprintln!("will_panic {}", cnt);
    if cnt > 0 {
        hprintln!("task sleeping {}", cnt);
        sleep_ms(15000);
    }
    hprintln!("task woke up {}", cnt);
    if cnt < 2 {
        hprintln!("Panic number: {}", cnt);
        panic!("Panic number: {}", cnt);
    }

    hprintln!("panic passed {}", cnt);
    sleep_ms(10000);
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
