#![no_std]
#![no_main]

extern crate alloc;
use core::fmt::Write;

use alloc::string::String;
use hopter::{boot::main, debug::semihosting};
use nb::block;
use stm32f4xx_hal::{gpio::GpioExt, prelude::*, rcc::RccExt, serial::Serial, uart::Config};

// Attribute `#[main]` marks the function as the entry function for the main
// task. The function name can be arbitrary. The main function should accept
// one argument which is the Cortex-M core peripherals.
#[main]
fn main(_: cortex_m::Peripherals) {
    // Take the board peripherals.
    // NOTE: must not use the `take()` method, because it contains a
    // `cortex_m::interrupt::free` block, which will conflict with the
    // segmented stack implementation via SVC.
    let dp = unsafe { stm32f4xx_hal::pac::Peripherals::steal() };

    // Configure the clocks on the board.
    let clocks = dp.RCC.constrain().cfgr.freeze();

    // Take the pins used for USART1.
    // PA9 is for TX, PA10 is for RX.
    // They should be set to mode alternative function 7.
    // See STM32F405 datasheet for details.
    // https://www.st.com/resource/en/datasheet/stm32f405rg.pdf
    let gpioa = dp.GPIOA.split();
    let usart1_pins = (
        gpioa.pa9.into_alternate::<7>(),
        gpioa.pa10.into_alternate::<7>(),
    );

    // Initialize USART1. The baudrate is not meaningful on QEMU, but is
    // important on physical hardware.
    let mut usart1: Serial<_, u8> = dp
        .USART1
        .serial(
            usart1_pins,
            Config::default().baudrate(115200.bps()),
            &clocks,
        )
        .unwrap();

    // Read characters into a string until a new line is observed.
    let mut s = String::new();
    loop {
        let c = block!(usart1.read()).unwrap().try_into().unwrap();
        s.push(c);
        if c == '\n' || c == '\r' {
            break;
        }
    }

    // Echo the line back.
    usart1.write_str(&s).unwrap();

    // Write an additional new line.
    // This gives a nice print if the read line was ended by '\r'.
    usart1.write_str("\n").unwrap();

    // When running with QEMU, this will cause the QEMU process to terminate.
    // Do not include this line when running with OpenOCD, because it will
    // clobber its internal states.
    semihosting::terminate(true);
}
