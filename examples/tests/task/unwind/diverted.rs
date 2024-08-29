//! A forced unwinding should occur when a task without dynamic stack extension
//! is going to overflow its stack.

#![no_std]
#![no_main]

extern crate alloc;
use core::{
    mem::MaybeUninit,
    sync::atomic::{AtomicUsize, Ordering},
};
use hopter::{
    debug::semihosting::{self, dbg_println},
    task,
    task::main,
};

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build()
        .set_entry(test_task)
        .disable_dynamic_stack()
        .set_stack_limit(512)
        .spawn_restartable()
        .unwrap();
}

fn test_task() {
    // A persistent counter.
    static CNT: AtomicUsize = AtomicUsize::new(0);

    // Every time the task is started we increment it by 1.
    let cnt = CNT.fetch_add(1, Ordering::SeqCst);

    // Call the large function when the task is executed for the first time.
    // The function will require a large stack frame causing a stack overflow.
    // The function call should be diverted to a forced stack unwinding.
    if cnt == 0 {
        large_func();
    }

    if cnt == 0 {
        // The task should have been unwound so this print should not be
        // reachable.
        dbg_println!("Should not print this.");
    }

    if cnt > 0 {
        dbg_println!("Task successfully restarted after a diverted forced unwinding.");
        #[cfg(feature = "qemu")]
        semihosting::terminate(true);
        #[cfg(not(feature = "qemu"))]
        {
            dbg_println!("test complete!");
            loop {}
        }
    } else {
        #[cfg(feature = "qemu")]
        semihosting::terminate(false);
        #[cfg(not(feature = "qemu"))]
        {
            dbg_println!("test complete!");
            loop {}
        }
    }
}

/// A function that allocates a large stack frame.
#[inline(never)]
fn large_func() {
    let _padding = StackFramePadding::new();
}

struct StackFramePadding {
    _padding: [u8; 1024],
}

impl StackFramePadding {
    fn new() -> Self {
        let mut padding = MaybeUninit::<[u8; 1024]>::uninit();
        let mut ptr = unsafe { (*padding.as_mut_ptr()).as_mut_ptr() };
        for _ in 0..1024 {
            unsafe {
                ptr.write_volatile(0);
                ptr = ptr.offset(1);
            }
        }
        let padding = unsafe { padding.assume_init() };
        Self { _padding: padding }
    }
}
