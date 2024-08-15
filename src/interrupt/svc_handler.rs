//! A task invokes SVC when the kernel operation requested by the task needs
//! to run with the kernel contiguous stack. An SVC always returns back to the
//! calling task, i.e., SVC itself does not *directly* perform any context
//! switch. Based on this invariant, the SVC entry instruction sequence is
//! optimized so that only minimal context is saved. Specifically, caller-saved
//! registers are pushed to the user segmented stack, forming the trap frame,
//! while callee-saved registers are preserved by the handler functions
//! following the function call ABI. So, there is no need to make a copy of
//! callee-saved registers, unlike in [`TaskCtxt`](crate::task::TaskCtxt).
//!
//! To clarify, a task indeed invokes SVC to yield, but the actual context
//! switch is done by chaining PendSV after the SVC. Logically, the SVC still
//! returns to the yielding task, but PendSV then immediately causes the task
//! to be switched out of the CPU.

use super::trap_frame::TrapFrame;
use crate::{
    allocator, config,
    schedule::scheduler,
    task::{self, MoreStackReason, TaskLocalStorage},
    unrecoverable::{self, Lethal},
};
use core::arch::asm;
use int_enum::IntEnum;

#[repr(u8)]
#[derive(IntEnum)]
pub(crate) enum SVCNum {
    /// The calling task wants to get off from CPU. A task may voluntarily
    /// yield the CPU or it may be forced to yield when becoming blocked on a
    /// synchronization primitive.
    TaskYield = 1,
    /// The task wants to terminate and release its task struct.
    TaskDestroy = 2,
    /// The calling task wants to release its top stacklet.
    TaskLessStack = 3,
    /// The task wants to allocate dynamic memory.
    MemAlloc = 4,
    /// The task wants to free dynamic memory.
    MemFree = 5,
    /// The task wants to allocate a stacklet to run the stack unwinder.
    TaskUnwindPrepare = 252,
    /// The task wants to release the stacklet used to run the unwinder and
    /// then jump to the landing pad.
    #[cfg(feature = "unwind")]
    TaskUnwindLand = 253,
    /// The task wants to allocate a new stacklet when calling a drop handler
    /// function.
    ///
    /// IMPORTANT NOTE: The compiler toolchain assumes that the SVC number for
    /// new stacklets in this case to be 254. Changing the value requires a
    /// compiler toolchain rebuild.
    TaskMoreStackFromDrop = 254,
    /// The task wants to allocate a new stacklet when calling a function other
    /// than a drop handler.
    ///
    /// IMPORTANT NOTE: The compiler toolchain assumes that the SVC number for
    /// new stacklets in this case to be 255. Changing the value requires a
    /// compiler toolchain rebuild.
    TaskMoreStack = 255,
}

/// Context of a task when it invokes SVC. SVC context is available only during
/// the handling of an SVC. This struct should not be confused with
/// [`TaskCtxt`](crate::task::TaskCtxt), which is available when a task
/// is scheduled out, i.e., not running on the CPU.
///
/// Similar to [`TaskCtxt`](crate::task::TaskCtxt), modification to the
/// struct's fields causes the corresponding state of the task to also be
/// updated when resuming the task.
#[repr(C)]
pub(crate) struct TaskSVCCtxt {
    /// The stack pointer value when the task invokes SVC.
    pub(crate) sp: u32,
    /// The task local storage.
    pub(crate) tls: TaskLocalStorage,
}

/// The interrupt entry function for SVC. The SVC handling is slower than other
/// IRQ, because it saves some extra context in order to allocate or free
/// stacklets. The SVC always exception returns to the calling task. PendSV
/// performs context switch instead.
#[export_name = "SVCall"]
#[allow(unused)]
#[naked]
unsafe extern "C" fn svc_entry() {
    asm!(
        // Make sure SVC is invoked from thread mode, was using process stack
        // pointer, and the floating point registers s0-s15 were pushed in the
        // trap frame.
        "cmp      lr, #0xffffffed",
        "it       ne",
        "blne     {die}",
        // Execute a floating point instruction, so that the CPU will push the
        // floating point registers into the trap frame. See the "lazy stacking"
        // feature of Cortex-M4 for details.
        "vmov.f32 s0, s0",
        // Read task's stack pointer into `r0`, which is pointing the trap
        // frame, and which will become the first argument to the SVC handler.
        "mrs      r0, psp",
        // Read the task local storage fields into `r1-r3`.
        "ldr      r12, ={tls_mem_addr}",
        "ldmia    r12, {{r1-r3}}",
        // Preserve the stack pointer, the TLS, and the exception return value.
        // They become the `TaskSVCCtxt` struct.
        "push     {{r0-r3, lr}}",
        // Update the stacklet boundary to the kernel's boundary and zero out
        // other fields in the TLS.
        "ldr      r1, ={kern_stk_boundary}",
        "mov      r2, #0",
        "mov      r3, #0",
        "stmia    r12, {{r1-r3}}",
        // Load the pointer to the `TaskSVCCtxt` struct into `r1`, which
        // becomes the second argument to the SVC handler.
        "mov      r1, sp",
        // Call the SVC handler.
        "bl       {svc_handler}",
        // Restore the stack pointer and TLS of the current task.
        "pop      {{r0-r3, lr}}",
        "msr      psp, r0",
        "ldr      r12, ={tls_mem_addr}",
        "stmia    r12, {{r1-r3}}",
        // Exception return.
        "bx       lr",
        tls_mem_addr = const config::TLS_MEM_ADDR,
        kern_stk_boundary = const config::CONTIGUOUS_STACK_BOUNDARY,
        svc_handler = sym svc_handler,
        die = sym unrecoverable::die,
        options(noreturn)
    )
}

/// Get SVC number from the SVC instruction's immediate field.
fn get_svc_num(tf: &TrapFrame) -> SVCNum {
    // The saved PC points to the instruction after the SVC instruction.
    // Move it backwards by 2 bytes and we can read the SVC number.
    let task_pc = tf.gp_regs.pc;
    let svc_num_ptr = (task_pc - 2) as *const u8;
    let svc_num = unsafe { core::ptr::read_volatile(svc_num_ptr) };
    SVCNum::try_from(svc_num).unwrap_or_die()
}

/// The SVC handler. Decleared as `extern "C"` because it's called from
/// the assembly code.
extern "C" fn svc_handler(tf: &mut TrapFrame, ctxt: &mut TaskSVCCtxt) {
    match get_svc_num(tf) {
        // Task wants to yield. Mark its state as ready so that the
        // scheduler can schedule it later.
        SVCNum::TaskYield => scheduler::yield_cur_task_from_isr(),
        SVCNum::TaskDestroy => scheduler::destroy_current_task_and_schedule(),
        SVCNum::TaskLessStack => task::less_stack(tf, ctxt),
        SVCNum::TaskMoreStack => task::more_stack(tf, ctxt, MoreStackReason::Normal),
        SVCNum::TaskMoreStackFromDrop => task::more_stack(tf, ctxt, MoreStackReason::Drop),
        SVCNum::TaskUnwindPrepare => task::more_stack(tf, ctxt, MoreStackReason::Unwind),
        SVCNum::MemAlloc => allocator::task_malloc(tf),
        SVCNum::MemFree => allocator::task_free(tf),
        #[cfg(feature = "unwind")]
        SVCNum::TaskUnwindLand => task::unwind_land(tf, ctxt),
    }
}
