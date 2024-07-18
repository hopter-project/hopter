use crate::{allocator, config, schedule, task, unrecoverable::Lethal};
use alloc::boxed::Box;
use core::sync::atomic::AtomicPtr;
use cortex_m::peripheral::scb::SystemHandler;

#[no_mangle]
pub extern "C" fn entry() -> ! {
    allocator::init_allocator();

    let mut cp = cortex_m::Peripherals::take().unwrap();

    unsafe {
        cp.SCB.set_priority(
            cortex_m::peripheral::scb::SystemHandler::SVCall,
            config::SVC_RAISED_PRIORITY,
        );
        cp.SCB.set_priority(
            cortex_m::peripheral::scb::SystemHandler::PendSV,
            config::PENDSV_PRIORITY,
        );

        cp.SCB
            .set_priority(SystemHandler::SysTick, config::SYSTICK_PRIORITY);

        // Circumvent compiler bug.
        // use cortex_m::peripheral::syst::SystClkSource;
        // cp.SYST.set_clock_source(SystClkSource::Core);
        let val = cp.SYST.csr.read();
        let val = val | (1 << 2);
        cp.SYST.csr.write(val);

        cp.SYST.set_reload(168_000);
        cp.SYST.clear_current();
        cp.SYST.enable_counter();
        cp.SYST.enable_interrupt();

        cortex_m::register::basepri::write(config::IRQ_DISABLE_BASEPRI_PRIORITY);
    }

    cp.SCB.enable_fpu();

    let boxed_cp = Box::new(cp);
    let raw_cp = AtomicPtr::new(Box::into_raw(boxed_cp) as *mut u8);

    extern "C" {
        fn __main_trampoline(arg: AtomicPtr<u8>);
    }

    unsafe {
        task::build()
            .set_id(1)
            .set_entry(move || __main_trampoline(raw_cp))
            .set_stack_size(config::MAIN_TASK_INITIAL_STACK_SIZE)
            .set_priority(config::MAIN_TASK_PRIORITY)
            .spawn()
            .unwrap_or_die();
        schedule::start_scheduler();
    }
}
