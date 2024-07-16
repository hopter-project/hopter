#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, schedule, sync::Mutex};

static MUTEX: Mutex<usize> = Mutex::new(0);
const ITERATIONS: usize = 10;

#[main]
fn main(_: cortex_m::Peripherals) {
      schedule::start_restartable_task(2, move |_| task(), (), 0, 4).unwrap();
}


fn task(){
      let mut curr_value = 0;
      for _ in 0..ITERATIONS {
            let mut guard = MUTEX.lock();
            *guard += 1;
            curr_value = *guard;
      }


      hprintln!("curr_value: {}", curr_value);
      if curr_value < 100 {
            panic!();
      } else if curr_value > 100 {
            hprintln!("Test Failed");
            semihosting::terminate(false); 
      } else {
            hprintln!("Test Passed");
            semihosting::terminate(true); 
      }
}


