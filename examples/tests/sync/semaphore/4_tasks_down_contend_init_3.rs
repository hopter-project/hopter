#![no_main]
#![no_std]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync::Semaphore,
    task,
    task::main,
    time,
};

static SEMAPHORE: Semaphore = Semaphore::new(3, 3);

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build().set_entry(task1).spawn().unwrap();
    task::build().set_entry(task2).spawn().unwrap();
    task::build().set_entry(task3).spawn().unwrap();
    task::build().set_entry(task4).spawn().unwrap();

    task::change_current_priority(10).unwrap();
    #[cfg(feature = "qemu")]
    semihosting::terminate(true);
    #[cfg(not(feature = "qemu"))]
    {
        dbg_println!("test complete!");
        loop {}
    }
}

fn task1() {
    dbg_println!("Task 1 started");

    SEMAPHORE.down();
    dbg_println!("Task 1 acquired semaphore");

    time::sleep_ms(1000);

    dbg_println!("Task 1 releasing semaphore");
    SEMAPHORE.up();

    dbg_println!("Task 1 completed");
}

fn task2() {
    dbg_println!("Task 2 started");

    SEMAPHORE.down();
    dbg_println!("Task 2 acquired semaphore");

    time::sleep_ms(1000);

    dbg_println!("Task 2 releasing semaphore");
    SEMAPHORE.up();

    dbg_println!("Task 2 completed");
}

fn task3() {
    dbg_println!("Task 3 started");

    SEMAPHORE.down();
    dbg_println!("Task 3 acquired semaphore");

    time::sleep_ms(1000);

    dbg_println!("Task 3 releasing semaphore");
    SEMAPHORE.up();

    dbg_println!("Task 3 completed");
}

fn task4() {
    dbg_println!("Task 4 started");

    SEMAPHORE.down();
    dbg_println!("Task 4 acquired semaphore");

    time::sleep_ms(1000);

    dbg_println!("Task 4 releasing semaphore");
    SEMAPHORE.up();

    dbg_println!("Task 4 completed");
}
