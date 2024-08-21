//! Tests try_down_allow_isr functionality in periodic interrupts
#![no_main]
#![no_std]
#![feature(naked_functions)]

extern crate alloc;

use hopter::{
    boot::main,
    debug::semihosting,
    hprintln,
    interrupt::handler,
    sync::{AllIrqExceptSvc, MutexIrqSafe, Semaphore},
    task,
};
use stm32f4xx_hal::{
    pac::{Interrupt, Peripherals, TIM2},
    prelude::*,
    timer::{CounterUs, Event},
};

static TIMER: MutexIrqSafe<Option<CounterUs<TIM2>>, AllIrqExceptSvc> = MutexIrqSafe::new(None);

static SEMAPHORE: Semaphore = Semaphore::new(1, 1);

#[main]
fn main(_cp: cortex_m::Peripherals) {
    let dp = Peripherals::take().unwrap();

    // For unknown reason QEMU accepts only the following clock frequency.
    let rcc = dp.RCC.constrain();
    let clocks = rcc.cfgr.sysclk(16.MHz()).pclk1(8.MHz()).freeze();

    let mut timer = dp.TIM2.counter(&clocks);

    // Generate an interrupt when the timer expires.
    timer.listen(Event::Update);

    task::build()
        .set_entry(up_function)
        .set_priority(2)
        .spawn()
        .unwrap();

    // Enable TIM2 interrupt.
    unsafe {
        cortex_m::peripheral::NVIC::unmask(Interrupt::TIM2);
    }

    // Set the timer to expire every 1 second.
    // Empirically when set to 62 seconds the interval is actually
    // approximately 1 second. Weird QEMU.
    timer.start(62.secs()).unwrap();

    // Move the timer into the global storage to prevent it from being dropped.
    *TIMER.lock() = Some(timer);
}

fn up_function() {
    hprintln!("Before incrementing in task");
    SEMAPHORE.up();
    hprintln!("After incrementing in task");
    semihosting::terminate(true);
}

/// Get invoked approximately every 1 second.
#[handler(TIM2)]
extern "C" fn tim2_handler() {
    // attempt to increment SEMAPHORE
    let result = SEMAPHORE.try_down_allow_isr();
    match result {
        Ok(()) => {
            hprintln!("Semaphore decremented to {}", SEMAPHORE.count())
        }
        Err(()) => {
            hprintln!("Failed to decrement");
            semihosting::terminate(false);
        }
    }
}
