use crate::{config, sync::Holdable};
use core::{
    marker::PhantomData,
    sync::atomic::{AtomicUsize, Ordering},
};

/// Representing recursively maskable interrupt(s). Recursive means one can
/// `mask_recursive` an already masked interrupt, which will increase the
/// mask count by one. `unmask_recursive` will decrease the mask count, and
/// the interrupt will be unmasked only when the count reaches zero.
/// MEMO: should suspend scheduler in these functions.
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

pub use core::sync::atomic::{AtomicUsize as __AtomicUsize, Ordering as __Ordering};
pub use paste as __paste;

/// Declare an IRQ to be used with the `IrqSafe` variant of locks, e.g.,
/// [`SpinIrqSafe`](crate::sync::SpinIrqSafe),
/// [`SpinSchedIrqSafe`](crate::sync::SpinSchedIrqSafe),
/// [`MutexIrqSafe`](crate::sync::MutexIrqSafe).
///
/// [`declare_irq`] accepts two arguments as in `declare_irq!($name, $irq)`.
/// The macro expands to produce a type with name `$name` which can be passed
/// to the type construction of `IrqSafe` locks. `$irq` should be an enum
/// variant that implements [`cortex_m::interrupt::InterruptNumber`].
///
/// # Example
/// ```rust
/// /// Produce the type `Tim2Irq`.
/// declare_irq!(Tim2Irq, stm32f4xx_hal::pac::Interrupt::TIM2);
///
/// /// The interrupt `TIM2` will be masked whenever the spin lock is acquired.
/// static TIMER: SpinIrqSafe<stm32f4xx_hal::pac::TIM2>, Tim2Irq>
///     = SpinIrqSafe::new(None);
/// ```
#[macro_export]
macro_rules! declare_irq {
    ($name:ident, $irq:path) => {
        hopter::interrupt::mask::__paste::paste! {
            #[allow(non_upper_case_globals)]
            static [<__ $name _MASK_CNT>]: hopter::interrupt::mask::__AtomicUsize
                = hopter::interrupt::mask::__AtomicUsize::new(0);

            pub struct $name {}

            impl hopter::interrupt::mask::RecursivelyMaskable for $name {
                fn mask_recursive() {
                    cortex_m::peripheral::NVIC::mask($irq);
                    let prev_cnt = [<__ $name _MASK_CNT>]
                        .fetch_add(1, hopter::interrupt::mask::__Ordering::SeqCst);
                    assert!(prev_cnt < usize::MAX);
                }

                unsafe fn unmask_recursive() {
                    let prev_cnt = [<__ $name _MASK_CNT>]
                        .fetch_sub(1, hopter::interrupt::mask::__Ordering::SeqCst);
                    assert!(prev_cnt > 0);
                    if prev_cnt == 1 {
                        cortex_m::peripheral::NVIC::unmask($irq);
                    }
                }
            }
        }
    };
}

/// Representing interrupt(s) being masked. When the struct is dropped, the
/// masked interrupt(s) will be unmasked if no where else is still masking
/// it. See [`RecursivelyMaskable`] for details.
pub struct HeldInterrupt<I>
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
