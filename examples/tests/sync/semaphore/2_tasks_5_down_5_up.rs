#![no_main]
#![no_std]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync::Semaphore,
    task,
    task::main,
};

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build().set_entry(task1).spawn().unwrap();
    task::build().set_entry(task2).spawn().unwrap();

    task::change_current_priority(10).unwrap();

    semihosting::terminate(true);
}

static SEMAPHORE: Semaphore = Semaphore::new(3, 3);

fn task1() {
    dbg_println!("Task 1 started");
    for i in 1..6 {
        SEMAPHORE.down();
        dbg_println!("Down {}", i);
    }
    dbg_println!("Task1 completed");
}

fn task2() {
    dbg_println!("Task 2 started");
    for i in 1..6 {
        SEMAPHORE.up();
        dbg_println!("Up {}", i);
    }
    dbg_println!("Task2 completed");
}
