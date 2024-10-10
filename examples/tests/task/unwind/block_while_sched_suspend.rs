//! A forced unwinding should occur when a task without dynamic stack extension
//! is going to overflow its stack.

#![no_std]
#![no_main]

extern crate alloc;
use hopter::{
    debug::semihosting::{self, dbg_println},
    interrupt::mask::{AllIrqExceptSvc, MaskableIrq},
    sync::{self, CondVar, Mailbox, Mutex, Semaphore},
    task::{self, main},
    time,
};
use hopter_conf_params::DEFAULT_TASK_PRIORITY;

#[main]
fn main(_: cortex_m::Peripherals) {
    task::change_current_priority(DEFAULT_TASK_PRIORITY + 1).unwrap();

    task::build()
        .set_entry(panic_with_semaphore)
        .spawn()
        .unwrap();
    task::build().set_entry(panic_with_mutex).spawn().unwrap();
    task::build().set_entry(panic_with_channel).spawn().unwrap();
    task::build().set_entry(panic_with_condvar).spawn().unwrap();
    task::build().set_entry(panic_with_mailbox).spawn().unwrap();
    task::build().set_entry(panic_with_sleep).spawn().unwrap();

    #[cfg(feature = "qemu")]
    semihosting::terminate(true);
    #[cfg(not(feature = "qemu"))]
    {
        dbg_println!("test complete!");
        loop {}
    }
}

fn panic_with_semaphore() {
    static SEM: Semaphore = Semaphore::new(1, 0);

    let pod = PrintOnDrop("Panicked with semaphore.");
    let _guard = AllIrqExceptSvc::mask();

    SEM.down();

    // Don't print if not panic.
    core::mem::forget(pod);
}

fn panic_with_mutex() {
    static MTX: Mutex<()> = Mutex::new(());

    let pod = PrintOnDrop("Panicked with mutex.");
    let _guard = AllIrqExceptSvc::mask();

    let _mtx_gurad = MTX.lock();
    MTX.lock();

    // Don't print if not panic.
    core::mem::forget(pod);
}

fn panic_with_channel() {
    let (_, cons) = sync::create_channel::<(), 4>();

    let pod = PrintOnDrop("Panicked with channel.");
    let _guard = AllIrqExceptSvc::mask();

    cons.consume();

    // Don't print if not panic.
    core::mem::forget(pod);
}

fn panic_with_condvar() {
    static CV: CondVar = CondVar::new();

    let pod = PrintOnDrop("Panicked with condvar.");
    let _guard = AllIrqExceptSvc::mask();

    CV.wait_without_lock_until(|| false);

    // Don't print if not panic.
    core::mem::forget(pod);
}

fn panic_with_mailbox() {
    static MAILBOX: Mailbox = Mailbox::new();

    let pod = PrintOnDrop("Panicked with mailbox.");
    let _guard = AllIrqExceptSvc::mask();

    MAILBOX.wait();

    // Don't print if not panic.
    core::mem::forget(pod);
}

fn panic_with_sleep() {
    let pod = PrintOnDrop("Panicked with sleep.");
    let _guard = AllIrqExceptSvc::mask();

    time::sleep_ms(1000).unwrap();

    // Don't print if not panic.
    core::mem::forget(pod);
}

struct PrintOnDrop(&'static str);

impl Drop for PrintOnDrop {
    fn drop(&mut self) {
        dbg_println!("{}", self.0);
    }
}
