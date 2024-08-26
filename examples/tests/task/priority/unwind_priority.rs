//! Tests that a panicked task will get its priority reduced to a low
//! `UNWIND_PRIORITY` thus other normal tasks can run first. The unwinding
//! should take otherwise idle CPU time.

#![no_std]
#![no_main]

extern crate alloc;
use alloc::string::String;
use hopter::{
    config,
    debug::semihosting::{self, dbg_println},
    task,
    task::main,
};

struct DataPointer {
    data: String,
}

impl Drop for DataPointer {
    fn drop(&mut self) {
        dbg_println!("Dropping {}", self.data);
    }
}

#[main]
fn main(_: cortex_m::Peripherals) {
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

    task::change_current_priority(config::UNWIND_PRIORITY + 1).unwrap();
    semihosting::terminate(true);
}

fn high_task() {
    let _resource = DataPointer {
        data: String::from("High priority resource"),
    };
    dbg_println!("High priority task going to panic");
    panic!();
}

fn middle_task() {
    let _resource = DataPointer {
        data: String::from("Middle priority resource"),
    };
    dbg_println!("Middle priority task executed");
}

fn low_task() {
    let _resource = DataPointer {
        data: String::from("Low priority resource"),
    };
    dbg_println!("Low priority task executed");
}
