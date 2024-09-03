#![no_main]
#![no_std]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync::Semaphore,
    task::main,
};

#[main]
fn main(_: cortex_m::Peripherals) {
    for i in 0..5 {
        for j in 5..10 {
            let semaphore = Semaphore::new(j, i);
            if semaphore.count() != i || semaphore.max_count() != j {
                dbg_println!("Test Failed");
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
    dbg_println!("Test Passed");
    #[cfg(feature = "qemu")]
    semihosting::terminate(true);
    #[cfg(not(feature = "qemu"))]
    {
        dbg_println!("test complete!");
        loop {}
    }
}
