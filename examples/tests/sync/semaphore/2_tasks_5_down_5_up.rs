#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, schedule, sync::Semaphore};

#[main]
fn main(_: cortex_m::Peripherals) {
  schedule::start_task(2, |_| task1(), (), 0, 4).unwrap();
  schedule::start_task(2, |_| task2(), (), 0, 4).unwrap();
  
}

static SEMAPHORE: Semaphore = Semaphore::new(3,3);

fn task1() {
      hprintln!("Task 1 started");
      for i in 1..6 {
            SEMAPHORE.down();
            hprintln!("Down {}", i);
        }
    hprintln!("Task1 completed");
    
}

fn task2() {
      hprintln!("Task 2 started");
      for i in 1..6 {
            SEMAPHORE.up();
            hprintln!("Up {}", i);
        }
    hprintln!("Task2 completed");
    semihosting::terminate(true);
  }
