use super::super::config;
use core::sync::atomic::{AtomicUsize, Ordering};

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
                config::SVC_HIGH_PRIORITY,
            );
            cortex_m::register::basepri::write(config::IRQ_BASEPRI_DISABLE_PRIORITY);
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
                cortex_m::register::basepri::write(config::IRQ_BASEPRI_ENABLE_PRIORITY);
                cortex_m::Peripherals::steal().SCB.set_priority(
                    cortex_m::peripheral::scb::SystemHandler::SVCall,
                    config::SVC_REDUCED_PRIORITY,
                );
            }
        }
    }
}
