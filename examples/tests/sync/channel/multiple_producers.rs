#![no_main]
#![no_std]

extern crate alloc;
use alloc::vec;
use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync, sync::Producer};

#[main]
fn main(_: cortex_m::Peripherals) {

    let (mut producer, consumer) = sync::create_channel::<usize, 4>();
    let mut producer2 = producer.clone();

    schedule::start_task(2, move |_| produce_thread(&mut producer), (), 0, 4).unwrap();
    schedule::start_task(3, move |_| produce2_thread(&mut producer2), (), 0, 4).unwrap();

    schedule::change_current_task_priority(10).unwrap();
    let values = vec![
        consumer.consume(),
        consumer.consume(),
        consumer.consume(),
        consumer.consume(),
        ];

    if values != vec![1, 2, 3, 4]{
        hprintln!("Test Failed");
        semihosting::terminate(false);
    }
    hprintln!("Test Passed");
    semihosting::terminate(true);

}


fn produce_thread(producer: &mut Producer<usize, 4>)
{
    producer.produce(1);
    producer.produce(2);
}

fn produce2_thread(producer2: &mut Producer<usize, 4>)
{
    producer2.produce(3);
    producer2.produce(4);
}