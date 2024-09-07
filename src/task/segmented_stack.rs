//! The segmented stack forms a logical function call stack using a linked list
//! of small memory chunks called stacklets. The linked list grows and shrinks
//! on demand.
//!
//! The layout of a stacklet is shown below.
//!
//! ```plain
//! +--------------------+ <- Bottom              \
//! |                    |                        |
//! |     Used Space     |  (variable bytes)      |
//! |                    |                        |
//! +--------------------+ <- Stack Pointer (SP)  +- Available Size
//! |                    |                        |
//! |     Free Space     |  (variable bytes)      |
//! |                    |                        |
//! +--------------------+ <- Boundary (Top)      /
//! |        R12         |  (4 bytes)    \
//! +--------------------+               |
//! | Trap Frame Padding |  (4 bytes)    |
//! +--------------------+               +- Overhead Size
//! |     Trap Frame     |  (104 bytes)  |
//! +--------------------+               |
//! |      Metadata      |  (12 bytes)   /
//! +--------------------+ <- Stacklet Pointer
//! ```
//!
//! - `Bottom` is the bottom of the stacklet.
//! - `Boundary` is the top of the usable space. Stack allocated variables
//!   should never go beyond the `boundary`.
//! - `R12` reserves the space for the function prologue to push the R12
//!   register so that it can use R12 for scratch computation.
//! - `Trap Frame Padding` reserves the space for the CPU to push a padding
//!   for the trap frame.
//! - `Trap Frame` reserves the space for the CPU to push a trap frame.
//! - `Metadata` maintains information to link a series of stacklets as a
//!   logical stack.
//! - `Stack Pointer` points to the top of used stacklet space.
//! - `Stacklet Pointer` points to the beginning of the memory chunk, which
//!   should be used to free the memory.
//!
//! `Metadata` is an unavoidable overhead. In contrast, the other three are
//! architectural specific to Cortex-M. Some other architectures push the trap
//! frame to the kernel stack, which will eliminate the overhead space reserved
//! for the trap frame and padding. If one more scratch register is available,
//! we need not reserve space to push R12.
//!
//! [`more_stack`] and [`less_stack`] manage the growth and shrinkage of the
//! segmented stack, respectively. They assume that the compiler generates a
//! specific sequence of instructions at the beginning of each function called
//! the function prologue. See inline comments for details.
//!
//! [`unwind_land`] handles the corner case when the unwinder invokes a landing
//! pad.

use crate::{
    config,
    interrupt::{
        svc,
        svc_handler::TaskSVCCtxt,
        trap_frame::{TrapFrame, TRAP_FRAME_PAD_SIZE},
    },
    schedule::current,
    unrecoverable::{self, Lethal},
    unwind,
};
use core::{
    alloc::Layout,
    arch::asm,
    sync::atomic::{AtomicU32, AtomicUsize, Ordering},
};

#[no_mangle]
static STACK_EXTEND_COUNT: AtomicUsize = AtomicUsize::new(0);

/// Return the number of times of dynamic task call stack extension since
/// system boot. The counter will wrap around back to zero after reaching
/// `usize::MAX`.
pub fn get_stack_extend_count() -> usize {
    STACK_EXTEND_COUNT.load(Ordering::Relaxed)
}

#[no_mangle]
static ACTIVE_STACKLET_COUNT: AtomicUsize = AtomicUsize::new(0);

/// Return the number of currently existing stacklets in the system.
pub fn get_active_stacklet_count() -> usize {
    ACTIVE_STACKLET_COUNT.load(Ordering::Relaxed)
}

#[derive(PartialEq)]
pub(crate) enum MoreStackReason {
    Normal,
    Drop,
    Unwind,
}

/// The metadata kept in each stacklet that is used to chain several stacklets
/// together to form a logical function call stack.
#[repr(C)]
#[derive(Clone, Default)]
pub(crate) struct StackletMeta {
    /// The boundary address of the previous stacklet.
    pub(crate) prev_stklet_bound: u32,
    /// The final stack pointer address pointing into the previous stacklet
    /// before switching to the next stacklet.
    pub(crate) prev_sp: u32,
    /// How many times a new stacklet was allocated when running with the
    /// current stacklet.
    pub(crate) extend_cnt: u32,
    /// The size counting towards the stack usage, which will be used to
    /// compare against the stack size limit.
    pub(crate) count_size: u32,
}

/// Information related to each task's stack. Only tasks with dynamic stack
/// extension enabled need this struct.
#[derive(Default)]
pub(crate) struct StackCtrlBlock {
    /// A hash value representing the chain of stacklet allocation sites.
    call_chain_signature: AtomicU32,
    /// The places where hot-split happended, represented by the call chain
    /// signatures.
    hot_split_cause_signatures: [AtomicU32; config::HOT_SPLIT_PREVENTION_CACHE_SIZE],
    /// Additional allocation at each hot-split site to prevent it from
    /// happening again.
    add_sizes: [AtomicU32; config::HOT_SPLIT_PREVENTION_CACHE_SIZE],
    /// The eviction policy of the hot-split prevention cache is round-robin,
    /// using this index.
    round_robin_idx: AtomicUsize,
    /// Cumulative size of all stacklets allocated for a task, which does not
    /// count the overhead size in each stacklet but only application requested
    /// size.
    pub(crate) cumulated_size: AtomicU32,
}

/// Calculate the overhead size according to the stacklet layout. See the
/// layout graph for details.
const OVERHEAD_SIZE: usize = core::mem::size_of::<StackletMeta>()
    + TRAP_FRAME_PAD_SIZE
    + TRAP_FRAME_SIZE
    + R12_PRESERVE_SIZE;
const TRAP_FRAME_SIZE: usize = core::mem::size_of::<TrapFrame>();
const R12_PRESERVE_SIZE: usize = 4;

/// Offset between the stacklet metadata and the boundary.
/// See `svc_more_stack` for how offset is calculated.
const STACKLET_METADATA_BOUNDARY_OFFSET: usize = OVERHEAD_SIZE;

/// Given the boundary address of a stacklet, return the `*mut u8` pointer to
/// the stacklet.
#[cfg(feature = "unwind")]
pub(crate) fn bound_to_stklet_ptr(bound: usize) -> *mut u8 {
    (bound - STACKLET_METADATA_BOUNDARY_OFFSET) as *mut u8
}

/// Given the boundary address of a stacklet, return the raw pointer pointing
/// to the stacklet metadata.
pub(crate) fn bound_to_stklet_meta(bound: usize) -> *mut StackletMeta {
    (bound - STACKLET_METADATA_BOUNDARY_OFFSET) as *mut StackletMeta
}

/// Given the raw pointer to a stacklet, return the boundary address.
pub(crate) fn stklet_ptr_to_bound(ptr: *mut u8) -> usize {
    (ptr as usize) + STACKLET_METADATA_BOUNDARY_OFFSET
}

/// Allocate the initial stacklet for a task. Return a pair of pointers
/// pointing to the start and end of the memory chunk. The first pointer,
/// pointing to the start, should be used to call [`alloc::alloc::dealloc()`].
pub(super) fn alloc_initial_stacklet(free_size: usize) -> (*mut u8, *mut u8) {
    // Must include the overhead size for memory allocation. See the stacklet
    // layout graph for details.
    let total_size = free_size.checked_add(OVERHEAD_SIZE).unwrap_or_die();

    // Allocate the memory without initialization.
    // Safety: `total_size` is guaranteed to be non-zero because the above
    // addition has been checked to avoid overflow. The alignment is currently
    // ignored by the allocator.
    let stklet_ptr =
        unsafe { alloc::alloc::alloc(Layout::from_size_align(total_size, 4).unwrap_or_die()) };

    // Currently, it is an unrecoverable error if the allocation fails.
    unrecoverable::die_if(|| stklet_ptr.is_null());

    // The stacklet metadata region is placed at the lower address
    // boundary of each stacklet. Initialize the metadata region to its
    // default values. Specifically, the fields `prev_stklet_bound` and
    // `prev_sp` are set to zero so that the stack unwinder can identify
    // the initial stacklet as the last one to unwind.
    //
    // Safety: The stack memory is just allocated, so the current code
    // has exclusive access to the memory.
    let meta_ptr = stklet_ptr as *mut StackletMeta;
    unsafe {
        meta_ptr.write(StackletMeta::default());
    }

    // Check for the non-overflow safety condition required below.
    unrecoverable::die_if(|| total_size > isize::MAX as usize);

    // Safety: The allocation size was `total_size`, so the pointer after
    // offset must point into the same allocation. The `total_size` does not
    // overflow `isize` as checked above.
    unsafe { (stklet_ptr, stklet_ptr.add(total_size)) }
}

/// Allocate a new stacklet for the currently running task. Let the task's current
/// function continue with the new stacklet to execute its function body.
pub(crate) fn more_stack(tf: &mut TrapFrame, ctxt: &mut TaskSVCCtxt, reason: MoreStackReason) {
    if !config::ALLOW_DYNAMIC_STACK {
        unrecoverable::die();
    }

    // The compiler generates the following function prologue:
    //
    //   00: f04f 5c00 mov.w  r12, #0x20000000 ; take stacklet boundary address
    //   04: f8dc c000 ldr.w  r12, [r12]       ; read stacklet boundary
    //   08: ebbd 0c0c subs.w r12, sp, r12     ; calculate remaining free size
    //   0c: f1bc 0f18 cmp.w  r12, #24         ; compare with requested size
    //   10: da02      bge.n  func_body        ; if enough free space, goto func_body
    //   12: dfff      svc    #255             ; otherwise, invoke SVC
    //   14: xxxx      .short function_stack_size (right shifted by 2) ; <- preserved PC
    //   16: xxxx      .short function_arg_size (right shifted by 2)   ; <- PC + 2
    // func_body:                                                      ;
    //   18: ...                                                       ; <- PC + 4
    //
    // The two `.short` constants are the parameters to allocate new stacklet.
    // Since the stack frame size and argument size are always multiples of 4,
    // the constant stored are right shifted by 4, so that we can represent a
    // larger range with 16 bits.

    // Get the stack frame size according to the layout above.
    fn get_stack_frame_size(tf: &TrapFrame) -> u32 {
        let task_pc = tf.gp_regs.pc;
        let half_word_ptr = task_pc as *const u16;
        let half_word = unsafe { core::ptr::read_volatile(half_word_ptr) };
        (half_word as u32) * 4
    }

    // Get the stack argument size according to the layout above.
    fn get_stack_arg_size(tf: &TrapFrame) -> u32 {
        let task_pc = tf.gp_regs.pc;
        let half_word_ptr = (task_pc + 2) as *const u16;
        let half_word = unsafe { core::ptr::read_volatile(half_word_ptr) };
        (half_word as u32) * 4
    }

    STACK_EXTEND_COUNT.fetch_add(1, Ordering::Relaxed);

    let mut stk_frame_size = get_stack_frame_size(tf);
    let stk_arg_size = get_stack_arg_size(tf);

    // The current stacklet boundary.
    let bound = ctxt.tls.stklet_bound;

    // Retrieve the current stacklet metadata.
    let cur_meta_ptr = bound_to_stklet_meta(bound as usize);
    let cur_meta = unsafe { &mut *cur_meta_ptr };

    // Whether we should abort the new stacklet allocation.
    let mut abort = false;

    current::with_current_task(|cur_task| {
        // Define a closure to be invoked when the stack size limit is
        // exceeded.
        let mut handle_limit_exceed = |tf: &mut TrapFrame| {
            // If the task wants to start unwinding or is under unwinding,
            // proceed to allocate a new stacklet even if the task does not
            // enable dynamic stack extension.
            if reason == MoreStackReason::Unwind || cur_task.is_unwinding() {
            }
            // If the overflowing function is a drop handler or if any
            // active parent function is a drop handler, pend a panic. The
            // pending panic will be invoked after all drop handlers have
            // finished execution. This is done by the complier inserting
            // an epilogue to all drop handlers. See the `unwind::forced`
            // module for details. We proceed to allocate a new stacklet
            // even if the task does not enabled dynamic stack extension,
            // because we must not unwind from inside a drop handler.
            else if reason == MoreStackReason::Drop || ctxt.tls.nested_drop_cnt > 0 {
                ctxt.tls.unwind_pending = 1;
            // If the overflowing function is not a drop handler and no
            // drop handler is active, divert the function call to the
            // stack unwinding entry to forcefully unwind the task.
            } else if reason == MoreStackReason::Normal {
                if !cur_task.is_unwinding() {
                    tf.gp_regs.pc = unwind::forced::diverted_unwind as u32;

                    // Do not allocate a new stacklet if the task is going
                    // to be unwound.
                    abort = true;
                }
            }
        };

        cur_task
            // Alleviate the hot split problem if the task contains a hot-split
            // alleviation block. All tasks with dynamic stack extension
            // enabled have it.
            .with_stack_ctrl_block(|scb: &StackCtrlBlock| {
                // Increase allocation request size if hot-split happened in
                // the past at this alloaction site.
                svc_more_stack_anti_hot_split(
                    tf,
                    &mut stk_frame_size,
                    scb,
                    &mut cur_meta.extend_cnt,
                );

                // Count stack usage.
                let prev_size = scb
                    .cumulated_size
                    .fetch_add(stk_frame_size, Ordering::SeqCst);
                let updated_size = prev_size + stk_frame_size;

                // Check if stack limit is reached.
                if let Some(limit) = cur_task.get_stack_limit() {
                    if updated_size > limit as u32 {
                        handle_limit_exceed(tf);
                    }
                }
            })
            // Otherwise, the task does not enable dynamic stack extension. A
            // stacklet allocation request entails that the stack size limit
            // is exceeded.
            .unwrap_or_else(|| handle_limit_exceed(tf));
    });

    if abort {
        return;
    }

    // Total chunk size to request from malloc.
    // The overhead includes the trap frame, its padding, and the metadata block.
    let total_size = stk_frame_size as usize
        + stk_arg_size as usize
        + OVERHEAD_SIZE
        + config::STACKLET_ADDITION_ALLOC_SIZE;

    unsafe {
        // Pointer to the new stacklet.
        let stacklet_ptr =
            alloc::alloc::alloc(Layout::from_size_align(total_size, 4).unwrap_or_die());

        // Currently, it is an unrecoverable error if the allocation fails.
        unrecoverable::die_if(|| stacklet_ptr.is_null());

        // The metadata is placed at the lowest address inside the chunk.
        let meta_ptr = stacklet_ptr as *mut StackletMeta;
        meta_ptr.write(StackletMeta {
            prev_stklet_bound: ctxt.tls.stklet_bound,
            prev_sp: ctxt.sp,
            extend_cnt: 0,
            count_size: stk_frame_size,
        });

        // Below shows the layout of the previous stacklet:
        //
        // |            ... ...            |
        // |   Caller's Func Stack Frame   |
        // +-------------------------------+
        // |  Stack Arguments for Callee   |
        // +-------------------------------+
        // | Trap Frame (104 or 108 bytes) |
        // +-------------------------------+ <- prev_sp points here

        // Calculate the trap frame size. The 9th bit in `xPSR` indicates if
        // the trap frame contains a padding.
        let mut tf_size = core::mem::size_of::<TrapFrame>();
        if (tf.gp_regs.xpsr & (1 << 9)) != 0 {
            tf_size += TRAP_FRAME_PAD_SIZE;
        }

        // Pointer to the stack passed arguments inside the new stacklet.
        let dst_arg_ptr = stacklet_ptr.offset((total_size - stk_arg_size as usize) as isize);

        // Pointer to the stack passed arguments inside the previous stacklet.
        let src_arg_ptr = (ctxt.sp as usize + tf_size) as *const u8;

        // Copy the stack passed arguments.
        core::ptr::copy_nonoverlapping(src_arg_ptr, dst_arg_ptr, stk_arg_size as usize);

        // Pointer to the trap frame inside the new stacklet. This trap frame
        // will be used to exception return to the task's function body.
        let new_tf_ptr = dst_arg_ptr.offset(-(TRAP_FRAME_SIZE as isize));

        // Copy the trap frame from the previous stacklet to the new one.
        let new_tf = &mut *(new_tf_ptr as *mut TrapFrame);
        *new_tf = tf.clone();

        // Since we did not add padding for the trap frame in the new stacklet,
        // clear the 9th bit so that the hardware will assume there is no padding.
        new_tf.gp_regs.xpsr &= !(1 << 9);

        // Calculate the stacklet boundary of the new stacklet.
        let new_bound = stacklet_ptr as usize + OVERHEAD_SIZE;

        // Update the stacklet boundary and stack pointer for the current task.
        ctxt.tls.stklet_bound = new_bound as u32;
        ctxt.sp = new_tf_ptr as u32;

        // We should resume execution from the function body. See the instruction
        // layout above for `+4`.
        new_tf.gp_regs.pc = tf.gp_regs.pc + 4;

        // Set the return address so that when the function returns
        // we can take over the control to release the stacklet.
        new_tf.gp_regs.lr = svc::svc_less_stack as u32;
    }

    ACTIVE_STACKLET_COUNT.fetch_add(1, Ordering::Relaxed);
}

/// Free the current stacklet of the currently running task. Let the task return to the
/// function running with the previous stacklet.
pub(crate) fn less_stack(tf: &TrapFrame, ctxt: &mut TaskSVCCtxt) {
    if !config::ALLOW_DYNAMIC_STACK {
        unrecoverable::die();
    }

    // The current stacklet boundary.
    let bound = ctxt.tls.stklet_bound;

    unsafe {
        // Retrieve the previous stacklet information.
        let meta_ptr = bound_to_stklet_meta(bound as usize);
        let meta = &*meta_ptr;

        // Trap frame in the previous stacklet is on the stacklet top.
        let prev_tf = &mut *(meta.prev_sp as *mut TrapFrame);

        // Copy the return values to the previous trap frame.
        prev_tf.gp_regs.r0 = tf.gp_regs.r0;
        prev_tf.gp_regs.r1 = tf.gp_regs.r1;
        prev_tf.gp_regs.r2 = tf.gp_regs.r2;
        prev_tf.gp_regs.r3 = tf.gp_regs.r3;

        // Will resume execution from the returning address.
        prev_tf.gp_regs.pc = prev_tf.gp_regs.lr;

        // Restore the stacklet boundary and stack pointer to the previous stacklet.
        ctxt.tls.stklet_bound = meta.prev_stklet_bound;
        ctxt.sp = meta.prev_sp;

        current::with_current_task(|cur_task| {
            cur_task.with_stack_ctrl_block(|scb| {
                // Update hot split alleviation information.
                svc_less_stack_anti_hot_split(prev_tf, scb);

                // Update stack size usage.
                scb.cumulated_size
                    .fetch_sub(meta.count_size, Ordering::SeqCst);
            });
        });

        // The stacklet starts with the metadata.
        let stacklet_ptr = meta_ptr as *mut u8;

        // Free the current stacklet.
        // Layout is not used in the current dealloc implementation.
        alloc::alloc::dealloc(stacklet_ptr, Layout::new::<u8>());
    }

    ACTIVE_STACKLET_COUNT.fetch_sub(1, Ordering::Relaxed);
}

/// Let the task being unwound execute the landing pad.
#[cfg(feature = "unwind")]
pub fn unwind_land(tf: &TrapFrame, ctxt: &mut TaskSVCCtxt) {
    use crate::unwind::unwind::{ARMGPReg, UnwindState};

    // This SVC function must be invoked from the unwinder. The stacklet boundary
    // we get from the context is the one *used by the unwinder*. Also, by the
    // code structure of the unwinder, this is the only stacklet that has not
    // been freed by the unwinder, because this is the initial stacklet when the
    // unwinder starts to run.
    let unwinder_stklet_bound = ctxt.tls.stklet_bound;

    // Calculate the pointer pointing to the stacklet chunk.
    let unwinder_stklet_ptr = bound_to_stklet_ptr(unwinder_stklet_bound as usize);

    // The unwind state pointer is passed in `r0` when the SVC function is invoked.
    let unw_state_ptr = tf.gp_regs.r0 as *mut UnwindState;

    // The landing address is passed in `r1`.
    let land_addr = tf.gp_regs.r1;

    // Get the reference to the unwind state struct.
    // Safety: the unwind state will not be freed until the panic is caught.
    // This SVC function is invoked during unwinding, so the panic has not been
    // caught yet.
    let unw_state = unsafe { &*unw_state_ptr };

    // The stack pointer contained in the unwind state points to the stack frame
    // of the function for which we are about to invoke the landing pad. Since we
    // are going to exception return to the landing pad code, we must build a
    // trap frame. We start by moving the stack pointer down for the trap frame.
    let prev_sp = unw_state.gp_regs[ARMGPReg::SP] - TRAP_FRAME_SIZE as u32;

    // Build a trap frame at `prev_sp``.
    let prev_tf = unsafe { &mut *(prev_sp as *mut TrapFrame) };

    // The trap frame we are building contains no padding. Thus, we clear the
    // padding bit in `xpsr` so that the hardware gets to know there is no padding.
    prev_tf.gp_regs.xpsr = tf.gp_regs.xpsr;
    prev_tf.gp_regs.xpsr &= !(1 << 9);

    // `r0` and `lr` will be restored through the trap frame.
    // `r0` holds the unwind state pointer.
    prev_tf.gp_regs.r0 = unw_state.gp_regs[ARMGPReg::R0];

    // Set the `pc` in the trap frame to be the landing address, so that when we
    // exception return the task will resume at the landing pad code.
    prev_tf.gp_regs.pc = land_addr;

    // Update the stacklet boundary when we exception return to the task.
    ctxt.tls.stklet_bound = unw_state.stklet_boundary;

    // And let the task's stack pointer point to the trap frame we just built.
    ctxt.sp = prev_sp;

    // FIXME: missing anti-hotsplit operation here.

    // Free the initial stacklet of the unwinder.
    // Layout is not used in the current dealloc implementation.
    unsafe {
        alloc::alloc::dealloc(unwinder_stklet_ptr, Layout::new::<u8>());
    }
}

fn svc_less_stack_anti_hot_split(tf: &TrapFrame, scb: &StackCtrlBlock) {
    let cur_lr = tf.gp_regs.lr;

    // prev_signature = rotate_left(cur_signature ^ cur_lr)
    scb.call_chain_signature
        .fetch_update(Ordering::SeqCst, Ordering::SeqCst, |sig| {
            Some((sig ^ cur_lr).rotate_left(1))
        })
        .unwrap_or_die();
}

/// Alleviate the hot-split problem. The basic idea is that when we need to
/// allocate a new stacklet, we record the function F that triggered the
/// allocation. If we consecutively see F, it indicates that F is under hot-split.
/// We then find the function G that triggered the allocation of the current
/// stacklet in use, i.e., the stacklet that is insufficient to hold the stack
/// frame of F. We should increase the allocation size when G is called so that
/// when G (directly or indirectly) calls F there will be enough free space in
/// the stacklet to avoid the need of F to allocate a new stacklet, thus resolving
/// the hot-split.
///
/// The increased allocation size will just be enough to eliminate the hot-split
/// we see, so that the memory usage will be as efficient as possible.
///
/// We further differentiate between different calling chains to F.
/// For example, when P -> Q -> F leads to a hot-split, R -> F might not.
/// Thus, we compute the function call chain signature below to differentiate
/// calling chains and use the signature to identify hot-split point.
fn svc_more_stack_anti_hot_split(
    tf: &mut TrapFrame,
    frame_size: &mut u32,
    scb: &StackCtrlBlock,
    extend_cnt: &mut u32,
) {
    // Get the saved `lr` register from the task's trap frame. It identifies
    // which function we are currently in.
    let cur_lr = tf.gp_regs.lr;

    // new_signature = rotate_right(prev_signature) ^ cur_lr
    let prev_signature = scb
        .call_chain_signature
        .fetch_update(Ordering::SeqCst, Ordering::SeqCst, |sig| {
            Some(sig.rotate_right(1) ^ cur_lr)
        })
        .unwrap_or_die();
    let new_signature = prev_signature.rotate_right(1) ^ cur_lr;

    // If for the current signature we have decided to increase the allocation
    // size, adjust the `frame_size`.
    for (cause_signature, add_size) in scb
        .hot_split_cause_signatures
        .iter()
        .zip(scb.add_sizes.iter())
    {
        if new_signature == cause_signature.load(Ordering::SeqCst) {
            *frame_size *= add_size.load(Ordering::SeqCst);
            break;
        }
    }

    // We have a new stack expansion. Increase the counter.
    // Using wrapping add so that an overflow does not lead to a panic.
    *extend_cnt = extend_cnt.wrapping_add(1);

    // If we see a signature 4 times consecutively, we will decide that it is a
    // hot-split. Otherwise, we need to do nothing for now. Note that we must use
    // `!=` instead of `>=`, because when the calling chain is ... -> G ->* F and
    // F is currently hot-splitting, we will increase the allocation size once for
    // G, but if we use `>=` and F hot-splits for example 10 times, we will then
    // inadvertently increase the allocation for G 7 times.
    if *extend_cnt != config::HOT_SPLIT_DETECTION_THRESHOLD as u32 {
        return;
    }

    // If for the current signature we have decided to increase the allocation
    // size, but we still see another hot-split, we further increase the allocation
    // size.
    for (cause_signature, add_size) in scb
        .hot_split_cause_signatures
        .iter()
        .zip(scb.add_sizes.iter())
    {
        if cause_signature.load(Ordering::SeqCst) == prev_signature {
            add_size.fetch_add(1, Ordering::SeqCst);
            return;
        }
    }

    // Otherwise, evict one entry in the cause array and record the signature
    // to prevent future hot-split.
    let mut idx = scb.round_robin_idx.load(Ordering::SeqCst);
    scb.hot_split_cause_signatures[idx].store(prev_signature, Ordering::SeqCst);
    scb.add_sizes[idx].store(2, Ordering::SeqCst);

    // We evict the array entry using round-robin.
    idx += 1;
    if idx % config::HOT_SPLIT_PREVENTION_CACHE_SIZE == 0 {
        idx = 0;
    }
    scb.round_robin_idx.store(idx, Ordering::SeqCst);
}

/// Provide a function to satisfy the linker. This function should never be
/// invoked.
#[export_name = "__morestack_non_split"]
#[allow(unused)]
#[naked]
unsafe extern "C" fn more_stack_non_split() {
    asm!("udf #255", options(noreturn))
}
