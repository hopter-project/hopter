#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln};

// Attribute `#[main]` marks the function as the entry function for the main
// task. The function name can be arbitrary. The main function should accept
// one argument which is the Cortex-M core peripherals.
#[main]
fn main(_: cortex_m::Peripherals) {
    // Print via semihosting. When using QEMU with semihosting option enabled,
    // the characters will appear on the QEMU console.
    say_hello_fn();

    // When running with QEMU, this will cause the QEMU process to terminate.
    // Do not include this line when running with OpenOCD, because it will
    // clobber its internal states.
    semihosting::terminate(true);
}

#[no_mangle]
fn say_hello_fn() {
    for i in 0..10 {
        hprintln!("Hello, world! {}", i);
    }
}
