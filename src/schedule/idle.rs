use super::super::{
    config,
    interrupt::svc,
    sync::{SpinSchedSafe, SpinSchedSafeGuard},
};
use alloc::{sync::Arc, vec::Vec};

pub trait IdleCallback: Send + Sync {
    /// Invoked every time the idle task is switched on to the CPU.
    fn idle_begin_callback(&self) {}
    /// Invoked every time the idle task is switched out of the CPU.
    fn idle_end_callback(&self) {}
}

/// Callbacks to invoke when the idle task is switched in or out.
static IDLE_CALLBACKS: SpinSchedSafe<Vec<Arc<dyn IdleCallback>>> = SpinSchedSafe::new(Vec::new());

pub fn insert_idle_callback(callback: Arc<dyn IdleCallback>) {
    IDLE_CALLBACKS.lock_now_or_die().push(callback);
}

pub(super) fn lock_idle_callbacks() -> SpinSchedSafeGuard<'static, Vec<Arc<dyn IdleCallback>>> {
    IDLE_CALLBACKS.lock_now_or_die()
}

/// The idle task. Just endlessly yield itself so that whenever a task becomes
/// ready, that task will be chosen by the scheduler to run.
pub(super) unsafe extern "C" fn idle() -> ! {
    super::mark_scheduler_started();

    // Enable interrupt.
    unsafe {
        cortex_m::register::basepri::write(config::IRQ_ENABLE_BASEPRI_PRIORITY);
        cortex_m::Peripherals::steal().SCB.set_priority(
            cortex_m::peripheral::scb::SystemHandler::SVCall,
            config::SVC_NORMAL_PRIORITY,
        );
    }

    svc::svc_yield_current_task();
    loop {}
}
