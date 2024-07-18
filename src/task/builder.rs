use super::Task;
use crate::schedule::scheduler;
use alloc::sync::Arc;

const DEFAULT_TASK_ID: u8 = 255;

const TASK_DEFAULT_PRIORITY: u8 = 8;

pub struct TaskBuilder<F>
where
    F: FnOnce() + Send + 'static,
{
    entry_closure: Option<F>,
    init_stklet_size: Option<usize>,
    priority: Option<u8>,
    id: Option<u8>,
}

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
            init_stklet_size: None,
            priority: None,
            id: None,
        }
    }

    pub fn set_id(mut self, id: u8) -> Self {
        self.id.replace(id);
        self
    }

    pub fn set_entry(mut self, closure: F) -> Self {
        self.entry_closure.replace(closure);
        self
    }

    pub fn set_stack_size(mut self, size: usize) -> Self {
        self.init_stklet_size.replace(size);
        self
    }

    pub fn set_priority(mut self, prio: u8) -> Self {
        self.priority.replace(prio);
        self
    }

    pub fn spawn(self) -> Result<(), ()> {
        let entry_closure = self.entry_closure.ok_or(())?;
        let id = self.id.unwrap_or(DEFAULT_TASK_ID);
        let prio = self.priority.unwrap_or(TASK_DEFAULT_PRIORITY);
        let init_stklet_size = self.init_stklet_size.unwrap_or(0);
        let new_task = Task::build(id, entry_closure, init_stklet_size, prio)?;
        scheduler::make_new_task_ready(id, Arc::new(new_task))
    }
}

impl<F> TaskBuilder<F>
where
    F: FnOnce() + Send + Sync + Clone + 'static,
{
    #[cfg(feature = "unwind")]
    pub fn spawn_restartable(self) -> Result<(), ()> {
        let entry_closure = self.entry_closure.ok_or(())?;
        let id = self.id.unwrap_or(DEFAULT_TASK_ID);
        let prio = self.priority.unwrap_or(TASK_DEFAULT_PRIORITY);
        let init_stklet_size = self.init_stklet_size.unwrap_or(0);
        let new_task = Task::build_restartable(id, entry_closure, init_stklet_size, prio)?;
        scheduler::make_new_task_ready(id, Arc::new(new_task))
    }
}

/// Start a new task from a previously failed task.
#[cfg(feature = "unwind")]
pub(crate) fn spawn_restarted_from_task(prev_task: Arc<Task>) -> Result<(), ()> {
    let id = prev_task.get_id();
    let new_task = Task::build_restarted(prev_task)?;

    // FIXME: should check for available task slot in advance but not here.
    scheduler::make_new_task_ready(id, Arc::new(new_task))
}
