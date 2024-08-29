//! Test basic functionaliy of produce() and consume()

#![no_main]
#![no_std]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync,
    task::main,
};

#[main]
fn main(_: cortex_m::Peripherals) {
    // Create a channel with a buffer capacity of 4
    let (producer, consumer) = sync::create_channel::<usize, 4>();

    // Fill a channel with values 23-26
    producer.produce(23);
    producer.produce(24);
    producer.produce(25);
    producer.produce(26);

    // Consume each element from channel, verifying the expected value
    for i in 0..4 {
        let value = consumer.consume();
        if value != 23 + i {
            dbg_println!("Test Failed");
            // semihosting::terminate(false);
            dbg_println!("test complete!");
            loop {}
        }
    }
    dbg_println!("Test Passed");
    // semihosting::terminate(true);
    dbg_println!("test complete!");
    loop {}
}
