#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync::Mutex};

#[main]
fn main(_: cortex_m::Peripherals) {
    let data = "Data for the Test";
    schedule::start_task(2, move |_| task1(&data), (), 0, 4).unwrap();
    schedule::start_task(3, move |_| task2(&data), (), 0, 4).unwrap();

    schedule::change_current_task_priority(10).unwrap();
    semihosting::terminate(true);


}

fn task1(data: &str){

  let mutex = Mutex::new(data);
  let result = mutex.try_lock();

  match result {
      Some(_t) => {
          hprintln!("Mutex Locked in Task 1");
      },
      None => {
        hprintln!("Lock failed in Task 1");
        semihosting::terminate(false);
      }
  }

}

fn task2(data: &str){

  let mutex = Mutex::new(data);
  let result = mutex.try_lock();

  match result {
      Some(_t) => {
          hprintln!("Mutex Locked in Task 2");
      },
      None => {
        hprintln!("Lock failed in Task 2");
        semihosting::terminate(false);
      }
  }

}

