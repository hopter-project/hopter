use super::super::{allocator, config, schedule};
use alloc::boxed::Box;
use core::sync::atomic::AtomicPtr;

#[no_mangle]
pub extern "C" fn entry() -> ! {
    allocator::init_allocator();

    let mut cp = cortex_m::Peripherals::take().unwrap();

    unsafe {
        cp.SCB.set_priority(
            cortex_m::peripheral::scb::SystemHandler::SVCall,
            config::SVC_HIGH_PRIORITY,
        );
        cp.SCB.set_priority(
            cortex_m::peripheral::scb::SystemHandler::PendSV,
            config::CTXT_SWITCH_PRIORITY,
        );
        cortex_m::register::basepri::write(config::IRQ_BASEPRI_DISABLE_PRIORITY);
    }

    cp.SCB.enable_fpu();

    let boxed_cp = Box::new(cp);
    let raw_cp = AtomicPtr::new(Box::into_raw(boxed_cp) as *mut u8);

    extern "C" {
        fn __main_trampoline(arg: AtomicPtr<u8>);
    }

    unsafe {
        schedule::start_task(
            1,
            move |_| __main_trampoline(raw_cp),
            (),
            0,
            config::MAIN_TASK_PRIORITY,
        )
        .unwrap();
        schedule::start_scheduler();
    }
}
