#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, time, schedule, sync::Semaphore};

static SEMAPHORE: Semaphore = Semaphore::new(3,3);

#[main]
fn main(_: cortex_m::Peripherals) {
    schedule::start_task(2, |_| task1(), (), 0, 4).unwrap();
    schedule::start_task(2, |_| task2(), (), 0, 4).unwrap();
    schedule::start_task(2, |_| task3(), (), 0, 4).unwrap();
    schedule::start_task(2, |_| task4(), (), 0, 4).unwrap();
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
    semihosting::terminate(true);
}


fn task3() {
    hprintln!("Task 3 started");

    SEMAPHORE.down();
    hprintln!("Task 3 acquired semaphore");

    time::sleep_ms(1000);

    hprintln!("Task 3 releasing semaphore");
    SEMAPHORE.up();

    hprintln!("Task 3 completed");
    semihosting::terminate(true);
}

fn task4() {
    hprintln!("Task 4 started");

    SEMAPHORE.down();
    hprintln!("Task 4 acquired semaphore");

    time::sleep_ms(1000);

    hprintln!("Task 4 releasing semaphore");
    SEMAPHORE.up();

    hprintln!("Task 4 completed");
    semihosting::terminate(true);
    
}
