//! Test waiting with timeout but getting notified before timeout.

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{debug::semihosting, hprintln, sync::Mailbox, task, task::main, time};

static MAILBOX: Mailbox = Mailbox::new();

#[main]
fn main(_: cortex_m::Peripherals) {
    MAILBOX.notify_allow_isr();

    task::build()
        .set_entry(listener)
        .set_priority(4)
        .spawn()
        .unwrap();

    task::build()
        .set_entry(notifier)
        .set_priority(8)
        .spawn()
        .unwrap();
}

fn listener() {
    let notified = MAILBOX.wait_until_timeout(1000);
    if !notified {
        hprintln!("Unexpected timeout.");
        semihosting::terminate(false);
    }

    let notified = MAILBOX.wait_until_timeout(1000);
    if !notified {
        hprintln!("Unexpected timeout.");
        semihosting::terminate(false);
    }

    semihosting::terminate(true);
}

fn notifier() {
    time::sleep_ms(500);
    MAILBOX.notify_allow_isr();
}
