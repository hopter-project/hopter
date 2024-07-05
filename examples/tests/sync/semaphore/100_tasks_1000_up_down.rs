#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, schedule, sync::Semaphore};

static SEMAPHORE: Semaphore = Semaphore::new(10, 5);
static TASK_COMPLETION_COUNTER: AtomicUsize = AtomicUsize::new(0);
const TOTAL_TASKS: usize = 100;

#[main]
fn main(_: cortex_m::Peripherals) {
    // Start 100 tasks
    for _ in 0..TOTAL_TASKS {
        schedule::start_task(2, move |_| task(), (), 0, 4).unwrap();
    }

    // loop to check for task completion
    loop {
        if TASK_COMPLETION_COUNTER.load(Ordering::SeqCst) == TOTAL_TASKS {
            // All tasks completed, check semaphore count
            let final_count = SEMAPHORE.count.load(Ordering::SeqCst);
             // Check if the count matches the initial value
            if final_count == 5 {
                semihosting::terminate(true);
            }
            else {
                semihosting::terminate(false);
            }
        }
    }
}

// Task function that will run independently
fn task() {
    for _ in 0..1000 {
        SEMAPHORE.up();
        SEMAPHORE.down();
    }
    // Increment the task completion counter
    TASK_COMPLETION_COUNTER.fetch_add(1, Ordering::SeqCst);
}
