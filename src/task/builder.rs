use crate::schedule;

const DEFAULT_TASK_ID: u8 = 255;

pub struct TaskBuilder<F, A>
where
    F: FnOnce(A) + Send + 'static,
    A: Send + 'static,
{
    entry_closure: Option<F>,
    entry_arg: Option<A>,
    init_stklet_size: Option<usize>,
    priority: Option<u8>,
    id: Option<u8>,
}

impl<F, A> TaskBuilder<F, A>
where
    F: FnOnce(A) + Send + 'static,
    A: Send + 'static,
{
    pub const fn new() -> Self {
        Self {
            entry_closure: None,
            entry_arg: None,
            init_stklet_size: None,
            priority: None,
            id: None,
        }
    }

    pub fn entry(mut self, closure: F) -> Self {
        self.entry_closure.replace(closure);
        self
    }

    pub fn arg(mut self, arguments: A) -> Self {
        self.entry_arg.replace(arguments);
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
        match (
            self.entry_closure,
            self.entry_arg,
            self.init_stklet_size,
            self.priority,
        ) {
            (Some(entry_closure), Some(entry_arg), Some(init_stklet_size), Some(priority)) => {
                schedule::start_task(233, entry_closure, entry_arg, init_stklet_size, priority)
            }
            _ => return Err(()),
        }
    }
}

impl<F, A> TaskBuilder<F, A>
where
    F: FnOnce(A) + Send + Sync + Clone + 'static,
    A: Send + Sync + Clone + 'static,
{
    pub fn spawn_restartable(self) -> Result<(), ()> {
        match (
            self.entry_closure,
            self.entry_arg,
            self.init_stklet_size,
            self.priority,
        ) {
            (Some(entry_closure), Some(entry_arg), Some(init_stklet_size), Some(priority)) => {
                let id = self.id.unwrap_or(DEFAULT_TASK_ID);
                schedule::start_restartable_task(
                    id,
                    entry_closure,
                    entry_arg,
                    init_stklet_size,
                    priority,
                )
            }
            _ => return Err(()),
        }
    }
}
