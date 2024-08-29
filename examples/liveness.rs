#![no_std]
#![no_main]

extern crate alloc;
use alloc::boxed::Box;
use hopter::{boot::main, debug::semihosting, hprintln, time};

#[derive(Debug)]
struct MyStruct {
    a: u32,
    b: u32,
}

impl Drop for MyStruct {
    fn drop(&mut self) {
        hprintln!("Dropping Mystruct: {:?}", self);
    }
}

// Attribute `#[main]` marks the function as the entry function for the main
// task. The function name can be arbitrary. The main function should accept
// one argument which is the Cortex-M core peripherals.
#[main]
fn main(_: cortex_m::Peripherals) {
    // Print via semihosting. When using QEMU with semihosting option enabled,
    // the characters will appear on the QEMU console.
    // hprintln!("hello world!");

    let tick = time::get_tick();

    let y = Box::new(MyStruct { a: 1, b: 1 });

    let mut x = MyStruct { a: 2, b: 2 };

    x.a = 3;
    x.b = 3;

    if tick % 2 == 0 {
        drop(x);
        drop(y);
    }

    // When running with QEMU, this will cause the QEMU process to terminate.
    // Do not include this line when running with OpenOCD, because it will
    // clobber its internal states.
    // semihosting::terminate(true);
    semihosting::dbg_println!("test complete!");
    loop {}
}
