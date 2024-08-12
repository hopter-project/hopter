#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Mutex, task};

#[main]
fn main(_: cortex_m::Peripherals) {
    let data = "Data for the Test";

    task::build()
        .set_entry(move || task1(data))
        .spawn()
        .unwrap();
    task::build()
        .set_entry(move || task2(data))
        .spawn()
        .unwrap();

    task::change_current_priority(10).unwrap();
    semihosting::terminate(true);
}

fn task1(data: &str) {
    let mutex = Mutex::new(data);
    let result = mutex.try_lock();

    match result {
        Some(_t) => {
            hprintln!("Mutex Locked in Task 1");
        }
        None => {
            hprintln!("Lock failed in Task 1");
            semihosting::terminate(false);
        }
    }
}

fn task2(data: &str) {
    let mutex = Mutex::new(data);
    let result = mutex.try_lock();

    match result {
        Some(_t) => {
            hprintln!("Mutex Locked in Task 2");
        }
        None => {
            hprintln!("Lock failed in Task 2");
            semihosting::terminate(false);
        }
    }
}
