//! Tests notifying a task from an ISR with `try_down_allow_isr`.

#![no_main]
#![no_std]
#![feature(naked_functions)]

extern crate alloc;

use core::sync::atomic::{AtomicUsize, Ordering};
use hopter::{
    boot::main,
    config,
    debug::semihosting,
    declare_irq, hprintln,
    interrupt::handler,
    sync::{Semaphore, SpinIrqSafe},
    task,
};
use stm32f4xx_hal::{
    pac::{Interrupt, Peripherals, TIM2},
    prelude::*,
    timer::{CounterUs, Event},
};

declare_irq!(Tim2Irq, Interrupt::TIM2);
static TIMER: SpinIrqSafe<Option<CounterUs<TIM2>>, Tim2Irq> = SpinIrqSafe::new(None);

static SEMAPHORE: Semaphore = Semaphore::new(1, 1);

#[main]
fn main(_cp: cortex_m::Peripherals) {
    // Allow the new task below to run first until it blocks.
    task::change_current_priority(config::DEFAULT_TASK_PRIORITY).unwrap();

    // The new task should block on the semaphore.
    task::build()
        .set_entry(up_function)
        .set_priority(config::DEFAULT_TASK_PRIORITY - 1)
        .spawn()
        .unwrap();

    let dp = Peripherals::take().unwrap();

    // For unknown reason QEMU accepts only the following clock frequency.
    let rcc = dp.RCC.constrain();
    let clocks = rcc.cfgr.sysclk(16.MHz()).pclk1(8.MHz()).freeze();

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
    timer.start(62.secs()).unwrap();

    // Move the timer into the global storage to prevent it from being dropped.
    *TIMER.lock() = Some(timer);
}

fn up_function() {
    for _ in 0..3 {
        hprintln!("Before task blocking");
        SEMAPHORE.up();
        hprintln!("After task resuming");
    }
    semihosting::terminate(true);
}

/// Get invoked approximately every 1 second.
#[handler(TIM2)]
extern "C" fn tim2_handler() {
    // Only run this handler for three times. If running more than three times,
    // the test task must have been stuck.
    static COUNT: AtomicUsize = AtomicUsize::new(0);
    if COUNT.fetch_add(1, Ordering::SeqCst) >= 3 {
        semihosting::terminate(false);
    }

    // Attempt to consume from the channel. Assuming that the task can keep up
    // with the interval of 1 second, which should just be unless QEMU is super
    // broken.
    let result = SEMAPHORE.try_down_allow_isr();
    match result {
        Ok(_) => {
            hprintln!("Semaphore down to {}", SEMAPHORE.count())
        }
        Err(_) => {
            hprintln!("Failed to down");
            semihosting::terminate(false);
        }
    }
}
