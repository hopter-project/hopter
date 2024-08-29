//! Tests consuming data produced in a task from an ISR with `try_consume_allow_isr`.

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
static CHANNEL_CONSUMER: SpinIrqSafe<Option<Consumer<usize, 2>>, Tim2Irq> = SpinIrqSafe::new(None);

#[main]
fn main(_cp: cortex_m::Peripherals) {
    // Allow the new task below to run first until it blocks.
    task::change_current_priority(config::DEFAULT_TASK_PRIORITY).unwrap();

    // Initalize channel
    let (producer, consumer) = sync::create_channel::<usize, 2>();
    *CHANNEL_CONSUMER.lock() = Some(consumer);
    producer.produce(0);
    producer.produce(1);

    // The new task should block on the channel.
    task::build()
        .set_entry(move || produce_function(producer))
        .set_priority(config::DEFAULT_TASK_PRIORITY - 1)
        .spawn()
        .unwrap();

    let dp = Peripherals::take().unwrap();

    // For unknown reason QEMU accepts only the following clock frequency.
    let rcc = dp.RCC.constrain();

    #[cfg(feature = "qemu")]
    let clocks = rcc.cfgr.sysclk(16.MHz()).pclk1(8.MHz()).freeze();
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

fn produce_function(producer: Producer<usize, 2>) {
    for i in 2..5 {
        producer.produce(i);
    }
}

/// Get invoked approximately every 1 second.
#[handler(TIM2)]
fn tim2_handler() {
    TIMER.lock().as_mut().unwrap().wait();

    static COUNT: AtomicUsize = AtomicUsize::new(0);
    COUNT.fetch_add(1, Ordering::SeqCst);

    // Attempt to consume from the channel. Assuming that the task can keep up
    // with the interval of 1 second, which should just be unless QEMU is super
    // broken.
    if let Some(consumer) = CHANNEL_CONSUMER.lock().as_ref() {
        let result = consumer.try_consume_allow_isr();
        match result {
            // The first 5 consume attempt should be successful.
            Some(value) => {
                dbg_println!("Consumed {}", value);
                if COUNT.load(Ordering::SeqCst) > 5 {
                    #[cfg(feature = "qemu")]
                    semihosting::terminate(false);
                    #[cfg(not(feature = "qemu"))]
                    {
                        dbg_println!("test complete!");
                        loop {}
                    }
                }
            }
            // The 6th consume attempt should be unsuccessful.
            None => {
                dbg_println!("Failed to consume");
                if COUNT.load(Ordering::SeqCst) == 6 {
                    #[cfg(feature = "qemu")]
                    semihosting::terminate(true);
                    #[cfg(not(feature = "qemu"))]
                    {
                        dbg_println!("test complete!");
                        loop {}
                    }
                }
                dbg_println!("Unexpectedly succeed to consume");
                #[cfg(feature = "qemu")]
                semihosting::terminate(false);
                #[cfg(not(feature = "qemu"))]
                {
                    dbg_println!("test complete!");
                    loop {}
                }
            }
        }
    } else {
        dbg_println!("Consumer not initialized!");
        #[cfg(feature = "qemu")]
        semihosting::terminate(false);
        #[cfg(not(feature = "qemu"))]
        {
            dbg_println!("test complete!");
            loop {}
        }
    }
}
