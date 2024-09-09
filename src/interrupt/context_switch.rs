use crate::{
    config,
    schedule::{current, scheduler::Scheduler},
    unrecoverable,
};
use core::arch::asm;

/// The interrupt entry function for PendSV. It preserves the registers and segmented
/// stack status of the previously running task. PendSV is used for context switch.
///
/// The PendSV handling is slower than other IRQ, because it saves the full context of
/// the task for the purpose of doing context switch. On the contrary, other IRQ handlers
/// will always exception return back to the previously running task from the entry
/// function, where callee-saved registers, i.e. those not pushed to the task's stack by
/// the hardware, are lazily preserved onto the kernel stack by the handler functions if
/// they need to use them.
///
/// Safety: This function should only be invoked directly by hardware PendSV exception.
///
/// FIXME: make sure lazy stacking of floating point registers is properly done.
#[export_name = "PendSV"]
#[allow(unused)]
#[naked]
unsafe extern "C" fn pendsv_entry() {
    asm!(
        // Let `r12` point to the task local storage (TLS) area.
        "ldr    r12, ={tls_mem_addr}",
        // Let `r0` hold the stacklet boundary, `r1` hold the nested drop
        // count, and `r2` hold the panic pending flag.
        "ldmia  r12, {{r0-r2}}",
        // Let `r3` hold the previously running task's stack pointer.
        "mrs    r3, psp",
        // Let `r12` hold the address of `CUR_TASK_CTXT_PTR`.
        "movw   r12, :lower16:{cur_task}",
        "movt   r12, :upper16:{cur_task}",
        // Let `r12` hold `CUR_TASK_CTXT_PTR`, which is a pointer.
        "ldr    r12, [r12]",
        // Preserve the TLS, stacklet boundary, and register `r4-r11`.
        // Register `r0-r3` and `r12` are pushed by hardware onto the task's stack.
        "stmia  r12!, {{r0-r3, r4-r11}}",
        // Preserve the floating point registers `s16-s31`.
        // Register `s0-s15` and `fpscr` are pushed by hardware onto the task's stack.
        "vstmia r12!, {{s16-s31}}",
        // Update the stacklet boundary to the kernel's boundary and zero out
        // other fields in the TLS.
        "ldr    r0, ={kern_stk_boundary}",
        "mov    r1, #0",
        "mov    r2, #0",
        "ldr    r12, ={tls_mem_addr}",
        "stmia  r12, {{r0-r2}}",
        // Copy the exception return pattern into `r0`, which becomes the argument to
        // the handler function.
        "mov    r0, lr",
        // Call the handler function.
        "bl     {pendsv_handler}",
        // Let `r12` hold the address of `CUR_TASK_CTXT_PTR`.
        "movw   r12, :lower16:{cur_task}",
        "movt   r12, :upper16:{cur_task}",
        // Let `r12` hold `CUR_TASK_CTXT_PTR`, which is a pointer.
        // The pointer content should have been updated by the scheduler.
        "ldr    r12, [r12]",
        // Let `r0-r2` hold the TLS fields and `r3` hold the task's stack pointer.
        // Restore the value in r4-r11.
        "ldmia  r12!, {{r0-r3, r4-r11}}",
        // Restore the task's stack pointer.
        "msr    psp, r3",
        // Restore the task's TLS storage.
        "ldr    r3, ={tls_mem_addr}",
        "stmia  r3, {{r0-r2}}",
        // Restore the task's floating point registers s16-s31.
        "vldmia r12!, {{s16-s31}}",
        // Sanity check that the kernel stack pointer is at the bottom.
        "mrs    r3, msp",
        "ldr    r2, ={kern_stk_bottom}",
        "cmp    r2, r3",
        // Call `unrecoverable::die` if the check fails.
        "bne    0f",
        // Perform exception return, assuming that the task has floating
        // point context. Register r0-r3, r12, lr, s0-s15, and fpscr will
        // be restored from the trap frame on the task's stack.
        "ldr    lr, ={ex_ret_to_psp_with_fp}",
        "bx     lr",
        // Call `unrecoverable::die`.
        "0:",
        "bl     {die}",
        "udf    #254",
        cur_task = sym current::CUR_TASK_CTXT_PTR,
        tls_mem_addr = const config::__TLS_MEM_ADDR,
        kern_stk_boundary = const config::__CONTIGUOUS_STACK_BOUNDARY,
        pendsv_handler = sym pendsv_handler,
        kern_stk_bottom = const config::_CONTIGUOUS_STACK_BOTTOM,
        ex_ret_to_psp_with_fp = const 0xffffffedu32,
        die = sym unrecoverable::die,
        options(noreturn)
    )
}

/// Make sure PendVS is invoked from thread mode, was using process stack pointer,
/// and the floating point registers s0-s15 were pushed in the trap frame.
fn die_if_unexpected_pendsv(ex_ret_lr: u32) {
    if ex_ret_lr != 0xffffffed {
        unrecoverable::die();
    }
}

/// The PendSV handler. Decleared as `extern "C"` because it is called from
/// the assembly code.
extern "C" fn pendsv_handler(ex_ret_lr: u32) {
    die_if_unexpected_pendsv(ex_ret_lr);

    // The `CUR_TASK_CTXT_PTR` pointer will be updated to reflect the next
    // chosen task to run.
    Scheduler::pick_next();
}
