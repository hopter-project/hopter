use core::sync::atomic::{AtomicBool, Ordering};

/// Indicate that certain operation on the struct can be pended and get executed
/// at a later time. For example, an ISR might want to notify a task and make it
/// ready, but the task queue is being locked, the ISR will then pend the notification
/// operation.
///
/// Implementing this trait necessitates providing two accessor types. The
/// `FullAccessor` is the one used when the code successfully acquires the full
/// accessibility on the protected content. In contrast, the `PendOnlyAccessor`
/// will be provided when there is active `FullAccessor` held by other part of the
/// code. Normally, the `PendOnlyAccessor` should grant a subset of access to the
/// protected content compared to `FullAccessor`.
///
/// The two required methods should respectively return the two accessor types
/// given the `&self` reference.
pub trait AllowPendOp<'a> {
    type FullAccessor: RunPendedOp + 'a;
    type PendOnlyAccessor: 'a;

    fn full_access(&'a self) -> Self::FullAccessor;
    fn pend_only_access(&'a self) -> Self::PendOnlyAccessor;
}

/// The `FullAccessor` should check whether there is any pended operation and run
/// it if exists.
pub trait RunPendedOp {
    fn run_pended_op(&mut self);
}

/// This wrapper type intends to resolve concurrent access to the internal component
/// when the concurrency comes from ISRs. The protected component should implement the
/// `AllowPendOp` trait.
///
/// Request to access the protected component will be granted either `Access::Full` or
/// `Access::PendOnly`. When there is an active `Access:Full`, futher access request will
/// get `Access::PendOnly`.
///
/// When a task thread is holding `Access::Full` while working on the protected content,
/// an ISR may preempt it and get `Access::PendOnly` to the protected content. In such
/// case, the ISR should use the pend-only accessor to pend the intended operation and
/// let the task thread to later run the operation.
///
/// An ISR may get `Access::Full` if no one was actively accessing the protected content,
/// and in such case the ISR may run the intended operation directly.
///
/// Important Note: The wrapper assumes that the preemting thread of execution always
/// finishes before returning to the prreempted thread of execution, which is the case
/// for ISRs, but not the case for task context switching in general.
pub struct Interruptable<T>
where
    for<'b> T: AllowPendOp<'b>,
{
    /// The content being protected.
    content: T,
    /// Whether there is any pended operation.
    pending: AtomicBool,
    /// Whether a `FullAccessor` is active.
    locked: AtomicBool,
}

impl<T> Interruptable<T>
where
    for<'b> T: AllowPendOp<'b>,
{
    pub const fn new(val: T) -> Self {
        Self {
            content: val,
            pending: AtomicBool::new(false),
            locked: AtomicBool::new(false),
        }
    }

    /// Get access to the protected content and execute the operation. The closure
    /// should take an `Access` enum type as the argument. The operation should run
    /// based on the `Access` variant. It may be either `Full` or `PendOnly`.
    pub fn with_access<'a, F, R>(&'a self, op: F) -> R
    where
        F: FnOnce(
            Access<<T as AllowPendOp>::FullAccessor, <T as AllowPendOp>::PendOnlyAccessor>,
        ) -> R,
    {
        let guard = AccessGuard::guard(self);
        let accessor = guard.get_access();
        op(accessor)
    }

    /// Get the full access to the protected content and execute the operation. If
    /// `Full` access cannot be granted, the code spins. Otherwise, the closure is
    /// invoked with `FullAccessor` variant as the argument.
    pub fn must_with_full_access<'a, F, R>(&'a self, op: F) -> R
    where
        F: FnOnce(<T as AllowPendOp>::FullAccessor) -> R,
    {
        let guard = AccessGuard::guard(self);
        let accessor = guard.must_get_full_access();
        op(accessor)
    }
}

/// Access to the protected contents can be either `Full` or `PendOnly`, yielding
/// the `FullAccessor` or `PendOnlyAccessor`, respectively.
pub enum Access<FullAccessor, PendOnlyAccessor>
where
    FullAccessor: RunPendedOp,
{
    Full { full_access: FullAccessor },
    PendOnly { pend_access: PendOnlyAccessor },
}

/// The guard type of an active access to the protected content. Depending on the
/// `lock_held` field, it may represent either full or pend-only access.
struct AccessGuard<'a, T>
where
    for<'b> T: AllowPendOp<'b>,
{
    /// If true, the guard assumes full access, otherwise pend-only access.
    lock_held: bool,
    /// Reference to interruptable struct instance.
    interruptable: &'a Interruptable<T>,
}

impl<'a, T> AccessGuard<'a, T>
where
    for<'b> T: AllowPendOp<'b>,
{
    /// Get access to the protected content. If there is no active full access,
    /// the returned guard will assume full access by setting the `locked` bit.
    /// Otherwise, the guard will assume pend-only access.
    fn guard(interruptable: &'a Interruptable<T>) -> Self {
        Self {
            lock_held: interruptable
                .locked
                .compare_exchange(false, true, Ordering::SeqCst, Ordering::SeqCst)
                .is_ok(),
            interruptable,
        }
    }

    /// Return an accessor, either the `Full` or `PendOnly` variant, depending on
    /// whether the guard assumes full access.
    fn get_access(
        &self,
    ) -> Access<<T as AllowPendOp>::FullAccessor, <T as AllowPendOp>::PendOnlyAccessor> {
        match self.lock_held {
            true => Access::Full {
                full_access: self.interruptable.content.full_access(),
            },
            false => Access::PendOnly {
                pend_access: self.interruptable.content.pend_only_access(),
            },
        }
    }

    /// Return the `FullAccessor`. If the guard assumes pend-only access but not full
    /// access, the function spins.
    fn must_get_full_access(&self) -> <T as AllowPendOp>::FullAccessor {
        match self.lock_held {
            true => self.interruptable.content.full_access(),
            false => loop {},
        }
    }
}

impl<'a, T> Drop for AccessGuard<'a, T>
where
    for<'b> T: AllowPendOp<'b>,
{
    fn drop(&mut self) {
        match self.lock_held {
            // If the guard assumes full access, we should now check if there is any
            // pended operation and run it if exists.
            true => {
                let mut full_access = self.interruptable.content.full_access();

                // While we are performing the pended operation, we may be preempted by an
                // ISR that again adds more pended operations. We keep checking until we are
                // certain that we miss no operation.
                loop {
                    // Check if we have pended operation and clear the pending flag.
                    let prev_pending = self.interruptable.pending.swap(false, Ordering::SeqCst);

                    // If some tasks are pended to be added to the ready queue, add them in.
                    if prev_pending {
                        full_access.run_pended_op();
                    }

                    // *** ISR might set pending again here. ***

                    // Release the lock here.
                    self.interruptable.locked.store(false, Ordering::SeqCst);

                    // If the pending flag is still clear, we are done and can return.
                    if !self.interruptable.pending.load(Ordering::SeqCst) {
                        break;

                    // Otherwise, we have more tasks to add to the ready queue. We lock the
                    // queue and run it over again. It suffices to just `.store(true)` to
                    // `locked`, but we use `compare_exchange` here for sanity checking that
                    // the previous value is `false`.
                    } else {
                        let res = self.interruptable.locked.compare_exchange(
                            false,
                            true,
                            Ordering::SeqCst,
                            Ordering::SeqCst,
                        );
                        if res.is_err() {
                            loop {}
                        }
                    }
                }
            }
            // If the guard assumes pend-only access, we should set the pending flag
            // to true so that the owner having full access will later run the pended
            // operation.
            false => {
                self.interruptable.pending.store(true, Ordering::SeqCst);
            }
        }
    }
}
