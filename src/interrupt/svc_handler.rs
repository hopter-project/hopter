//! A task invokes SVC when the kernel operation requested by the task needs
//! to run with the kernel contiguous stack. An SVC always returns back to the
//! calling task, i.e., SVC itself does not *directly* perform any context
//! switch. Based on this invariant, the SVC entry instruction sequence is
//! optimized so that only minimal context is saved. Specifically, caller-saved
//! registers are pushed to the user segmented stack, forming the trap frame,
//! while callee-saved registers are preserved by the handler functions
//! following the function call ABI. So, there is no need to make a copy of
//! callee-saved registers, unlike in [`TaskCtxt`](super::super::task::TaskCtxt).
//!
//! To clarify, a task indeed invokes SVC to yield, but the actual context
//! switch is done by chaining PendSV after the SVC. Logically, the SVC still
//! returns to the yielding task, but PendSV then immediately causes the task
//! to be switched out of the CPU.

use super::super::{
    allocator, config, schedule, task,
    unrecoverable::{self, Lethal},
};
use super::trap_frame::TrapFrame;
use core::arch::asm;
use int_enum::IntEnum;

#[repr(u8)]
#[derive(IntEnum)]
pub(in super::super) enum SVCNum {
    /// The calling task wants to yield the CPU. The yielded task will become
    /// ready immediately.
    TaskYield = 1,
    /// The calling task wants to block itself until being notified in the
    /// future.
    TaskBlock = 2,
    /// The calling task wants to release its top stacklet.
    TaskLessStack = 3,
    /// The task wants to allocate dynamic memory.
    MemAlloc = 4,
    /// The task wants to free dynamic memory.
    MemFree = 5,
    /// The task wants to terminate and release its task struct.
    TaskDestroy = 8,
    /// The task wants to allocate a stacklet to run the stack unwinder.
    TaskUnwindPrepare = 253,
    /// The task wants to release the stacklet used to run the unwinder and
    /// then jump to the landing pad.
    TaskUnwindLand = 254,
    /// The task wants to allocate a new stacklet.
    /// IMPORTANT NOTE: The compiler toolchain assumes that the SVC number for
    /// allocating new stacklets to be 255. Changing the value requires a
    /// compiler toolchain rebuild.
    TaskMoreStack = 255,
}

/// Context of a task when it invokes SVC. SVC context is available only during
/// the handling of an SVC. This struct should not be confused with
/// [`TaskCtxt`](super::super::task::TaskCtxt), which is available when a task
/// is scheduled out, i.e., not running on the CPU.
///
/// Similar to [`TaskCtxt`](super::super::task::TaskCtxt), modification to the
/// struct's fields causes the corresponding state of the task to also be
/// updated when resuming the task.
#[repr(C)]
pub(in super::super) struct TaskSVCCtxt {
    /// The stack pointer value when the task invokes SVC.
    pub(in super::super) sp: u32,
    /// The boundary address of the top stacklet when the task invokes SVC.
    pub(in super::super) stklet_bound: u32,
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
        "cmp  lr, #0xffffffed",
        "it   ne",
        "blne {die}",
        // Execute a floating point instruction, so that the CPU will push the
        // floating point registers into the trap frame. See the "lazy stacking"
        // feature of Cortex-M4 for details.
        "vmov.f32 s0, s0",
        // Read task's stack pointer into `r0`, which is pointing the trap
        // frame, and which will become the first argument to the SVC handler.
        "mrs  r0, psp",
        // Read task's stacklet boundary into `r1`.
        "ldr  r3, ={stklet_boundary_mem_addr}",
        "ldr  r1, [r3]",
        // Preserve the two above and also the exception return value.
        // They become the `TaskSVCCtxt` struct.
        "push {{r0, r1, lr}}",
        // Update the stacklet boundary to the kernel's boundary.
        "ldr  r2, ={kern_stk_boundary}",
        "str  r2, [r3]",
        // Load the pointer to the `TaskSVCCtxt` struct into `r1`, which
        // becomes the second argument to the SVC handler.
        "mov  r1, sp",
        // Call the SVC handler.
        "bl   {svc_handler}",
        // Restore the stack pointer and stacklet boundary of the current task.
        "pop  {{r0, r1, lr}}",
        "msr  psp, r0",
        "ldr  r0, ={stklet_boundary_mem_addr}",
        "str  r1, [r0]",
        // Exception return.
        "bx   lr",
        stklet_boundary_mem_addr = const config::STACKLET_BOUNDARY_MEM_ADDR,
        kern_stk_boundary = const config::KERNEL_STACK_BOUNDARY,
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
        SVCNum::TaskYield => schedule::yield_task(),
        SVCNum::TaskBlock => schedule::block_task(),
        SVCNum::TaskMoreStack => task::more_stack(tf, ctxt),
        SVCNum::TaskLessStack => task::less_stack(tf, ctxt),
        SVCNum::MemAlloc => allocator::task_malloc(tf),
        SVCNum::MemFree => allocator::task_free(tf),
        SVCNum::TaskDestroy => schedule::destroy_current_task_and_schedule(),
        SVCNum::TaskUnwindPrepare => task::more_stack(tf, ctxt),
        SVCNum::TaskUnwindLand => task::unwind_land(tf, ctxt),
    }
}
