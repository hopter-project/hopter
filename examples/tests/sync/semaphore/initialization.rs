#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Semaphore};

#[main]
fn main(_: cortex_m::Peripherals) {
  for i in 1..5 {
        let semaphore = Semaphore::new(i, i);
    
        if semaphore.count != i {
            hprintln!("Count Not Initialized Properly");
            semihosting::terminate(false);
        }
      
        if semaphore.max_count != i {
            hprintln!("Max Count Not Initialized Properly");
            semihosting::terminate(false);
        }
}


  hprintln!("Test Passed");
  semihosting::terminate(true);

}
