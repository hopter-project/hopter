//! Test functionality of produce() and produce_with_overflow_allow_isr() for empty and full channels

#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync};

#[main]
fn main(_: cortex_m::Peripherals) {
    // Create a channel with a buffer capacity of 4
    let (producer, consumer) = sync::create_channel::<usize, 4>();

    // Fill channel with values 0-3 inclusive
    for i in 0..=3 {
        producer.produce(i);
    }

    // Attempt to push values 4-7. `produce_with_overflow_allow_isr` should
    // return the value we attempt to push each time.
    for i in 4..=7 {
        let result = producer.try_produce_allow_isr(i);
        if result != Err(i) {
            hprintln!("Test Failed");
            semihosting::terminate(false);
        }
    }

    // Consume each value in channel, confirming the values are 0-3
    for i in 0..4 {
        let value = consumer.consume();
        if value != i {
            hprintln!("Test Failed");
            semihosting::terminate(false);
        }
    }
    hprintln!("Test Passed");
    semihosting::terminate(true);
}
