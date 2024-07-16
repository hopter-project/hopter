#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync::Mutex};

static MUTEX: Mutex<i32> = Mutex::new(0);

#[main]
fn main(_: cortex_m::Peripherals) {
    schedule::start_task(2, |_| high_task(), (), 0, 4).unwrap();
    schedule::start_task(3, |_| intermediate_task(), (), 0, 4).unwrap();
    schedule::start_task(4, |_| low_task(), (), 0, 4).unwrap();


    schedule::change_current_task_priority(10).unwrap();
    semihosting::terminate(true);

}

fn high_task(){
    let _gaurd = MUTEX.lock();
    hprintln!("High priority task locking data");
}

fn intermediate_task(){
    let _gaurd = MUTEX.lock();
    hprintln!("Intermediate priority task locking data");
}

fn low_task(){
    let _gaurd = MUTEX.lock();
    hprintln!("Low priority task locking data");
}















// #![no_main]
// #![no_std]

// extern crate alloc;
// use core::sync::atomic::{AtomicUsize, Ordering};
// use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync::Mutex};



// #[main]
// fn main(_: cortex_m::Peripherals) {
//     let data = Mutex::new(0);
//     schedule::start_task(2, |_| high_priority_task(data), (), 0, 4).unwrap();
//     schedule::start_task(3, |_| intermediate_task(data), (), 0, 4).unwrap();
//     schedule::start_task(4, |_| low_task(data), (), 0, 4).unwrap();


//     schedule::change_current_task_priority(10).unwrap();
//     semihosting::terminate(true);

// }

// fn high_priority_task(data: Mutex<i32>){
//     let gaurd = data.lock();
//     hprintln!("High priority task locking data: {}", *gaurd);
// }

// fn intermediate_task(data: Mutex<i32>){
//     let gaurd = data.lock();
//     hprintln!("inter priority task locking data: {}", *gaurd);
// }

// fn low_task(data: Mutex<i32>){
//     let gaurd = data.lock();
//     hprintln!("low priority task locking data: {}", *gaurd);
// }