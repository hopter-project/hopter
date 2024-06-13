#![no_std]
#![no_main]

extern crate alloc;
use core::fmt::Write;

use alloc::string::String;
use hopter::{boot::main, debug::semihosting, hprint, hprintln};
use nb::block;
use stm32f4xx_hal::{
    dma::CurrentBuffer, gpio::GpioExt, pac::USART1, prelude::*, rcc::RccExt, serial::Serial,
    uart::Config,
};
const MESSSAGE_SIZE: usize = 60;
const CHECKSUM_SIZE: usize = 4;
const PACKET_SIZE: usize = MESSSAGE_SIZE + CHECKSUM_SIZE;
const FILESIZE: usize = 1000;

struct Packet {
    data: [u8; 60],
    sequence: u32,
    checksum: u32,
}

fn send_filesize(filesize: usize, usart1: &mut Serial<USART1>) {
    let filesize_bytes = filesize.to_le_bytes();
    for i in 0..CHECKSUM_SIZE {
        usart1.write(filesize_bytes[i] as u8).unwrap();
    }
}
fn send_binary(binary: [u8; FILESIZE], usart1: &mut Serial<USART1>, filesize: usize) {
    let mut current_read_size = 0;
    let mut checksum: u32 = 0;
    while current_read_size < filesize {
        // hprintln!("current read size: {}", current_read_size);
        let mut data: [u8; PACKET_SIZE] = [0; PACKET_SIZE];
        for i in 0..MESSSAGE_SIZE {
            if current_read_size + i >= filesize {
                break;
            }
            data[i] = binary[current_read_size + i];
        }
        checksum = crc32fast::hash(&data[0..MESSSAGE_SIZE]);
        for i in MESSSAGE_SIZE..PACKET_SIZE {
            data[i] = checksum.to_le_bytes()[i - MESSSAGE_SIZE];
        }

        for i in 0..PACKET_SIZE {
            usart1.write(data[i] as u8).unwrap();
        }
        current_read_size += MESSSAGE_SIZE;
    }
}

// print 32 bit number as hex with spaces
fn print_checksum(checksum: u32) {
    let bytes = checksum.to_le_bytes();
    for i in 0..4 {
        hprint!("{:02X?} ", bytes[i]);
    }
    hprint!("\n");
}
fn print_slice(slice: [u8; 64]) {
    for i in 0..8 {
        for j in 0..8 {
            hprint!("{:02X?} ", slice[(8 * i) + j]);
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

    // For MCU
    // steps to sending a binary file as packets with checksums
    // send total filesize as a 32 bit number, or [u8; 4]
    // loop:
    //     read 252 bytes from file
    //     calculate checksum
    //     send 256 byte packet with message + checksum
    //     the last package should still be 256 bytes with the last 4 bytes as the checksum. Reciever will handle storing only the correct bytes

    // For Reciever
    // on connect, read 4 bytes as total filesize
    // loop:
    //     read bytes and increment current read size
    //     store chunks of 252 bytes incramentally, calculate checksum
    //     when current read size > total filesize, read checksum immediately

    // binary will be the serialized data we want to send
    // this will assume we have a separate way of serializing and deserialzing the data
    // filesize is arbitrary, and should work with any size
    let mut binary: [u8; FILESIZE] = [0; FILESIZE];
    // fill binary with arbitrary data
    for i in 0..FILESIZE {
        binary[i] = i as u8;
    }

    // first send the filesize as a 32 bit number
    send_filesize(FILESIZE, &mut usart1);

    // send the binary data in chunks of 252 bytes
    send_binary(binary, &mut usart1, FILESIZE);

    let mut data: [u8; PACKET_SIZE] = [0; PACKET_SIZE];
    for i in 0..PACKET_SIZE {
        data[i] = usart1.read().unwrap();
    }
    print_slice(data);
    semihosting::terminate(true);
}
