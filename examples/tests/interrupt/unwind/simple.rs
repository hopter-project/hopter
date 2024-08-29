//! Tests that panics can be caught in an interrupt handler.

#![no_main]
#![no_std]
#![feature(naked_functions)]

extern crate alloc;

use core::sync::atomic::{AtomicUsize, Ordering};
use hopter::{
    debug::semihosting::{self, dbg_println},
    interrupt::declare::{handler, irq},
    sync::SpinIrqSafe,
    task::main,
};
use stm32f4xx_hal::{
    pac::{Interrupt, Peripherals, TIM2},
    prelude::*,
    timer::{CounterUs, Event},
};

irq!(Tim2Irq, Interrupt::TIM2);
static TIMER: SpinIrqSafe<Option<CounterUs<TIM2>>, Tim2Irq> = SpinIrqSafe::new(None);

#[main]
fn main(_cp: cortex_m::Peripherals) {
    let dp = Peripherals::take().unwrap();

    // For unknown reason QEMU accepts only the following clock frequency.
    let rcc = dp.RCC.constrain();
    // let clocks = rcc.cfgr.sysclk(16.MHz()).pclk1(8.MHz()).freeze();
    #[cfg(feature = "stm32f411")]
    let clocks = rcc.cfgr.sysclk(180.MHz()).pclk1(90.MHz()).freeze();
    #[cfg(feature = "stm32f407")]
    let clocks = rcc.cfgr.sysclk(168.MHz()).pclk1(84.MHz()).freeze();

    let mut timer = dp.TIM2.counter(&clocks);

    // Generate an interrupt when the timer expires.
    timer.listen(Event::Update);

    // Enable TIM2 interrupt.
    unsafe {
        cortex_m::peripheral::NVIC::unmask(Interrupt::TIM2);
    }

    // Set the timer to expire every 1 second.
    // Empirically when set to 62 seconds the interval is actually
    // approximately 1 second. Weird QEMU.
    // timer.start(62.secs()).unwrap();
    timer.start(1.secs()).unwrap();

    // Move the timer into the global storage to prevent it from being dropped.
    *TIMER.lock() = Some(timer);
}

/// Get invoked approximately every 1 second.
#[handler(TIM2)]
fn tim2_handler() {
    static IRQ_CNT: AtomicUsize = AtomicUsize::new(0);
    let prev_cnt = IRQ_CNT.fetch_add(1, Ordering::SeqCst);

    let _print_on_drop = PrintOnDrop("Resource released");

    if prev_cnt % 2 == 0 {
        panic!();
    }

    dbg_println!("TIM2 IRQ count {}", prev_cnt);

    if prev_cnt >= 5 {
        // semihosting::terminate(true);
        semihosting::dbg_println!("test complete!");
        loop {}
    }
}

struct PrintOnDrop(&'static str);

impl Drop for PrintOnDrop {
    fn drop(&mut self) {
        dbg_println!("{}", self.0);
    }
}
