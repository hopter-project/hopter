#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, schedule, sync::Semaphore};

static SEMAPHORE: Semaphore = Semaphore::new(5,3);

#[main]
fn main(_: cortex_m::Peripherals) {
  let result = SEMAPHORE.try_down_allow_isr();

  match result {
      Ok(()) => continue,
      Err(()) => 
      {
           hprintln!("Did not decremented");
           semihosting::terminate(false);
      }
    }

  // SEMAPHORE count should be 2
    SEMAPHORE.down();
    SEMAPHORE.down();

 // SEMAPHORE count should be 0
let second_result = SEMAPHORE.try_down_allow_isr();

  match second_result {
      Ok(()) => {
           hprintln!("Decremented at 0");
           semihosting::terminate(false);
      },
      Err(()) => 
      {
           hprintln!("Test Passed");
           semihosting::terminate(true);
      }
    }
  
}
