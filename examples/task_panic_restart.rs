#![no_std]
#![no_main]

extern crate alloc;
use core::sync::atomic::{AtomicUsize, Ordering};
use hopter::{
    debug::semihosting::{self, dbg_println},
    schedule, task,
    task::main,
};

// Attribute `#[main]` marks the function as the entry function for the main
// task. The function name can be arbitrary. The main function should accept
// one argument which is the Cortex-M core peripherals.
#[main]
fn main(_: cortex_m::Peripherals) {
    // Start a task running the `will_panic` function.
    // The task is restartable. When the panic occurs, the task's stack will be
    // unwound, and the task will be restarted.
    // will_panic();
//     schedule::start_restartable_task(2, |_| will_panic2(), (), 0, 4).unwrap();
//     schedule::start_restartable_task(2, |_| will_panic(), (), 0, 4).unwrap();
    task::build()
        .set_entry(will_panic)
        .spawn_restartable()
        .unwrap();
}

fn will_panic() {
    // A persistent counter.
    static CNT: AtomicUsize = AtomicUsize::new(0);

    // Every time the task runs we increment it by 1.
    let cnt = CNT.fetch_add(1, Ordering::SeqCst);

// <<<<<<< main
    hprintln!("Current count: {}", cnt);
//     dbg_println!("Current count: {}", cnt);


    // Panic and get restarted for 5 times.
    if cnt < 1 {
        hprintln!("Panic1!");
        panic!();
    }

    // When running with QEMU, this will cause the QEMU process to terminate.
    // Do not include this line when running with OpenOCD, because it will
    // clobber its internal states.
    semihosting::terminate(true);
}

fn will_panic2() {
    // A persistent counter.
    static CNT: AtomicUsize = AtomicUsize::new(0);

    // Every time the task runs we increment it by 1.
    let cnt = CNT.fetch_add(1, Ordering::SeqCst);

    // hprintln!("Current count: {}", cnt);

    // Panic and get restarted for 5 times.
    if cnt < 1 {
        hprintln!("Panic2!");
        panic!();
    }

    // When running with QEMU, this will cause the QEMU process to terminate.
    // Do not include this line when running with OpenOCD, because it will
    // clobber its internal states.
    semihosting::terminate(true);
}
