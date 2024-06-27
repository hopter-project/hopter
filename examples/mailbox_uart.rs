#![no_std]
#![no_main]
#![feature(naked_functions)]
extern crate alloc;

use hopter::interrupt::handler;
use hopter::sync::Mailbox;
use hopter::uart::UartCrc;
use hopter::uart::*;
use hopter::{boot::main, debug::semihosting};
use stm32f4xx_hal::pac::USART1;
use stm32f4xx_hal::prelude::*;
use stm32f4xx_hal::uart::Config;
use stm32f4xx_hal::uart::{Rx, Tx};

static G_MAILBOX: Mailbox = Mailbox::new();
static mut G_RX: Option<Rx<USART1>> = None;
static mut G_TX: Option<Tx<USART1>> = None;
static mut G_RBYTE: heapless::Deque<u8, CHUNK_SIZE> = heapless::Deque::new();
struct UartSerial();

impl UartRW for UartSerial {
    fn uart_read_byte(&mut self) -> Result<u8, UartError> {
        let result = G_MAILBOX.wait_until_timeout(3000);
        if result {
            let byte = unsafe { G_RBYTE.pop_front().unwrap() };
            Ok(byte)
        } else {
            Err(UartError::Timeout)
        }
    }
    fn uart_write_byte(&mut self, byte: u8) -> Result<(), UartError> {
        unsafe {
            G_TX.as_mut().unwrap().write(byte).unwrap();
        };
        Ok(())
    }
}

// Attribute `#[main]` marks the function as the entry function for the main
// task. The function name can be arbitrary. The main function should accept
// one argument which is the Cortex-M core peripherals.
#[main]
fn main(_: cortex_m::Peripherals) {
    // Note that this example requires qemu to have a valid serial connection
    // This can be enabled using the -serial tcp:localhost:4545 flag

    // Acquire the device peripherals and configure the gpio pins and clocks
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
    let (tx, mut rx) = dp
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
    // tx.listen();

    unsafe {
        G_RX = Some(rx);
        G_TX = Some(tx);
        // Create a global mailbox which will be used in the interrupt handler to signal data has been read
    }

    // Allow the USART1 interrupt to trigger when we receive data
    unsafe {
        cortex_m::peripheral::NVIC::unmask(stm32f4xx_hal::pac::Interrupt::USART1);
    }

    // Initialize the UartSerial, which now takes no input
    let mut usart = UartSerial();
    let mut usart = UartCrc::new(&mut usart);

    let mut request: heapless::Vec<u8, MAX_DATA_SIZE> = heapless::Vec::new();

    for i in 0..50 {
        request.push(i as u8).unwrap();
    }

    let mut chunk = Chunk::new([0; MESSAGE_SIZE], 0);
    chunk.compute_checksum();

    usart.send_data(request).unwrap();

    let binary: heapless::Vec<u8, MAX_DATA_SIZE> = usart.listen_for_data().unwrap();
    print_data(&binary);

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
        unsafe {
            let _ = G_RBYTE.push_back(G_RX.as_mut().unwrap().read().unwrap());
        };

        // Notify the mailbox that a byte is available to read by incrementing the counter
        G_MAILBOX.notify_allow_isr();
    });
}
