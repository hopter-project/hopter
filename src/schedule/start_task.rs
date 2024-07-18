use super::scheduler;
use crate::task::Task;
use alloc::sync::Arc;

/// Create a new task with the given task ID and the closure as the entry
/// function. The task ID should be non-zero otherwise the function will
/// return `Err(())`. `reserve_stack_size` is the extra bytes allocated
/// to the initial stacklet.
pub fn start_task<F>(
    id: u8,
    entry_closure: F,
    reserve_stack_size: usize,
    priority: u8,
) -> Result<(), ()>
where
    F: FnOnce() + Send + 'static,
{
    let new_task = Task::build(id, entry_closure, reserve_stack_size, priority)?;
    scheduler::make_new_task_ready(id, Arc::new(new_task))
}

/// Create a new task with the given task ID and the closure as the entry
/// function. The task ID should be non-zero otherwise the function will
/// return `Err(())`. `reserve_stack_size` is the extra bytes allocated
/// to the initial stacklet.
///
/// When created task panics, it will automatically restart using the same
/// entry function, and thus it must implement `Clone`.
#[cfg(feature = "unwind")]
pub fn start_restartable_task<F>(
    id: u8,
    entry_closure: F,
    reserve_stack_size: usize,
    priority: u8,
) -> Result<(), ()>
where
    F: FnOnce() + Send + Sync + Clone + 'static,
{
    let new_task = Task::build_restartable(id, entry_closure, reserve_stack_size, priority)?;
    scheduler::make_new_task_ready(id, Arc::new(new_task))
}

/// Start a new task from a previously failed task.
#[cfg(feature = "unwind")]
pub(crate) fn restart_from_task(prev_task: Arc<Task>) -> Result<(), ()> {
    let id = prev_task.get_id();
    let new_task = Task::build_restarted(prev_task)?;

    // FIXME: should check for available task slot in advance but not here.
    scheduler::make_new_task_ready(id, Arc::new(new_task))
}
