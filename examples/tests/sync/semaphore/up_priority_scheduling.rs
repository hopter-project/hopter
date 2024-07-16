#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync::Semaphore};

static SEMAPHORE: Semaphore = Semaphore::new(3, 0);

#[main]
fn main(_: cortex_m::Peripherals) {
    schedule::start_task(2, |_| high_priority_task(), (), 0, 4).unwrap();
    schedule::start_task(3, |_| intermediate_task(), (), 0, 4).unwrap();
    schedule::start_task(4, |_| low_task(), (), 0, 4).unwrap();


    schedule::change_current_task_priority(10).unwrap();
    semihosting::terminate(true);
}


fn high_priority_task(){
    SEMAPHORE.up();
    hprintln!("High priority task released semaphore");
}

fn intermediate_task(){
    SEMAPHORE.up();
    hprintln!("Intermediate priority task released semaphore");
}

fn low_task(){
    SEMAPHORE.up();
    hprintln!("Low priority task released semaphore");
}
