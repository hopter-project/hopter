use crate::{
    interrupt::context_switch,
    sync::{SpinSchedSafe, SpinSchedSafeGuard},
};
use alloc::{sync::Arc, vec::Vec};

pub(crate) trait IdleCallback: Send + Sync {
    /// Invoked every time the idle task is switched on to the CPU.
    fn idle_begin(&self) {}
    /// Invoked every time the idle task is switched out of the CPU.
    fn idle_end(&self) {}
}

/// Callbacks to invoke when the idle task is switched in or out.
static IDLE_CALLBACKS: SpinSchedSafe<Vec<Arc<dyn IdleCallback>>> = SpinSchedSafe::new(Vec::new());

pub(crate) fn insert_idle_callback(callback: Arc<dyn IdleCallback>) {
    IDLE_CALLBACKS.lock_now_or_die().push(callback);
}

pub(super) fn lock_idle_callbacks() -> SpinSchedSafeGuard<'static, Vec<Arc<dyn IdleCallback>>> {
    IDLE_CALLBACKS.lock_now_or_die()
}

/// The idle task. Just endlessly yield itself so that whenever a task becomes
/// ready, that task will be chosen by the scheduler to run.
pub(super) unsafe extern "C" fn idle_task() -> ! {
    // The idle task is always executed first when the scheduler is just
    // started. A main task should always be present awaiting to run. Perform
    // a context switch to let the main task run.
    context_switch::yield_current_task();

    // If nothing to do, enter low power state.
    loop {
        cortex_m::asm::wfe();
    }
}
