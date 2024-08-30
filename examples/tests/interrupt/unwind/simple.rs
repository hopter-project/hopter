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

<<<<<<< HEAD
    #[cfg(feature = "qemu")]
    let clocks = rcc.cfgr.sysclk(16.MHz()).pclk1(8.MHz()).freeze();
=======
>>>>>>> 8a5aa34 (change STM32F411 clock)
    #[cfg(feature = "stm32f411")]
    let clocks = rcc
        .cfgr
        .use_hse(8.MHz())
        .sysclk(100.MHz())
        .pclk1(25.MHz())
        .pclk2(50.MHz())
        .freeze();
    #[cfg(feature = "stm32f407")]
    let clocks = rcc
        .cfgr
        .use_hse(8.MHz())
        .sysclk(168.MHz())
        .pclk1(42.MHz())
        .pclk2(84.MHz())
        .freeze();

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
    #[cfg(feature = "qemu")]
    timer.start(62.secs()).unwrap();
    #[cfg(not(feature = "qemu"))]
    timer.start(1.secs()).unwrap();

    // Move the timer into the global storage to prevent it from being dropped.
    *TIMER.lock() = Some(timer);
}

/// Get invoked approximately every 1 second.
#[handler(TIM2)]
fn tim2_handler() {
    TIMER.lock().as_mut().unwrap().wait();

    static IRQ_CNT: AtomicUsize = AtomicUsize::new(0);
    let prev_cnt = IRQ_CNT.fetch_add(1, Ordering::SeqCst);

    let _print_on_drop = PrintOnDrop("Resource released");

    if prev_cnt % 2 == 0 {
        panic!();
    }

    dbg_println!("TIM2 IRQ count {}", prev_cnt);

    if prev_cnt >= 5 {
        #[cfg(feature = "qemu")]
        semihosting::terminate(true);
        #[cfg(not(feature = "qemu"))]
        {
            dbg_println!("test complete!");
            loop {}
        }
    }
}

struct PrintOnDrop(&'static str);

impl Drop for PrintOnDrop {
    fn drop(&mut self) {
        dbg_println!("{}", self.0);
    }
}
