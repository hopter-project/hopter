//! Tests mutex functionality against priority inversion

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, config, debug::semihosting, hprintln, sync::Mutex, task};

// Define a global mutex
static MUTEX: Mutex<()> = Mutex::new(());

#[main]
fn main(_: cortex_m::Peripherals) {
    
    // Acquire the mutex lock
    let guard = MUTEX.lock();
    
    // Spawn a low priority task
    task::build()
    .set_entry(low_task)
    .set_priority(config::DEFAULT_TASK_PRIORITY + 1)
    .spawn()
    .unwrap();

    // Let the test tasks run. But they will be blocked by the mutex.
    task::change_current_priority(config::DEFAULT_TASK_PRIORITY + 2).unwrap();

    // Release the mutex and the test tasks should be woken up based on their
    // respective priority.
    core::mem::drop(guard);

    
    semihosting::terminate(true);

}

fn low_task() {
    // Attempt to acquire the mutex
    let _guard = MUTEX.lock();
    hprintln!("Low priority task locking data");

    // Spawn a high priority task
    task::build()
    .set_entry(high_task)
    .set_priority(config::DEFAULT_TASK_PRIORITY - 1)
    .spawn()
    .unwrap();

    // Spawn a middle priority task
    task::build()
    .set_entry(middle_task)
    .set_priority(config::DEFAULT_TASK_PRIORITY)
    .spawn()
    .unwrap();
}

fn high_task() {
    // Attempt to acquire the mutex
    let _guard = MUTEX.lock();
    hprintln!("High priority task locking data");
}

fn middle_task() {
    // Attempt to acquire the mutex
    let _guard = MUTEX.lock();
    hprintln!("Middle priority task locking data");
}

