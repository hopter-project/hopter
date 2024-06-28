#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, time, schedule, sync::Semaphore};

static SEMAPHORE: Semaphore = Semaphore::new(3,3);

#[main]
fn main(_: cortex_m::Peripherals) {
  if SEMAPHORE.count == 3
  {
    semihosting::terminate(true);
  }
  else
  {
    semihosting::terminate(false);
  }
  
}
