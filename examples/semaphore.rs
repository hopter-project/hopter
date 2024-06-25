#![no_std]
#![no_main]
extern crate alloc;

use crate::hal::{
    prelude::*,
    timer::{Event, Timer},
};
use core::cell::{Cell, RefCell};
use core::ops::DerefMut;
use cortex_m;
use hopter::{boot::main, debug::semihosting, hprintln, uart::*};

use cortex_m::interrupt::{free, Mutex};
use cortex_m::peripheral::NVIC;
use stm32f4xx_hal as hal;
use stm32f4xx_hal::pac::Interrupt;
static LED_STATE: Mutex<Cell<bool>> = Mutex::new(Cell::new(false));
static TIMER_TIM2: Mutex<RefCell<Option<Timer<TIM2>>>> =
    Mutex::new(RefCell::new(None));

#[interrupt]
fn TIM2() {
    free(|cs| {
        if let Some(ref mut tim2) = TIMER_TIM2.borrow(cs).borrow_mut().deref_mut() {
            tim2.clear_interrupt(Event::TimeOut);
        }
        let led_state = LED_STATE.borrow(cs);
        led_state.replace(!led_state.get());
    });
}

#[main]
fn main(_: cortex_m::Peripherals) {
    let dp = stm32f4xx_hal::pac::Peripherals::take().unwrap();
    // Set up the LED
    let gpiob = dp.GPIOB.split();
    let mut led = gpiob.pb7.into_push_pull_output();

    // Set up the system clock
    let rcc = dp.RCC.constrain();
    let clocks = rcc.cfgr.sysclk(48.mhz()).freeze();

    // Set up the interrupt timer
    let mut timer = Timer::tim2(dp.TIM2, 10.hz(), clocks);
    timer.listen(Event::TimeOut);

    free(|cs| {
        TIMER_TIM2.borrow(cs).replace(Some(timer));
    });

    // Enable interrupt
    NVIC::unpend(Interrupt::TIM2);
    unsafe {
        NVIC::unmask(Interrupt::TIM2);
    }

    loop {
        if free(|cs| LED_STATE.borrow(cs).get()) {
            led.set_high().unwrap();
        } else {
            led.set_low().unwrap();
        }
    }
    semihosting::terminate(true);
}
