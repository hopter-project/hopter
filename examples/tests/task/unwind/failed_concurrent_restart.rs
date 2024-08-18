//! Tests that a panicked task should unwind first and reuse its task struct
//! to restart a new instance when the maximum number of tasks allowed by the
//! system configuration has already been reached.

#![no_std]
#![no_main]

extern crate alloc;
use core::sync::atomic::{AtomicBool, Ordering};
use hopter::{boot::main, config, debug::semihosting, hprintln, task};

#[main]
fn main(_: cortex_m::Peripherals) {
    // Task #0 is the idle task.
    // Task #1 is the main task.

    // Task #2 is the test task.
    task::build()
        .set_entry(will_panic)
        .set_priority(config::DEFAULT_TASK_PRIORITY)
        .spawn_restartable()
        .unwrap();

    // Task #3 to #MAX_TASK_NUMBER-1 are dummy tasks.
    for _ in 3..config::MAX_TASK_NUMBER {
        task::build()
            .set_entry(|| {})
            .set_priority(config::UNWIND_PRIORITY + 1)
            .spawn()
            .unwrap();
    }

    // Now we have reached the maximum task number. The panicked test task will
    // not be able to concurrently restart.

    // Let the test task run.
    task::change_current_priority(config::UNWIND_PRIORITY + 1).unwrap();

    semihosting::terminate(true);
}

fn will_panic() {
    static FIRST_TIME: AtomicBool = AtomicBool::new(true);
    let first_time = FIRST_TIME.fetch_and(false, Ordering::SeqCst);

    // Deliberate panic when the task is executed for the first time.
    // Unwinding should happen before the second run is completed becaues it
    // cannot concurrently restart.
    if first_time {
        let _print_on_drop = PrintOnDrop("First run dropped on panic");
        panic!()
    }

    hprintln!("Second run completed");
}

struct PrintOnDrop(&'static str);

impl Drop for PrintOnDrop {
    fn drop(&mut self) {
        hprintln!("{}", self.0)
    }
}
