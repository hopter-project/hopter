use super::{breathing, StackConfig, Task};
use crate::{config, schedule::scheduler::Scheduler, unrecoverable::Lethal};
use alloc::sync::Arc;
use core::num::NonZeroUsize;

/// Enumeration of errors during task creation.
#[derive(Debug, PartialEq)]
pub enum TaskBuildError {
    /// Dynamic stack extension is disabled but stack limit is not configured.
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
    stack_limit: Option<usize>,
    stack_init_size: Option<usize>,
    stack_is_dynamic: bool,
    priority: Option<u8>,
    id: Option<u8>,
}

pub struct BreathingTaskBuilder<F, G, H, S, I>
where
    F: FnOnce() -> S + Send + Sync + 'static,
    G: Fn(&mut S) -> I + Send + Sync + 'static,
    H: Fn(&mut S, I) + Send + Sync + 'static,
{
    init: Option<F>,
    wait: Option<G>,
    work: Option<H>,
    stack_limit: Option<usize>,
    stack_init_size: Option<usize>,
    priority: Option<u8>,
    id: Option<u8>,
}

macro_rules! define_common_set_methods {
    () => {
        /// Set a numerical ID for the task.
        ///
        /// The ID is used only for tagging a task and does not have any
        /// functional purpose. It might be helpful for diagnosing bugs. The ID
        /// need not be unique among tasks.
        pub fn set_id(mut self, id: u8) -> Self {
            self.id.replace(id);
            self
        }

        /// Set the size limit of the stack in bytes. If the task exceeds the
        /// limit, it will be terminated with its stack forcefully unwound to
        /// reclaim resources. The task will be restarted if restartable.
        pub fn set_stack_limit(mut self, limit: usize) -> Self {
            self.stack_limit = Some(limit);
            self
        }

        /// Set the size of the first stacklet in bytes. Only meaningful when
        /// dynamic stack extension is enabled. The setting is ignored when
        /// dynamic stack extension is disabled.
        pub fn set_stack_init_size(mut self, size: usize) -> Self {
            self.stack_init_size = Some(size);
            self
        }

        /// Set the priority to a task. If not explicitly set, the task will
        /// have the [`DEFAULT_TASK_PRIORITY`](config::DEFAULT_TASK_PRIORITY).
        pub fn set_priority(mut self, prio: u8) -> Self {
            self.priority.replace(prio);
            self
        }
    };
}

macro_rules! define_task_spawn {
    (
        $method_name:ident,
        $builder_fn:ident
    ) => {
        /// Start the task. A spawned task is always detached. If a panic
        /// occurs while running the task, the task's stack will be unwound.
        ///
        /// With [`spawn`](Self::spawn), the task will not be restarted after
        /// its resource is reclaimed through unwinding. With
        /// [`spawn_restartable`](Self::spawn_restartable), the task will be
        /// restarted again from the given entry closure.
        pub fn $method_name(self) -> Result<(), TaskBuildError> {
            let stack_config = self.parse_stack_config()?;

            let entry_closure = self.entry_closure.ok_or(TaskBuildError::NoEntry)?;
            let id = self.id.unwrap_or(config::DEFAULT_TASK_ID);
            let prio = self.priority.unwrap_or(config::DEFAULT_TASK_PRIORITY);

            // Get a quota from the scheduler to ensure that the maximum number of
            // tasks has not been reached yet.
            let quota = Scheduler::request_task_quota().map_err(|_| TaskBuildError::NoMoreTask)?;

            let new_task = Task::$builder_fn(quota, id, entry_closure, stack_config, prio)?;
            Scheduler::accept_task(Arc::new(new_task));

            Ok(())
        }
    };
}

macro_rules! define_breathing_task_spawn {
    (
        $method_name:ident,
        $entry_constr_fn:ident,
        $builder_fn:ident
    ) => {
        /// Start the task. A spawned task is always detached. If a panic
        /// occurs while running the task, the task's stack will be unwound.
        ///
        /// With [`spawn`](Self::spawn), the task will not be restarted after
        /// its resource is reclaimed through unwinding. With
        /// [`spawn_restartable`](Self::spawn_restartable), the task will be
        /// restarted again from the given entry closure.
        pub fn $method_name(self) -> Result<(), TaskBuildError> {
            let init = self.init.ok_or(TaskBuildError::NoEntry)?;
            let wait = self.wait.ok_or(TaskBuildError::NoEntry)?;
            let work = self.work.ok_or(TaskBuildError::NoEntry)?;
            let id = self.id.unwrap_or(config::DEFAULT_TASK_ID);
            let prio = self.priority.unwrap_or(config::DEFAULT_TASK_PRIORITY);

            // Get a quota from the scheduler to ensure that the maximum number of
            // tasks has not been reached yet.
            let quota = Scheduler::request_task_quota().map_err(|_| TaskBuildError::NoMoreTask)?;

            let initial = match self.stack_init_size {
                Some(initial) => NonZeroUsize::new(initial),
                None => None,
            };
            let limit = match self.stack_limit {
                Some(limit) => NonZeroUsize::new(limit),
                None => None,
            };
            let stack_config = StackConfig::Dynamic { initial, limit };

            let entry = breathing::$entry_constr_fn(init, wait, work);

            let new_task = Task::$builder_fn(quota, id, entry, stack_config, prio)?;
            Scheduler::accept_task(Arc::new(new_task));

            Ok(())
        }
    };
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
    define_common_set_methods!();
    define_task_spawn!(spawn, build);

    const fn new() -> Self {
        Self {
            entry_closure: None,
            stack_limit: None,
            stack_init_size: None,
            stack_is_dynamic: true,
            priority: None,
            id: None,
        }
    }

    /// Set the entry closure for the task. This is the entry point where the
    /// task will start to run.
    pub fn set_entry(mut self, closure: F) -> Self {
        self.entry_closure.replace(closure);
        self
    }

    /// Disable dynamic stack extension for the task.
    ///
    /// When dynamic stack extension is disabled, must set a stack size limit
    /// through [`set_stack_limit`](Self::set_stack_limit). The stack will be
    /// allocated as a contiguous memory chunk when the task is spawned.
    ///
    /// By default dynamic stack extension is enabled, in which case the stack
    /// is allocated on demand in small memory chunks not contiguous with each
    /// other, called stacklet. The stacklets will be freed when function call
    /// returns.
    pub fn disable_dynamic_stack(mut self) -> Self {
        self.stack_is_dynamic = false;
        self
    }

    /// Check the configuration of the stack and generate a [`StackConfig`]
    /// instance representing a valid configuration.
    fn parse_stack_config(&self) -> Result<StackConfig, TaskBuildError> {
        if self.stack_is_dynamic {
            let initial = match self.stack_init_size {
                Some(initial) => NonZeroUsize::new(initial),
                None => None,
            };
            let limit = match self.stack_limit {
                Some(limit) => NonZeroUsize::new(limit),
                None => None,
            };
            Ok(StackConfig::Dynamic { initial, limit })
        } else {
            let limit = match self.stack_limit {
                Some(0) => return Err(TaskBuildError::NoStack),
                Some(limit) => NonZeroUsize::new(limit).unwrap_or_die(),
                None => return Err(TaskBuildError::NoStack),
            };
            Ok(StackConfig::Static { limit })
        }
    }
}

#[cfg(feature = "unwind")]
impl<F> TaskBuilder<F>
where
    F: FnOnce() + Send + Sync + Clone + 'static,
{
    define_task_spawn!(spawn_restartable, build_restartable);
}

/// Start a new task from a previously failed task.
#[cfg(feature = "unwind")]
pub(crate) fn try_spawn_restarted(prev_task: Arc<Task>) -> Result<(), ()> {
    // Get a quota from the scheduler to ensure that the maximum number of
    // tasks has not been reached yet.
    let quota = Scheduler::request_task_quota()?;

    let restarted_task = Task::build_restarted(quota, prev_task);
    Scheduler::accept_task(Arc::new(restarted_task));
    Ok(())
}

/// Build a new breathing task with the breathing task builder. Breathing tasks
/// always run with dynamic stacks.
///
/// A breathing task requires three closures upon definition: `init`, `wait`,
/// and `work`. The task will be constructed to look roughly like the
/// following:
///
/// ```rust
/// let mut state = init();
/// loop {
///     let item = wait(&mut state);
///     work(&mut state, item);
/// }
/// ```
///
/// But more precisely, to smooth out stack memory usage among tasks and
/// avoid high peaks, the concurrency among breathing tasks is constrained.
/// Only a number of breathing tasks can run in the `work` function,
/// controlled by the `hopter::config::BREATHING_CONCURRENCY` parameter.
///
/// # Example
/// ```rust
/// task::build_breathing()
///     .set_init(init)
///     .set_wait(wait)
///     .set_work(work)
///     .spawn()
///     .unwrap();
///
/// struct Ctxt;
/// struct Item;
///
/// fn init() -> Ctxt { Ctxt }
/// fn wait(_ctxt: &mut Ctxt) -> Item { Item }
/// fn work(_ctxt: &mut Ctxt, _item: Item) { /* ... */ }
/// ```
pub fn build_breathing<F, G, H, S, I>() -> BreathingTaskBuilder<F, G, H, S, I>
where
    F: FnOnce() -> S + Send + Sync + 'static,
    G: Fn(&mut S) -> I + Send + Sync + 'static,
    H: Fn(&mut S, I) + Send + Sync + 'static,
{
    BreathingTaskBuilder::new()
}

impl<F, G, H, S, I> BreathingTaskBuilder<F, G, H, S, I>
where
    F: FnOnce() -> S + Send + Sync + 'static,
    G: Fn(&mut S) -> I + Send + Sync + 'static,
    H: Fn(&mut S, I) + Send + Sync + 'static,
{
    define_common_set_methods!();
    define_breathing_task_spawn!(spawn, construct_breathing_task_entry, build);

    const fn new() -> Self {
        Self {
            init: None,
            wait: None,
            work: None,
            stack_limit: None,
            stack_init_size: None,
            priority: None,
            id: None,
        }
    }

    /// Set the `init` closure for the task. See [`build_breathing`] for
    /// details.
    pub fn set_init(mut self, init: F) -> Self {
        self.init.replace(init);
        self
    }

    /// Set the `wait` closure for the task. See [`build_breathing`] for
    /// details.
    pub fn set_wait(mut self, wait: G) -> Self {
        self.wait.replace(wait);
        self
    }

    /// Set the `work` closure for the task. See [`build_breathing`] for
    /// details.
    pub fn set_work(mut self, work: H) -> Self {
        self.work.replace(work);
        self
    }
}

#[cfg(feature = "unwind")]
impl<F, G, H, S, I> BreathingTaskBuilder<F, G, H, S, I>
where
    F: FnOnce() -> S + Clone + Send + Sync + 'static,
    G: Fn(&mut S) -> I + Clone + Send + Sync + 'static,
    H: Fn(&mut S, I) + Clone + Send + Sync + 'static,
{
    define_breathing_task_spawn!(
        spawn_restartable,
        construct_restartable_breathing_task_entry,
        build_restartable
    );
}
