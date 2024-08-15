//! Tests that a panicked task is given unwind priority,
/// allowing other tasks to run even if one of them panics.

#![no_std]
#![no_main]

extern crate alloc;
use alloc::string::String;
use hopter::{boot::main, config, debug::semihosting, hprintln, task};

struct DataPointer {
    data: String,
}

impl Drop for DataPointer {
    fn drop(&mut self) {
        hprintln!("Dropping `{}`!", self.data);
    }
}

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

    task::change_current_priority(config::DEFAULT_TASK_PRIORITY + 2).unwrap();
    semihosting::terminate(true);
}

fn high_task() {
    let _resource = DataPointer {
        data: String::from("High Priority resource"),
    };
    panic!();

}

fn middle_task() {
    let _resource = DataPointer {
        data: String::from("Middle Priority resource"),
    };
    hprintln!("Middle priority task executed");
}

fn low_task() {
    let _resource = DataPointer {
        data: String::from("Low Priority resource"),
    };
    hprintln!("Low priority task executed");
}
