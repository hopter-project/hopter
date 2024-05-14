/// A lock guard trait that makes it unlockable and can get the reference
/// to the lock instance.
pub trait UnlockableGuard<'a> {
    type LockType: ?Sized;

    /// Release the lock guard and get the reference to the lock instance.
    fn unlock_and_into_lock_ref(self) -> &'a Self::LockType;
}

/// A lock trait that just a wrapper around the normal `.lock()`.
pub trait Lockable {
    type GuardType<'a>
    where
        Self: 'a;

    /// Lock it and return the lock guard.
    fn lock_and_get_guard(&self) -> Self::GuardType<'_>;
}

/// A holdable condition. It may be masking an interrupt or suspending the scheduler.
pub trait Holdable {
    type GuardType;

    /// Hold a condition and return a guard. While the guard is active, the condition
    /// should remain being held.
    fn hold() -> Self::GuardType;

    /// Force the release of the condition.
    unsafe fn force_unhold();
}

/// Implement `Holdable` for a tuple of `Holdable` types.
impl<H0, H1, G0, G1> Holdable for (H0, H1)
where
    H0: Holdable<GuardType = G0>,
    H1: Holdable<GuardType = G1>,
{
    type GuardType = (G1, G0);

    /// The 0-th position should be held first and then the 1-th position.
    /// The respective guards should be dropped in reverse order.
    fn hold() -> Self::GuardType {
        let g0 = H0::hold();
        let g1 = H1::hold();

        // We must put `g1` in the 0-th position, because the dropping sequence
        // is the same as the element sequence, not in reverse.
        // https://doc.rust-lang.org/reference/destructors.html
        (g1, g0)
    }

    /// Force the release of the condition. Should happen in reverse order,
    /// starting from the 1-th position to the 0-th.
    unsafe fn force_unhold() {
        H1::force_unhold();
        H0::force_unhold();
    }
}
