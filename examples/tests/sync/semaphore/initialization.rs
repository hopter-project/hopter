#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Semaphore};


#[main]
fn main(_: cortex_m::Peripherals) {
  for i in 0..5
    {
      for j in 5..10 {
        let semaphore = Semaphore::new(j, i);
        if semaphore.count() != i || semaphore.max_count() != j {
            hprintln!("Test Failed");
            semihosting::terminate(false);
          }  
      }
    }
    hprintln!("Test Passed");
    semihosting::terminate(true);
}

