use crate::{
    config,
    interrupt::context_switch,
    schedule::{current, scheduler::Scheduler},
    sync::{Access, AllowPendOp, RefCellSchedSafe, RunPendedOp, SoftLock, Spin},
    task::{Task, TaskListAdapter, TaskListInterfaces, TaskState},
    unrecoverable::Lethal,
};
use alloc::sync::Arc;
use core::{
    cmp::Ordering as CmpOrdering,
    sync::atomic::{AtomicBool, AtomicU32, Ordering},
};
use heapless::mpmc::MpMcQueue;
use intrusive_collections::LinkedList;

struct Inner {
    time_sorted_queue: Spin<LinkedList<TaskListAdapter>>,
    delete_buffer: DeleteBuffer,
    time_to_wakeup: AtomicBool,
}

type DeleteBuffer = MpMcQueue<Arc<Task>, { config::MAX_TASK_NUMBER }>;

impl Inner {
    const fn new() -> Self {
        Self {
            time_sorted_queue: Spin::new(LinkedList::new(TaskListAdapter::NEW)),
            delete_buffer: DeleteBuffer::new(),
            time_to_wakeup: AtomicBool::new(false),
        }
    }
}

type SleepQueue = RefCellSchedSafe<SoftLock<Inner>>;

struct InnerFullAccessor<'a> {
    time_sorted_queue: &'a Spin<LinkedList<TaskListAdapter>>,
    delete_buffer: &'a DeleteBuffer,
    time_to_wakeup: &'a AtomicBool,
}

struct InnerPendAccessor<'a> {
    delete_buffer: &'a DeleteBuffer,
    time_to_wakeup: &'a AtomicBool,
}

/// Bind the accessor types.
impl<'a> AllowPendOp<'a> for Inner {
    type FullAccessor = InnerFullAccessor<'a>;
    type PendOnlyAccessor = InnerPendAccessor<'a>;
    fn full_access(&'a self) -> InnerFullAccessor<'a> {
        InnerFullAccessor {
            time_sorted_queue: &self.time_sorted_queue,
            delete_buffer: &self.delete_buffer,
            time_to_wakeup: &self.time_to_wakeup,
        }
    }
    fn pend_only_access(&'a self) -> InnerPendAccessor<'a> {
        InnerPendAccessor {
            delete_buffer: &self.delete_buffer,
            time_to_wakeup: &self.time_to_wakeup,
        }
    }
}

impl<'a> InnerFullAccessor<'a> {
    fn wake_expired_tasks(&self) {
        let cur_tick = TICKS.load(Ordering::SeqCst);
        let mut locked_queue = self.time_sorted_queue.lock_now_or_die();

        // remove also moves the cursor to the next element
        let mut cursor_mut = locked_queue.front_mut();
        while let Some(task) = cursor_mut.get() {
            if let CmpOrdering::Less | CmpOrdering::Equal = tick_cmp(task.get_wake_tick(), cur_tick)
            {
                let task = cursor_mut.remove().unwrap_or_die();
                Scheduler::accept_task(task);
            } else {
                break;
            }
        }

        while let Some(task) = self.delete_buffer.dequeue() {
            if let Some(task) = locked_queue.remove_task(&task) {
                Scheduler::accept_task(task);
            }
        }
    }
}

impl<'a> RunPendedOp for InnerFullAccessor<'a> {
    fn run_pended_op(&mut self) {
        if self.time_to_wakeup.load(Ordering::SeqCst) {
            self.wake_expired_tasks();
            self.time_to_wakeup.store(false, Ordering::SeqCst);
        }
    }
}

static SLEEP_TASK_QUEUE: SleepQueue = RefCellSchedSafe::new(SoftLock::new(Inner::new()));

/// The tick number of SysTick.
static TICKS: AtomicU32 = AtomicU32::new(0);

/// Advance the SysTick count by 1.
pub(crate) fn advance_tick() {
    TICKS.fetch_add(1, Ordering::SeqCst);
}

/// Return the system tick counter. The counter gets incremented by 1 every
/// millisecond, and it wraps around `u32::MAX`.
pub fn get_tick() -> u32 {
    TICKS.load(Ordering::SeqCst)
}

/// Wake up those sleeping tasks that have their sleeping time expired.
pub(crate) fn wake_sleeping_tasks() {
    SLEEP_TASK_QUEUE.with_suspended_scheduler(|queue, _| {
        queue.with_access(|access| match access {
            Access::Full { full_access } => {
                full_access.wake_expired_tasks();
            }
            Access::PendOnly { pend_access } => {
                pend_access.time_to_wakeup.store(true, Ordering::SeqCst)
            }
        })
    });
}

/// Block the task for the given number of milliseconds.
#[inline]
pub fn sleep_ms(ms: u32) -> Result<(), SleepError> {
    // See `tick_cmp` for the reason of limitation.
    if ms > i32::MAX as u32 {
        return Err(SleepError::TooLong);
    }

    sleep_ms_unchecked(ms);
    Ok(())
}

#[inline]
fn sleep_ms_unchecked(ms: u32) {
    let sleep_begin_tick = get_tick();
    let wake_at_tick = sleep_begin_tick + ms;

    if let CmpOrdering::Less = tick_cmp(get_tick(), wake_at_tick) {
        add_cur_task_to_sleep_queue(wake_at_tick);

        // Yield from the current task. Even if the current task has already
        // been woken up, yielding from it will not introduce deadlock.
        context_switch::yield_current_task();
    }

    // Outline the logic to reduce the stack frame size of `sleep_ms`.
    #[inline(never)]
    fn add_cur_task_to_sleep_queue(wake_at_tick: u32) {
        // The application logic must have gone terribly wrong if the task
        // tries to block when the scheduler is suspended or if an ISR
        // tries to block. In this case, panic the task or ISR.
        if Scheduler::is_suspended() || current::is_in_isr_context() {
            panic!();
        }

        current::with_cur_task_arc(|cur_task| {
            cur_task.set_state(TaskState::Blocked);
            add_task_to_sleep_queue(cur_task, wake_at_tick);
        })
    }
}

pub(crate) fn add_task_to_sleep_queue(task: Arc<Task>, wake_at_tick: u32) {
    SLEEP_TASK_QUEUE.with_suspended_scheduler(|queue, _| {
        queue.must_with_full_access(|full_access| {
            task.set_wake_tick(wake_at_tick);
            let mut locked_queue = full_access.time_sorted_queue.lock_now_or_die();
            locked_queue.push_back_tick_sorted(task);
        })
    });
}

pub(crate) fn remove_task_from_sleep_queue_allow_isr(task: Arc<Task>) {
    SLEEP_TASK_QUEUE.with_suspended_scheduler(|queue, _| {
        queue.with_access(|access| match access {
            Access::Full { full_access } => {
                let mut locked_queue = full_access.time_sorted_queue.lock_now_or_die();
                if let Some(task) = locked_queue.remove_task(&task) {
                    Scheduler::accept_task(task);
                }
            }
            Access::PendOnly { pend_access } => {
                pend_access.delete_buffer.enqueue(task).unwrap_or_die();
            }
        })
    });
}

/// A time-based task barrier that allow a task to proceed at a given interval.
pub struct IntervalBarrier {
    /// The interval in milliseconds.
    interval_ms: u32,
    /// The next SysTick count to wake up the blocked task.
    next_tick_to_wake: u32,
}

impl IntervalBarrier {
    /// Create a new barrier that will unblock the task at the given interval
    /// in milliseconds. The first time that the barrier allows a task to
    /// proceed is the creation time plus the interval.
    pub fn new(interval_ms: u32) -> Result<Self, SleepError> {
        // See `tick_cmp` for the reason of limitation.
        if interval_ms > (i32::MAX) as u32 {
            return Err(SleepError::TooLong);
        }
        let next_tick_to_wake = TICKS.load(Ordering::SeqCst).wrapping_add(interval_ms);
        Ok(Self {
            interval_ms,
            next_tick_to_wake,
        })
    }

    /// Block the current task until the interval is elapsed since the last time
    /// the task was resumed.
    /// FIXME: fix the case when the task cannot keep up with the interval of the
    /// barrier.
    pub fn wait(&mut self) {
        let cur_tick = TICKS.load(Ordering::SeqCst);
        if let CmpOrdering::Less = tick_cmp(cur_tick, self.next_tick_to_wake) {
            let ms_to_sleep = self.next_tick_to_wake.wrapping_sub(cur_tick);
            sleep_ms_unchecked(ms_to_sleep);
        }
        self.next_tick_to_wake = self.next_tick_to_wake.wrapping_add(self.interval_ms);
    }
}

/// Enumeration for sleeping error.
#[derive(Debug, PartialEq, Eq)]
pub enum SleepError {
    /// The given time to sleep is too long.
    TooLong,
}

/// Compare the two given tick numbers (`lhs` and `rhs`).
///
/// Since the tick count can wrap around, the comparison cannot simply be
/// `lhs.cmp(&rhs)`. Instead, we view the current tick as the origin of the
/// number axis, and view `lhs` and `rhs` as within the [-2^31, 2^31 - 1]
/// range around the origin.
///
/// Below shows an example when `lhs.wrapping_add(1) == cur_tick` and
/// `rhs.wrapping_sub(5) == cur_tick`. In this case `lhs` is less than `rhs`.
///
/// ```plain
/// -2^31               -1   0             5        2^31 - 1
/// +-----...----------------+----------------...-----+
///                      ^   ^             ^
///                     lhs cur_tick      rhs
/// ```
///
/// The offset from the current tick is called the *relative tick*, which have
/// the range [-2^31, 2^31 - 1]. The tick in the world clock time is called the
/// *absolute tick*, which increases indefinitely and does not wrap around.
///
/// This [`tick_cmp`] function is used to compare among the wake up ticks of
/// sleeping tasks and also between the current tick. We must ensure that the
/// comparison using the relative tick yields the same result as if we were
/// using the absolute tick. We can guarantee the same result as long as we
/// guarantee that all tick numbers subject to comparison are within the
/// [-2^31, 2^31 - 1] range around the current tick.
///
/// The folowing two invariants help to meet such guarantee:
///
/// 1. Any sleeping task with its wake up tick logically smaller than the
///    current tick will get notified very soon and removed from the sleeping
///    queue. Thus, if we see a logically negative tick number, its absolute
///    value should always be very small.
/// 2. A new sleeping task being pushed into the sleeping queue can sleep for
///    at most (2^31 - 1) milliseconds. Thus its wake up tick should be no
///    greater than the current tick plus (2^31 - 1).
///
/// We can thus compare the ticks using the logical tick number, i.e. the
/// offset from the current tick, as follows:
///
/// ```rust
/// fn tick_cmp(cur_tick: u32, lhs: u32, rhs: u32) -> CmpOrdering {
///     let offset_lhs_cur = lhs.wrapping_sub(cur_tick) as i32;
///     let offset_rhs_cur = rhs.wrapping_sub(cur_tick) as i32;
///     offset_lhs_cur.cmp(&offset_rhs_cur)
/// }
/// ```
///
/// Notice that the current tick value cancels out during the comparison, so
/// we can further simplify it by removing the `cur_tick` variable, as shown by
/// the final definition of this function.
#[inline]
pub(crate) fn tick_cmp(lhs: u32, rhs: u32) -> CmpOrdering {
    (lhs.wrapping_sub(rhs) as i32).cmp(&0)
}
