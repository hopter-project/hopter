use super::svc_handler::SVCNum;
use core::arch::asm;

/// Invoke SVC to free the top stacklet. This function should *never* be called
/// directly. See [`more_stack`](`super::super::task::more_stack`) for how this
/// function is used.
#[naked]
pub(in super::super) unsafe extern "C" fn svc_less_stack() {
    asm!(
        "svc {task_less_stack}",
        "bx lr",
        task_less_stack = const(SVCNum::TaskLessStack as u8),
        options(noreturn)
    )
}

/// Allocate memory when running in task context, i.e., in thread mode.
#[naked]
pub(in super::super) extern "C" fn svc_malloc(size: u32) -> *mut u8 {
    unsafe {
        asm!(
            "svc {mem_alloc}",
            "bx  lr",
            mem_alloc = const(SVCNum::MemAlloc as u8),
            options(noreturn)
        )
    }
}

/// Free memory when running in task context, i.e., in thread mode.
///
/// Safety: The pointer must point to a memory chunk previously allocated from
/// the heap.
#[naked]
pub(in super::super) unsafe extern "C" fn svc_free(ptr: *mut u8) {
    asm!(
        "svc {mem_free}",
        "bx  lr",
        mem_free = const(SVCNum::MemFree as u8),
        options(noreturn)
    )
}

/// Yield the current task. Let the scheduler choose the next task to run.
/// The current task will become ready to run after yielding.
#[naked]
pub(in super::super) extern "C" fn svc_yield_current_task() {
    unsafe {
        asm!(
            "svc {task_yield}",
            "bx lr",
            task_yield = const(SVCNum::TaskYield as u8),
            options(noreturn)
        )
    }
}

/// Block the current task. Let the scheduler choose the next task to run.
/// The current task will not be scheduled to run unless being notified.
#[naked]
pub(in super::super) extern "C" fn svc_block_current_task() {
    unsafe {
        asm!(
            "svc {task_block}",
            "bx lr",
            task_block = const(SVCNum::TaskBlock as u8),
            options(noreturn)
        )
    }
}

/// Terminate the current task and free its task struct.
#[naked]
pub(in super::super) unsafe extern "C" fn svc_destroy_current_task() {
    asm!(
        "svc {task_destroy}",
        "bx lr",
        task_destroy = const(SVCNum::TaskDestroy as u8),
        options(noreturn)
    )
}
