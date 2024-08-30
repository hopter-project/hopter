#[doc(hidden)]
pub use core::sync::atomic::{AtomicUsize as __AtomicUsize, Ordering as __Ordering};
#[doc(hidden)]
pub use paste as __paste;

/// Declare an IRQ to be used with the `IrqSafe` variant of locks, e.g.,
/// [`SpinIrqSafe`](crate::sync::SpinIrqSafe),
/// [`SpinSchedIrqSafe`](crate::sync::SpinSchedIrqSafe),
/// [`MutexIrqSafe`](crate::sync::MutexIrqSafe).
///
/// [`irq`] accepts two arguments as in `irq!($name, $irq_num)`.
/// The macro expands to produce a type with name `$name` which can be passed
/// to the type construction of `IrqSafe` locks. `$irq_num` should be an enum
/// variant that implements [`cortex_m::interrupt::InterruptNumber`].
///
/// # Example
/// ```rust
/// /// Produce the type `Tim2Irq`.
/// irq!(Tim2Irq, stm32f4xx_hal::pac::Interrupt::TIM2);
///
/// /// The interrupt `TIM2` will be masked whenever the spin lock is acquired.
/// static TIMER: SpinIrqSafe<stm32f4xx_hal::pac::TIM2>, Tim2Irq>
///     = SpinIrqSafe::new(None);
/// ```
#[doc(hidden)]
#[macro_export]
macro_rules! __macro_impl_declare_irq {
    ($name:ident, $irq:path) => {
        $crate::interrupt::declare::__paste::paste! {
            #[allow(non_upper_case_globals)]
            static [<__ $name _MASK_CNT>]: $crate::interrupt::declare::__AtomicUsize
                = $crate::interrupt::declare::__AtomicUsize::new(0);

            pub struct $name {}

            impl $crate::interrupt::mask::RecursivelyMaskable for $name {
                fn mask_recursive() {
                    cortex_m::peripheral::NVIC::mask($irq);
                    let prev_cnt = [<__ $name _MASK_CNT>]
                        .fetch_add(1, $crate::interrupt::declare::__Ordering::SeqCst);
                    assert!(prev_cnt < usize::MAX);
                }

                unsafe fn unmask_recursive() {
                    let prev_cnt = [<__ $name _MASK_CNT>]
                        .fetch_sub(1, $crate::interrupt::declare::__Ordering::SeqCst);
                    assert!(prev_cnt > 0);
                    if prev_cnt == 1 {
                        cortex_m::peripheral::NVIC::unmask($irq);
                    }
                }
            }
        }
    };
}

#[doc(inline)]
pub use __macro_impl_declare_irq as irq;

#[doc(inline)]
pub use hopter_proc_macro::handler;
