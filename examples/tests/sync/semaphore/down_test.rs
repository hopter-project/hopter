#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Semaphore};


#[main]
fn main(_: cortex_m::Peripherals) {
  let sema = semaphore::new(3,3);

  for i in 0..3 {
    sema.down();
  }

  if sema.count != 0 {
      hprintln!("Incorrect Count");
      semihosting::terminate(false);
  }

  let result = sema.try_down_allow_isr();

  match result {
      Ok(()) => {
        hprintln!("Decremented at 0");
        semihosting::terminate(false);
      },
      Err(()) => {
        hprintln!("Test Passed"); 
        semihosting::terminate(true);
      }
   }

} 
