//! Tests producing data to a task from an ISR with
//! `produce_with_overflow_allow_isr`.

#![no_main]
#![no_std]
#![feature(naked_functions)]

extern crate alloc;

use core::sync::atomic::{AtomicUsize, Ordering};
use hopter::{
    config,
    debug::semihosting::{self, dbg_println},
    interrupt::declare::{handler, irq},
    sync,
    sync::{Consumer, Producer, SpinIrqSafe},
    task,
    task::main,
};
use stm32f4xx_hal::{
    pac::{Interrupt, Peripherals, TIM2},
    prelude::*,
    timer::{CounterUs, Event},
};

irq!(Tim2Irq, Interrupt::TIM2);
static TIMER: SpinIrqSafe<Option<CounterUs<TIM2>>, Tim2Irq> = SpinIrqSafe::new(None);
static CHANNEL_PRODUCER: SpinIrqSafe<Option<Producer<usize, 2>>, Tim2Irq> = SpinIrqSafe::new(None);

#[main]
fn main(_cp: cortex_m::Peripherals) {
    // Allow the new task below to run first until it blocks.
    task::change_current_priority(config::DEFAULT_TASK_PRIORITY).unwrap();

    // Initalize channel
    let (producer, consumer) = sync::create_channel::<usize, 2>();
    *CHANNEL_PRODUCER.lock() = Some(producer);

    // The new task should block on the channel.
    task::build()
        .set_entry(move || consume_function(consumer))
        .set_priority(config::DEFAULT_TASK_PRIORITY - 1)
        .spawn()
        .unwrap();

    let dp = Peripherals::take().unwrap();

    // For unknown reason QEMU accepts only the following clock frequency.
    let rcc = dp.RCC.constrain();

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
    timer.start(1.secs()).unwrap();

    // Move the timer into the global storage to prevent it from being dropped.
    *TIMER.lock() = Some(timer);
}

fn consume_function(consumer: Consumer<usize, 2>) {
    // Consume the first three values produced. The buffer of the channel
    // should be able to hold two more values produced.
    for _ in 0..3 {
        let val = consumer.consume();
        dbg_println!("Consumed {}", val);
    }
}

/// Get invoked approximately every 1 second.
#[handler(TIM2)]
extern "C" fn tim2_handler() {
    TIMER.lock().as_mut().unwrap().wait();

    static COUNT: AtomicUsize = AtomicUsize::new(0);
    let prev_cnt = COUNT.fetch_add(1, Ordering::SeqCst);

    // Attempt to consume from the channel. Assuming that the task can keep up
    // with the interval of 1 second, which should just be unless QEMU is super
    // broken.
    if let Some(producer) = CHANNEL_PRODUCER.lock().as_ref() {
        let result = producer.try_produce_allow_isr(prev_cnt);
        match result {
            // The first 5 produce attempt should be successful.
            Ok(_) => {
                if COUNT.load(Ordering::SeqCst) > 5 {
                    // semihosting::terminate(false);
                    semihosting::dbg_println!("test complete!");
                    loop {}
                }
            }
            // The 6th produce attempt should be unsuccessful.
            Err(_) => {
                dbg_println!("Failed to produce");
                if COUNT.load(Ordering::SeqCst) == 6 {
                    // semihosting::terminate(true);
                    semihosting::dbg_println!("test complete!");
                    loop {}
                }
                dbg_println!("Unexpectedly succeed to produce");
                // semihosting::terminate(false);
                semihosting::dbg_println!("test complete!");
                loop {}
            }
        }
    } else {
        dbg_println!("Producer not initialized!");
        // semihosting::terminate(false);
        semihosting::dbg_println!("test complete!");
        loop {}
    }
}
