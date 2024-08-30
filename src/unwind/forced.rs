//! Forced unwinding is used to forcefully terminate a task while reclaiming
//! its allocated resources. The only current use of forced unwinding is to
//! terminate a task whose stack is going to overflow but does not enable
//! dynamic stack extension. In this case, the segmented stack runtime
//! [`crate::task::more_stack`] will divert the original function call to
//! [`diverted_unwind`] instead, which further starts the unwinding process.
//!
//! A notable caveat to forced unwinding is that it is an undefined behavior
//! if we initiate unwinding from inside a drop handler function. Thus, if an
//! overflowing function is a drop handler or if any active parent function in
//! the call stack is a drop handler, we must defer the forced unwinding to
//! some later time.
//!
//! A deferred unwinding has two steps:
//! 1. Upon detecting that a forced unwinding must be deferred, the segmented
//!    stack runtime sets a deferred unwinding pending flag in the task local
//!    storage (TLS) area. The flag is currently placed at the fixed address
//!    `0x2000_0008`. The segmented stack runtime allocates a new stacklet to
//!    let the task proceed with executing the function instead of immediately
//!    diverting it to unwinding, even if the task does not enable dynamic
//!    stack extension.
//! 2. When the last (outmost) drop handler is returning, it checks if the
//!    deferred unwinding pending flag is set. If so, instead of returning,
//!    it will call [`deferred_unwind`].
//!
//! The compiler generates a special function prologue and epilogue for drop
//! handler functions to enable deferred forced unwinding.
//!
//! The special prologue contains two components:
//! 1. A segmented stack prologue placed at the very beginning of the function
//!    that detects upcoming stack overflows. When an overflow is impending,
//!    the prologue invokes SVC using a different SVC number than other normal
//!    functions, and thus the segmented stack runtime can notice that the
//!    overflowing function is a drop handler.
//! 2. A counter increment prologue that placed at the beginning of the body of
//!    the drop logic, i.e., `CNT += 1`. The counter is currently placed at a
//!    fixed address in the task local storage (TLS) area. The address of the
//!    counter is `0x2000_0004`. The counter is named
//!    [nested drop count](crate::task::TaskLocalStorage::nested_drop_cnt)
//!    because it represents the nesting level of active drop handlers.
//!
//! The epilogue contains two components:
//! 1. A counter decrement epilogue that placed at the ending of the body of
//!    the drop logic, i.e., `CNT -= 1`.
//! 2. A flag checking epilogue that checks the deferred unwinding pending flag
//!    if the nested drop count is zero after the decrement. If the flag is set,
//!    call [`deferred_unwind`]. The call will be made through a function
//!    pointer stored at address `0x2000_000c`. The function pointer is
//!    initialized by the power on reset assembly sequence
//!    in [boot::reset](crate::boot::reset) and remains constant.

use super::unwind;
use crate::config;
use core::arch::asm;

/// Just jump to the entry point to start unwinding.
#[naked]
pub(crate) extern "C" fn diverted_unwind() {
    unsafe {
        asm!(
            "b {start_unwind_entry}",
            start_unwind_entry = sym unwind::start_unwind_entry,
            options(noreturn)
        )
    }
}

/// See [module](crate::unwind::forced) level documentation for when this
/// function will be called.
#[naked]
pub(crate) extern "C" fn deferred_unwind() {
    unsafe {
        asm!(
            // Clear the deferred unwinding pending flag.
            "mov r0, #0",
            "ldr r1, ={tls_mem_addr}",
            "str r0, [r1, #8]",
            // Jump to the entry point to start unwinding.
            "b {start_unwind_entry}",
            tls_mem_addr = const config::TLS_MEM_ADDR,
            start_unwind_entry = sym unwind::start_unwind_entry,
            options(noreturn)
        )
    }
}
