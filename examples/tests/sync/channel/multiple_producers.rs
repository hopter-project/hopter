//! Tests behavior of a multi-producer, single-consumer channel
//! It spawns two producer tasks with different priorities that add elements to a shared channel,
//! and then consumes the elements in a specific order to verify the correct sequence

#![no_main]
#![no_std]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync,
    sync::Producer,
    task,
    task::main,
};

#[main]
fn main(_: cortex_m::Peripherals) {
    // create a channel with a buffer capacity of 4
    let (mut producer, consumer) = sync::create_channel::<usize, 4>();
    // Clone the producer to allow multiple producers to push data into the channel
    let mut producer2 = producer.clone();

    // Spawn a task with the first producer
    task::build()
        .set_entry(move || produce_thread(&mut producer))
        .set_priority(1)
        .spawn()
        .unwrap();
    // Spawn a task with the second producer
    task::build()
        .set_entry(move || produce2_thread(&mut producer2))
        .set_priority(2)
        .spawn()
        .unwrap();

    // Change the priority of the current task to 10
    // This allows the consumer to run after both producers have executed
    task::change_current_priority(10).unwrap();

    // Consume values from the channel and store them in a vector
    let values = [
        consumer.consume(),
        consumer.consume(),
        consumer.consume(),
        consumer.consume(),
    ];

    // Verify the consumed values against the expected order
    if values != [1, 2, 3, 4] {
        dbg_println!("Test Failed");
        semihosting::terminate(false);
    }
    dbg_println!("Test Passed");
    semihosting::terminate(true);
}

fn produce_thread(producer: &mut Producer<usize, 4>) {
    producer.produce(1);
    producer.produce(2);
}

fn produce2_thread(producer2: &mut Producer<usize, 4>) {
    producer2.produce(3);
    producer2.produce(4);
}
