#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, time::*, uart::*};
use nb::block;
use stm32f4xx_hal::pac::NVIC;
use stm32f4xx_hal::{
    gpio::GpioExt,
    pac::USART1,
    prelude::*,
    rcc::RccExt,
    rtc::Event,
    serial::Serial,
    timer::{CounterMs, Event, Timer},
    uart::Config,
};
struct UartSerial(Serial<USART1>);

impl UartRW for UartSerial {
    fn uart_read_byte(&mut self) -> Result<u8, UartError> {
        self.0.listen(event);
        let starting_tick = get_tick();
        while get_tick() - starting_tick < 10000 {
            let buf = self.0.read();
            match buf {
                Ok(byte) => return Ok(byte),
                Err(_) => continue,
            }
        }
        // hprintln!("Timeout");
        Err(UartError::Timeout)
    }
    fn uart_write_byte(&mut self, byte: u8) -> Result<(), UartError> {
        let starting_tick = get_tick();
        while get_tick() - starting_tick < 100 {
            let buf = self.0.write(byte);
            match buf {
                Ok(byte) => return Ok(()),
                Err(_) => continue,
            }
        }
        // hprintln!("Timeout");
        Err(UartError::Timeout)
    }
}

#[main]
fn main(_: cortex_m::Peripherals) {
    hprintln!("Starting uart test...");

    let dp = stm32f4xx_hal::pac::Peripherals::take();
    let clocks = dp.RCC.constrain().cfgr.sysclk(48.mhz()).freeze();

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

    let mut timer = Timer::tim2(dp.TIM2, 10.hz(), clocks);
    timer.listen(Event::TimeOut);

    free(|cs| {
        TIMER_TIM2.borrow(cs).replace(Some(timer));
    });

    stm32::NVIC::upend(hal::stm32::interrupt::TIM2);
    unsafe {
        stm32::NVIC::unmask(hal::stm32::interrupt::TIM2);
    }

    semihosting::terminate(true);
}
