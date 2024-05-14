use super::{
    lock_traits::{Lockable, UnlockableGuard},
    WaitQueue,
};

/// Condition variable, similar to `std::sync::Condvar`.
pub struct CondVar {
    wait_queue: WaitQueue,
}

impl CondVar {
    /// Create a new condition variable.
    pub const fn new() -> Self {
        Self {
            wait_queue: WaitQueue::new(),
        }
    }

    /// Wait on the condition variable until notified and the condition is met.
    ///
    /// Important: *must not* call this method in ISR context.
    ///
    /// Important: the tasks waiting for nofitication follow first-in-first-out
    /// order. If the front task being notified does not have its condition met,
    /// it will be placed back to the tail of the queue. No other task will be
    /// in turn notified, i.e., the notification is discarded.
    pub fn wait_without_lock_until<F>(&self, mut condition: F)
    where
        F: FnMut() -> bool,
    {
        self.wait_queue.wait_until(|| condition().then(|| ()))
    }

    /// Wait on the condition variable until notified and the condition is met.
    /// The task calling this method should pass in a lock guard, which will be
    /// atomically unlocked when the task is blocked and re-locked when the task
    /// is resumed. The condition predicate function can access the data
    /// protected through the lock guard and should return true when the condition
    /// is met. When the task resumes, it will get back the lock guard from the
    /// method's return value.
    ///
    /// Important: *must not* call this method in ISR context.
    ///
    /// Important: the tasks waiting for nofitication follow first-in-first-out
    /// order. If the front task being notified does not have its condition met,
    /// it will be placed back to the tail of the queue. No other task will be
    /// in turn notified, i.e., the notification is discarded.
    #[allow(dead_code)]
    pub fn wait_until<'a, G, L, F>(&self, guard: G, mut condition: F) -> G
    where
        F: FnMut(&mut G) -> bool,
        G: UnlockableGuard<'a, LockType = L>,
        L: Lockable<GuardType<'a> = G> + 'a,
    {
        self.wait_queue
            .wait_until_with_lock(guard, |guard| condition(guard).then(|| ()))
            .0
    }

    /// Wake up one task if there exists. Allowed to be invoked in ISR context.
    ///
    /// Important: the tasks waiting for nofitication follow first-in-first-out
    /// order. If the front task being notified does not have its condition met,
    /// it will be placed back to the tail of the queue. No other task will be
    /// in turn notified, i.e., the notification is discarded.
    pub fn notify_one_allow_isr(&self) {
        self.wait_queue.notify_one_allow_isr()
    }
}
