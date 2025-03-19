use crate::{config, time};
use core::arch::asm;

#[naked]
#[export_name = "SysTick"]
unsafe extern "C" fn systick_entry() {
    asm!(
        // Preserve the task local storage (TLS) fields and exception return value.
        "ldr   r0, ={tls_mem_addr}",
        "ldmia r0!, {{r1-r3}}",
        "push  {{r1-r3, lr}}",
        // Set the kernel stacklet boundary and clear out other fields in the TLS.
        "ldr   r0, ={tls_mem_addr}",
        "ldr   r1, ={cont_stk_boundary}",
        "movs  r2, #0",
        "str   r1, [r0]",
        "str   r2, [r0, #4]",
        "str   r2, [r0, #8]",
        // Run the IRQ handler.
        "bl    {systick_handler}",
        // Restore the task local storage (TLS) fields and exception return value.
        "pop   {{r1-r3}}",
        "ldr   r0, ={tls_mem_addr}",
        "stmia r0!, {{r1-r3}}",
        // Exception return.
        "pop   {{pc}}",
        tls_mem_addr = const config::__TLS_MEM_ADDR,
        cont_stk_boundary = const config::__CONTIGUOUS_STACK_BOUNDARY,
        systick_handler = sym systick_handler,
        options(noreturn)
    )
}

/// We simply need to advance the tick count when SysTick fires.
unsafe extern "C" fn systick_handler() {
    time::advance_tick();
    time::wake_sleeping_tasks();
}
