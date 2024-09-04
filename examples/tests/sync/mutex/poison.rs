//! Test mutex poisoning upon unwinding.

#![no_main]
#![no_std]

extern crate alloc;
use hopter::{
    config,
    debug::semihosting::{self, dbg_println},
    sync::Mutex,
    task,
    task::main,
};

static MTX: Mutex<()> = Mutex::new(());

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build().set_entry(will_panic).spawn().unwrap();
    task::change_current_priority(config::UNWIND_PRIORITY + 1).unwrap();
    if MTX.is_poisoned() {
        dbg_println!("Test Passed");
        #[cfg(feature = "qemu")]
        semihosting::terminate(true);
        #[cfg(not(feature = "qemu"))]
        {
            dbg_println!("test complete!");
            loop {}
        }
    } else {
        dbg_println!("Test Failed");
        #[cfg(feature = "qemu")]
        semihosting::terminate(false);
        #[cfg(not(feature = "qemu"))]
        {
            dbg_println!("test complete!");
            loop {}
        }
    }
}

fn will_panic() {
    let _gurad = MTX.lock();
    panic!();
}
