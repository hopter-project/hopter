use super::Holdable;
use crate::{
    interrupt::mask::{HeldInterrupt, RecursivelyMaskable},
    schedule::scheduler::{SchedSuspendGuard, Scheduler},
    unrecoverable::Lethal,
};
use core::{
    marker::PhantomData,
    ops::{Deref, DerefMut},
};
use owning_ref::StableAddress;
use spin::{Mutex as RawSpin, MutexGuard as RawSpinGuard};

/// Generic type of a spin lock. When the lock is being held, some extra
/// condition can also be held. For example, the extra condition may be
/// some interrupt being masked or the scheduler being suspended.
/// Generic parameter:
/// - `T``: The type that the lock is protecting.
/// - `H``: A holdable condition.
/// - `G``: The guard type representing the additional held condition.
pub(super) struct GenericSpin<T, H, G>
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
pub(super) struct GenericSpinGuard<'a, T, G>
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

impl<T, H, G> GenericSpin<T, H, G>
where
    H: Holdable<GuardType = G>,
{
    /// Create a new spin lock instance protecting the given `data`.
    pub(super) const fn new(data: T) -> Self {
        Self {
            raw_spin: RawSpin::new(data),
            _phantom_holdable: PhantomData,
        }
    }

    /// Discard the lock and take back the contained data.
    pub(super) fn into_inner(self) -> T {
        self.raw_spin.into_inner()
    }
}

impl<T, H, G> GenericSpin<T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    /// If the lock is not already locked, lock it and return it in `Some`,
    /// otherwise return `None`. This is non-blocking.
    pub(super) fn try_lock(&self) -> Option<GenericSpinGuard<T, G>> {
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
        self.raw_spin.try_lock().map(|lock_guard| GenericSpinGuard {
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
    #[allow(unused)]
    pub(super) fn lock_now_or_die(&self) -> GenericSpinGuard<T, G> {
        self.try_lock().unwrap_or_die()
    }

    /// Acquire the lock and return the lock gurad. If the lock is under
    /// contention, spin until the lock can be acquired.
    pub(super) fn lock(&self) -> GenericSpinGuard<T, G> {
        loop {
            if let Some(locked) = self.try_lock() {
                return locked;
            }
        }
    }

    /// Returns a mutable reference to the underlying data. Since this call
    /// borrows the lock mutably, and a mutable reference is guaranteed to
    /// be exclusive in Rust, no actual locking needs to take place – the
    /// mutable borrow statically guarantees no contention exist. As such, this
    /// is a zero-cost operation.
    pub(super) fn get_mut(&mut self) -> &mut T {
        self.raw_spin.get_mut()
    }

    /// Forecefully set the lock into released state.
    ///
    /// Safety: The previous acquired lock guard must not be used to access the
    /// protected data.
    pub(super) unsafe fn force_unlock(&self) {
        self.raw_spin.force_unlock();
        H::force_unhold();
    }
}

impl<'a, T, G> Deref for GenericSpinGuard<'a, T, G>
where
    T: ?Sized,
{
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &*self.raw_spin_guard
    }
}

impl<'a, T, G> DerefMut for GenericSpinGuard<'a, T, G>
where
    T: ?Sized,
{
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut *self.raw_spin_guard
    }
}

unsafe impl<'a, T, G> StableAddress for GenericSpinGuard<'a, T, G> where T: ?Sized {}

/// Generate the definition and methods and trait implementation of a spin
/// lock. The generated lock wraps around [`GenericSpin`] and the generated
/// lock gruard wraps around [`GenericSpinGuard`]. The generated methods
/// simply calls the identically named methods in the wrapped generic
/// instance.
///
/// The reason for wrapping the generic lock and gurad type is to prevent
/// leaking internal types, such as [`SchedSuspendGuard`].
///
/// This macro also allows to generate different documentation for each
/// concrete lock type and guard type.
macro_rules! define_spin_lock {
    (
        // The type name of the spin lock struct to be generated.
        $spin_ty:ident,
        // The documentation of the spin lock struct in addition to the common
        // documentation.
        $spin_extra_doc:expr,
        // The type name of the lock guard struct to be generated.
        $guard_ty:ident,
        // The documentation of the lock guard struct in addition to the
        // common documentation.
        $guard_extra_doc:expr,
        // Generic type parameters to the lock type and their constraints.
        <$($gen:ident $(: $bound:path)?),*>,
        // Concrete type providing the implementation of the spin lock.
        $generic_spin_ty:ty,
        // Concrete type providing the implementation of the lock gurad.
        $generic_guard_ty:ty
    ) => {
        /// A lock type that protects the given data. When trying to acquire
        /// the lock, the CPU wait in a busy loop while repeatedly checking
        /// whether the lock is available, i.e., no context switch will be
        /// performed.
        ///
        #[doc = $spin_extra_doc]
        pub struct $spin_ty<$($gen $(: $bound)?),*> {
            generic_spin: $generic_spin_ty,
        }

        /// The guard type that provides mutable access to the data being
        /// protected. The guard will be returned after successfully acquiring
        /// the lock.
        ///
        #[doc = $guard_extra_doc]
        pub struct $guard_ty<'a, $($gen $(: $bound)?),*> {
            generic_guard: $generic_guard_ty,
        }

        impl<$($gen $(: $bound)?),*> $spin_ty<$($gen),*> {
            /// Create a new spin lock instance protecting the given `data`.
            pub const fn new(data: T) -> Self {
                Self {
                    generic_spin: GenericSpin::new(data),
                }
            }

            /// Discard the lock and take back the contained data.
            pub fn into_inner(self) -> T {
                self.generic_spin.into_inner()
            }

            /// If the lock is not already locked, lock it and return it in
            /// `Some`, otherwise return `None`. This is non-blocking.
            pub fn try_lock<'a>(&'a self) -> Option<$guard_ty<'a, $($gen),*>> {
                self.generic_spin.try_lock().map(|guard| $guard_ty {
                    generic_guard: guard,
                })
            }

            /// Acquire the lock and return the lock guard, while asserting
            /// that there should be no contention. It is an unrecoverable
            /// error if the lock turns out to be under contention.
            ///
            /// The method is currently only for kernel's internel use. For
            /// global and static variables that logically have no concurrent
            /// access, we use a spin lock to wrap them around and use this
            /// method to access the object. We prefer having an extra sanity
            /// check rather than writing unsafe code for mutable global or
            /// static variable.
            #[allow(unused)]
            pub(crate) fn lock_now_or_die<'a>(&'a self) -> $guard_ty<'a, $($gen),*> {
                self.try_lock().unwrap_or_die()
            }

            /// Acquire the lock and return the lock gurad. If the lock is
            /// under contention, wait in a busy loop until the lock can be
            /// acquired.
            pub fn lock<'a>(&'a self) -> $guard_ty<'a, $($gen),*> {
                $guard_ty {
                    generic_guard: self.generic_spin.lock(),
                }
            }

            /// Returns a mutable reference to the underlying data. Since this
            /// call borrows the lock mutably, and a mutable reference is
            /// guaranteed to be exclusive in Rust, no actual locking needs to
            /// take place – the mutable borrow statically guarantees no
            /// contention exist. As such, this is a zero-cost operation.
            pub fn get_mut(&mut self) -> &mut T {
                self.generic_spin.get_mut()
            }

            /// Forecefully set the lock into released state.
            ///
            /// Safety: The previous acquired lock guard must not be used to
            /// access the protected data.
            pub unsafe fn force_unlock(&self) {
                self.generic_spin.force_unlock()
            }
        }

        impl<'a, $($gen $(: $bound)?),*> Deref for $guard_ty<'a, $($gen),*> {
            type Target = T;

            fn deref(&self) -> &Self::Target {
                self.generic_guard.deref()
            }
        }

        impl<'a, $($gen $(: $bound)?),*> DerefMut for $guard_ty<'a, $($gen),*> {
            fn deref_mut(&mut self) -> &mut Self::Target {
                self.generic_guard.deref_mut()
            }
        }

        unsafe impl<'a, $($gen $(: $bound)?),*> StableAddress for $guard_ty<'a, $($gen),*> {}
    };
}

define_spin_lock!(
    Spin,
    "",
    SpinGuard,
    "",
    <T>,
    GenericSpin<T, (), ()>,
    GenericSpinGuard<'a, T, ()>
);

define_spin_lock!(
    SpinIrqSafe,
    "When the lock is acquired, the associated IRQ will also be masked.",
    SpinIrqSafeGuard,
    "The associated IRQ will be masked until the guard is dropped.",
    <T, I: RecursivelyMaskable>,
    GenericSpin<T, I, HeldInterrupt<I>>,
    GenericSpinGuard<'a, T, HeldInterrupt<I>>
);

define_spin_lock!(
    SpinSchedSafe,
    "When the lock is acquired, the scheduler will also be suspended.",
    SpinSchedSafeGuard,
    "The scheduler will be suspended until the guard is dropped.",
    <T>,
    GenericSpin<T, Scheduler, SchedSuspendGuard>,
    GenericSpinGuard<'a, T, SchedSuspendGuard>
);

define_spin_lock!(
    SpinSchedIrqSafe,
    "When the lock is acquired, the associated IRQ will also be masked and \
the scheduler suspended. Suspending the scheduler happens before masking the \
IRQ during locking. Conversely, during unlocking, the IRQ is unmasked first \
and subsequently the scheduler is resumed.",
    SpinSchedIrqSafeGuard,
    "The associated IRQ will be masked and the scheduler will be suspended \
until the guard is dropped.",
    <T, I: RecursivelyMaskable>,
    GenericSpin<T, (Scheduler, I), (HeldInterrupt<I>, SchedSuspendGuard)>,
    GenericSpinGuard<'a, T, (HeldInterrupt<I>, SchedSuspendGuard)>
);
