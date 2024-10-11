use super::{Lockable, SpinSchedIrqSafe, UnlockableGuard};
use crate::{
    interrupt::{context_switch, mask::AllIrqExceptSvc},
    schedule::{current, scheduler::Scheduler},
    task::{TaskListAdapter, TaskListInterfaces, TaskState},
};
use intrusive_collections::LinkedList;

/// Queue for blocked tasks waiting for notification.
pub(super) struct WaitQueue {
    inner: SpinSchedIrqSafe<Inner, AllIrqExceptSvc>,
}

/// The inner content of a wait queue.
struct Inner {
    /// A buffer containing reference counted task pointers. The buffer will
    /// be sorted based on task priority when popping out tasks. The spin lock
    /// around it is only for sanity check.
    queue: LinkedList<TaskListAdapter>,
}

impl Inner {
    const fn new() -> Self {
        Self {
            queue: LinkedList::new(TaskListAdapter::NEW),
        }
    }
}

impl WaitQueue {
    /// Create a new empty wait queue.
    pub(super) const fn new() -> Self {
        Self {
            inner: SpinSchedIrqSafe::new(Inner::new()),
        }
    }

    /// Put the current task into the queue and block it. Wait until some other
    /// task notifies it.
    ///
    /// Important: *must not* call this method in ISR context.
    #[inline]
    #[allow(unused)]
    pub(super) fn wait(&self) {
        add_cur_task_to_block_queue(self);

        // We have put the current task to the wait queue.
        // Tell the scheduler to run another task.
        context_switch::yield_current_task();

        // Outline the logic to reduce the stack frame size of `.wait()`.
        #[inline(never)]
        fn add_cur_task_to_block_queue(wq: &WaitQueue) {
            // The application logic must have gone terribly wrong if the task
            // tries to block when the scheduler is suspended or if an ISR
            // tries to block. In this case, panic the task or ISR.
            if Scheduler::is_suspended() || current::is_in_isr_context() {
                panic!();
            }

            let mut locked_inner = wq.inner.lock();
            let locked_queue = &mut locked_inner.queue;

            // Put the current task into the queue.
            current::with_cur_task_arc(|cur_task| {
                cur_task.set_state(TaskState::Blocked);
                locked_queue.push_back(cur_task);
            });
        }
    }

    /// Put the current task into the queue and block it. Wait until some other
    /// task notifies it and the condition is also met. When the condition is met,
    /// the `condition` predicate function should return `Some`, otherwise `None`.
    /// When the predicate function returns `Some`, the task resumes and gets
    /// the returned value contained in `Some`.
    ///
    /// Important: *must not* call this method in ISR context.
    ///
    /// Important: the tasks waiting for nofitication are ordered with respect to
    /// their priorities. If the highest priority task gets notified but does not
    /// have its condition met, it will be placed back to the queue. No other task
    /// will be in turn notified, i.e., the notification is treated as spurious and
    /// is discarded.
    #[inline]
    pub(super) fn wait_until<F, R>(&self, mut condition: F) -> R
    where
        F: FnMut() -> Option<R>,
    {
        // Keep blocking until the predicate is satisfied.
        loop {
            let res = add_cur_task_to_block_queue_with_condition(self, &mut condition);

            // If the condition is met, we return.
            if let Some(ret) = res {
                return ret;
            }

            // Otherwise, we have put the current task to the wait queue.
            // Tell the scheduler to run another task.
            context_switch::yield_current_task();
        }

        // Outline the logic to reduce the stack frame size of `.wait_until()`.
        #[inline(never)]
        fn add_cur_task_to_block_queue_with_condition<F, R>(
            wq: &WaitQueue,
            condition: &mut F,
        ) -> Option<R>
        where
            F: FnMut() -> Option<R>,
        {
            // The application logic must have gone terribly wrong if the task
            // tries to block when the scheduler is suspended or if an ISR
            // tries to block. In this case, panic the task or ISR.
            if Scheduler::is_suspended() || current::is_in_isr_context() {
                panic!();
            }

            let mut locked_inner = wq.inner.lock();

            // Must lock the queue here before evaluating the condition to
            // prevent deadlock.
            let locked_queue = &mut locked_inner.queue;

            // Check if the predicate is satisfied and if yes return the value
            // contained in `Some`.
            if let Some(ret) = condition() {
                return Some(ret);
            }

            // Otherwise, put the current task into the queue.
            current::with_cur_task_arc(|cur_task| {
                cur_task.set_state(TaskState::Blocked);
                locked_queue.push_back(cur_task);
            });

            None
        }
    }

    /// Put the current task into the queue and block it. Wait until some other
    /// task notifies it and the condition is also met. When the condition is met,
    /// the `condition` predicate function should return `Some`, otherwise `None`.
    /// When the predicate function returns `Some`, the task resumes and gets
    /// the returned value contained in `Some`. The lock guard passed in will be
    /// released atomically when the task blocks and get locked again when the
    /// task resumes.
    ///
    /// Important: *must not* call this method in ISR context.
    ///
    /// Important: the tasks waiting for nofitication are ordered with respect to
    /// their priorities. If the highest priority task gets notified but does not
    /// have its condition met, it will be placed back to the queue. No other task
    /// will be in turn notified, i.e., the notification is treated as spurious and
    /// is discarded.
    #[inline]
    pub(super) fn wait_until_with_lock<'a, F, G, R, L>(
        &self,
        mut guard: G,
        mut condition: F,
    ) -> (G, R)
    where
        F: FnMut(&mut G) -> Option<R>,
        G: UnlockableGuard<'a, LockType = L>,
        L: Lockable<GuardType<'a> = G> + 'a,
    {
        // Keep blocking until the predicate is satisfied.
        loop {
            let res = add_cur_task_to_block_queue_and_unlock(self, guard, &mut condition);

            match res {
                // If the condition is met, we return the lock guard and condition
                // function's return value.
                Err(ret) => return ret,
                // Otherwise, we have put the current task to the wait queue. Tell
                // the scheduler to run another task. After this task is scheduled
                // again, take back the lock and try again.
                Ok(mutex) => {
                    context_switch::yield_current_task();
                    guard = mutex.lock_and_get_guard();
                }
            }
        }

        // Outline the logic to reduce the stack frame size of `.wait_until_with_lock()`.
        #[inline(never)]
        fn add_cur_task_to_block_queue_and_unlock<'a, F, G, R, L>(
            wq: &WaitQueue,
            mut guard: G,
            condition: &mut F,
        ) -> Result<&'a L, (G, R)>
        where
            F: FnMut(&mut G) -> Option<R>,
            G: UnlockableGuard<'a, LockType = L>,
            L: Lockable<GuardType<'a> = G> + 'a,
        {
            // The application logic must have gone terribly wrong if the task
            // tries to block when the scheduler is suspended or if an ISR
            // tries to block. In this case, panic the task or ISR.
            if Scheduler::is_suspended() || current::is_in_isr_context() {
                panic!();
            }

            let mut locked_inner = wq.inner.lock();

            // Must lock the queue here before evaluating the condition and
            // releasing the `guard` passed in argument to prevent deadlock.
            let locked_queue = &mut locked_inner.queue;

            // Check if the predicate is satisfied and if yes return the value
            // contained in `Some` with the lock guard.
            if let Some(ret) = condition(&mut guard) {
                return Err((guard, ret));
            }

            // Otherwise, release the lock guard and get the lock itself.
            let mutex = guard.unlock_and_into_lock_ref();

            // Put the current task into the queue.
            current::with_cur_task_arc(|cur_task| {
                cur_task.set_state(TaskState::Blocked);
                locked_queue.push_back(cur_task);
            });

            Ok(mutex)
        }
    }

    /// Pop a task (if exists) from the queue and mark its state as ready.
    /// This method is allowed in ISR context. The popped the task is the one
    /// with the highest priority (smallest numerical value) in the queue.
    ///
    /// Important: the tasks waiting for nofitication are ordered with respect to
    /// their priorities. If the highest priority task gets notified but does not
    /// have its condition met, it will be placed back to the queue. No other task
    /// will be in turn notified, i.e., the notification is treated as spurious and
    /// is discarded.
    pub(super) fn notify_one_allow_isr(&self) {
        let mut locked_inner = self.inner.lock();
        let locked_queue = &mut locked_inner.queue;
        if let Some(task) = locked_queue.pop_highest_priority() {
            Scheduler::accept_task(task);
        }
    }
}
