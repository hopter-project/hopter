//! Test notifying a task from task context. The notification to the mailbox
//! happens before the task waits on the mailbox.

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    sync::Mailbox,
    task::main,
};

static MAILBOX: Mailbox = Mailbox::new();

#[main]
fn main(_: cortex_m::Peripherals) {
    for _ in 0..5 {
        MAILBOX.notify_allow_isr();
    }

    for _ in 0..5 {
        MAILBOX.wait();
        dbg_println!("received");
    }

    // semihosting::terminate(true);
    dbg_println!("test complete!");
    loop {}
}
