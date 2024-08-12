#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, config, debug::semihosting, hprintln, sync::Semaphore, task};

static SEMAPHORE: Semaphore = Semaphore::new(1, 0);

#[main]
fn main(_: cortex_m::Peripherals) {
    // Create test tasks.
    task::build()
        .set_entry(low_task)
        .set_priority(config::DEFAULT_TASK_PRIORITY + 1)
        .spawn()
        .unwrap();
    task::build()
        .set_entry(high_task)
        .set_priority(config::DEFAULT_TASK_PRIORITY - 1)
        .spawn()
        .unwrap();
    task::build()
        .set_entry(middle_task)
        .set_priority(config::DEFAULT_TASK_PRIORITY)
        .spawn()
        .unwrap();

    task::change_current_priority(config::DEFAULT_TASK_PRIORITY - 2).unwrap();

    for _ in 0..3 {
        SEMAPHORE.up();
    }

    semihosting::terminate(true);
}

fn high_task() {
    SEMAPHORE.down();
    hprintln!("High priority task acquired semaphore");
}

fn middle_task() {
    SEMAPHORE.down();
    hprintln!("Middle priority task acquired semaphore");
}

fn low_task() {
    SEMAPHORE.down();
    hprintln!("Low priority task acquired semaphore");
}
