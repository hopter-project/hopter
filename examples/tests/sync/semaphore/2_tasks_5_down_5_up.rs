#![no_main]
#![no_std]

extern crate alloc;
use hopter::{debug::semihosting, hprintln, sync::Semaphore, task, task::main};

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build().set_entry(task1).spawn().unwrap();
    task::build().set_entry(task2).spawn().unwrap();

    task::change_current_priority(10).unwrap();

    semihosting::terminate(true);
}

static SEMAPHORE: Semaphore = Semaphore::new(3, 3);

fn task1() {
    hprintln!("Task 1 started");
    for i in 1..6 {
        SEMAPHORE.down();
        hprintln!("Down {}", i);
    }
    hprintln!("Task1 completed");
}

fn task2() {
    hprintln!("Task 2 started");
    for i in 1..6 {
        SEMAPHORE.up();
        hprintln!("Up {}", i);
    }
    hprintln!("Task2 completed");
}
