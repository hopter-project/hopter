#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, schedule, sync::Semaphore};

#[main]
fn main(_: cortex_m::Peripherals) {
  for _ in 0..100:
    schedule::start_task(2, |_| task(), (), 0, 4).unwrap();
}

static SEMAPHORE: Semaphore = Semaphore::new(10,5);

fn task() {
    for _ in 0..100 {
      semaphore.up();
      semaphore.down();
  }
  hprintln!("Task completed");
}
