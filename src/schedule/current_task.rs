use crate::{
    sync::{self, RwLock, RwLockReadGuard},
    task::{Task, TaskCtxt},
};
use alloc::sync::Arc;

/// The `Arc` of the currently running task. After the scheduler is started,
/// it should always be `Some`. When all user tasks are blocked, it should
/// be the idle task.
///
/// NOTE: We must use a [`RwLock`] instead of a
/// [`SpinSchedSafe`](crate::sync::SpinSchedSafe) to protect the data. This is
/// because the [`more_stack`](crate::task::more_stack) and
/// [`less_stack`](crate::task::less_stack) function need to access the current
/// task struct. However, `more_stack` or `less_stack` may be invoked when the
/// current task struct is being accessed. Thus, using a spin lock will cause
/// deadlock, and `RwLock` is necessary.
static CUR_TASK: RwLock<Option<Arc<Task>>> = RwLock::new(None);

/// Get the task struct of the currently running task.
pub(super) fn get_cur_task() -> RwLockReadGuard<'static, Option<Arc<Task>>> {
    CUR_TASK.read()
}

/// Update the current running task to a new one.
pub(super) fn set_cur_task(task: Arc<Task>) {
    let mut write_guard = CUR_TASK.write();
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
    let _sched_suspend_guard = sync::suspend_scheduler();

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
    let _sched_suspend_guard = sync::suspend_scheduler();

    let cur_task = get_cur_task();
    let ret = if let Some(cur_task) = &*cur_task {
        closure(cur_task)
    } else {
        loop {}
    };

    return ret;
}
