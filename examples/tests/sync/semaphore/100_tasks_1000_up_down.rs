#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync::Semaphore};
use core::sync::atomic::{AtomicUsize, Ordering};
use cortex_m::asm::delay;

static SEMAPHORE: Semaphore = Semaphore::new(10, 5);
static TASK_COMPLETION_COUNTER: AtomicUsize = AtomicUsize::new(0);
const TOTAL_TASKS: usize = 10;

#[main]
fn main(_: cortex_m::Peripherals) {
    // Start 100 tasks
    for i in 0..TOTAL_TASKS {
        schedule::start_task(2, |_| task(), (), 0, 4).unwrap();
        hprintln!("created task {}", i);
    }

    loop {
        let completed_tasks = TASK_COMPLETION_COUNTER.load(Ordering::SeqCst);
    
        if completed_tasks == TOTAL_TASKS {
            // All tasks completed, check semaphore count
            let final_count = SEMAPHORE.count();
            // Check if the count matches the initial value
            if final_count == 5 {
                hprintln!("Test Passed");
                semihosting::terminate(true);
            } else {
                hprintln!("Test Failed");
                semihosting::terminate(false);
            }
        }
        delay(100_000);
    }
}


// Task function that will run independently
fn task() {
    hprintln!("in task");
    for _ in 0..100 {
        SEMAPHORE.up();
        SEMAPHORE.down();
    }
    // Increment the task completion counter
    TASK_COMPLETION_COUNTER.fetch_add(1, Ordering::SeqCst);

}


