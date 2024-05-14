use super::CondVar;
use core::sync::atomic::{AtomicUsize, Ordering};

/// A semaphore that has the classic semantic. A counter is associated with
/// each semaphore whose initial value is zero its maximum allowed value is
/// set upon creation. `.down()` method will try to decrease the counter and
/// block the current task when the counter is already zero. `.up()` method
/// will try to increase the counter and block the current task if the counter
/// is already at the maximum value. The blocked tasks will be resumed if the
/// `.down()` or `.up()` can proceed.
///
/// FIXME: Semaphores are used in IRQ handlers, but the handlers should never
/// block.
pub struct Semaphore {
    /// The counter.
    count: AtomicUsize,
    /// The maximum value which the counter can possibly reach.
    max_count: usize,
    /// Condition variable to wait for an increase on the counter.
    cv_incremented: CondVar,
    /// Condition variable to wait for a decrease on the counter.
    cv_decremented: CondVar,
}

impl Semaphore {
    /// Create a new semaphore.
    pub const fn new(max_count: usize, init_count: usize) -> Self {
        Self {
            count: AtomicUsize::new(init_count),
            max_count,
            cv_incremented: CondVar::new(),
            cv_decremented: CondVar::new(),
        }
    }

    /// Increment the counter value by 1. Block if the counter value is already
    /// at the maximum until it is decremented by someone else.
    ///
    /// Important: *must not* call this method in ISR context.
    pub fn up(&self) {
        loop {
            // If the counter is already at the maximum, wait until it is not.
            self.cv_decremented
                .wait_without_lock_until(|| self.count.load(Ordering::SeqCst) < self.max_count);

            // Get the latest count.
            let cur_cnt = self.count.load(Ordering::SeqCst);

            // If now it is back to maximum again, we should continue to wait.
            if cur_cnt == self.max_count {
                continue;
            }

            // Atomically increment the counter. Fail if others have changed the counter.
            if self
                .count
                .compare_exchange(cur_cnt, cur_cnt + 1, Ordering::SeqCst, Ordering::SeqCst)
                .is_ok()
            {
                // If we successfully incremented the counter, signal the condition variable.
                self.cv_incremented.notify_one_allow_isr();
                return;
            }

            // Otherwise, the increment operation has failed. Try again from the beginning.
        }
    }

    /// Try to increment the counter value by 1. Return `Err(())` if the counter value
    /// is already at the maximum. Return `Ok(())` if succeeded. Calling this method in
    /// ISR context is allowed.
    pub fn try_up_allow_isr(&self) -> Result<(), ()> {
        loop {
            let cur_cnt = self.count.load(Ordering::SeqCst);
            if cur_cnt == self.max_count {
                return Err(());
            }

            if self
                .count
                .compare_exchange(cur_cnt, cur_cnt + 1, Ordering::SeqCst, Ordering::SeqCst)
                .is_ok()
            {
                self.cv_incremented.notify_one_allow_isr();
                return Ok(());
            }
        }
    }

    /// Try to decrement the counter value by 1. Return `Err(())` if the counter value
    /// is already zero. Return `Ok(())` if succeeded. Calling this method in ISR context
    /// is allowed.
    pub fn try_down_allow_isr(&self) -> Result<(), ()> {
        loop {
            let cur_cnt = self.count.load(Ordering::SeqCst);
            if cur_cnt == 0 {
                return Err(());
            }

            if self
                .count
                .compare_exchange(cur_cnt, cur_cnt - 1, Ordering::SeqCst, Ordering::SeqCst)
                .is_ok()
            {
                self.cv_decremented.notify_one_allow_isr();
                return Ok(());
            }
        }
    }

    /// Decrement the counter value by 1. Block if the counter value is already
    /// zero until it is incremented by someone else.
    ///
    /// Important: *must not* call this method in ISR context.
    pub fn down(&self) {
        loop {
            // If the counter is already at the zero, wait until it is not.
            self.cv_incremented
                .wait_without_lock_until(|| self.count.load(Ordering::SeqCst) > 0);

            // Get the latest count.
            let cur_cnt = self.count.load(Ordering::SeqCst);

            // If now it is back to zero again, we should continue to wait.
            if cur_cnt == 0 {
                continue;
            }

            // Atomically decrement the counter. Fail if others have changed the counter.
            if self
                .count
                .compare_exchange(cur_cnt, cur_cnt - 1, Ordering::SeqCst, Ordering::SeqCst)
                .is_ok()
            {
                // If we successfully incremented the counter, signal the condition variable.
                self.cv_decremented.notify_one_allow_isr();
                return;
            }

            // Otherwise, the increment operation has failed. Try again from the beginning.
        }
    }
}
