use crate::config;
use core::arch::asm;

extern "C" fn handler_trampoline(handler_func_ptr: u32) {
    #[cfg(feature = "unwind")]
    use crate::unwind;

    #[cfg(feature = "unwind")]
    let saved_is_handler_unwinding = unwind::unwind::save_and_clear_isr_unwinding();

    // Following the documentation, we `as`-cast to a raw pointer before
    // `transmute`ing to a function pointer. This avoids an integer-to-pointer
    // `transmute`, which can be problematic. Transmuting between raw pointers
    // and function pointers (i.e., two pointer types) is fine.
    let handler_func_ptr = handler_func_ptr as *const ();
    let handler_func =
        unsafe { core::mem::transmute::<*const (), extern "C" fn()>(handler_func_ptr) };

    #[cfg(not(feature = "unwind"))]
    handler_func();

    #[cfg(feature = "unwind")]
    {
        let _ = unwind::unw_catch::catch_unwind(|| handler_func());
        unwind::unwind::set_isr_unwinding(saved_is_handler_unwinding);
    }
}

/// Entry point for servicing an IRQ, which will never do context switch.
/// After the IRQ is serviced, it will return back to the currently running task.
/// Caller-saved registers are already pushed onto the task's stack by the
/// hardware. Callee-saved registers are preserved by the handler functions
/// if they need to use them.
#[naked]
pub unsafe extern "C" fn entry(handler_func_ptr: u32) {
    asm!(
        // Preserve the task local storage (TLS) fields and exception return
        // value.
        "ldr   r12, ={tls_mem_addr}",
        "ldmia r12, {{r1-r3}}",
        "push  {{r1-r3, lr}}",
        // Set the kernel stacklet boundary and clear out other fields in the
        // TLS.
        "ldr   r1, ={kern_stk_boundary}",
        "mov   r2, #0",
        "mov   r3, #0",
        "stmia r12, {{r1-r3}}",
        // Let the handler return to the exit sequence.
        "ldr   lr, ={exit}",
        // Run the IRQ handler.
        "b     {handler_trampoline}",
        tls_mem_addr = const config::TLS_MEM_ADDR,
        kern_stk_boundary = const config::CONTIGUOUS_STACK_BOUNDARY,
        exit = sym exit,
        handler_trampoline = sym handler_trampoline,
        options(noreturn)
    )
}

/// Exception return back to the currently running task. Assuming that the
/// system is running with FPU and the task has floating point context.
#[naked]
unsafe extern "C" fn exit() {
    asm!(
        // Restore the task local storage (TLS) fields and exception return
        // value.
        "pop   {{r1-r3, lr}}",
        "ldr   r12, ={tls_mem_addr}",
        "stmia r12, {{r1-r3}}",
        // Exception return.
        "bx    lr",
        tls_mem_addr = const config::TLS_MEM_ADDR,
        options(noreturn)
    )
}
