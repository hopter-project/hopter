#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync};

#[main]
fn main(_: cortex_m::Peripherals) {

    let (producer, consumer) = sync::create_channel::<usize, 4>();
    
    producer.produce(23);
    producer.produce(24);
    producer.produce(25);
    producer.produce(26);
    for i in 0..4
    {
        let value = consumer.consume();
        if value != 23 + i
        {
            hprintln!("Test Failed");
            semihosting::terminate(false);
        }

    }
    hprintln!("Test Passed");
    semihosting::terminate(true);

}