use crate::{
    sync::{SpinSchedSafe, SpinSchedSafeGuard},
    task::{Task, TaskCtxt},
};
use alloc::sync::Arc;

/// The `Arc` of the currently running task. After the scheduler is started,
/// it should always be `Some`. When all user tasks are blocked, it should
/// be the idle task.
static CUR_TASK: SpinSchedSafe<Option<Arc<Task>>> = SpinSchedSafe::new(None);

/// Get the task struct of the currently running task.
fn get_cur_task() -> SpinSchedSafeGuard<'static, Option<Arc<Task>>> {
    CUR_TASK.lock_now_or_die()
}

/// Update the current running task to a new one.
pub(super) fn set_cur_task(task: Arc<Task>) {
    let mut write_guard = CUR_TASK.lock_now_or_die();
    write_guard.replace(task);
}

/// Forcefully release the lock on the registers of the current task.
///
/// Safety: The locked should have been acquired. There should be no active
/// reference to the content.
pub(super) unsafe extern "C" fn release_cur_task_regs() {
    with_current_task(|cur_task| cur_task.force_unlock_ctxt());
}

/// Lock the current task's in-memory preserved registers. Return the mutable
/// pointer to the locked content.
pub(super) fn lock_cur_task_regs() -> *mut TaskCtxt {
    with_current_task(|cur_task| cur_task.lock_ctxt())
}

/// Do things with the current task struct. When the given closure is being
/// executed, the current task `Arc` in the scheduler will be locked in
/// reader mode and thus no context switch should happen during this period.
pub(crate) fn with_current_task_arc<F, R>(closure: F) -> R
where
    F: FnOnce(Arc<Task>) -> R,
{
    // WARNING: the reader lock on the current task `Arc` is deliberately
    // held longer than necessary to make the following `.clone()`. This is
    // to ensure that during the running of the closure no context switch
    // shall ever happen.
    let cur_task = get_cur_task();

    let ret = if let Some(cur_task) = &*cur_task {
        closure(cur_task.clone())
    } else {
        loop {}
    };

    return ret;
}

/// Do things with the current task struct. When the given closure is being
/// executed, the current task `Arc` in the scheduler will be locked in
/// reader mode and thus no context switch should happen during this period.
pub(crate) fn with_current_task<F, R>(closure: F) -> R
where
    F: FnOnce(&Task) -> R,
{
    let cur_task = get_cur_task();
    let ret = if let Some(cur_task) = &*cur_task {
        closure(cur_task)
    } else {
        loop {}
    };

    return ret;
}
