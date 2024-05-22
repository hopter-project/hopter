use super::super::{config, schedule, task::TaskCtxt};
use core::arch::asm;

/// The interrupt entry function for PendSV. It preserves the registers and segmented
/// stack status of the previously running task.
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
        // Let `r0` hold the previously running task's stacklet boundary.
        "ldr r0, ={stklet_boundary_mem_addr}",
        "ldr r0, [r0]",
        // Let `r3` hold the address of `CUR_TASK_REGS`.
        "movw r3, :lower16:{cur_task}",
        "movt r3, :upper16:{cur_task}",
        // Let `r3` hold `CUR_TASK_REGS`, which is a pointer.
        "ldr  r3, [r3]",
        // Let `r1` hold the previously running task's stack pointer.
        "mrs r1, psp",
        // Preserve the stack pointer, stacklet boundary, and register `r4-r11`.
        // Register `r0-r3` and `r12` are pushed by hardware onto the task's stack.
        "stmia r3!, {{r0-r1, r4-r11}}",
        // Preserve the floating point registers `s16-s31`.
        // Register `s0-s15` and `fpscr` are pushed by hardware onto the task's stack.
        "vstmia r3!, {{s16-s31}}",
        // Update the stacklet boundary to the kernel's boundary.
        "ldr r2, ={kern_stk_boundary}",
        "ldr r3, ={stklet_boundary_mem_addr}",
        "str r2, [r3]",
        // Copy the exception return pattern into `r0`, which becomes the argument to
        // the handler function.
        "mov r0, lr",
        // Call the handler function.
        "bl {pendsv_handler}",
        // `r0` is holding the content of `CUR_TASK_REGS`.
        // Let `r1`` hold the task's stacklet boundary.
        // Let `r2`` hold the task's stack pointer.
        // Restore the value in r4-r11.
        "ldmia r0!, {{r1-r2, r4-r11}}",
        // Restore the task's stack pointer.
        "msr psp, r2",
        // Restore the task's stacklet boundary.
        "ldr r2, ={stklet_boundary_mem_addr}",
        "str r1, [r2]",
        // Restore the task's floating point registers s16-s31.
        "vldmia r0!, {{s16-s31}}",
        // Sanity check that the kernel stack pointer is at the bottom.
        "mrs r3, msp",
        "ldr r2, ={kern_stk_bottom}",
        "cmp r2, r3",
        // Infinite loop if the check fails.
        "bne 0f",
        // Perform exception return, assuming that the task has floating
        // point context. Register r0-r3, r12, lr, s0-s15, and fpscr will
        // be restored from the trap frame on the task's stack.
        "ldr lr, ={ex_ret_to_psp_with_fp}",
        "bx lr",
        // Infinite loop.
        "0:",
        "b 0b",
        cur_task = sym schedule::CUR_TASK_REGS,
        stklet_boundary_mem_addr = const config::STACKLET_BOUNDARY_MEM_ADDR,
        kern_stk_boundary = const config::CONTIGUOUS_STACK_BOUNDARY,
        pendsv_handler = sym pendsv_handler,
        kern_stk_bottom = const config::CONTIGUOUS_STACK_BOTTOM,
        ex_ret_to_psp_with_fp = const 0xffffffedu32,
        options(noreturn)
    )
}

/// Make sure PendVS is invoked from thread mode, was using process stack pointer,
/// and the floating point registers s0-s15 were pushed in the trap frame.
fn die_if_unexpected_pendsv(ex_ret_lr: u32) {
    if ex_ret_lr != 0xffffffed {
        loop {}
    }
}

/// The PendSV handler. Decleared as `extern "C"` because it's called from
/// the assembly code.
extern "C" fn pendsv_handler(ex_ret_lr: u32) -> *mut TaskCtxt {
    die_if_unexpected_pendsv(ex_ret_lr);

    schedule::schedule()
}
