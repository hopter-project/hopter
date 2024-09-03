//! Test mutex `new`, `into_inner`, and `try_lock` with a single task.

#![no_std]
#![no_main]

extern crate alloc;
use alloc::string::String;
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync::Mutex,
    task::main,
};

#[main]
fn main(_: cortex_m::Peripherals) {
    // Create mutex around data
    let mutex = Mutex::new(String::from("Hello, World"));

    // Test `into_inner`.
    dbg_println!("Data: {}", mutex.into_inner());

    // Test `try_lock`.
    let mutex = Mutex::new(());
    let gaurd = mutex.try_lock();

    match gaurd {
        Some(_) => {
            dbg_println!("First try lock success");
            let guard = mutex.try_lock();
            if guard.is_none() {
                dbg_println!("Second try lock failed");
                #[cfg(feature = "qemu")]
                semihosting::terminate(true);
                #[cfg(not(feature = "qemu"))]
                {
                    dbg_println!("test complete!");
                    loop {}
                }
            } else {
                dbg_println!("Second try lock success");
                #[cfg(feature = "qemu")]
                semihosting::terminate(true);
                #[cfg(not(feature = "qemu"))]
                {
                    dbg_println!("test complete!");
                    loop {}
                }
            }
        }
        None => {
            dbg_println!("First try lock failed");
            #[cfg(feature = "qemu")]
            semihosting::terminate(true);
            #[cfg(not(feature = "qemu"))]
            {
                dbg_println!("test complete!");
                loop {}
            }
        }
    }
}
