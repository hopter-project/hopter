use super::trap_frame::TrapFrame;
use crate::{config, unwind};
use core::arch::asm;

/// Prepare r0 register to point to the trap frame, so that later we can
/// examine it.
#[export_name = "HardFaultTrampoline"]
#[naked]
pub unsafe extern "C" fn hardfault_trampoline() {
    asm!(
        // See whether it was running with MSP or PSP before the hardfault.
        "mov r0, lr",
        "mov r1, #4",
        "tst r0, r1",
        "bne 0f",
        // Was running with MSP.
        "mrs r0, MSP",
        "b {hardfault_handler}",
        // Was running with PSP.
        "0:",
        "mrs r0, PSP",
        // Jump to and loop in the hardfault handler.
        "b {hardfault_handler}",
        hardfault_handler = sym hardfault_handler,
        options(noreturn)
    )
}

/// Loop if we run into a hardfault.
#[export_name = "HardFault"]
#[naked]
pub unsafe extern "C" fn hardfault_handler(_ef: &TrapFrame) -> ! {
    asm!("0:", "b 0b", options(noreturn))
}

/// Loop if default handler is invoked. This means we saw an IRQ but is not
/// prepared to handle it.
#[export_name = "DefaultHandler"]
#[naked]
pub unsafe extern "C" fn default_handler(_ex_num: i16) {
    asm!("0:", "b 0b", options(noreturn))
}

extern "C" fn irq_handler_trampoline(handler_func_ptr: u32) {
    let saved_is_handler_unwinding = unwind::unwind::save_and_clear_isr_unwinding();

    // Following the documentation, we `as`-cast to a raw pointer before
    // `transmute`ing to a function pointer. This avoids an integer-to-pointer
    // `transmute`, which can be problematic. Transmuting between raw pointers
    // and function pointers (i.e., two pointer types) is fine.
    let handler_func_ptr = handler_func_ptr as *const ();
    let handler_func =
        unsafe { core::mem::transmute::<*const (), extern "C" fn()>(handler_func_ptr) };

    let _ = unwind::unw_catch::catch_unwind_with_arg(|_| handler_func(), ());

    if saved_is_handler_unwinding {
        unwind::unwind::set_isr_unwinding(true);
    }
}

/// Entry point for servicing an IRQ, which will never do context switch.
/// After the IRQ is serviced, it will return back to the currently running task.
/// Caller-saved registers are already pushed onto the task's stack by the
/// hardware. Callee-saved registers are preserved by the handler functions
/// if they need to use them.
#[naked]
pub unsafe extern "C" fn fast_irq_entry(handler_func_ptr: u32) {
    asm!(
        // Preserve the user task's stacklet boundary and exception return value.
        "ldr r3, ={stklet_boundary_mem_addr}",
        "ldr r1, [r3]",
        "push {{r1, lr}}",
        // Set the kernel stacklet boundary.
        "ldr r2, ={kern_stk_boundary}",
        "str r2, [r3]",
        // Let the handler return to the exit sequence.
        "ldr lr, ={irq_fast_exit}",
        // Run the IRQ handler.
        "b   {handler_trampoline}",
        stklet_boundary_mem_addr = const config::STACKLET_BOUNDARY_MEM_ADDR,
        kern_stk_boundary = const config::CONTIGUOUS_STACK_BOUNDARY,
        irq_fast_exit = sym fast_irq_exit,
        handler_trampoline = sym irq_handler_trampoline,
        options(noreturn)
    )
}

/// Exception return back to the currently running task. Assuming that the
/// system is running with FPU and the task has floating point context.
#[naked]
pub unsafe extern "C" fn fast_irq_exit() {
    asm!(
        // Restore user task's stacklet boundary.
        "pop {{r1, lr}}",
        "ldr r2, ={stklet_boundary_mem_addr}",
        "str r1, [r2]",
        // Exception return.
        "bx  lr",
        stklet_boundary_mem_addr = const config::STACKLET_BOUNDARY_MEM_ADDR,
        options(noreturn)
    )
}
