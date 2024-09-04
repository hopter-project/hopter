//! Tests that a panicked task will be restarted by a new instance running in
//! concurrent with the unwinding process of the panicked instance. The old
//! panicked instance should be reduced to a low priority (`UNWIND_PRIORITY`)
//! and thus the restarted instance should finish before the unwinding completes.

#![no_std]
#![no_main]

extern crate alloc;
use core::sync::atomic::{AtomicBool, Ordering};
use hopter::{
    config,
    debug::semihosting::{self, dbg_println},
    task,
    task::main,
};

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build()
        .set_entry(will_panic)
        .spawn_restartable()
        .unwrap();

    // Let the test task and its unwinding complete first.
    task::change_current_priority(config::UNWIND_PRIORITY + 1).unwrap();

    #[cfg(feature = "qemu")]
    semihosting::terminate(true);
    #[cfg(not(feature = "qemu"))]
    {
        dbg_println!("test complete!");
        loop {}
    }
}

fn will_panic() {
    static FIRST_TIME: AtomicBool = AtomicBool::new(true);
    let first_time = FIRST_TIME.fetch_and(false, Ordering::SeqCst);

    // Deliberate panic when the task is executed for the first time.
    // Unwinding should happen after the second run is completed.
    if first_time {
        let _print_on_drop = PrintOnDrop("First run dropped on panic");
        panic!()
    }

    dbg_println!("Second run completed");
}

struct PrintOnDrop(&'static str);

impl Drop for PrintOnDrop {
    fn drop(&mut self) {
        dbg_println!("{}", self.0)
    }
}
