#![no_std]
#![no_main]
#![feature(naked_functions)]
extern crate alloc;

use hopter::interrupt::handler;
use hopter::sync::Mailbox;
use hopter::{boot::main, debug::semihosting, hprintln};
use stm32f4xx_hal::pac::USART1;
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::uart::Config;
use stm32f4xx_hal::uart::Rx;

static mut G_MAILBOX: Option<Mailbox> = None;
static mut G_RX: Option<Rx<USART1>> = None;
static mut G_BYTE: u8 = 0;

// Attribute `#[main]` marks the function as the entry function for the main
// task. The function name can be arbitrary. The main function should accept
// one argument which is the Cortex-M core peripherals.
#[main]
fn main(_: cortex_m::Peripherals) {
    // Aquire the device peripherals and configure the gpio pins and clocks
    let dp = unsafe { stm32f4xx_hal::pac::Peripherals::steal() };
    let clocks = dp.RCC.constrain().cfgr.freeze();
    let gpioa = dp.GPIOA.split();

    // For USART1, the pins are PA9 and PA10, which need to be put in alternate mode 7
    let usart1_pins = (
        gpioa.pa9.into_alternate::<7>(),
        gpioa.pa10.into_alternate::<7>(),
    );

    // Initialize the USART1 peripheral with the pins and the baudrate
    // Split allows us to interact with tx and rx individually, for this example only rx is used
    let (_tx, mut rx) = dp
        .USART1
        .serial(
            usart1_pins,
            Config::default().baudrate(115200.bps()),
            &clocks,
        )
        .unwrap()
        .split();

    // Listen for incoming USART1 interrupt events
    // Then store rx in a global variable to be accessed in the interrupt handler
    rx.listen();

    unsafe {
        G_RX = Some(rx);

        // Create a global mailbox which will be used in the interrupt handler to signal data has been read
        G_MAILBOX = Some(Mailbox::new());
    }

    // Allow the USART1 interrupt to trigger when we receive data
    unsafe {
        cortex_m::peripheral::NVIC::unmask(stm32f4xx_hal::pac::Interrupt::USART1);
    }

    // If the mailbox is not signaled within 3000ms, the result will be false
    // Otherwise the interrupt handler will store the read byte in G_BYTE
    let mailbox_result = unsafe { G_MAILBOX.wait_until_timeout(3000) };

    if mailbox_result {
        hprintln!("Mailbox received data\n");
        let byte = unsafe { G_BYTE };
        hprintln!("Received byte: {}\n", byte);
    } else {
        hprintln!("Mailbox timeout\n");
    }

    // When running with QEMU, this will cause the QEMU process to terminate.
    // Do not include this line when running with OpenOCD, because it will
    // clobber its internal states.
    semihosting::terminate(true);
}

/// USART1 interrupt handler
/// Will read one byte from global rx and store it in G_BTYE, then notify the mailbox
#[handler(USART1)]
unsafe extern "C" fn usart1_handler() {
    cortex_m::interrupt::free(|_| {
        unsafe { G_BYTE = G_RX.as_mut().unwrap().read().unwrap() };
        G_MAILBOX.notify_allow_isr();
    });
}
