#![no_std]
#![no_main]

extern crate alloc;
use core::fmt::Write;

use alloc::string::String;
// use hopter::{boot::main, debug::semihosting, hprintln};
use hopter::{debug::semihosting, task::main};
use nb::block;
use stm32f4xx_hal::{gpio::GpioExt, prelude::*, rcc::RccExt, serial::Serial, uart::Config};

#[derive(Debug)]
pub struct UnwindInfoPackage<'a> {
    func_addr: u32,
    s: &'a String,
}

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

    // print test package struct
    // hprintln!("{:?}", test_package);

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

    // Send a string to the USART1.
    let data: [u8; 256] = [0; 256];
    for i in 0..256 {
        data[i] = i as u8;
    }
    usart1.write(data).unwrap();
    semihosting::terminate(true);
}
