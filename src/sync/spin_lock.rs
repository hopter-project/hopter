use super::{HeldInterrupt, Holdable};
use crate::{
    schedule::scheduler::{SchedSuspendGuard, Scheduler},
    unrecoverable::Lethal,
};
use core::marker::PhantomData;
use core::ops::{Deref, DerefMut};
use owning_ref::StableAddress;
use spin::{Mutex as RawSpin, MutexGuard as RawSpinGuard};

/// The normal spin lock.
pub(crate) type Spin<T> = SpinGeneric<T, (), ()>;

/// The lock guard of the normal spin lock.
#[allow(unused)]
pub(crate) type SpinGuard<'a, T> = SpinGenericGuard<'a, T, ()>;

/// A spin lock type that also masks the given interrupt upon locking.
#[allow(unused)]
pub(crate) type SpinIrqSafe<T, I> = SpinGeneric<T, I, HeldInterrupt<I>>;

/// The lock guard that can dereference into the contained type.
/// When the guard is dropped, the lock will be released and the interrupt
/// will be unmasked conditionally. See `RecursivelyMaskable` for details
/// about interrupt mask/unmask.
#[allow(unused)]
pub(crate) type SpinIrqSafeGuard<'a, T, I> = SpinGenericGuard<'a, T, HeldInterrupt<I>>;

/// A spin lock type that also suspend the scheduler upon locking.
#[allow(unused)]
pub(crate) type SpinSchedSafe<T> = SpinGeneric<T, Scheduler, SchedSuspendGuard>;

/// The lock guard that can dereference into the contained type.
/// When the guard is dropped, the lock will be released and the scheduler
/// will be resumed conditionally if the suspend count reaches zero.
#[allow(unused)]
pub(crate) type SpinSchedSafeGuard<'a, T> = SpinGenericGuard<'a, T, SchedSuspendGuard>;

/// A spin lock type that also suspend the scheduler and masks the given
/// interrupt upon locking. Suspending the scheduler happens before masking
/// the interrupt during locking. Conversely, during unlocking, the interrupt
/// is unmasked first and subsequently the scheduler is resumed. See the
/// `Holdable` trait implementation on tuples for the details of sequence.
#[allow(unused)]
pub(crate) type SpinSchedIrqSafe<T, I> =
    SpinGeneric<T, (Scheduler, I), (HeldInterrupt<I>, SchedSuspendGuard)>;

/// The lock guard that can dereference into the contained type.
/// When the guard is dropped, the lock will be released, with the interrupt
/// unmasked and the scheduler resumed if the mask and suspend count respectively
/// reach zero. See the `Holdable` trait implementation on tuples for the details
/// of sequence.
#[allow(unused)]
pub(crate) type SpinSchedIrqSafeGuard<'a, T, I> =
    SpinGenericGuard<'a, T, (HeldInterrupt<I>, SchedSuspendGuard)>;

/// Generic type of a spin lock. When the lock is being held, some extra
/// condition can also be held. For example, the extra condition may be
/// some interrupt being masked or the scheduler being suspended.
/// Generic parameter:
/// - `T``: The type that the lock is protecting.
/// - `H``: A holdable condition.
/// - `G``: The guard type representing the additional held condition.
pub struct SpinGeneric<T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    /// Just to satisfy the compiler so that it sees `H` in a field.
    _phantom_holdable: PhantomData<H>,
    /// The actual spin lock.
    raw_spin: RawSpin<T>,
}

/// Generic type of a spin lock guard that can dereference into the contained
/// type. When the guard is dropped, the lock will be released and the additionally
/// held condition will be released atomically.
pub struct SpinGenericGuard<'a, T, G>
where
    T: ?Sized,
{
    /// The lock guard for the actual spin lock.
    pub(super) raw_spin_guard: RawSpinGuard<'a, T>,
    // The guard for the additionally held condition.
    // It will be dropped after the above.
    // Rust guarantees that fields are dropped in the order of declaration.
    // https://doc.rust-lang.org/reference/destructors.html
    pub(super) _held: G,
}

impl<T, H, G> SpinGeneric<T, H, G>
where
    H: Holdable<GuardType = G>,
{
    /// Create a new instance. `irq` is the interrupt(s) that will be masked
    /// upon locking.
    pub const fn new(data: T) -> Self {
        Self {
            raw_spin: RawSpin::new(data),
            _phantom_holdable: PhantomData,
        }
    }

    /// Discard the mutex and get back the contained data.
    pub fn into_inner(self) -> T {
        self.raw_spin.into_inner()
    }
}

impl<T, H, G> SpinGeneric<T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    /// If the lock is not already locked, lock it and return it in `Some`,
    /// otherwise return `None`. This is non-blocking.
    pub fn try_lock(&self) -> Option<SpinGenericGuard<T, G>> {
        // Return `None` if already locked.
        if self.raw_spin.is_locked() {
            return None;
        }

        // Not yet locked. Hold the required condition first. It may be masking
        // some interrupts or suspending the scheduler.
        let _held = H::hold();

        // Try to lock the raw spin lock. If this is successful, it will return the
        // raw spin lock guard in `Some` which we will then put together the held
        // condition guard and return. If the raw spin lock was already locked by someone
        // else while we were trying to hold the condition, it returns `None` and we will
        // also return `None`. In this case the held condition guard will be dropped
        // upon function return so it will also be released.
        self.raw_spin.try_lock().map(|lock_guard| SpinGenericGuard {
            raw_spin_guard: lock_guard,
            _held,
        })
    }

    /// Acquire the lock and return the lock guard, while asserting that there
    /// should be no contention. It is an unrecoverable error if the lock turns
    /// out to be under contention.
    ///
    /// The method is currently only for kernel's internel use. For global and
    /// static variables that logically have no concurrent access, we use a
    /// spin lock to wrap them around and use this method to access the object.
    /// We prefer having an extra sanity check rather than writing unsafe code
    /// for mutable global or static variable.
    pub(crate) fn lock_now_or_die(&self) -> SpinGenericGuard<T, G> {
        self.try_lock().unwrap_or_die()
    }

    /// Acquire the lock and return the lock gurad. If the lock is under
    /// contention, spin until the lock can be acquired.
    pub fn lock(&self) -> SpinGenericGuard<T, G> {
        loop {
            if let Some(locked) = self.try_lock() {
                return locked;
            }
        }
    }

    /// Returns a mutable reference to the underlying data. Since this call
    /// borrows the `Mutex`` mutably, and a mutable reference is guaranteed to
    /// be exclusive in Rust, no actual locking needs to take place – the
    /// mutable borrow statically guarantees no locks exist. As such, this is a
    /// 'zero-cost' operation.
    pub fn get_mut(&mut self) -> &mut T {
        self.raw_spin.get_mut()
    }

    pub unsafe fn force_unlock(&self) {
        self.raw_spin.force_unlock();
        H::force_unhold();
    }
}

impl<'a, T, G> Deref for SpinGenericGuard<'a, T, G>
where
    T: ?Sized,
{
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &*self.raw_spin_guard
    }
}

impl<'a, T, G> DerefMut for SpinGenericGuard<'a, T, G>
where
    T: ?Sized,
{
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut *self.raw_spin_guard
    }
}

unsafe impl<'a, T, G> StableAddress for SpinGenericGuard<'a, T, G> where T: ?Sized {}
