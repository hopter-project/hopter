use super::{Holdable, RecursivelyMaskable};
use core::marker::PhantomData;

/// Representing interrupt(s) being masked. When the struct is dropped,
/// the masked interrupt(s) will be unmasked if no one else is also masking
/// it. See `RecursivelyMaskable` for details.
pub struct HeldInterrupt<I>
where
    I: RecursivelyMaskable,
{
    _phantom: PhantomData<I>,
}

/// Mask the given interrupt(s) and return a guard.
pub fn hold_interrupt<I>() -> HeldInterrupt<I>
where
    I: RecursivelyMaskable,
{
    I::mask_recursive();
    HeldInterrupt {
        _phantom: PhantomData,
    }
}

impl<I> Drop for HeldInterrupt<I>
where
    I: RecursivelyMaskable,
{
    // FIXME: this safe wrapper is not safe.
    fn drop(&mut self) {
        unsafe {
            I::unmask_recursive();
        }
    }
}

/// The status of some interrupt being masked should not be sent across
/// different tasks.
impl<I> !Send for HeldInterrupt<I> {}

/// Masking interrupts is a holdable condition.
impl<I> Holdable for I
where
    I: RecursivelyMaskable,
{
    type GuardType = HeldInterrupt<I>;

    fn hold() -> HeldInterrupt<I> {
        hold_interrupt()
    }

    unsafe fn force_unhold() {
        I::unmask_recursive();
    }
}

/// Used when no additional condition needs to be held.
impl Holdable for () {
    type GuardType = ();

    fn hold() -> () {
        ()
    }
    unsafe fn force_unhold() {}
}
