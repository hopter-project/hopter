use super::Task;
use crate::{config, schedule::scheduler, unrecoverable::Lethal};
use alloc::sync::Arc;

/// Enumeration of errors during task creation.
#[derive(Debug, PartialEq)]
pub enum TaskBuildError {
    /// Dynamic stack extension is disabled but stack size is not configured.
    NoStack,
    /// Has reached the maximum task number
    /// [MAX_TASK_NUMBER](config::MAX_TASK_NUMBER).
    NoMoreTask,
    /// No entry closure is set for the task.
    NoEntry,
    /// The priority level is not an allowed value.
    PriorityNotAllowed,
}

/// Supporting the builder pattern to create a new task.
pub struct TaskBuilder<F>
where
    F: FnOnce() + Send + 'static,
{
    entry_closure: Option<F>,
    init_stklet_size: usize,
    priority: Option<u8>,
    id: Option<u8>,
    is_dynamic_stack: bool,
}

/// Build a new task with the task builder.
///
/// # Example
/// ```rust
/// task::build()
///     .set_entry(foo)
///     .spawn()
///     .unwrap();
///
/// fn foo() {}
/// ```
pub fn build<F>() -> TaskBuilder<F>
where
    F: FnOnce() + Send + 'static,
{
    TaskBuilder::new()
}

impl<F> TaskBuilder<F>
where
    F: FnOnce() + Send + 'static,
{
    const fn new() -> Self {
        Self {
            entry_closure: None,
            init_stklet_size: 0,
            priority: None,
            id: None,
            is_dynamic_stack: true,
        }
    }

    /// Set a numerical ID for the task.
    ///
    /// The ID is used only for tagging a task and does not have any functional
    /// purpose. It might be helpful for diagnosing bugs. The ID need not be
    /// unique among tasks.
    pub fn set_id(mut self, id: u8) -> Self {
        self.id.replace(id);
        self
    }

    /// Set the entry closure for the task. This is the entry point where the
    /// task will start to run.
    pub fn set_entry(mut self, closure: F) -> Self {
        self.entry_closure.replace(closure);
        self
    }

    /// Set the stack size of the task. If dynamic stack extension is enabled
    /// (default), then the configured size becomes the size of the initial
    /// stacklet. The default is 0.
    ///
    /// Must set a stack size when dynamic stack extension is disabled.
    ///
    /// When dynamic stack extension is enabled, an upcoming stacklet overflow
    /// will be resolved by dynamically allocating a new stacklet. When dynamic
    /// extension is disabled, a stack overflow will cause a forceful unwinding
    /// to the task.
    pub fn set_stack_size(mut self, size: usize) -> Self {
        self.init_stklet_size = size;
        self
    }

    /// Disable dynamic stack extension for the task. A stack overflow will
    /// cause a forceful unwinding to the task.
    ///
    /// When dynamic stack extension is disabled, must set a stack size through
    /// [`set_stack_size`](Self::set_stack_size).
    pub fn disable_dynamic_stack(mut self) -> Self {
        self.is_dynamic_stack = false;
        self
    }

    /// Set the priority to a task. If not explicitly set, the task will have
    /// the [`DEFAULT_TASK_PRIORITY`](config::DEFAULT_TASK_PRIORITY).
    pub fn set_priority(mut self, prio: u8) -> Self {
        self.priority.replace(prio);
        self
    }

    /// Start the task. A spawned task is always detached. If a panic occurs
    /// while running the task, the task's stack will be unwound.
    pub fn spawn(self) -> Result<(), TaskBuildError> {
        let entry_closure = self.entry_closure.ok_or(TaskBuildError::NoEntry)?;
        let id = self.id.unwrap_or(config::DEFAULT_TASK_ID);
        let prio = self.priority.unwrap_or(config::DEFAULT_TASK_PRIORITY);

        if self.init_stklet_size == 0 && !self.is_dynamic_stack {
            return Err(TaskBuildError::NoStack);
        }

        let new_task = Task::build(
            id,
            entry_closure,
            self.init_stklet_size,
            self.is_dynamic_stack,
            prio,
        )
        .unwrap_or_die();
        scheduler::make_new_task_ready(id, Arc::new(new_task))
            .map_err(|_| TaskBuildError::NoMoreTask)
    }
}

impl<F> TaskBuilder<F>
where
    F: FnOnce() + Send + Sync + Clone + 'static,
{
    /// Start the task. A spawned task is always detached. If a panic occurs
    /// while running the task, the task's stack will be unwound and a new
    /// instance will be automatically created.
    #[cfg(feature = "unwind")]
    pub fn spawn_restartable(self) -> Result<(), TaskBuildError> {
        let entry_closure = self.entry_closure.ok_or(TaskBuildError::NoEntry)?;
        let id = self.id.unwrap_or(config::DEFAULT_TASK_ID);
        let prio = self.priority.unwrap_or(config::DEFAULT_TASK_PRIORITY);

        if self.init_stklet_size == 0 && !self.is_dynamic_stack {
            return Err(TaskBuildError::NoStack);
        }

        let new_task = Task::build_restartable(
            id,
            entry_closure,
            self.init_stklet_size,
            self.is_dynamic_stack,
            prio,
        )
        .unwrap_or_die();
        scheduler::make_new_task_ready(id, Arc::new(new_task))
            .map_err(|_| TaskBuildError::NoMoreTask)
    }
}

/// Start a new task from a previously failed task.
#[cfg(feature = "unwind")]
pub(crate) fn spawn_restarted_from_task(prev_task: Arc<Task>) -> Result<(), ()> {
    let id = prev_task.get_id();
    let new_task = Task::build_restarted(prev_task);

    // FIXME: should check for available task slot in advance but not here.
    scheduler::make_new_task_ready(id, Arc::new(new_task))
}
