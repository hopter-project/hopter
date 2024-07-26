#![no_main]
#![no_std]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync};

#[main]
fn main(_: cortex_m::Peripherals) {

    let (producer, consumer) = sync::create_channel::<usize, 4>();

    // attempt to consume from an empty channel
    let result = consumer.try_consume_allow_isr();

    if result != None
    {
        hprintln!("consumed from an empty channel");
        semihosting::terminate(false);
    }

    // fill channel
    for i in 0..4
    {
        producer.produce(i);
    }

    // empty channel
    for _i in 0..4
    {
        let result = consumer.try_consume_allow_isr();
        if result == None
        {
            hprintln!("failed to consume from a non-empty channel");
            semihosting::terminate(false);
        }
    }

    //should return None now that the channel is empty
    let final_result = consumer.try_consume_allow_isr();
    match final_result
    {
        None => {
            hprintln!("Test Passed");
            semihosting::terminate(true);
        }
        Some(_t)=> {
            hprintln!("consumed from an empty channel");
            semihosting::terminate(false);
        }
    }

}