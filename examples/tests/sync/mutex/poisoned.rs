#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync::Mutex};


static MTX: Mutex<()> = Mutex::new(());

#[main]
fn main(_: cortex_m::Peripherals) {
    schedule::start_task(2, |_| will_panic(), (), 0, 4).unwrap();
    let _ = schedule::change_current_task_priority(10);
    if MTX.is_poisoned() {
        hprintln!("Test Passed");
        semihosting::terminate(true);
    } else {
        hprintln!("Test Failed");
        semihosting::terminate(false);
    }
}

fn will_panic() {
    let _gurad = MTX.lock();
    panic!();
}
