use super::{
    CompoundHoldable, GenericSpin, GenericSpinGuard, Holdable, Lockable, SpinSchedSafe,
    UnlockableGuard, WaitQueue,
};
use crate::{
    interrupt::mask::{HeldInterrupt, RecursivelyMaskable},
    schedule::{
        current,
        scheduler::{SchedSuspendGuard, Scheduler},
    },
    task::Task,
};
use alloc::sync::Arc;
use core::{
    ops::{Deref, DerefMut},
    sync::atomic::{AtomicBool, Ordering},
};
use owning_ref::StableAddress;

/// Generic type of a mutex. When the mutex is acquired, some extra conditions
/// can also be held. For example, an extra condition may be that some IRQs are
/// being masked. Failure to acquire a mutex will cause the calling task to
/// block until the mutex can be acquired.
/// Generic parameter:
/// - `T``: The type that the lock is protecting.
/// - `H``: A holdable condition.
/// - `G``: The guard type representing the additional held condition.
struct GenericMutex<T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    /// The wait queue for tasks being blocked to wait for their turn.
    queue: WaitQueue,
    /// The task that is currently holding this mutex.
    owner: SpinSchedSafe<Option<Arc<Task>>>,
    /// If the mutex is released in an unwinding path, this variable will
    /// be set to `true`. This is just additional information to application
    /// code.
    poisoned: AtomicBool,
    /// The spin lock actually protecting the data. When the mutex is being
    /// acquired, the scheduler will first be suspended and then the additional
    /// condition be held. After the mutex is fully acquired, the guard on the
    /// spin lock will be downgraded to a weaker spin lock guard that no longer
    /// suspend the scheduler, but which keeps holding only the additional
    /// condition `H`.
    spin_lock: GenericSpin<
        T,
        CompoundHoldable<Scheduler, H, SchedSuspendGuard, G>,
        (G, SchedSuspendGuard),
    >,
}

/// Generic type of a mutex guard that can dereference into contained type.
/// When the guard is dropped, the mutex will be released and the additionally
/// held condition will be released atomically.
struct GenericMutexGuard<'a, T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    guard: Option<GenericSpinGuard<'a, T, G>>,
    mutex: &'a GenericMutex<T, H, G>,
}

impl<T, H, G> GenericMutex<T, H, G>
where
    H: Holdable<GuardType = G>,
{
    /// Create a new mutex instance.
    pub const fn new(data: T) -> Self {
        GenericMutex {
            queue: WaitQueue::new(),
            owner: SpinSchedSafe::new(None),
            poisoned: AtomicBool::new(false),
            spin_lock: GenericSpin::new(data),
        }
    }

    /// Discard the mutex and get back the contained data.
    fn into_inner(self) -> T {
        self.spin_lock.into_inner()
    }

    /// Return if the mutex was acquired by a task when the task is being
    /// unwound.
    fn is_poisoned(&self) -> bool {
        self.poisoned.load(Ordering::SeqCst)
    }

    /// Forecefully set the mutex into released state.
    ///
    /// Safety: The previous acquired mutex guard must not be used to access
    /// the protected data in the future.
    unsafe fn force_unlock(&self) {
        self.owner.lock_now_or_die().take();
        self.spin_lock.force_unlock();
        self.queue.notify_one_allow_isr();
    }
}

impl<T, H, G> GenericMutex<T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    /// If the mutex has not been locked, lock it and return it within `Some`.
    /// Otherwise, return `None`.
    pub fn try_lock(&self) -> Option<GenericMutexGuard<T, H, G>> {
        self.spin_lock
            // Try to acquire the spin lock that wraps around the protected data. If it
            // failes, i.e. returns `None`, the following will be skipped and this
            // method returns with `None`.
            .try_lock()
            // If the spin lock is acquired, the scheduler should have been suspended.
            // Update the current task to be the owner of the lock. If we acquired the
            // lock inside an ISR, it should always succeed. However, we will not update
            // the owner field for two reasons. First, logically, the ISR cannot context
            // switch, so the ISR will always release the lock before any other code can
            // later acquire it. Second, mechanically, reading the current task pointer
            // from an ISR can cause deadlock when the scheduler is setting the current
            // task pointer.
            .and_then(|guard| {
                if !current::is_in_isr_context() {
                    current::with_current_task_arc(|cur_task| {
                        self.owner.lock_now_or_die().replace(cur_task)
                    });
                }
                Some(guard)
            })
            // After we finish updating the owner, we can resume the scheduler. We now
            // downgrade the guard that both suspends the scheduler and holds the
            // condition `H` to a weaker one that no longer suspends the scheduler
            // but still holds `H`.
            .map(|guard| GenericSpinGuard {
                raw_spin_guard: guard.raw_spin_guard,
                // Discard the `.1` component which is the scheduler suspend guard.
                _held: guard._held.0,
            })
            // Finally, we convert it to `GenericMutexGuard`.
            .map(|guard| GenericMutexGuard {
                guard: Some(guard),
                mutex: &self,
            })
    }

    /// Lock the mutex. If the mutex has already been locked, block until the
    /// current task can lock it.
    pub fn lock(&self) -> GenericMutexGuard<T, H, G> {
        // Fast path for no contention.
        if let Some(guard) = self.try_lock() {
            return guard;
        }

        // Priority inheritance.
        current::with_current_task(|cur_task| {
            let locked_owner = self.owner.lock_now_or_die();
            if let Some(owner) = locked_owner.as_ref() {
                owner.ceil_priority_from(cur_task);
            }
        });

        // Otherwise, wait on the wait queue until the current task can lock it.
        // The called method will return the mutex guard upon return.
        self.queue.wait_until(|| self.try_lock())
    }
}

impl<'a, T, H, G> Deref for GenericMutexGuard<'a, T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    type Target = T;

    fn deref(&self) -> &T {
        self.guard.as_ref().unwrap()
    }
}

impl<'a, T, H, G> DerefMut for GenericMutexGuard<'a, T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    fn deref_mut(&mut self) -> &mut T {
        self.guard.as_mut().unwrap()
    }
}

impl<'a, T, H, G> Drop for GenericMutexGuard<'a, T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    fn drop(&mut self) {
        if let Some(cur_task) = self.mutex.owner.lock_now_or_die().take() {
            cur_task.restore_intrinsic_priority();
        }

        #[cfg(feature = "unwind")]
        if crate::unwind::unwind::is_unwinding() {
            self.mutex.poisoned.store(true, Ordering::SeqCst);
        }

        // Drop the spin lock before notifying other tasks. Otherwise, if a task being
        // notified has higher priority than the current task, without having the spin
        // lock guard dropped first, the woken up high priority task will immediately
        // go back to block state again, causing a deadlock.
        core::mem::drop(self.guard.take());

        // Notify a task on the waitqueue that the lock is released, which occurs
        // automatically when the inner `guard` is dropped after this method executes.
        self.mutex.queue.notify_one_allow_isr();
    }
}

impl<T, H, G> Lockable for GenericMutex<T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    type GuardType<'a> = GenericMutexGuard<'a, T, H, G> where T: 'a, H: 'a, G:'a;

    fn lock_and_get_guard(&self) -> Self::GuardType<'_> {
        self.lock()
    }
}

impl<'a, T, H, G> UnlockableGuard<'a> for GenericMutexGuard<'a, T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
    type LockType = GenericMutex<T, H, G>;

    fn unlock_and_into_lock_ref(self) -> &'a Self::LockType {
        self.mutex
    }
}

unsafe impl<'a, T, H, G> StableAddress for GenericMutexGuard<'a, T, H, G>
where
    T: ?Sized,
    H: Holdable<GuardType = G>,
{
}

/// Generate the definition and methods and trait implementation of a mutex.
/// The generated mutex wraps around [`GenericMutex`] and the generated mutex
/// gruard wraps around [`GenericMutexGuard`]. The generated methods simply
/// calls the identically named methods in the wrapped generic instance.
///
/// The reason for wrapping the generic mutex and gurad type is to prevent
/// leaking internal types.
///
/// This macro also allows to generate different documentation for each
/// concrete mutex type and guard type.
macro_rules! define_mutex {
    (
        // The type name of the mutex struct to be generated.
        $mutex_ty:ident,
        // The documentation of the mutex struct in addition to the common
        // documentation.
        $mutex_extra_doc:expr,
        // The type name of the mutex guard struct to be generated.
        $guard_ty:ident,
        // The documentation of the mutex guard struct in addition to the
        // common documentation.
        $guard_extra_doc:expr,
        // Generic type parameters to the mutex type and their constraints.
        <$($gen:ident $(: $bound:path)?),*>,
        // Concrete type providing the implementation of the mutex.
        $generic_mutex_ty:ty,
        // Concrete type providing the implementation of the mutex gurad.
        $generic_guard_ty:ty
    ) => {
        /// A lock type protecting the contained data. At most one task can
        /// access the protected data at any time. Failure to acquire a mutex
        /// will cause the calling task to block until the mutex can be
        /// acquired.
        ///
        #[doc = $mutex_extra_doc]
        pub struct $mutex_ty<$($gen $(: $bound)?),*> {
            generic_mutex: $generic_mutex_ty,
        }

        /// The guard type that provides mutable access to the data being
        /// protected. The guard will be returned after successfully acquiring
        /// the mutex.
        ///
        #[doc = $guard_extra_doc]
        pub struct $guard_ty<'a, $($gen $(: $bound)?),*> {
            generic_guard: $generic_guard_ty,
            mutex: &'a $mutex_ty<$($gen),*>,
        }

        impl<$($gen $(: $bound)?),*> $mutex_ty<$($gen),*> {
            /// Create a new mutex instance protecting the given `data`.
            pub const fn new(data: T) -> Self {
                Self {
                    generic_mutex: GenericMutex::new(data),
                }
            }

            /// Discard the mutex and get back the contained data.
            pub fn into_inner(self) -> T {
                self.generic_mutex.into_inner()
            }

            /// Return if the mutex was acquired by a task when the task is
            /// being unwound.
            pub fn is_poisoned(&self) -> bool {
                self.generic_mutex.is_poisoned()
            }

            /// Forecefully set the mutex into released state.
            ///
            /// Safety: The previous acquired mutex guard must not be used to
            /// access the protected data in the future.
            pub unsafe fn force_unlock(&self) {
                self.generic_mutex.force_unlock()
            }

            /// If the mutex has not been locked, lock it and return it within
            /// `Some`. Otherwise, return `None`.
            pub fn try_lock<'a>(&'a self) -> Option<$guard_ty<'a, $($gen),*>> {
                self.generic_mutex
                    .try_lock()
                    .map(|generic_guard| $guard_ty {
                        generic_guard,
                        mutex: self,
                    })
            }

            /// Lock the mutex. If the mutex has already been locked, block
            /// until the current task can lock it.
            pub fn lock<'a>(&'a self) -> $guard_ty<'a, $($gen),*> {
                $guard_ty {
                    generic_guard: self.generic_mutex.lock(),
                    mutex: self,
                }
            }
        }

        impl<'a, $($gen $(: $bound)?),*> Deref for $guard_ty<'a, $($gen),*> {
            type Target = T;

            fn deref(&self) -> &T {
                self.generic_guard.deref()
            }
        }

        impl<'a, $($gen $(: $bound)?),*> DerefMut for $guard_ty<'a, $($gen),*> {
            fn deref_mut(&mut self) -> &mut T {
                self.generic_guard.deref_mut()
            }
        }

        impl<$($gen $(: $bound)?),*> Lockable for $mutex_ty<$($gen),*> {
            type GuardType<'a> = $guard_ty<'a, $($gen),*> where $($gen:'a), *;

            fn lock_and_get_guard(&self) -> Self::GuardType<'_> {
                self.lock()
            }
        }

        impl<'a, $($gen $(: $bound)?),*> UnlockableGuard<'a> for $guard_ty<'a, $($gen),*> {
            type LockType = $mutex_ty<$($gen),*>;

            fn unlock_and_into_lock_ref(self) -> &'a Self::LockType {
                self.mutex
            }
        }

        unsafe impl<'a, $($gen $(: $bound)?),*> StableAddress for $guard_ty<'a, $($gen),*> {}
    };
}

define_mutex!(
    Mutex,
    "",
    MutexGuard,
    "",
    <T>,
    GenericMutex<T, (), ()>,
    GenericMutexGuard<'a, T, (), ()>
);

define_mutex!(
    MutexIrqSafe,
    "When the mutex is acquired, the associated IRQ will also be masked.",
    MutexIrqSafeGuard,
    "The associated IRQ will be masked until the guard is dropped.",
    <T, I: RecursivelyMaskable>,
    GenericMutex<T, I, HeldInterrupt<I>>,
    GenericMutexGuard<'a, T, I, HeldInterrupt<I>>
);
