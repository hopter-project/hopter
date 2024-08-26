#![no_std]
#![no_main]

extern crate alloc;
use hopter::{debug::semihosting, hprintln, sync::Semaphore, task::main};

#[main]
fn main(_: cortex_m::Peripherals) {
    let sema = Semaphore::new(3, 0);

    for _ in 0..3 {
        sema.up();
    }

    let result = sema.try_up_allow_isr();

    match result {
        Ok(()) => {
            hprintln!("Incremented when at max count");
            semihosting::terminate(false);
        }
        Err(()) => {
            hprintln!("Test Passed");
            semihosting::terminate(true);
        }
    }
}
