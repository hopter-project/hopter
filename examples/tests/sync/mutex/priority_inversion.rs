//! Tests mutex functionality against priority inversion

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{
    config,
    debug::semihosting::{self, dbg_println},
    sync::Mutex,
    task,
    task::main,
};

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
    dbg_println!("Low priority task locked mutex");

    // Spawn a high priority task
    task::build()
        .set_entry(high_task)
        .set_priority(config::DEFAULT_TASK_PRIORITY - 1)
        .spawn()
        .unwrap();

    dbg_println!("High priority task blocked by mutex and low priority task continued");
    dbg_println!("Low priority task got elevated to high priority");

    // Spawn a middle priority task
    task::build()
        .set_entry(middle_task)
        .set_priority(config::DEFAULT_TASK_PRIORITY)
        .spawn()
        .unwrap();

    dbg_println!("Middle priority task was not able to run for now");

    // Drop the mutex. Low priority task should be reduced back to low priority.
    core::mem::drop(guard);

    dbg_println!("Low priority task finished last");

    semihosting::terminate(true);
}

fn high_task() {
    dbg_println!("High priority task trying to lock mutex");
    let _guard = MUTEX.lock();
    dbg_println!("High priority task locked mutex");
}

fn middle_task() {
    dbg_println!("Middle priority task executed");
}
