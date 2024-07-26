#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, schedule, hprintln, sync, sync::Consumer};



#[main]
fn main(_: cortex_m::Peripherals) {

    let (producer, consumer) = sync::create_channel::<usize, 4>();

    producer.produce(1);
    producer.produce(2);
    producer.produce(3);
    producer.produce(4);

    let mut consumer2 = consumer.clone();
    let mut consumer3 = consumer.clone();

    schedule::start_task(2, move |_| consume_thread(&mut consumer2), (), 0, 4).unwrap();
    schedule::start_task(3, move |_| consume_thread(&mut consumer3), (), 0, 4).unwrap();

    schedule::change_current_task_priority(10).unwrap();

    if consumer.try_consume_allow_isr() != None{
        hprintln!("Channel not empty");
        semihosting::terminate(false);
    }
    hprintln!("Test Passed");
    semihosting::terminate(true);

}


fn consume_thread(consumer: &mut Consumer<usize, 4>)
{
    consumer.consume();
    consumer.consume();
}
