#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, schedule, sync::Semaphore};

static SEMAPHORE: Semaphore = Semaphore::new(1, 0);

#[main]
fn main(_: cortex_m::Peripherals) {
    schedule::start_task(2, |_| acquire(), (), 0, 4).unwrap();
    schedule::start_task(3, |_| release(), (), 0, 4).unwrap();
}

fn acquire() {
    hprintln!("attempting to acquire semaphore..");
    SEMAPHORE.down();
    hprintln!("semaphore acquired");
    semihosting::terminate(true);
}

fn release() {
    SEMAPHORE.up();
    hprintln!("semaphore released");
}
