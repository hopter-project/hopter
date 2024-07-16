#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Mutex};

#[main]
fn main(_: cortex_m::Peripherals) {
  
  // create mutex around data
  let data = "Hello, World";
  let mutex = Mutex::new(data);

  // access data in mutex. Into_inner takes ownership of mutex
  hprintln!("Data: {}", mutex.into_inner());

  // create second mutex around data, attempt to lock it
  let second_mutex = Mutex::new(data);
  let gaurd = second_mutex.try_lock();
  
  match gaurd {
      Some(_T) => {
          hprintln!("Mutex Locked");
          semihosting::terminate(true);
      },
      None => {
        hprintln!("Lock failed");
        semihosting::terminate(false);
      }
  }
  
}  
  

 





