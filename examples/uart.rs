#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, uart::*};
use nb::block;
use stm32f4xx_hal::{
    gpio::GpioExt, pac::USART1, prelude::*, rcc::RccExt, serial::Serial,
    uart::Config,
};
struct UartSerial(Serial<USART1>);

impl UartRW for UartSerial {
    fn uart_read_byte(&mut self) -> Result<u8, UartError> {
        let buf = block!(self.0.read());
        match buf {
            Ok(byte) => Ok(byte),
            Err(_) => Err(UartError::ReadError),
        }
    }
    fn uart_write_byte(&mut self, byte: u8) -> Result<(), UartError> {
        let buf = block!(self.0.write(byte));
        match buf {
            Ok(_) => Ok(()),
            Err(_) => Err(UartError::WriteError),
        }
    }
}

#[main]
fn main(_: cortex_m::Peripherals) {
    hprintln!("Starting uart test...");

    let dp = unsafe { stm32f4xx_hal::pac::Peripherals::steal() };

    let clocks = dp.RCC.constrain().cfgr.freeze();

    let gpioa = dp.GPIOA.split();
    let usart1_pins = (
        gpioa.pa9.into_alternate::<7>(),
        gpioa.pa10.into_alternate::<7>(),
    );

    let usart1: Serial<_, u8> = dp
        .USART1
        .serial(
            usart1_pins,
            Config::default().baudrate(115200.bps()),
            &clocks,
        )
        .unwrap();
    let mut tmp_uart: UartSerial = UartSerial(usart1);
    let mut uart_crc = UartCrc::new(&mut tmp_uart);

    let mut request: heapless::Vec<u8, MAX_DATA_SIZE> = heapless::Vec::new();

    for i in 0..500 {
        request.push(i as u8).unwrap();
    }

    let mut chunk = Chunk::new([0; MESSSAGE_SIZE], 0);
    chunk.compute_checksum();
    // uart_crc.send_data_size(request.len() as usize);

    // uart_crc.send_data(request);
    uart_crc.send_data(request).unwrap();

    let binary: heapless::Vec<u8, MAX_DATA_SIZE> = uart_crc.listen_for_data().unwrap();
    print_data(&binary);
    // uart_crc.listen_for_response

    semihosting::terminate(true);
}
