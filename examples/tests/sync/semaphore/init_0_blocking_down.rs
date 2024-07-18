#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Semaphore, task};

static SEMAPHORE: Semaphore = Semaphore::new(1, 0);

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build().set_entry(acquire).spawn().unwrap();
    task::build().set_entry(release).spawn().unwrap();
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
