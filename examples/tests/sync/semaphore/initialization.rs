// #![no_std]
// #![no_main]

// extern crate alloc;
// use hopter::{boot::main, debug::semihosting, hprintln, sync::Semaphore};

// #[main]
// fn main(_: cortex_m::Peripherals) {
//   for i in 1..5 {
//         let semaphore = Semaphore::new(i, i);
    
//         if semaphore.count != i {
//             hprintln!("Count Not Initialized Properly");
//             semihosting::terminate(false);
//         }
      
//         if semaphore.max_count != i {
//             hprintln!("Max Count Not Initialized Properly");
//             semihosting::terminate(false);
//         }
// }


//   hprintln!("Test Passed");
//   semihosting::terminate(true);

// }

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Semaphore};


#[main]
fn main(_: cortex_m::Peripherals) {
  let sema = Semaphore::new(3,3);

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
