#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, schedule, sync::Mutex};

static MUTEX: Mutex<i32> = Mutex::new(0);

#[main]
fn main(_: cortex_m::Peripherals) {
    schedule::start_task(2, |_| high_task(), (), 0, 4).unwrap();
    schedule::start_task(3, |_| intermediate_task(), (), 0, 4).unwrap();
    schedule::start_task(4, |_| low_task(), (), 0, 4).unwrap();

    schedule::change_current_task_priority(10).unwrap();
    semihosting::terminate(true);
}

fn high_task() {
    let _gaurd = MUTEX.lock();
    hprintln!("High priority task locking data");
}

fn intermediate_task() {
    let _gaurd = MUTEX.lock();
    hprintln!("Intermediate priority task locking data");
}

fn low_task() {
    let _gaurd = MUTEX.lock();
    hprintln!("Low priority task locking data");
}
