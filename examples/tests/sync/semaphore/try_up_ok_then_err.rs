#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Semaphore};

static SEMAPHORE: Semaphore = Semaphore::new(5, 2);

#[main]
fn main(_: cortex_m::Peripherals) {
    let result = SEMAPHORE.try_up_allow_isr();

    match result {
        Ok(()) => {}
        Err(()) => {
            hprintln!("Did not increment");
            semihosting::terminate(false);
        }
    }

    // SEMAPHORE count should be 3
    SEMAPHORE.up();
    SEMAPHORE.up();

    // SEMAPHORE count should be 5
    let second_result = SEMAPHORE.try_up_allow_isr();

    match second_result {
        Ok(()) => {
            hprintln!("incremented at max");
            semihosting::terminate(false);
        }
        Err(()) => {
            hprintln!("Test Passed");
            semihosting::terminate(true);
        }
    }
}
