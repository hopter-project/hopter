//! Test reducing the priority of a task. Should print out "one", "two", and
//! "three" in sequence.

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, schedule};

/// The main task always starts with the highest priority (numerical value 0).
#[main]
fn main(_: cortex_m::Peripherals) {
    schedule::start_task(2, |_| task(), (), 0, 4).unwrap();
    hprintln!("one");
    schedule::change_current_task_priority(10).unwrap();
    hprintln!("three");
    semihosting::terminate(true);
}

fn task() {
    hprintln!("two");
}
