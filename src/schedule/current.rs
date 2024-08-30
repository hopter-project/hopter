use super::scheduler::Scheduler;
use crate::{
    sync::{RwSpin, RwSpinReadGuard, RwSpinWriteGuard},
    task::{Task, TaskCtxt},
    unrecoverable,
};
use alloc::sync::Arc;
use core::{
    arch::asm,
    sync::atomic::{AtomicPtr, Ordering},
};

/// The `Arc` of the currently running task. After the scheduler is started,
/// it should always be `Some`. When no other user task is ready, the current
/// task should be the idle task.
///
/// The [`RwSpin`] around it is only for sanity check.
///
/// NOTE: We must use a [`RwSpin`] instead of a
/// [`SpinSchedSafe`](crate::sync::SpinSchedSafe) to protect the data. This is
/// because the [`more_stack`](crate::task::more_stack) and
/// [`less_stack`](crate::task::less_stack) function need to access the current
/// task struct. However, `more_stack` or `less_stack` may be invoked when the
/// current task struct is being accessed. Thus, using a spin lock will cause
/// deadlock, and [`RwSpin`] is necessary.
static CUR_TASK: RwSpin<Option<Arc<Task>>> = RwSpin::new(None);

/// Set another task to be the current task. The current task will lock its
/// context field. See [`Task`] for the context lock invariant.
pub(super) fn update_cur_task(task: Arc<Task>) {
    let mut write_guard: RwSpinWriteGuard<_> = CUR_TASK.write();

    // Unlock the context struct for the task being context switched out of
    // the CPU. The only case where the current task is `None` is upon system
    // boot.
    //
    // Safety: The lock was acquired by the next statement when the task was
    // being context switched on to the CPU.
    if let Some(ref cur_task) = *write_guard {
        unsafe {
            cur_task.force_unlock_ctxt();
        }
    }

    // Acquire the context lock for the task going to be executed on the CPU.
    let task_ctxt_ptr = task.lock_ctxt();

    // Update the global pointer so that the context switch assembly sequence
    // will find the new task context through the pointer.
    CUR_TASK_CTXT_PTR.store(task_ctxt_ptr, Ordering::SeqCst);

    // Update the global `Arc` current task reference.
    write_guard.replace(task);
}

/// Point to the struct that preserves the task's callee-saved registers upon
/// context switch. This pointer is used by the context switch assembly
/// sequence in [`context_switch`](crate::interrupt::context_switch).
#[no_mangle]
pub(crate) static CUR_TASK_CTXT_PTR: AtomicPtr<TaskCtxt> = AtomicPtr::new(core::ptr::null_mut());

/// Do things with the current task struct. When the given closure is being
/// executed, the current task `Arc` will be locked in reader mode and no
/// context switch will happen during this period.
///
/// [`with_current_task_arc`] has slightly better performance than this
/// function. Use that function if `&Task` suffices.
pub(crate) fn with_current_task_arc<F, R>(closure: F) -> R
where
    F: FnOnce(Arc<Task>) -> R,
{
    // Suspend the scheduler and lock the current task `Arc` in reader mode.
    let _sched_suspend_guard = Scheduler::suspend();
    let read_guard = CUR_TASK.read();

    // Run the closure.
    if let Some(cur_task) = &*read_guard {
        closure(cur_task.clone())
    } else {
        unrecoverable::die();
    }
}

/// Do things with the current task struct. When the given closure is being
/// executed, the current task `Arc` will be locked in reader mode and no
/// context switch will happen during this period.
///
/// This function has slightly better performance than [`with_current_task_arc`].
pub(crate) fn with_current_task<F, R>(closure: F) -> R
where
    F: FnOnce(&Task) -> R,
{
    // Suspend the scheduler and lock the current task `Arc` in reader mode.
    let _sched_suspend_guard = Scheduler::suspend();
    let read_guard: RwSpinReadGuard<_> = CUR_TASK.read();

    // Run the closure.
    if let Some(cur_task) = &*read_guard {
        closure(cur_task)
    } else {
        unrecoverable::die();
    }
}

/// Return if the code is currently executing in an interrupt service routine
/// (ISR), in contrast to in a task.
pub(crate) fn is_in_isr_context() -> bool {
    let ipsr: u32;

    unsafe {
        asm!(
            "mrs {}, ipsr",
            out(reg) ipsr,
            options(nomem, nostack)
        );
    }

    ipsr != 0
}

/// Return if the code is currently executing in a task, in contrast to in an
/// interrupt service routine (ISR).
pub(crate) fn is_in_task_context() -> bool {
    !is_in_isr_context()
}

/// Return if the code is currently executing in the PendSV exception context.
pub(crate) fn is_in_pendsv_context() -> bool {
    let ipsr: u32;

    unsafe {
        asm!(
            "mrs {}, ipsr",
            out(reg) ipsr,
            options(nomem, nostack)
        );
    }

    ipsr == 14
}
