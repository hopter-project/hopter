//! Test consume() and try_consume_allow_isr() functionality for empty and full channels
#![no_main]
#![no_std]

extern crate alloc;
use hopter::{debug::semihosting, hprintln, sync, task::main};

#[main]
fn main(_: cortex_m::Peripherals) {
    // Create a channel with a buffer capacity of 4 elements
    let (producer, consumer) = sync::create_channel::<usize, 4>();

    // Attempt to consume from an empty channel. Should return `None`.
    let result = consumer.try_consume_allow_isr();

    // Check against expected behavior
    if result != None {
        hprintln!("consumed from an empty channel");
        semihosting::terminate(false);
    }

    // Fill channel to capacity with 4 elements
    for i in 0..4 {
        producer.produce(i);
    }

    // Empty channel by consuming iteratively, checking the element was consumed sucessfully each time
    // otherwise, report error.
    for _i in 0..4 {
        let result = consumer.try_consume_allow_isr();
        if result == None {
            hprintln!("failed to consume from a non-empty channel");
            semihosting::terminate(false);
        }
    }

    // Attempt to consume from the empty channel. Should return `None`.
    let final_result = consumer.try_consume_allow_isr();
    match final_result {
        None => {
            hprintln!("Test Passed");
            semihosting::terminate(true);
        }
        Some(_t) => {
            hprintln!("consumed from an empty channel");
            semihosting::terminate(false);
        }
    }
}
