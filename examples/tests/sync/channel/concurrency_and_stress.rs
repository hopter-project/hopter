#![no_main]
#![no_std]

extern crate alloc;
use alloc::vec;
use alloc::vec::Vec;
use core::sync::atomic::{AtomicUsize, Ordering};
use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync, sync::Producer};


const NUM_THREADS: usize = 4;
const NUM_ITEMS: usize = 3;
static TASK_COMPLETION_COUNTER: AtomicUsize = AtomicUsize::new(0);


#[main]
fn main(_: cortex_m::Peripherals) {

    // create a channel with a buffering capacity of 16
    let (producer, consumer) = sync::create_channel::<usize, 16>();

    // create 4 tasks, cloning the producer each time
    for i in 2..6
    {
        let mut cloned_producer = producer.clone();
        schedule::start_task(2 + i as u8, move |_| thread(&mut cloned_producer, i), (), 0, 4).unwrap();
    }
    schedule::change_current_task_priority(10).unwrap();

    //consume the numbers produced by the tasks, storing them in a vector
    let mut results = vec![];
    for _ in 0..(4 * NUM_ITEMS) {
        results.push(consumer.consume());
    }


    results.sort();

    // make a vector to compare the results to
    let compare_vec = (6..(NUM_THREADS * NUM_THREADS + 2)).collect::<Vec<_>>();


    if results != compare_vec{
        hprintln!("Test Failed");
        semihosting::terminate(false);
    }
    hprintln!("Test Passed");
    semihosting::terminate(true);


}


fn thread(producer: &mut Producer<usize, 16>, i: usize){

    for j in 0..NUM_ITEMS {
        producer.produce(i * NUM_ITEMS + j);
    }

    TASK_COMPLETION_COUNTER.fetch_add(1, Ordering::SeqCst);

}
