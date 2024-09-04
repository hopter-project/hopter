#![no_std]
#![no_main]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync::Semaphore,
    task::main,
};

#[main]
fn main(_: cortex_m::Peripherals) {
    let sema = Semaphore::new(3, 0);

    for _ in 0..3 {
        sema.up();
    }

    let result = sema.try_up_allow_isr();

    match result {
        Ok(()) => {
            dbg_println!("Incremented when at max count");
            #[cfg(feature = "qemu")]
            semihosting::terminate(false);
            #[cfg(not(feature = "qemu"))]
            {
                dbg_println!("test complete!");
                loop {}
            }
        }
        Err(()) => {
            dbg_println!("Test Passed");
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
