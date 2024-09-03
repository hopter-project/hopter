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
    let sema = Semaphore::new(3, 3);

    for _i in 0..3 {
        sema.down();
    }

    // should return Err(()) since the count is 0
    let result = sema.try_down_allow_isr();

    match result {
        Ok(()) => {
            dbg_println!("Decremented at 0");
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
