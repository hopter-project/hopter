//! The module performs the initialization before running the user defined main
//! function.

use crate::{allocator, config, schedule::scheduler::Scheduler, task, unrecoverable::Lethal};
use alloc::boxed::Box;
use core::sync::atomic::AtomicPtr;
use cortex_m::peripheral::scb::SystemHandler;

/// The very first Rust function executed.
pub(super) extern "C" fn system_start() -> ! {
    allocator::initialize();

    let mut cp = unsafe { cortex_m::Peripherals::steal() };

    // Configure system call and context switch exception priority.
    unsafe {
        cp.SCB
            .set_priority(SystemHandler::SVCall, config::SVC_NORMAL_PRIORITY);
        cp.SCB
            .set_priority(SystemHandler::PendSV, config::PENDSV_PRIORITY);
        cortex_m::register::basepri::write(config::IRQ_ENABLE_BASEPRI_PRIORITY);
    }

    cp.SCB.enable_fpu();

    // Spawn the main task. The task will not be executed until we start the
    // scheduler.
    task::build()
        .set_id(config::MAIN_TASK_ID)
        .set_entry(move || main_task(cp))
        .set_stack_init_size(config::MAIN_TASK_INITIAL_STACK_SIZE)
        .set_priority(config::MAIN_TASK_PRIORITY)
        .spawn()
        .unwrap_or_die();

    // Start the scheduler. It will transform the current bootstrap thread into
    // the idle task context and then perform a context switch to run the main
    // task.
    unsafe {
        Scheduler::start();
    }
}

fn enable_systick(cp: &mut cortex_m::Peripherals) {
    // Manually set the config register to circumvent compiler bug, otherwise
    // there will be a compile error related to debug info generation.
    // The code is equivalenet to the following:
    // ```
    // use cortex_m::peripheral::syst::SystClkSource;
    // cp.SYST.set_clock_source(SystClkSource::Core);
    // ```
    let val = cp.SYST.csr.read();
    let val = val | (1 << 2);
    unsafe {
        cp.SYST.csr.write(val);
    }

    // Trigger an interrupt for every 1 millisecond.
    cp.SYST.set_reload(config::SYSTICK_FREQUENCY_HZ / 1000);
    cp.SYST.clear_current();
    cp.SYST.enable_counter();

    // Enable interrupt.
    unsafe {
        cp.SCB
            .set_priority(SystemHandler::SysTick, config::SYSTICK_PRIORITY);
    }
    cp.SYST.enable_interrupt();
}

extern "C" {
    /// A glue function that calls to the user defined main function with
    /// the [`#[main]`](crate::task::main) attribute.
    fn __main_trampoline(arg: AtomicPtr<u8>);
}

/// The first non-idle task run by the scheduler. It enables SysTick and then
/// calls the user defined main function with the [`#[main]`](crate::task::main)
/// attribute.
fn main_task(mut cp: cortex_m::Peripherals) {
    enable_systick(&mut cp);

    let boxed_cp = Box::new(cp);
    let raw_cp = AtomicPtr::new(Box::into_raw(boxed_cp) as *mut u8);
    unsafe { __main_trampoline(raw_cp) }
}
