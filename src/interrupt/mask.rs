use crate::{config, sync::Holdable};
use core::{
    marker::PhantomData,
    sync::atomic::{AtomicUsize, Ordering},
};

/// Representing recursively maskable interrupt(s). Recursive means one can
/// [`mask_recursive`](RecursivelyMaskable::mask_recursive) an already masked
/// interrupt, which will increase the mask count by one.
/// [`unmask_recursive`](RecursivelyMaskable::unmask_recursive) will decrease
/// the mask count, and the interrupt will be unmasked only when the count
/// reaches zero.
///
/// If two types `T0` and `T1` are [`RecursivelyMaskable`], then the tuple
/// `(T0, T1)` is also [`RecursivelyMaskable`]. The masking follows the same
/// order as in the tuple definition, i.e., mask `T0` and then `T1`. The
/// unmasking follows the reverse order, i.e., unmask `T1` and then `T0`.
///
/// [`RecursivelyMaskable`] trait implementation is provided for tuples of
/// length up to 10.
pub trait RecursivelyMaskable {
    /// Mask the interrupt and increase the mask count by 1.
    fn mask_recursive();
    /// Decrease the mask count by 1. Re-enable the interrupt if the count
    /// reaches zero.
    /// Safety: One has to guarantee that no race condition will occur after
    /// the interrupt is enabled.
    unsafe fn unmask_recursive();
}

/// The mask count for `AllIrqExceptSvc`.
static ALL_IRQ_MASK_CNT: AtomicUsize = AtomicUsize::new(0);

/// Representing all IRQs except SVC.
/// FIXME: Should also suspend scheduler.
pub struct AllIrqExceptSvc;

impl RecursivelyMaskable for AllIrqExceptSvc {
    fn mask_recursive() {
        // Elevate the `BASEPRI` priority. This effectively masks out all
        // IRQs which all have priority 32 except SVC which has the highest
        // priority 0.
        unsafe {
            cortex_m::Peripherals::steal().SCB.set_priority(
                cortex_m::peripheral::scb::SystemHandler::SVCall,
                config::SVC_RAISED_PRIORITY,
            );
            cortex_m::register::basepri::write(config::IRQ_DISABLE_BASEPRI_PRIORITY);
        }

        // Increase the mask count.
        // This operation wraps around on overflow.
        let prev_cnt = ALL_IRQ_MASK_CNT.fetch_add(1, Ordering::SeqCst);

        // Panic if it overflows.
        assert!(prev_cnt < usize::MAX)
    }

    unsafe fn unmask_recursive() {
        // Decrease the mask count.
        let prev_cnt = ALL_IRQ_MASK_CNT.fetch_sub(1, Ordering::SeqCst);

        // Panic if it underflows.
        assert!(prev_cnt > 0);

        // If the mask count reaches zero, decrease the `BASEPRI` priority to 64,
        // which effectively enables all IRQs which all have priority 32 or up.
        if prev_cnt == 1 {
            unsafe {
                cortex_m::register::basepri::write(config::IRQ_ENABLE_BASEPRI_PRIORITY);
                cortex_m::Peripherals::steal().SCB.set_priority(
                    cortex_m::peripheral::scb::SystemHandler::SVCall,
                    config::SVC_NORMAL_PRIORITY,
                );
            }
        }
    }
}

/// Representing interrupt(s) being masked. When the struct is dropped, the
/// masked interrupt(s) will be unmasked if no where else is still masking
/// it. See [`RecursivelyMaskable`] for details.
pub(crate) struct HeldInterrupt<I>
where
    I: RecursivelyMaskable,
{
    _phantom: PhantomData<I>,
}

impl<I> Drop for HeldInterrupt<I>
where
    I: RecursivelyMaskable,
{
    fn drop(&mut self) {
        // Safety: An instance can be created only by calling `hold()` where
        // `mask_recursive` would have been called.
        unsafe {
            I::unmask_recursive();
        }
    }
}

/// The status of some interrupt being masked should not be sent across
/// different tasks.
impl<I> !Send for HeldInterrupt<I> {}

/// That some interrupts are being masked is a holdable condition.
impl<I> Holdable for I
where
    I: RecursivelyMaskable,
{
    type GuardType = HeldInterrupt<I>;

    fn hold() -> HeldInterrupt<I> {
        I::mask_recursive();
        HeldInterrupt {
            _phantom: PhantomData,
        }
    }

    unsafe fn force_unhold() {
        I::unmask_recursive();
    }
}

/// If all types compounding a tuple are [`RecursivelyMaskable`], then the
/// tuple type is also [`RecursivelyMaskable`]. Masking follows the ordering in
/// the definition of the tuple, while unmasking follows the reverse order.
macro_rules! impl_recursively_maskable_for_tuples {
    (($($T:ident),+), ($($G:ident),+)) => {
        impl<$($T),+> RecursivelyMaskable for ($($T,)+)
        where
            $($T: RecursivelyMaskable,)+
        {
            fn mask_recursive() {
                $(
                    $T::mask_recursive();
                )+
            }

            unsafe fn unmask_recursive() {
                $(
                    $G::unmask_recursive();
                )+
            }
        }
    };
}
impl_recursively_maskable_for_tuples! {
    (T0, T1), (T1, T0)
}
impl_recursively_maskable_for_tuples! {
    (T0, T1, T2), (T2, T1, T0)
}
impl_recursively_maskable_for_tuples! {
    (T0, T1, T2, T3), (T3, T2, T1, T0)
}
impl_recursively_maskable_for_tuples! {
    (T0, T1, T2, T3, T4), (T4, T3, T2, T1, T0)
}
impl_recursively_maskable_for_tuples! {
    (T0, T1, T2, T3, T4, T5), (T5, T4, T3, T2, T1, T0)
}
impl_recursively_maskable_for_tuples! {
    (T0, T1, T2, T3, T4, T5, T6), (T6, T5, T4, T3, T2, T1, T0)
}
impl_recursively_maskable_for_tuples! {
    (T0, T1, T2, T3, T4, T5, T6, T7), (T7, T6, T5, T4, T3, T2, T1, T0)
}
impl_recursively_maskable_for_tuples! {
    (T0, T1, T2, T3, T4, T5, T6, T7, T8), (T8, T7, T6, T5, T4, T3, T2, T1, T0)
}
impl_recursively_maskable_for_tuples! {
    (T0, T1, T2, T3, T4, T5, T6, T7, T8, T9), (T9, T8, T7, T6, T5, T4, T3, T2, T1, T0)
}
