//! Test timeout waiting on a mailbox. The timeout is deliberate.

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{boot::main, debug::semihosting, hprintln, sync::Mailbox, task};

static MAILBOX: Mailbox = Mailbox::new();

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build().set_entry(listener).spawn().unwrap();
}

fn listener() {
    let notified = MAILBOX.wait_until_timeout(1000);
    if notified {
        hprintln!("Unexpected notification.");
        semihosting::terminate(false);
    }
    semihosting::terminate(true);
}
