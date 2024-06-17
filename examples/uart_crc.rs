#![no_std]
#![no_main]

extern crate alloc;


use alloc::string::String;
use hopter::{boot::main, debug::semihosting, hprint, hprintln};

use stm32f4xx_hal::{gpio::GpioExt, prelude::*, rcc::RccExt, serial::Serial, uart::Config};

#[derive(Debug)]
pub struct UnwindInfoPackage<'a> {
    func_addr: u32,
    s: &'a String,
}
// print 32 bit number as hex with spaces
fn print_checksum(checksum: u32) {
    let bytes = checksum.to_le_bytes();
    for i in 0..4 {
        hprint!("{:02X?} ", bytes[i]);
    }
    hprint!("\n");
}
fn print_slice(slice: [u8; 256]) {
    for i in 0..16 {
        for j in 0..16 {
            hprint!("{:02X?} ", slice[(16 * i) + j]);
        }
        hprint!("\n");
    }
    hprint!("\n");
}
// Attribute `#[main]` marks the function as the entry function for the main
// task. The function name can be arbitrary. The main function should accept
// one argument which is the Cortex-M core peripherals.
#[main]
fn main(_: cortex_m::Peripherals) {
    hprintln!("Starting qemu test...");
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

    let mut package: [u8; 252] = [0; 252];
    for i in 0..252 {
        package[i] = i as u8;
    }

    let mut data: [u8; 256] = [0; 256];
    for i in 0..252 {
        data[i] = package[i];
    }

    let checksum = crc32fast::hash(&data[0..252]);
    for i in 252..256 {
        hprintln!("{:02X}", checksum.to_le_bytes()[i - 252]);
        data[i] = checksum.to_le_bytes()[i - 252];
    }
    print_slice(data);
    print_checksum(checksum);

    for i in 0..256 {
        usart1.write(data[i] as u8).unwrap();
    }
    semihosting::terminate(true);
}
