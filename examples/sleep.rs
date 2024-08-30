#![no_std]
#![no_main]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    task::main,
    time,
};

// Attribute `#[main]` marks the function as the entry function for the main
// task. The function name can be arbitrary. The main function should accept
// one argument which is the Cortex-M core peripherals.
#[main]
fn main(_: cortex_m::Peripherals) {
    for _ in 0..5 {
        // Let the task sleep for some time.
        time::sleep_ms(1000);
        // Print via semihosting. When using QEMU with semihosting option enabled,
        // the characters will appear on the QEMU console.
        dbg_println!("hello");
    }

    // When running with QEMU, this will cause the QEMU process to terminate.
    // Do not include this line when running with OpenOCD, because it will
    // clobber its internal states.
    semihosting::terminate(true);
}
