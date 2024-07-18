//! Test notifying a task from another task. The waiting task starts its wait
//! before the notifying task notifies.

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Mailbox, task, time};

static MAILBOX: Mailbox = Mailbox::new();

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build().set_entry(notifier).spawn().unwrap();
    task::build().set_entry(listener).spawn().unwrap();
}

fn notifier() {
    for _ in 0..5 {
        time::sleep_ms(250);
        MAILBOX.notify_allow_isr();
    }
}

fn listener() {
    for _ in 0..5 {
        MAILBOX.wait();
        hprintln!("received");
    }

    semihosting::terminate(true);
}
