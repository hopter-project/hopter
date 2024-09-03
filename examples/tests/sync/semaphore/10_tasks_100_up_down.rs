#![no_main]
#![no_std]

extern crate alloc;
use core::sync::atomic::{AtomicUsize, Ordering};
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync::Semaphore,
    task,
    task::main,
};

static SEMAPHORE: Semaphore = Semaphore::new(10, 5);
static TASK_COMPLETION_COUNTER: AtomicUsize = AtomicUsize::new(0);
const TOTAL_TASKS: usize = 10;

#[main]
fn main(_: cortex_m::Peripherals) {
    // Start 10 tasks
    for _ in 0..TOTAL_TASKS {
        task::build().set_entry(task).spawn().unwrap();
    }
    task::change_current_priority(10).unwrap();
    check();
}

// Task function that will run independently
fn task() {
    for _ in 0..100 {
        SEMAPHORE.up();
        SEMAPHORE.down();
    }
    // Increment the task completion counter
    TASK_COMPLETION_COUNTER.fetch_add(1, Ordering::SeqCst);
}

fn check() {
    let completed_tasks = TASK_COMPLETION_COUNTER.load(Ordering::SeqCst);

    if completed_tasks == TOTAL_TASKS {
        // All tasks completed, check semaphore count
        let final_count = SEMAPHORE.count();
        // Check if the count matches the initial value
        if final_count == 5 {
            dbg_println!("Test Passed");
            #[cfg(feature = "qemu")]
            semihosting::terminate(true);
            #[cfg(not(feature = "qemu"))]
            {
                dbg_println!("test complete!");
                loop {}
            }
        } else {
            dbg_println!("Test Failed");
            #[cfg(feature = "qemu")]
            semihosting::terminate(true);
            #[cfg(not(feature = "qemu"))]
            {
                dbg_println!("test complete!");
                loop {}
            }
        }
    }
}
