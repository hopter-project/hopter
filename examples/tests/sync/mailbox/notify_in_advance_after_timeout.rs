//! Test in-advance notification on mailbox after a timeout on the mailbox.

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{debug::semihosting, hprintln, sync::Mailbox, task, task::main};

static MAILBOX: Mailbox = Mailbox::new();

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build().set_entry(listener).spawn().unwrap();
}

fn listener() {
    let notified = MAILBOX.wait_until_timeout(500);
    if notified {
        hprintln!("Unexpected notification.");
        semihosting::terminate(false);
    }

    MAILBOX.notify_allow_isr();

    let notified = MAILBOX.wait_until_timeout(500);
    if !notified {
        hprintln!("Unexpected timeout.");
        semihosting::terminate(false);
    }

    semihosting::terminate(true);
}
