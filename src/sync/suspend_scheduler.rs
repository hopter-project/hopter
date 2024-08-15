use super::Holdable;
use crate::schedule::scheduler;
use core::ops::Deref;

pub struct Scheduler {}

pub struct SchedulerSuspendGuard {}

pub fn suspend_scheduler() -> SchedulerSuspendGuard {
    scheduler::increment_suspend_count();
    SchedulerSuspendGuard {}
}

impl Drop for SchedulerSuspendGuard {
    fn drop(&mut self) {
        scheduler::decrement_suspend_count();
        scheduler::yield_for_preemption();
    }
}

impl !Send for SchedulerSuspendGuard {}

impl Holdable for Scheduler {
    type GuardType = SchedulerSuspendGuard;

    fn hold() -> SchedulerSuspendGuard {
        suspend_scheduler()
    }

    unsafe fn force_unhold() {
        scheduler::decrement_suspend_count();
        scheduler::yield_for_preemption();
    }
}

pub struct RefCellSchedSafe<T>
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
        let _guard = suspend_scheduler();
        RefSchedSafe {
            val_ref: &self.val,
            _guard,
        }
    }
}

pub struct RefSchedSafe<'a, T> {
    val_ref: &'a T,
    _guard: SchedulerSuspendGuard,
}

impl<'a, T> Deref for RefSchedSafe<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &self.val_ref
    }
}
