use crate::schedule::scheduler::{SchedSuspendGuard, Scheduler};

/// A lock type that grants access to the contained data when the scheduler
/// is suspended.
pub(crate) struct RefCellSchedSafe<T>
where
    T: ?Sized,
{
    val: T,
}

impl<T> RefCellSchedSafe<T> {
    /// Create a new [`RefCellSchedSafe`] instance wrapping the given value.
    pub(crate) const fn new(val: T) -> Self {
        Self { val }
    }

    /// Suspend the scheduler and run the given closure. The closure should
    /// take two arguments: `&T` and [`&SchedSuspendGuard`](SchedSuspendGuard).
    /// The granted access is not `mut` because even when the scheduler is
    /// suspended, an interrupt handler can still concurrently access the data.
    pub(crate) fn with_suspended_scheduler<F, R>(&self, op: F) -> R
    where
        F: FnOnce(&T, &SchedSuspendGuard) -> R,
    {
        let guard = Scheduler::suspend();
        op(&self.val, &guard)
    }
}
