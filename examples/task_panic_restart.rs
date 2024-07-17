#![no_std]
#![no_main]

extern crate alloc;
use core::sync::atomic::{AtomicUsize, Ordering};
use hopter::{boot::main, debug::semihosting, hprintln, schedule, task::TaskBuilder};

// Attribute `#[main]` marks the function as the entry function for the main
// task. The function name can be arbitrary. The main function should accept
// one argument which is the Cortex-M core peripherals.
#[main]
fn main(_: cortex_m::Peripherals) {
    // Start a task running the `will_panic` function.
    // The task is restartable. When the panic occurs, the task's stack will be
    // unwound, and the task will be restarted.
    // schedule::start_restartable_task(2, |_| will_panic(), (), 0, 4).unwrap();

    TaskBuilder::new()
        .entry(|_| will_panic())
        .arg(())
        .set_stack_size(0)
        .set_priority(4)
        .spawn_restartable()
        .unwrap();
}

fn will_panic() {
    // A persistent counter.
    static CNT: AtomicUsize = AtomicUsize::new(0);

    // Every time the task runs we increment it by 1.
    let cnt = CNT.fetch_add(1, Ordering::SeqCst);

    hprintln!("Current count: {}", cnt);

    // Panic and get restarted for 5 times.
    if cnt < 5 {
        panic!();
    }

    // When running with QEMU, this will cause the QEMU process to terminate.
    // Do not include this line when running with OpenOCD, because it will
    // clobber its internal states.
    semihosting::terminate(true);
}
