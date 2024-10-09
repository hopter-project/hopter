use crate::{config, schedule::scheduler::Scheduler, sync::Holdable};
use core::{
    marker::PhantomData,
    sync::atomic::{AtomicUsize, Ordering},
};

/// This trait allows masking an interrupt or interrupts. Normally, the
/// implementation of this trait should be generated automatically by using
/// the [`irq!`](crate::interrupt::declare::irq) macro.
///
/// To mask interrupts, call the [`mask`](MaskableIrq::mask) function, which
/// returns a mask guard. The interrupt(s) will remain masked until the guard
/// is dropped. Interrupts can be masked recursively, i.e., there is a counter
/// associtated to each interrupt. Every [`mask`](MaskableIrq::mask) call will
/// increment the counter by 1, and dropping a mask guard will decrement it by 1.
/// The interrupt will be unmasked when the counter becomes zero.
///
/// If two types `T0` and `T1` are [`MaskableIrq`], then the tuple
/// `(T0, T1)` is also [`MaskableIrq`]. The masking follows the same
/// order as in the tuple definition, i.e., mask `T0` and then `T1`. The
/// unmasking follows the reverse order, i.e., unmask `T1` and then `T0`.
///
/// [`MaskableIrq`] trait implementation is provided for tuples of
/// length up to 10.
///
/// Internally, implementing this trait must provide the definition of
/// [`__disable_recursive`](MaskableIrq::__disable_recursive) that masks the
/// interrupt and increments the counter, and the definition of
/// [`__enable_recursive`](MaskableIrq::__enable_recursive) that decrements the
/// counter and unmasks the interrupt. Again, the definition is normally
/// generated automatically by the [`irq!`](crate::interrupt::declare::irq)
/// macro. These two functions are not intended to be called from application
/// code. Instead, call [`mask`](MaskableIrq::mask) which returns a guard so
/// that the interrupt can be unmasked properly even in case of a panic.
pub trait MaskableIrq {
    /// Mask the interrupt(s) and increase the mask count by 1.
    fn __disable_recursive();

    /// Decrease the mask count by 1. Re-enable the interrupt(s) if the count
    /// reaches zero.
    ///
    /// Safety: One has to guarantee that no race condition will occur after
    /// the interrupt is enabled.
    unsafe fn __enable_recursive();

    /// Mask the interrupt(s) and return a mask guard. The interrupt(s) will be
    /// unmasked after all guards are dropped.
    fn mask() -> HeldInterrupt<Self>
    where
        Self: Sized,
    {
        Self::__disable_recursive();
        HeldInterrupt::new()
    }
}

/// The mask count for `AllIrqExceptSvc`.
static ALL_IRQ_MASK_CNT: AtomicUsize = AtomicUsize::new(0);

/// Representing all IRQs except SVC.
///
/// This is defined for application programmers' convenience to allow them mask
/// out all interrupts. Hopter's kernel never masks interrupt.
///
/// Important: When all IRQs are masked, the scheduler is also suspended.
pub struct AllIrqExceptSvc;

impl MaskableIrq for AllIrqExceptSvc {
    fn __disable_recursive() {
        // Suspend the scheduler. Forget the suspend guard to ensure that the
        // scheduler remains being suspended while all IRQs are being masked.
        //
        // Internally the scheduler also maintains a suspend counter. `hold()`
        // increments the counter by 1. By not dropping the guard, we prevent
        // the counter from being automatically decremented. We will manually
        // decrement the counter in `__enable_recursive()`.
        let sched_guard = Scheduler::hold();
        core::mem::forget(sched_guard);

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

    unsafe fn __enable_recursive() {
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

        // Safety: We incremented the scheduler suspend counter in
        // `__disable_recursive()` and forgot the suspend guard. Now we
        // manually decrement the suspend counter and resume the scheduler.
        unsafe {
            Scheduler::force_unhold();
        }
    }
}

/// Representing interrupt(s) being masked. When the struct is dropped, the
/// masked interrupt(s) will be unmasked if no where else is still masking
/// it. See [`MaskableIrq`] for details.
pub struct HeldInterrupt<I>
where
    I: MaskableIrq,
{
    _phantom: PhantomData<I>,
}

impl<I> HeldInterrupt<I>
where
    I: MaskableIrq,
{
    const fn new() -> Self {
        Self {
            _phantom: PhantomData,
        }
    }
}

impl<I> Drop for HeldInterrupt<I>
where
    I: MaskableIrq,
{
    fn drop(&mut self) {
        // Safety: An instance can be created only by calling `hold()` where
        // `mask_recursive` would have been called.
        unsafe {
            I::__enable_recursive();
        }
    }
}

/// The status of some interrupt being masked should not be sent across
/// different tasks.
impl<I> !Send for HeldInterrupt<I> {}

/// That some interrupts are being masked is a holdable condition.
impl<I> Holdable for I
where
    I: MaskableIrq,
{
    type GuardType = HeldInterrupt<I>;

    fn hold() -> HeldInterrupt<I> {
        I::__disable_recursive();
        HeldInterrupt {
            _phantom: PhantomData,
        }
    }

    unsafe fn force_unhold() {
        I::__enable_recursive();
    }
}

/// If all types compounding a tuple are [`MaskableIrq`], then the
/// tuple type is also [`MaskableIrq`]. Masking follows the ordering in
/// the definition of the tuple, while unmasking follows the reverse order.
macro_rules! impl_maskable_irq_for_tuples {
    (($($T:ident),+), ($($G:ident),+)) => {
        impl<$($T),+> MaskableIrq for ($($T,)+)
        where
            $($T: MaskableIrq,)+
        {
            fn __disable_recursive() {
                $(
                    $T::__disable_recursive();
                )+
            }

            unsafe fn __enable_recursive() {
                $(
                    $G::__enable_recursive();
                )+
            }
        }
    };
}
impl_maskable_irq_for_tuples! {
    (T0, T1), (T1, T0)
}
impl_maskable_irq_for_tuples! {
    (T0, T1, T2), (T2, T1, T0)
}
impl_maskable_irq_for_tuples! {
    (T0, T1, T2, T3), (T3, T2, T1, T0)
}
impl_maskable_irq_for_tuples! {
    (T0, T1, T2, T3, T4), (T4, T3, T2, T1, T0)
}
impl_maskable_irq_for_tuples! {
    (T0, T1, T2, T3, T4, T5), (T5, T4, T3, T2, T1, T0)
}
impl_maskable_irq_for_tuples! {
    (T0, T1, T2, T3, T4, T5, T6), (T6, T5, T4, T3, T2, T1, T0)
}
impl_maskable_irq_for_tuples! {
    (T0, T1, T2, T3, T4, T5, T6, T7), (T7, T6, T5, T4, T3, T2, T1, T0)
}
impl_maskable_irq_for_tuples! {
    (T0, T1, T2, T3, T4, T5, T6, T7, T8), (T8, T7, T6, T5, T4, T3, T2, T1, T0)
}
impl_maskable_irq_for_tuples! {
    (T0, T1, T2, T3, T4, T5, T6, T7, T8, T9), (T9, T8, T7, T6, T5, T4, T3, T2, T1, T0)
}
