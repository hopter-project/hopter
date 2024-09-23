use crate::schedule::scheduler::{SchedSuspendGuard, Scheduler};

pub(crate) struct RefCellSchedSafe<T>
where
    T: ?Sized,
{
    val: T,
}

impl<T> RefCellSchedSafe<T> {
    pub(crate) const fn new(val: T) -> Self {
        Self { val }
    }

    pub(crate) fn with_suspended_scheduler<F, R>(&self, op: F) -> R
    where
        F: FnOnce(&T, SchedSuspendGuard) -> R,
    {
        let guard = Scheduler::suspend();
        op(&self.val, guard)
    }
}
