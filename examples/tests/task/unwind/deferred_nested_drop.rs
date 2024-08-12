//! A deferred forced unwinding should occur when a drop handler function
//! overflows the call stack of a task that does not enable dynamic stack
//! extension. This test further tests the case where the drop handler is
//! nested inside another drop handler. The forced unwinding should begin
//! only after the return of the outmost drop handler finishes.

#![no_std]
#![no_main]

extern crate alloc;
use core::{
    mem::MaybeUninit,
    sync::atomic::{AtomicUsize, Ordering},
};
use hopter::{boot::main, debug::semihosting, hprintln, task};

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build()
        .set_entry(test_task)
        .disable_dynamic_stack()
        .set_stack_size(512)
        .spawn_restartable()
        .unwrap();
}

fn test_task() {
    // A persistent counter.
    static CNT: AtomicUsize = AtomicUsize::new(0);

    // Every time the task runs we increment it by 1.
    let cnt = CNT.fetch_add(1, Ordering::SeqCst);

    // When the task is executed for the first time, run the drop function.
    // Even if this drop function uses a large stack frame and will overflow
    // the task's stack while dynamic stack extension is not enabled, the
    // segmented stack runtime should still allow the drop function to proceed
    // because we cannot initiate an unwinding inside a drop function. A
    // deferred forced unwinding will be executed after the drop handler
    // finishes.
    if cnt == 0 {
        core::mem::drop(OuterDrop(InnerDrop));
    }

    if cnt == 0 {
        // The task should have been unwound so this print should not be
        // reachable.
        hprintln!("Should not print this.");
    }

    if cnt > 0 {
        hprintln!("Task successfully restarted after a deferred forced unwinding.");
        semihosting::terminate(true);
    } else {
        semihosting::terminate(false);
    }
}

struct OuterDrop(InnerDrop);

// Outter drop implicitly also invokes inner drop.
impl Drop for OuterDrop {
    #[inline(never)]
    fn drop(&mut self) {
        hprintln!("Outter drop executed.");
    }
}

struct InnerDrop;

// A drop function that uses a large stack frame.
impl Drop for InnerDrop {
    #[inline(never)]
    fn drop(&mut self) {
        let _padding = StackFramePadding::new();
        hprintln!("Inner drop executed.");
    }
}

/// A padding that causes large stack frame.
struct StackFramePadding {
    _padding: [u8; 1024],
}

impl StackFramePadding {
    /// Use volatile write to prevent the compiler from optimizing away the
    /// padding.
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
