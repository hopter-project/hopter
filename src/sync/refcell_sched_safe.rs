use crate::schedule::scheduler::{SchedSuspendGuard, Scheduler};
use core::ops::Deref;

pub(crate) struct RefCellSchedSafe<T>
where
    T: ?Sized,
{
    val: T,
}

impl<T> RefCellSchedSafe<T> {
    pub const fn new(val: T) -> Self {
        Self { val }
    }

    pub fn lock(&self) -> RefSchedSafe<T> {
        let _guard = Scheduler::suspend();
        RefSchedSafe {
            val_ref: &self.val,
            _guard,
        }
    }
}

pub(crate) struct RefSchedSafe<'a, T> {
    val_ref: &'a T,
    _guard: SchedSuspendGuard,
}

impl<'a, T> Deref for RefSchedSafe<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &self.val_ref
    }
}
