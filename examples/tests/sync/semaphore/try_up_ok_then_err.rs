#![no_main]
#![no_std]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync::Semaphore,
    task::main,
};

static SEMAPHORE: Semaphore = Semaphore::new(5, 2);

#[main]
fn main(_: cortex_m::Peripherals) {
    let result = SEMAPHORE.try_up_allow_isr();

    match result {
        Ok(()) => {}
        Err(()) => {
            dbg_println!("Did not increment");
            // semihosting::terminate(false);
            dbg_println!("test complete!");
            loop {}
        }
    }

    // SEMAPHORE count should be 3
    SEMAPHORE.up();
    SEMAPHORE.up();

    // SEMAPHORE count should be 5
    let second_result = SEMAPHORE.try_up_allow_isr();

    match second_result {
        Ok(()) => {
            dbg_println!("incremented at max");
            // semihosting::terminate(false);
            dbg_println!("test complete!");
            loop {}
        }
        Err(()) => {
            dbg_println!("Test Passed");
            // semihosting::terminate(true);
            dbg_println!("test complete!");
            loop {}
        }
    }
}
