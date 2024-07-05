#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync::Semaphore};
use core::sync::atomic::{AtomicUsize, Ordering};

static SEMAPHORE: Semaphore = Semaphore::new(10, 5);
static TASK_COMPLETION_COUNTER: AtomicUsize = AtomicUsize::new(0);
const TOTAL_TASKS: usize = 10;

#[main]
fn main(_: cortex_m::Peripherals) {
    // Start 100 tasks
    for _ in 0..TOTAL_TASKS {
        schedule::start_task(2, move |_| task(), (), 0, 4).unwrap();
    }

    // Loop to check for task completion
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
    }
}

// Task function that will run independently
fn task() {
    for _ in 0..10 {
        SEMAPHORE.up();
        SEMAPHORE.down();
    }
    // Increment the task completion counter
    TASK_COMPLETION_COUNTER.fetch_add(1, Ordering::SeqCst);
}


// #![no_main]
// #![no_std]

// extern crate alloc;
// use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync::Semaphore};
// use core::sync::atomic::{AtomicUsize, Ordering};

// static SEMAPHORE: Semaphore = Semaphore::new(10, 5);
// static TASK_COMPLETION_COUNTER: AtomicUsize = AtomicUsize::new(0);
// const TOTAL_TASKS: usize = 100;

// #[main]
// fn main(_: cortex_m::Peripherals) {
//     // Start 10 tasks
//     for _ in 0..TOTAL_TASKS {
//         schedule::start_task(2, move |_| task(), (), 0, 4).unwrap();
//     }

// }

// // Task function that will run independently
// fn task() {
//     for _ in 0..100 {
//         SEMAPHORE.up();
//         SEMAPHORE.down();
//     }
//     // Increment the task completion counter
//     TASK_COMPLETION_COUNTER.fetch_add(1, Ordering::SeqCst);

//     let completed_tasks = TASK_COMPLETION_COUNTER.load(Ordering::SeqCst);
//     if completed_tasks == TOTAL_TASKS {
//             // All tasks completed, check semaphore count
//             let final_count = SEMAPHORE.count();
//             // Check if the count matches the initial value
//             if final_count == 5 {
//                 hprintln!("Test Passed");
//                 semihosting::terminate(true);
//             } else {
//                 hprintln!("Test Failed");
//                 semihosting::terminate(false);
//             }
//         }
// }
