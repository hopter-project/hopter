//! Stress test for semaphore. 10 tasks contend on a semaphore to increment the
//! counter.

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, config, debug::semihosting, hprintln, sync::Mutex, task};

static MUTEX: Mutex<usize> = Mutex::new(0);
const ITERATIONS: usize = 10;
const NUM_TASK: usize = 10;

#[main]
fn main(_: cortex_m::Peripherals) {
    for i in 0..NUM_TASK {
        task::build()
            .set_entry(move || test_task(i))
            .spawn()
            .unwrap();
    }

    // Let the test tasks run first.
    task::change_current_priority(config::DEFAULT_TASK_PRIORITY + 1).unwrap();

    if *MUTEX.lock() == ITERATIONS * NUM_TASK {
        hprintln!("Test Passed");
        semihosting::terminate(true);
    } else {
        hprintln!("Test Failed");
        semihosting::terminate(false);
    }
}

fn test_task(num: usize) {
    for i in 0..ITERATIONS {
        let mut guard = MUTEX.lock();

        // Add some context switching stress.
        if num == i {
            task::yield_current();
        }

        *guard += 1;
    }
}
