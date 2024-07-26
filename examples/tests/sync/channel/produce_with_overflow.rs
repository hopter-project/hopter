#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync};

#[main]
fn main(_: cortex_m::Peripherals) {

    // create a channel with a buffer capacity of 4
    let (producer, consumer) = sync::create_channel::<usize, 4>();

    // fill channel with values 0-3
    for i in 0..4
    {
        producer.produce(i);
        hprintln!("{}", i);
    }

    // attempt to push values 4-7
    // produce_with_overflow_allow_isr should return the value we attempt to push each time
    for i in 4..8
    {
        let result = producer.produce_with_overflow_allow_isr(i);
        if result != Some(i)
        {
            hprintln!("Test Failed");
            semihosting::terminate(false);
        }

    }

    // consume each value in channel, confirming the values are 0-3
    for i in 0..4
    {
        let value = consumer.consume();
        if value != i
        {
            hprintln!("Test Failed");
            semihosting::terminate(false);
        }
    }
    hprintln!("Test Passed");
    semihosting::terminate(true);




}
