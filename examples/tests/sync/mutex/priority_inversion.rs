//! Tests mutex functionality against priority inversion

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, config, debug::semihosting, hprintln, sync::Mutex, task};

// Define a global mutex
static MUTEX: Mutex<()> = Mutex::new(());

#[main]
fn main(_: cortex_m::Peripherals) {
    // Spawn a low priority task
    task::build()
        .set_entry(low_task)
        .set_priority(config::DEFAULT_TASK_PRIORITY + 1)
        .spawn()
        .unwrap();
}

fn low_task() {
    // Attempt to acquire the mutex
    let guard = MUTEX.lock();
    hprintln!("Low priority task locked mutex");

    // Spawn a high priority task
    task::build()
        .set_entry(high_task)
        .set_priority(config::DEFAULT_TASK_PRIORITY - 1)
        .spawn()
        .unwrap();

    hprintln!("High priority task blocked by mutex and low priority task continues");
    hprintln!("Low priority task got elevated to high priority");

    // Spawn a middle priority task
    task::build()
        .set_entry(middle_task)
        .set_priority(config::DEFAULT_TASK_PRIORITY)
        .spawn()
        .unwrap();

    hprintln!("Middle priority task was not able to run for now");

    // Drop the mutex. Low priority task should be reduced back to low priority.
    core::mem::drop(guard);

    hprintln!("Low priority task finished last");

    semihosting::terminate(true);
}

fn high_task() {
    hprintln!("High priority task trying to lock mutex");
    let _guard = MUTEX.lock();
    hprintln!("High priority task locked mutex");
}

fn middle_task() {
    hprintln!("Middle priority task executed");
}
