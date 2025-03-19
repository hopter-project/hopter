use crate::sync::Holdable;
use core::marker::PhantomData;

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
