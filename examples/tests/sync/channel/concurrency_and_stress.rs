//! Tests the behavior of multiple producer tasks writing to a shared channel  
//! (This test is similar to the test "multiple_producers", but includes more tasks and elements produced on the channel)
//! It creates four tasks, each producing a sequence of numbers, and verifies that all numbers are correctly
//! produced and consumed in the expected order.

#![no_main]
#![no_std]

extern crate alloc;
use alloc::vec;
use alloc::vec::Vec;
use core::sync::atomic::{AtomicUsize, Ordering};
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync,
    sync::Producer,
    task,
    task::main,
};

const NUM_TASKS: usize = 4;
const NUM_ITEMS: usize = 3; // Number of items each task will produce
static TASK_COMPLETION_COUNTER: AtomicUsize = AtomicUsize::new(0); // Counter to track task completion

#[main]
fn main(_: cortex_m::Peripherals) {
    // Create a channel with a buffering capacity of 16
    let (producer, consumer) = sync::create_channel::<usize, 16>();

    // Create and spawn 4 producer tasks, each with different priorities and a cloned producer
    let mut producer2 = producer.clone();
    task::build()
        .set_entry(move || fill_channel(&mut producer2, 2))
        .set_priority(1)
        .spawn()
        .unwrap();

    let mut producer3 = producer.clone();
    task::build()
        .set_entry(move || fill_channel(&mut producer3, 3))
        .set_priority(2)
        .spawn()
        .unwrap();

    let mut producer4 = producer.clone();
    task::build()
        .set_entry(move || fill_channel(&mut producer4, 4))
        .set_priority(3)
        .spawn()
        .unwrap();

    let mut producer5 = producer.clone();
    task::build()
        .set_entry(move || fill_channel(&mut producer5, 5))
        .set_priority(3)
        .spawn()
        .unwrap();

    // Change the priority of the current task to allow producer tasks to run first
    task::change_current_priority(10).unwrap();

    // Consume the numbers produced by the tasks, storing them in a vector
    let mut results = vec![];
    for _ in 0..(NUM_TASKS * NUM_ITEMS) {
        results.push(consumer.consume()); // Consume and store each item produced by the tasks
    }

    // Create a vector of the expected results for comparison
    // compare_vec = [6..18]
    let compare_vec = (6..(NUM_TASKS * NUM_TASKS + 2)).collect::<Vec<_>>();

    // Check if the produced results match the expected sequence
    if results != compare_vec {
        dbg_println!("Test Failed");
        #[cfg(feature = "qemu")]
        semihosting::terminate(false);
        #[cfg(not(feature = "qemu"))]
        {
            dbg_println!("test complete!");
            loop {}
        }
    }
    dbg_println!("Test Passed");
    #[cfg(feature = "qemu")]
    semihosting::terminate(true);
    #[cfg(not(feature = "qemu"))]
    {
        dbg_println!("test complete!");
        loop {}
    }
}

fn fill_channel(producer: &mut Producer<usize, 16>, task_num: usize) {
    // Each task produces a sequence of 3 (NUM_ITEMS) numbers based on its task number
    for j in 0..NUM_ITEMS {
        // Conditionally yield to add more stress.
        if j == task_num {
            task::yield_current();
        }
        producer.produce(task_num * NUM_ITEMS + j);
    }

    TASK_COMPLETION_COUNTER.fetch_add(1, Ordering::SeqCst);
}
