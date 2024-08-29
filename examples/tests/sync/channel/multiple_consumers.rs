//! Tests  the correct behavior of a multi-consumer, single-producer channel
//! It fills a channel with four elements, spawns two consumer tasks with different priorities to consume the elements,
//! and then checks that the channel is empty after all elements have been consumed.

#![no_main]
#![no_std]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync,
    sync::Consumer,
    task,
    task::main,
};

#[main]
fn main(_: cortex_m::Peripherals) {
    // create a channel with a buffer capacity of 4
    let (producer, consumer) = sync::create_channel::<usize, 4>();

    // fill channel with 4 elements
    producer.produce(1);
    producer.produce(2);
    producer.produce(3);
    producer.produce(4);
    // Clone the consumer to allow multiple consumers to pull data from the channel
    let mut consumer2 = consumer.clone();
    let mut consumer3 = consumer.clone();

    // Spawn the first consumer task with priority 1
    task::build()
        .set_entry(move || consume_function(&mut consumer2))
        .set_priority(1)
        .spawn()
        .unwrap();
    // Spawn the second consumer task with priority 2
    task::build()
        .set_entry(move || consume_function(&mut consumer3))
        .set_priority(2)
        .spawn()
        .unwrap();

    // Change the priority of the current task to 10
    // This ensures that both consumer tasks run before the final check
    task::change_current_priority(10).unwrap();

    // Check if the channel is empty after both consumers have finished
    if consumer.try_consume_allow_isr() != None {
        dbg_println!("Channel not empty");
        // semihosting::terminate(false);
        dbg_println!("test complete!");
        loop {}
    }
    dbg_println!("Test Passed");
    // semihosting::terminate(true);
    dbg_println!("test complete!");
    loop {}
}

fn consume_function(consumer: &mut Consumer<usize, 4>) {
    dbg_println!("{}", consumer.consume());
    dbg_println!("{}", consumer.consume());
}
