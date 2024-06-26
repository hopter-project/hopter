#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, time, sync::semaphores};

static sema = semaphores::new(3,3)

#[main]
fn main(_: cortex_m::Peripherals) {
    schedule::start_task(2, |_| task1(), (), 0, 4).unwrap();
    schedule::start_task(2, |_| task2(), (), 0, 4).unwrap();
    schedule::start_task(2, |_| task3(), (), 0, 4).unwrap();
    schedule::start_task(2, |_| task4(), (), 0, 4).unwrap();
}

fn task1() {
    hprintln!("Task 1 started").unwrap();

    sema.down();
    hprintln!("Task 1 acquired semaphore").unwrap();

    time::sleep_ms(1000);

    hprintln!("Task 1 releasing semaphore").unwrap();
    sema.up();

    hprintln!("Task 1 completed").unwrap();

  }

fn task2() {
    hprintln!("Task 2 started").unwrap();

    sema.down();
    hprintln!("Task 2 acquired semaphore").unwrap();

    time::sleep_ms(1000);

    hprintln!("Task 2 releasing semaphore").unwrap();
    sema.up();

    hprintln!("Task 2 completed").unwrap();
}


fn task3() {
    hprintln!("Task 3 started").unwrap();

    sema.down();
    hprintln!("Task 3 acquired semaphore").unwrap();

    time::sleep_ms(1000);

    hprintln!("Task 3 releasing semaphore").unwrap();
    sema.up();

    hprintln!("Task 3 completed").unwrap();
}

fn task4() {
    hprintln!("Task 4 started").unwrap();

    sema.down();
    hprintln!("Task 4 acquired semaphore").unwrap();

    time::sleep_ms(1000);

    hprintln!("Task 4 releasing semaphore").unwrap();
    sema.up();

    hprintln!("Task 4 completed").unwrap();
}

