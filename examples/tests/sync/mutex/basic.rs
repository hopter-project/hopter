//! Test mutex `new`, `into_inner`, and `try_lock` with a single task.

#![no_std]
#![no_main]

extern crate alloc;
use alloc::string::String;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Mutex};

#[main]
fn main(_: cortex_m::Peripherals) {
    // Create mutex around data
    let mutex = Mutex::new(String::from("Hello, World"));

    // Test `into_inner`.
    hprintln!("Data: {}", mutex.into_inner());

    // Test `try_lock`.
    let mutex = Mutex::new(());
    let gaurd = mutex.try_lock();

    match gaurd {
        Some(_) => {
            hprintln!("First try lock success");
            let guard = mutex.try_lock();
            if guard.is_none() {
                hprintln!("Second try lock failed");
                semihosting::terminate(true);
            } else {
                hprintln!("Second try lock success");
                semihosting::terminate(false);
            }
        }
        None => {
            hprintln!("First try lock failed");
            semihosting::terminate(false);
        }
    }
}
