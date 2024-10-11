use super::SpinSchedIrqSafe;
use crate::{
    interrupt::{context_switch, mask::AllIrqExceptSvc},
    schedule::{current, scheduler::Scheduler},
    task::{Task, TaskState},
    time,
};
use alloc::sync::Arc;

/// A synchronization primitive that allows a task to wait for a notification
/// until timeout. [`Mailbox`] allows synchronization between tasks or between
/// a task and interrupt handlers.
///
/// However, unlike the [`Semaphore`](super::Semaphore), a [`Mailbox`] allows
/// *only one* task to wait on it. A task will panic if it tries to
/// [`wait`](Mailbox::wait) on a [`Mailbox`] that already has a waiting task on
/// it. Such restriction enables the [`Mailbox`] to provide the
/// [`wait_until_timeout`](Mailbox::wait_until_timeout) method.
/// It is still allowed to have multiple tasks or interrupt handlers to notify
/// on the same [`Mailbox`].
///
/// Like the [`Semaphore`](super::Semaphore), a [`Mailbox`] counts the number
/// of received notifications. For example, if an interrupt handler notifies
/// on a [`Mailbox`] before the task waits on the [`Mailbox`], an internal
/// counter will be incremented to record the notification. Later when the task
/// [`wait`](Mailbox::wait) on the [`Mailbox`], the task decrements the counter
/// and returns immediately. A task blocks on [`wait`](Mailbox::wait) only when
/// the notification counter is zero.
pub struct Mailbox {
    inner: SpinSchedIrqSafe<Inner, AllIrqExceptSvc>,
}

struct Inner {
    /// The number of notifications posted but not yet received by the waiting
    /// task.
    count: usize,
    /// The task waiting on this [`Mailbox`]. The spin lock around it is only
    /// for sanity check. This field should not be accessed concurrently.
    wait_task: WaitTask,
    /// Whether the [`notify_allow_isr`](Mailbox::notify_allow_isr) has been
    /// invoked. This is used to distinguish between waking up a task by
    /// notification and by timeout. The field is meaningful only when the
    /// waiting task is [`WithTimeout`](WaitTask::WithTimeout).
    task_notified: bool,
}

/// Enumaration of the waiting task category.
enum WaitTask {
    /// The task is waiting with a timeout.
    ///
    /// IMPORTANT: In this case, the sleeping queue in [`crate::time`] is
    /// logically holding the ownership of the task. When the task is woken
    /// up either due to notification or timeout, it is the `Arc<Task>` inside
    /// the sleeping queue that will be put back to the scheduler's ready queue.
    /// Logically, it is better to use `Weak<Task>` with this enum variant, but
    /// we choose to still use `Arc<Task>` to reduce code size bloat. This is
    /// in contrast with the [`WithoutTimeout`](WaitTask::WithoutTimeout)
    /// variant.
    WithTimeout(Arc<Task>),
    /// The task is waiting without a specified timeout.
    ///
    /// IMPORTANT: In this case, the logical ownership of the waiting task is
    /// maintained by this enum variant. When the task is woken up, it is the
    /// `Arc<Task>` carried by this enum variant that will be put back to the
    /// scheduler's ready queue. This is in contrast with the
    /// [`WithTimeout`](WaitTask::WithTimeout) variant.
    WithoutTimeout(Arc<Task>),
    /// No task is waiting on the mailbox.
    NoTask,
}

impl Inner {
    const fn new() -> Self {
        Self {
            count: 0,
            wait_task: WaitTask::NoTask,
            task_notified: false,
        }
    }
}

impl Mailbox {
    /// Create a new [`Mailbox`] with the notification counter initialized to
    /// zero.
    pub const fn new() -> Self {
        Self {
            inner: SpinSchedIrqSafe::new(Inner::new()),
        }
    }

    /// Block the calling task if the notification counter is currently zero.
    /// The blocking task will be woken up if other tasks or ISRs notify on the
    /// mailbox.
    ///
    /// Otherwise, if the counter is currently positive, the calling task to
    /// this method decrements the counter and continues its execution.
    ///
    /// NOTE: *Must not* call this method in ISR context. An ISR attempting
    /// to block will result in a panic.
    pub fn wait(&self) {
        // The application logic must have gone terribly wrong if the task
        // tries to block when the scheduler is suspended or if an ISR
        // tries to block. In this case, panic the task or ISR.
        if Scheduler::is_suspended() || current::is_in_isr_context() {
            panic!();
        }

        let mut should_block = true;
        {
            let mut locked_inner = self.inner.lock();

            assert!(locked_inner.wait_task.is_no_task());

            if locked_inner.count > 0 {
                locked_inner.count -= 1;
                should_block = false;
            } else {
                current::with_cur_task_arc(|cur_task| {
                    cur_task.set_state(TaskState::Blocked);

                    // Record the waiting task on this mailbox.
                    locked_inner.wait_task = WaitTask::WithoutTimeout(Arc::clone(&cur_task));
                });
            }
        }

        if should_block {
            context_switch::yield_current_task();
        }
    }

    /// Block the calling task if the notification counter is currently zero.
    /// The blocking task will be woken up if other tasks or ISRs notify on the
    /// mailbox or if the elapsed waiting time reaches timeout.
    ///
    /// Otherwise, if the counter is currently positive, the calling task to
    /// this method decrements the counter and continues its execution. In this
    /// case the calling task is considered to be notified.
    ///
    /// Arguments:
    /// - `timeout_ms`: Waiting timeout in milliseconds.
    ///
    /// Return:
    /// - `true` if the waiting task is woken up by notification, or `false` if
    ///   by timeout.
    ///
    /// NOTE: *Must not* call this method in ISR context. An ISR attempting
    /// to block will result in a panic.
    pub fn wait_until_timeout(&self, timeout_ms: u32) -> bool {
        // The application logic must have gone terribly wrong if the task
        // tries to block when the scheduler is suspended or if an ISR
        // tries to block. In this case, panic the task or ISR.
        if Scheduler::is_suspended() || current::is_in_isr_context() {
            panic!();
        }

        let mut should_block = true;

        {
            let mut locked_inner = self.inner.lock();

            // A sanity check to prevent more than one task to try to wait on
            // the same mailbox.
            assert!(locked_inner.wait_task.is_no_task());

            // If the counter is currently positive, decrement the counter and
            // do not block.
            if locked_inner.count > 0 {
                locked_inner.count -= 1;
                should_block = false;
            } else {
                // Otherwise the task is going to be blocked. Reset the flag.
                locked_inner.task_notified = false;

                current::with_cur_task_arc(|cur_task| {
                    cur_task.set_state(TaskState::Blocked);

                    // Record the waiting task on this mailbox.
                    locked_inner.wait_task = WaitTask::WithTimeout(Arc::clone(&cur_task));

                    // Add the waiting task to the sleeping queue.
                    // FIXME: This assumes 1ms tick interval.
                    let wake_at_tick = time::get_tick() + timeout_ms;
                    time::add_task_to_sleep_queue(cur_task, wake_at_tick);
                });
            }
        }

        if should_block {
            // If the task should block, request a context switch.
            context_switch::yield_current_task();

            // We reach here if either the waiting task is notified or the
            // waiting time reaches timeout.

            let mut locked_inner = self.inner.lock();

            locked_inner.wait_task.take();
            locked_inner.task_notified
        } else {
            // If the task need not block, it consumed a notification count and
            // is considered to be notified.
            true
        }
    }

    /// Make the waiting task ready to run if there is a waiting task on the
    /// [`Mailbox`], or otherwise increment the counter if there is not current
    /// waiting task.
    ///
    /// This method is allowed in ISR context.
    pub fn notify_allow_isr(&self) {
        let mut locked_inner = self.inner.lock();

        match locked_inner.wait_task.take() {
            // If there is a waiting task with timeout, wake it up. The
            // task's ownership is moved from the sleeping queue to the
            // scheduler's ready queue. See the documentation of
            // `WithTimeout` for details.
            WaitTask::WithTimeout(wait_task) => {
                time::remove_task_from_sleep_queue_allow_isr(wait_task);
                locked_inner.task_notified = true;
            }
            // If there is a waiting task without timeout, wake it up. The
            // task's ownership is moved from this enum variant to the
            // scheduler's ready queue. See the documentation of
            // `WithoutTimeout` for details.
            WaitTask::WithoutTimeout(wait_task) => {
                Scheduler::accept_task(wait_task);
            }
            // If there is not a waiting task, increment the counter.
            WaitTask::NoTask => {
                locked_inner.count += 1;
            }
        }
    }
}

impl WaitTask {
    /// Similar to [`Option::take`], return the current value and replace it
    /// with [`WaitTask::NoTask`].
    fn take(&mut self) -> Self {
        core::mem::replace(self, Self::NoTask)
    }

    /// Return if the variant is [`WaitTask::NoTask`].
    fn is_no_task(&self) -> bool {
        if let Self::NoTask = self {
            true
        } else {
            false
        }
    }
}
