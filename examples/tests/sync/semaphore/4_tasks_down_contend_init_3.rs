#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, schedule, sync::Semaphore, time};

static SEMAPHORE: Semaphore = Semaphore::new(3, 3);

#[main]
fn main(_: cortex_m::Peripherals) {
    schedule::start_task(2, task1, 0, 4).unwrap();
    schedule::start_task(3, task2, 0, 4).unwrap();
    schedule::start_task(4, task3, 0, 4).unwrap();
    schedule::start_task(5, task4, 0, 4).unwrap();
    schedule::change_current_task_priority(10).unwrap();
    semihosting::terminate(true);
}

fn task1() {
    hprintln!("Task 1 started");

    SEMAPHORE.down();
    hprintln!("Task 1 acquired semaphore");

    time::sleep_ms(1000);

    hprintln!("Task 1 releasing semaphore");
    SEMAPHORE.up();

    hprintln!("Task 1 completed");
}

fn task2() {
    hprintln!("Task 2 started");

    SEMAPHORE.down();
    hprintln!("Task 2 acquired semaphore");

    time::sleep_ms(1000);

    hprintln!("Task 2 releasing semaphore");
    SEMAPHORE.up();

    hprintln!("Task 2 completed");
}

fn task3() {
    hprintln!("Task 3 started");

    SEMAPHORE.down();
    hprintln!("Task 3 acquired semaphore");

    time::sleep_ms(1000);

    hprintln!("Task 3 releasing semaphore");
    SEMAPHORE.up();

    hprintln!("Task 3 completed");
}

fn task4() {
    hprintln!("Task 4 started");

    SEMAPHORE.down();
    hprintln!("Task 4 acquired semaphore");

    time::sleep_ms(1000);

    hprintln!("Task 4 releasing semaphore");
    SEMAPHORE.up();

    hprintln!("Task 4 completed");
}
