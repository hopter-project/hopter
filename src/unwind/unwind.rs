//! This module implements the unwinding of the call stack upon Rust panic.
//!
//! It uses the information (`.ARM.exidx` and `.ARM.extab` sections) from
//! the object file.
//!
//! The general flow of the unwinding procedure is as follows:
//! * A panic occurs, which jumps to the panic entry point.
//! * The panic entry point jumps to `start_unwind_entry()` which saves the initial
//!   context. It then jumps to `start_unwind()` to start unwinding.
//! * `start_unwind()` generates the state structure of the current stack frame.
//!   We can step the state through the call stack. The knowledge comes from parsing
//!   the `.ARM.exidx` and `.ARM.extab` section).
//! * `start_unwind()` skips the first several stack frames, which correspond to the
//!   panic and unwind handlers themselves. Note that we cannot unwind those frames
//!   because they contain resources that we are currently using for unwinding purposes.
//! * `start_unwind()` calls `continue_unwind()`, which contains the bulk of the
//!   unwinding logic.
//! * `continue_unwind()` iterates to the "next" stack frame (the previous frame in
//!   the call stack),
//!   and invokes its landing pad if it has one.
//! * If the landing pad is a cleanup routine, it jumps to `_Unwind_Resume()`
//!   automatically at its end. The compiler guarantees it.
//! * `_Unwind_Resume()` simply invokes `continue_unwind()`.
//! * If the landing pad is a catch block, it will then call the handler function
//!   inside which the unwinding state will be freed. It then returns to the
//!   normal execution flow.
//! * `continue_unwind()` continues iterating up the call stack until it reaches
//!   a catch block. If it reaches the bottom of the call stack without seeing a
//!   catch block, it halts.
//!
//! The implementation is inspired by `libunwind` and Theseus OS's unwinder.
use super::{
    unw_lsda::{self, LSDA},
    unw_table::{
        ExIdxEntry, /*ExTabEntry,*/ PersonalityType, Prel31, UnwindByteIter, UnwindInstrIter,
        UnwindInstruction,
    },
};
use crate::{
    boot, config,
    interrupt::{
        svc,
        trap_frame::{self, TrapFrame},
        SVCNum,
    },
    schedule, task,
    uart::{G_UART_SESSION, TIMEOUT_MS},
    unrecoverable::{self, Lethal},
};
use alloc::{boxed::Box, vec};
use core::{
    alloc::Layout,
    arch::asm,
    convert::TryFrom,
    fmt::Debug,
    mem::MaybeUninit,
    ops::{Index, IndexMut},
    panic::PanicInfo,
    sync::atomic::{AtomicBool, Ordering},
};
use cortex_m_semihosting::hprintln;
use gimli::{EndianSlice, LittleEndian};

#[cfg(feature = "debug_unwind")]
use crate::heprintln;

/// If a stack frame can be unwound, its `UnwindInfo` describes how to unwind.
#[allow(unused)]
#[derive(Debug)]
pub struct UnwindInfo<'a> {
    /// The address of the corresponding function.
    func_addr: u32,
    /// The personality routine of the corresponding function.
    /// Note however in our custom unwinder we *do not* use the
    /// personality routine.
    personality: PersonalityType,
    /// The iterator that yields unwind instructions to restore register values.
    unw_instr_iter: UnwindInstrIter,
    /// The LSDA describing the cleanup routines and exception catch blocks.
    /// Compact model that embeds the unwind instructions into the
    /// exidx entry does not have LSDA, thus the field is optional.
    lsda: Option<LSDA<EndianSlice<'a, LittleEndian>>>,
}

/// It describes whether a stack frame can be unwound. If yes, it additionally
/// contains the information needed during unwinding.
#[derive(Debug)]
pub enum UnwindAbility<'a> {
    CantUnwind,
    CanUnwind(UnwindInfo<'a>),
}

impl<'a> UnwindAbility<'a> {
    /// Return the unwind-ability from raw bytes.
    /// Arguments:
    /// - `exidx_entry` is the reference to a 2-word entry in the `.ARM.exidx` section.
    /// - `extab` is the slice of the whole `.ARM.extab` section.
    fn from_bytes(exidx_entry: &'a [u8; 8], _extab: &'a [u8]) -> Result<Self, &'static str> {
        let exidx_entry = ExIdxEntry::from_bytes(exidx_entry)?;

        // The current function might not support unwinding.
        if !exidx_entry.can_unwind() {
            return Ok(Self::CantUnwind);
        }

        // If the unwind instructions are embedded into the exidx entry,
        // then we have no LSDA.
        if exidx_entry.is_compact() {
            let func_addr = exidx_entry.get_func_addr();
            let personality = exidx_entry.get_personality();
            let instrs = exidx_entry.get_unw_instr_iter();

            Ok(Self::CanUnwind(UnwindInfo {
                func_addr,
                personality,
                unw_instr_iter: instrs,
                lsda: None,
            }))

        // The unwind instructions should be find in the extab followed
        // by an LSDA.
        } else {
            let extab_entry_addr = exidx_entry.get_extab_entry_addr() as usize;
            // let extab_start_addr = &extab[0] as *const u8 as usize;
            // let entry_offset = extab_entry_addr - extab_start_addr;
            // hprintln!("extab_entry_addr: 0x{:x?}", extab_entry_addr);
            // hprintln!("extab_start_addr: 0x{:x?}", extab_start_addr);
            // hprintln!("entry_offset: 0x{:x?}", entry_offset);
            // this is where we substitute data from the server. Need to have the bytes stored in extab
            // let (_extab_entry, _lsda_slice) = ExTabEntry::from_bytes(extab, entry_offset)?;
            // let _lsda = unw_lsda::LSDA::new(
            //     _lsda_slice,
            //     gimli::LittleEndian,
            //     exidx_entry.get_func_addr(),
            // );

            // ALEX CHANGES

            let session = match unsafe { G_UART_SESSION.as_mut() } {
                Some(s) => s,
                None => {
                    hprintln!("No session");
                    return Ok(Self::CantUnwind);
                }
            };

            hprintln!("session established");

            // first tell the server that we are handling the extab section
            let request_type: u32 = 0xAAAA;
            let data = request_type.to_le_bytes();
            match session.send(&data, TIMEOUT_MS) {
                Ok(_) => hprintln!("Sent request type"),
                Err(e) => hprintln!("Error: {:?}", e),
            };

            let data = (extab_entry_addr as u32).to_le_bytes();

            match session.send(&data, TIMEOUT_MS) {
                Ok(_) => hprintln!("Sent extab entry address"),
                Err(e) => hprintln!("Error: {:?}", e),
            };

            // in order receive:
            // 1. The bytes of the ExTabEntry.UnwindInstrIter.UnwindByteIter.bytes (needs to be stepped once)
            // 2. The lsda_slice as bytes
            // 3. The personality as u32, with extra byte for generic vs compact
            let size = session.listen(TIMEOUT_MS).unwrap();
            let mut extab_entry_bytes = vec![0; size as usize].into_boxed_slice();

            match session.receive(&mut extab_entry_bytes, TIMEOUT_MS) {
                Ok(_) => hprintln!("Received byte_iter"),
                Err(e) => hprintln!("Error: {:?}", e),
            }
            let mut unw_byte_iter = UnwindByteIter::from_box(extab_entry_bytes).unwrap();
            // need to cycle unw_byte_iter because we lose track of idx between server and MC
            unw_byte_iter.next();

            let unw_instr_iter = UnwindInstrIter::from_byte_iter(unw_byte_iter);

            hprintln!("Byte iter d : {:?}", unw_instr_iter);
            // hprintln!("Byte iter   : {:?}", _extab_entry.get_unw_instr_iter());

            // 2. The lsda_slice as bytes
            let size = session.listen(TIMEOUT_MS).unwrap();
            let mut lsda_slice_bytes = vec![0; size as usize].into_boxed_slice();

            match session.receive(&mut lsda_slice_bytes, TIMEOUT_MS) {
                Ok(_) => hprintln!("Received lsda"),
                Err(e) => hprintln!("Error: {:?}", e),
            }
            let lsda_d = unw_lsda::LSDA::from_box(
                lsda_slice_bytes,
                gimli::LittleEndian,
                exidx_entry.get_func_addr(),
            );
            hprintln!("LSDA d : {:?}", lsda_d);
            // hprintln!("LSDA   : {:?}", _lsda);
            // 3. The personality as u32, assume always be generic
            let size = session.listen(TIMEOUT_MS).unwrap();
            if size != 5 {
                hprintln!("Error: expected 5 bytes, got {}", size);
            }
            let mut personality_bytes = [0; 5];

            match session.receive(&mut personality_bytes, TIMEOUT_MS) {
                Ok(_) => hprintln!("Received personality"),
                Err(e) => hprintln!("Error: {:?}", e),
            }

            let personality = match personality_bytes[0] {
                0xAA => {
                    let p = u32::from_le_bytes(personality_bytes[1..5].try_into().unwrap());
                    PersonalityType::Compact(p as u8)
                }
                0xBB => {
                    let p = u32::from_le_bytes(personality_bytes[1..5].try_into().unwrap());
                    PersonalityType::Generic(p)
                }
                _ => panic!("Personality type not supported"),
            };

            hprintln!("Personality d : {:?}", personality);
            // hprintln!("Personality   : {:?}", _extab_entry.get_personality());

            Ok(Self::CanUnwind(UnwindInfo {
                func_addr: exidx_entry.get_func_addr(),

                // personality: _extab_entry.get_personality(),
                // unw_instr_iter: _extab_entry.get_unw_instr_iter(),
                // lsda: Some(_lsda),
                lsda: Some(lsda_d),
                personality: personality,
                unw_instr_iter: unw_instr_iter,
            }))
        }
    }

    /// Find and update the `UnwindAbility` for a function indicated by `pc`.
    /// The method updates `self`.
    /// Arguments:
    /// - `pc` is an address inside a function.
    /// - `exidx` is the slice of the whole `.ARM.exidx` section.
    /// - `extab` is the slice of the whole `.ARM.extab` section.
    /// Returns `Err(..)` if anything goes wrong. Otherwise `Ok(())`.
    pub fn get_for_pc(
        &mut self,
        pc: u32,
        exidx: &'a [u8],
        extab: &'a [u8],
    ) -> Result<(), &'static str> {
        // send pc and get back the exidx slice

        if exidx.len() % 8 != 0 {
            return Err("UnwindAbility::get_for_func: exidx length not multiple of 8.");
        }
        if exidx.len() == 0 {
            return Err("UnwindAbility::get_for_func: empty exidx.");
        }

        // Binary search boundaries.
        let mut first = 0usize;
        let mut last = exidx.len() - 8;

        let first_pc =
            Prel31::from_bytes(<&'a [u8; 4]>::try_from(&exidx[first..first + 4]).unwrap());
        if pc < first_pc.value() {
            return Err("UnwindAbility::get_for_func: no matching entry.");
        }

        let last_pc = Prel31::from_bytes(<&'a [u8; 4]>::try_from(&exidx[last..last + 4]).unwrap());
        if pc >= last_pc.value() {
            match Self::from_bytes(
                <&'a [u8; 8]>::try_from(&exidx[last..last + 8]).unwrap(),
                extab,
            ) {
                Ok(s) => {
                    *self = s;
                    return Ok(());
                }
                Err(e) => return Err(e),
            };
        }

        // Perform binary search.
        while first < last - 8 {
            let mid = first + (((last - first) / 8 + 1) >> 1) * 8;
            let mid_pc = Prel31::from_bytes(<&'a [u8; 4]>::try_from(&exidx[mid..mid + 4]).unwrap());
            if pc < mid_pc.value() {
                last = mid;
            } else {
                first = mid;
            }
        }

        match Self::from_bytes(
            <&'a [u8; 8]>::try_from(&exidx[first..first + 8]).unwrap(),
            extab,
        ) {
            Ok(s) => {
                *self = s;
                return Ok(());
            }
            Err(e) => return Err(e),
        };
    }
}

/// ARM general purpose registers.
/// This `enum` defines the mapping from their name to array offset.
#[allow(unused)]
pub enum ARMGPReg {
    R0 = 0,
    R4 = 1,
    R5 = 2,
    R6 = 3,
    R7 = 4,
    R8 = 5,
    R9 = 6,
    R10 = 7,
    R11 = 8,
    SP = 9,
    LR = 10,
    PC = 11,
}

impl ARMGPReg {
    fn from_reg_num(idx: usize) -> Self {
        match idx {
            0 => Self::R0,
            4 => Self::R4,
            5 => Self::R5,
            6 => Self::R6,
            7 => Self::R7,
            8 => Self::R8,
            9 => Self::R9,
            10 => Self::R10,
            11 => Self::R11,
            13 => Self::SP,
            14 => Self::LR,
            15 => Self::PC,
            _ => loop {},
        }
    }

    fn to_reg_num(&self) -> usize {
        match self {
            Self::R0 => 0,
            Self::R4 => 4,
            Self::R5 => 5,
            Self::R6 => 6,
            Self::R7 => 7,
            Self::R8 => 8,
            Self::R9 => 9,
            Self::R10 => 10,
            Self::R11 => 11,
            Self::SP => 13,
            Self::LR => 14,
            Self::PC => 15,
        }
    }
}

impl<T> Index<ARMGPReg> for [T] {
    type Output = T;

    fn index(&self, index: ARMGPReg) -> &Self::Output {
        &self[index as usize]
    }
}

impl<T> IndexMut<ARMGPReg> for [T] {
    fn index_mut(&mut self, index: ARMGPReg) -> &mut Self::Output {
        &mut self[index as usize]
    }
}

/// ARM double-precision floating point registers.
/// This `enum` defines the mapping from their name to array offset.
#[allow(unused)]
pub enum ARMDPFPReg {
    D8 = 0,
    D9 = 1,
    D10 = 2,
    D11 = 3,
    D12 = 4,
    D13 = 5,
    D14 = 6,
    D15 = 7,
}

impl ARMDPFPReg {
    fn from_reg_num(idx: usize) -> Self {
        match idx {
            8 => Self::D8,
            9 => Self::D9,
            10 => Self::D10,
            11 => Self::D11,
            12 => Self::D12,
            13 => Self::D13,
            14 => Self::D14,
            15 => Self::D15,
            _ => loop {},
        }
    }
}

impl<T> Index<ARMDPFPReg> for [T] {
    type Output = T;

    fn index(&self, index: ARMDPFPReg) -> &Self::Output {
        &self[index as usize]
    }
}

impl<T> IndexMut<ARMDPFPReg> for [T] {
    fn index_mut(&mut self, index: ARMDPFPReg) -> &mut Self::Output {
        &mut self[index as usize]
    }
}

/// `UnwindState` holds the state of the unwinding procedure. Only a single
/// instance is created during an unwinding. The construction, reference
/// passing, and destruction of the instance go as follows:
/// - An instance is created when the unwinding starts.
/// - When we call into cleanup routines, the pointer to the instance is
///   passed in the R0 register.
/// - When a cleanup routine finishes, it calls `_Unwind_Resume()` and passes
///   the pointer as the first argument. This is guaranteed by the compiler.
/// - `_Unwind_Resume()` simply calls `continue_unwind()` and forwards the
///   pointer. Now the reference is passed back to this module.
/// - When a catch block is invoked, the pointer to the `UnwindState`
///   instance is passed to it, where it will be freed. The catch block
///   should resume normal control flow (exiting from unwinding).
///
/// WARNING: IF ANY FIELD OF THIS STRUCT IS CHANGED, ONE MUST ALSO UPDATE THE
/// METHOD `from_init_ctxt` ACCORDINGLY.
pub struct UnwindState<'a> {
    /// Current general purpose register values. Callee saved registers
    /// have been restored by unwinding the previous stack frames.
    pub gp_regs: [u32; 12],
    /// Current double-precision floating point register values. Callee saved
    /// registers have been restored by unwinding the previous stack frames.
    pub dpfp_regs: [u64; 8],
    /// `UnwindInfo` associated with the current stack frame being unwound.
    pub unw_ability: UnwindAbility<'a>,
    /// The boundary of the current stacklet the unwinder is unwinding.
    pub stklet_boundary: u32,
    /// Whether the state represents the first function to be unwound in the stack.
    pub is_initial: bool,
}

/// A reserved memory chunk to be used as an unwind state object when the panic
/// occurs in an ISR or under out-of-memory situation.
static mut STATIC_UNWIND_STATE: MaybeUninit<UnwindState<'static>> = MaybeUninit::uninit();

/// Whether the reserved static storage for unwind state is being used.
static STATIC_UNWIND_STATE_IN_USE: AtomicBool = AtomicBool::new(false);

impl<'a> Debug for UnwindState<'a> {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        struct RegFormatter<'a> {
            regs: &'a [u32; 12],
        }

        impl<'a> Debug for RegFormatter<'a> {
            fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
                writeln!(f, "{{")
                    .and(write!(f, "\tR0:  {:#010x}", self.regs[0]))
                    .and(write!(f, "\tR4:  {:#010x}", self.regs[1]))
                    .and(write!(f, "\tR5:  {:#010x}", self.regs[2]))
                    .and(write!(f, "\tR6:  {:#010x}", self.regs[3]))
                    .and(write!(f, "\tR7:  {:#010x}", self.regs[4]))
                    .and(writeln!(f, "\tR8:  {:#010x}", self.regs[5]))
                    .and(write!(f, "\tR9:  {:#010x}", self.regs[6]))
                    .and(write!(f, "\tR10: {:#010x}", self.regs[7]))
                    .and(write!(f, "\tR11: {:#010x}", self.regs[8]))
                    .and(write!(f, "\tSP:  {:#010x}", self.regs[9]))
                    .and(write!(f, "\tLR:  {:#010x}", self.regs[10]))
                    .and(writeln!(f, "\tPC:  {:#010x}", self.regs[11]))
                    .and(write!(f, "}}"))
            }
        }

        let reg_formatter = RegFormatter {
            regs: &self.gp_regs,
        };

        f.debug_struct("UnwindState")
            .field("reg_value", &reg_formatter)
            .finish()
    }
}

#[inline(never)]
fn try_concurrent_restart() {
    let res = schedule::with_current_task_arc(|cur_task| {
        // We will limit the concurrent restart rate to at most one concurrent
        // instance. If this task is a restarted instance, and also if the original
        // instance has not finished unwinding, i.e. the task struct reference
        // count is positive, we will not do concurrent restart.
        if let Some(restarted_from) = cur_task.get_restart_origin_task() {
            if restarted_from.strong_count() != 0 {
                return Ok(());
            }
        }

        // Otherwise, we concurrent restart the task.
        schedule::restart_from_task(cur_task)
    });

    // Concurrent restart failed.
    // FIXME: in this case, we should try normal restart instead of giving up.
    if res.is_err() {
        cortex_m::interrupt::free(|_| loop {});
    }
}

impl UnwindState<'static> {
    /// Allocate memory for the unwind state. Return a raw pointer that points
    /// to *uninitialized* memory. Later the fields of the unwind state struct
    /// must be manually initialized.
    fn allocate_uninit() -> *mut MaybeUninit<Self> {
        // If we panic inside an ISR, we should use the static storage.
        if schedule::is_running_in_isr() {
            // Mark the reserved static storage as being in-use.
            let res = STATIC_UNWIND_STATE_IN_USE.compare_exchange(
                false,
                true,
                Ordering::SeqCst,
                Ordering::SeqCst,
            );

            // If the reserved static storage is already in-use, we halt here.
            if res.is_err() {
                loop {}
            }

            unsafe { &mut STATIC_UNWIND_STATE as *mut _ }
        // Otherwise, we panic inside a task. Use dynamic memory.
        } else {
            Box::into_raw(Box::<Self>::new_uninit())
        }
    }

    /// Free the memory for the unwind state.
    pub unsafe fn drop_from_ptr(ptr: *mut Self) {
        let static_storage_addr = unsafe { &mut STATIC_UNWIND_STATE as *mut _ as usize };
        let this_addr = ptr as *mut _ as usize;

        // If this is not backed by the static storage, we free it back to the heap.
        if static_storage_addr != this_addr {
            unsafe { core::mem::drop(Box::from_raw(ptr)) };
        // Otherwise, we drop the unwind state object in-place and mark the reserved
        // static storage as not being used.
        } else {
            unsafe {
                core::ptr::drop_in_place(ptr);
            }
            STATIC_UNWIND_STATE_IN_USE.store(false, Ordering::SeqCst);
        }
    }

    /// Construct the unwinding state from the initial context.
    extern "C" fn create_unwind_state(init_ctxt: &UnwindInitContext) -> *mut Self {
        // If we have a double panic in the same task or ISR, halt.
        if is_unwinding() {
            loop {}
        }

        // Mark that we are now unwinding.
        set_unwinding(true);

        // Allocate memory on the heap first and manually initialize the fields.
        // This is to avoid increasing the stack memory footprint.
        // See Rust issue #53827: https://github.com/rust-lang/rust/issues/53827
        let uninit_unw_state_ptr = Self::allocate_uninit();

        // Initialize the fields of the struct.
        // Safety: The raw pointers point to the memory we just allocated, and
        // nothing was there so we can safely overwrite it with `.write()`.
        unsafe {
            let unw_ability_ptr: *mut UnwindAbility<'static> =
                &mut (*((*uninit_unw_state_ptr).as_mut_ptr())).unw_ability;
            unw_ability_ptr.write(UnwindAbility::CantUnwind);

            let stklet_boundary_ptr: *mut u32 =
                &mut (*((*uninit_unw_state_ptr).as_mut_ptr())).stklet_boundary;
            stklet_boundary_ptr.write(0);

            let gp_regs_ptr: *mut [u32; 12] =
                &mut (*((*uninit_unw_state_ptr).as_mut_ptr())).gp_regs;
            gp_regs_ptr.write([0u32; 12]);

            let dpfp_regs_ptr: *mut [u64; 8] =
                &mut (*((*uninit_unw_state_ptr).as_mut_ptr())).dpfp_regs;
            dpfp_regs_ptr.write([0u64; 8]);

            let is_initial_ptr: *mut bool =
                &mut (*((*uninit_unw_state_ptr).as_mut_ptr())).is_initial;
            is_initial_ptr.write(true);
        }

        // Tell the type system that now the fields in the struct are initialized.
        // Safety: We just did the initialization above, and the pointer must be
        // valid because we just allocated it.
        let unw_state_ptr: *mut UnwindState = uninit_unw_state_ptr.cast();
        let unw_state = unsafe { &mut *unw_state_ptr };

        // Try concurrent restart if we panic in a task but not in an ISR.
        if !schedule::is_running_in_isr() {
            try_concurrent_restart();
        }

        // Continue to initialize register states to what they are just before the
        // unwinder is invoked.
        unw_state.gp_regs[ARMGPReg::R4] = init_ctxt.r4;
        unw_state.gp_regs[ARMGPReg::R5] = init_ctxt.r5;
        unw_state.gp_regs[ARMGPReg::R6] = init_ctxt.r6;
        unw_state.gp_regs[ARMGPReg::R7] = init_ctxt.r7;
        unw_state.gp_regs[ARMGPReg::R8] = init_ctxt.r8;
        unw_state.gp_regs[ARMGPReg::R9] = init_ctxt.r9;
        unw_state.gp_regs[ARMGPReg::R10] = init_ctxt.r10;
        unw_state.gp_regs[ARMGPReg::R11] = init_ctxt.r11;
        unw_state.gp_regs[ARMGPReg::SP] = init_ctxt.sp;
        unw_state.gp_regs[ARMGPReg::LR] = init_ctxt.lr;

        // See `UnwindState::step()` for why we need to -2.
        unw_state.gp_regs[ARMGPReg::PC] = init_ctxt.lr - 2;

        // Also for floating point registers.
        unw_state.dpfp_regs[ARMDPFPReg::D8] = init_ctxt.d8;
        unw_state.dpfp_regs[ARMDPFPReg::D9] = init_ctxt.d9;
        unw_state.dpfp_regs[ARMDPFPReg::D10] = init_ctxt.d10;
        unw_state.dpfp_regs[ARMDPFPReg::D11] = init_ctxt.d11;
        unw_state.dpfp_regs[ARMDPFPReg::D12] = init_ctxt.d12;
        unw_state.dpfp_regs[ARMDPFPReg::D13] = init_ctxt.d13;
        unw_state.dpfp_regs[ARMDPFPReg::D14] = init_ctxt.d14;
        unw_state.dpfp_regs[ARMDPFPReg::D15] = init_ctxt.d15;

        // Find the unwind ability for the last function before
        // the unwinder is invoked.
        let exidx = boot::get_exidx();

        // let extab = boot::get_extab();

        let extab: &[u8] = &[0; 0];
        unw_state
            .unw_ability
            .get_for_pc(unw_state.gp_regs[ARMGPReg::PC] as u32, exidx, extab)
            .unwrap_or_die();

        // Set the stacklet boundary field. It should be the boundary before
        // the unwinder is invoked, i.e., the boundary for the first function
        // being unwound.
        unw_state.stklet_boundary = init_ctxt.before_unwind_stklet_bound;

        unw_state_ptr
    }
}

impl<'a> UnwindState<'a> {
    /// Step to the next stack frame by applying the `UnwindInfo` stored
    /// in the `UnwindAbility`, or return an error if `CantUnwind`. The
    /// "next" stack frame is the caller of the current stack frame.
    ///
    /// Reference implementation:
    /// <https://github.com/libunwind/libunwind/blob/e07b43c02d/src/arm/Gex_tables.c>
    fn step(&mut self) -> Result<(), &'static str> {
        // Can't unwind if already finished.
        if self.has_finished() {
            return Err("UnwindState::step: already finished.");
        }

        // Get the unwind instructions.
        let unw_instr_iter = match &mut self.unw_ability {
            UnwindAbility::CantUnwind => {
                return Err("UnwindState::step: can't unwind.");
            }
            UnwindAbility::CanUnwind(unw_info) => &mut unw_info.unw_instr_iter,
        };

        // Mark PC as undefined. If PC is not implicitly restored, it will be
        // later explicitly restored from LR.
        self.gp_regs[ARMGPReg::PC] = !0;

        // Apply unwind instructions.
        for instr in unw_instr_iter {
            match instr {
                UnwindInstruction::Finish => {}
                UnwindInstruction::DataPush { size } => {
                    self.gp_regs[ARMGPReg::SP] -= size;
                }
                UnwindInstruction::DataPop { size } => {
                    self.gp_regs[ARMGPReg::SP] += size;
                }
                UnwindInstruction::RegPop { mask } => {
                    let mut tmp_sp = self.gp_regs[ARMGPReg::SP];
                    for i in 0..16 {
                        if (mask & (1 << i)) != 0 {
                            let addr = tmp_sp as *const u32;
                            self.gp_regs[ARMGPReg::from_reg_num(i)] = unsafe { *addr };
                            tmp_sp += 4;
                        }
                    }

                    // If the SP is not in the register list above, it should be updated
                    // to the new position after the pop. Otherwise, the SP should have
                    // already been updated, and we should not touch it.
                    if (mask & (ARMGPReg::SP.to_reg_num() as u32)) == 0 {
                        self.gp_regs[ARMGPReg::SP] = tmp_sp;
                    }
                }
                UnwindInstruction::RegToSp { reg_num } => {
                    self.gp_regs[ARMGPReg::SP] =
                        self.gp_regs[ARMGPReg::from_reg_num(reg_num as usize)];
                }
                UnwindInstruction::VfpPop {
                    start_reg_num,
                    count,
                } => {
                    for i in 0..count as usize {
                        // Stack pointer holds an address (for this instruction).
                        // Since the stack pointer is 32-bit aligned but we want to
                        // read 64 bits, we perform two 32-bit read and then OR
                        // them together.
                        let addr_u32 = self.gp_regs[ARMGPReg::SP] as *const u32;
                        let (low, high) = unsafe { (*addr_u32, *addr_u32.offset(1)) };
                        let val = ((high as u64) << 32) | (low as u64);

                        self.dpfp_regs[ARMDPFPReg::from_reg_num(start_reg_num as usize + i)] = val;
                        self.gp_regs[ARMGPReg::SP] += 8;
                    }
                }
                UnwindInstruction::WregPop => {
                    return Err("UnwindState::step: haven't supported WREG.");
                }
                UnwindInstruction::WcgrPop => {
                    return Err("UnwindState::step: haven't supported WCGR.");
                }
                _ => {
                    return Err("UnwindState::step: bad unwind instruction.");
                }
            }
        }

        // If PC has not been implicitly restored, restore it from LR.
        if self.gp_regs[ARMGPReg::PC] == !0 {
            self.gp_regs[ARMGPReg::PC] = self.gp_regs[ARMGPReg::LR];
        }

        // If the restored PC is 0, then we have finished unwinding, there is no
        // more unwind ability information to update.
        if self.gp_regs[ARMGPReg::PC] == 0 {
            return Ok(());
        }

        // If the restored PC points to `less_stack_entry`, it means that we
        // have unwound to a stacklet boundary. We switch to the previous
        // stacklet and free the current stacklet.
        if self.gp_regs[ARMGPReg::PC] == svc::svc_less_stack as u32 {
            // The metadata block of the stacklet that the unwinder is working on.
            let stklet_meta = {
                let meta_ptr = task::bound_to_stklet_meta(self.stklet_boundary as usize);

                // Safety: The metadata is stored at the beginning of each stacklet.
                // The stacklet is not freed because the function allocated the
                // stacklet has not returned (it paniced), and the unwinder is just
                // about to unwind it. Thus the pointer is valid.
                unsafe { (&*meta_ptr).clone() }
            };

            // Trap frame in the previous stacklet is on the stacklet top.
            // Safety: The previous stacklet has not been freed, because the
            // function that allocated it has not returned, and we are just
            // about to unwind it.
            let prev_tf = unsafe { &*(stklet_meta.prev_sp as *mut TrapFrame) };

            // Update the PC. See below for why we need to -2.
            self.gp_regs[ARMGPReg::PC] = prev_tf.gp_regs.lr - 2;

            // Calculate the trap frame size. The 9th bit in `xPSR` indicates if
            // the trap frame contains a padding.
            let mut tf_size = core::mem::size_of::<TrapFrame>();
            if (prev_tf.gp_regs.xpsr & (1 << 9)) != 0 {
                tf_size += trap_frame::TRAP_FRAME_PAD_SIZE;
            }

            // Working into the previous stacklet, we first pop out the
            // trap frame on the top. We will not return normally back to
            // that stacklet so the preserved registers in the trap frame
            // is useless.
            let restored_sp = stklet_meta.prev_sp + tf_size as u32;

            // Update the stack pointer to the previous stacklet. Now, the
            // register states look like as if we have returned from the
            // function that allocated the stacklet we just finished unwinding.
            self.gp_regs[ARMGPReg::SP] = restored_sp;

            // The stacklet starts with the metadata, so the pointer to the
            // metadata is the pointer to the stacklet. We record the pointer
            // to the stacklet that we are going to free.
            let to_free_stacklet_ptr = task::bound_to_stklet_ptr(self.stklet_boundary as usize);

            // Update the stacklet boundary to that of the previous stacklet.
            self.stklet_boundary = stklet_meta.prev_stklet_bound as u32;

            // Free the stacklet we have finished unwinding.
            // Layout is not used in the current dealloc implementation.
            // Safety: The function leads to a panic, so it did not return,
            // thus it did not free the stacklet itself. The unwinder has
            // unwound the function, so the function cannot free the stacklet
            // in the future. We can safely free it here.
            unsafe {
                alloc::alloc::dealloc(to_free_stacklet_ptr, Layout::new::<u8>());
            }
        // Otherwise, returning to the previous function needs not switch stacklet.
        // In this case, the restored PC is the return address +1 to the caller function.
        // The +1 comes from that we are running in thumb mode, so that the lowest
        // bit is always set in PC. We subtract the value by 2 so that now PC points
        // to the (middle of) the instruction (indirectly) causing the unwinding.
        } else {
            self.gp_regs[ARMGPReg::PC] -= 2;
        }

        // Update unwind ability information.
        // this is the one that triggers during unw_iter
        let exidx = boot::get_exidx();
        // let extab = boot::get_extab();
        let extab: &[u8] = &[0; 0];
        self.unw_ability
            .get_for_pc(self.gp_regs[ARMGPReg::PC] as u32, exidx, extab)?;

        Ok(())
    }

    /// Check if the unwinding has finished.
    fn has_finished(&self) -> bool {
        self.gp_regs[ARMGPReg::PC] == 0
    }

    /// Save the unwind state pointer to the architecture specific retister
    /// before jumping to the landing pad. If the landing pad is a cleanup
    /// routine, it will preserve the pointer and later pass it to
    /// `_Unwind_Resume()`, which in turn passes it to `continue_unwind()`.
    /// For ARM, the register should be R0.
    fn save_unw_state_ptr(&mut self, unw_state_ptr: *mut UnwindState) {
        self.gp_regs[ARMGPReg::R0] = unw_state_ptr as u32;
    }
}

/// Walk through the stack frames and print the state and the landing pads
/// along the way.
#[cfg(feature = "debug_unwind")]
fn print_stack_trace(init_ctxt: &UnwindInitContext) {
    let mut state = UnwindState::from_init_ctxt(init_ctxt).unwrap_or_die();

    loop {
        // This is not the final stack frame.
        if !state.has_finished() {
            heprintln!("print_stack_trace: current state:");
            heprintln!("{:#?}", state);

            // Get unwind information.
            let unw_info = match &mut state.unw_ability {
                UnwindAbility::CantUnwind => {
                    unw_die::print_and_die("print_stack_trace: can't unwind.")
                }
                UnwindAbility::CanUnwind(unw_info) => unw_info,
            };

            // Print call site table entries.
            use fallible_iterator::FallibleIterator;
            if let Some(callsite_iter) = &mut unw_info.lsda {
                let mut callsite_iter = callsite_iter
                    .call_site_table_entries()
                    .map_err(|_| "print_stack_trace: can't get callsite iterator.")
                    .unwrap_or_die();
                while let Ok(Some(entry)) = callsite_iter.next() {
                    heprintln!("{:?}", entry);
                }
            }
            heprintln!("");
            heprintln!("");

            // Advance to the next stack frame.
            state.step().unwrap_or_die();

        // This is the final stack frame.
        } else {
            heprintln!("print_stack_trace: final state:");
            heprintln!("{:#?}", state);
            heprintln!("");
            heprintln!("");
            break;
        }
    }
}

/// The initial unwinding context. Only callee-saved registers,
/// LR and SP are included.
#[repr(C)]
struct UnwindInitContext {
    r4: u32,
    r5: u32,
    r6: u32,
    r7: u32,
    r8: u32,
    r9: u32,
    r10: u32,
    r11: u32,
    lr: u32,
    sp: u32,
    /// The stacklet boundary before the unwinder is invoked.
    before_unwind_stklet_bound: u32,
    /// The boundary of the stacklet that the unwinder is running with.
    unwinder_stklet_bound: u32,
    d8: u64,
    d9: u64,
    d10: u64,
    d11: u64,
    d12: u64,
    d13: u64,
    d14: u64,
    d15: u64,
}

/// Prepare the initial unwinding context and jump to `start_unwind()`.
#[naked]
pub extern "C" fn start_unwind_entry() {
    unsafe {
        asm!(
            // Preserve some registers, because `lr` and `sp` will be overwritten
            // after the following SVC.
            "mov    r0, lr",                // Copy `lr` to `r0`.
            "mov    r1, sp",                // Copy `sp` to `r1`.
            "ldr    r2, ={stkbnd_mem_addr}",// Let `r2` hold the stacklet boundary of the
            "ldr    r2, [r2]",              // task before the unwinder in invoked.

            // If we are in an ISR, skip the following SVC, because we need not a new
            // stacklet since the code is already running in the contiguous stack.
            "mrs    r3, ipsr",              // Read the active ISR number.
            "cbnz   r3, 0f",                // If non-zero, an ISR is active. Skip the SVC.

            // Allocate the initial stacklet for the unwinder.
            "svc    {task_unwind_prep}",    // Allocate a new stacklet for unwinder.
                                            // All registers will be preserved except
                                            // `sp` and `lr`.
            ".short 512",                   // Stacklet request size 2048 bytes.
            ".short 0",                     // No stack argument.

            // Prepare arguments in the stack.
            "0:",
            "ldr    r3, ={stkbnd_mem_addr}",// The execution starts here after the
            "ldr    r3, [r3]",              // system call is completed. We save the
                                            // boundary of the unwinder's stacklet
                                            // into `r3`.

            "vpush  {{d8-d15}}",            // Push `d8-d15` onto the stack. They will
                                            // become part of the `UnwindInitContext`.
            "push   {{r0-r3}}",             // Push `r0-r3` onto the stack. They will
                                            // become part of the `UnwindInitContext`.
            "push   {{r4-r11}}",            // Save callee-saved registers. They will
                                            // become part of the `UnwindInitContext`.

            // Prepare register arguments and create the unwind state struct.
            "mov    r0, sp",                // Let `r0` point to `UnwindInitContext` struct.
            "bl     {create_unwind_state}", // Call `create_unwind_state()`.

            // Prepare register arguments and run the unwinder.
            // Now `r0` contains the pointer to the unwind state struct returned above.
            "add    sp, #96",               // Pop `UnwindInitContext`, but leave space
                                            // of 16 bytes for `LandInfo`
            "mov    r1, sp",                // Let `r1` point to `LandInfo` struct.
            "bl     {resume_unwind}",

            // The unwinder returns the information for landing in the `LandInfo`
            // struct. Here we restore callee-saved registers. Later, the SVC call
            // at the end will take care of restoring caller-saved registers.
            "pop    {{r0-r3}}",             // Get the 4 fields of `LandInfo` into `r0-r3`.
            "add    r2, #4",                // Let `r2` point to `gp_regs[4]`.
            "ldmia  r2, {{r4-r11}}",        // Restore `r4` to `r11`.
            "vldmia r3, {{d8-d15}}",        // Restore `d8` to `d15`.

            // If we are in an ISR, skip the following SVC, because we need not free any
            // stacklet since the code is already running in the contiguous stack. Also,
            // we perform the landing directly without invoking SVC. We maintain the
            // invariant that SVC shall not be invoked from CPU handler mode.
            "mrs    r3, ipsr",              // Read the active ISR number.
            "cbnz   r3, 1f",                // If non-zero, an ISR is active. Skip the SVC.

            // Invoke SVC to land if not running inside ISR.
            "svc    {task_unwind_land}",    // Invoke SVC to jump to the landing pad.
                                            // This SVC also frees the stacklet we allocated
                                            // above.

            // Callee-saved registers have been restored. The unwind state pointer is
            // already in `r0`. We just need to restore the stack pointer and jump to
            // the landing address.
            "1:",
            "ldr    sp, [r2, #32]",         // Restore the stack pointer.
            "bx     r1",                    // Jump to the landing address.
            create_unwind_state = sym UnwindState::create_unwind_state,
            resume_unwind = sym resume_unwind,
            stkbnd_mem_addr = const config::STACKLET_BOUNDARY_MEM_ADDR,
            task_unwind_prep = const(SVCNum::TaskUnwindPrepare as u8),
            task_unwind_land = const(SVCNum::TaskUnwindLand as u8),
            options(noreturn)
        )
    }
}

/// Landing information returned by the stack unwinder.
#[repr(C)]
struct LandInfo<'a> {
    state_ptr: *mut UnwindState<'a>,
    land_addr: u32,
    gp_regs_ptr: *mut [u32; 12],
    dpfp_regs_ptr: *mut [u64; 8],
}

static IS_ISR_UNWINDING: AtomicBool = AtomicBool::new(false);

pub fn set_isr_unwinding(val: bool) {
    IS_ISR_UNWINDING.store(val, Ordering::SeqCst);
}

pub fn save_and_clear_isr_unwinding() -> bool {
    IS_ISR_UNWINDING.swap(false, Ordering::SeqCst)
}

pub fn is_isr_unwinding() -> bool {
    IS_ISR_UNWINDING.load(Ordering::SeqCst)
}

pub fn set_cur_task_unwinding(val: bool) {
    schedule::with_current_task(|cur_task| cur_task.set_unwind_flag(val));
}

pub fn is_cur_task_unwinding() -> bool {
    schedule::with_current_task(|cur_task| cur_task.is_unwinding())
}

pub fn is_unwinding() -> bool {
    if schedule::is_running_in_isr() {
        is_isr_unwinding()
    } else {
        is_cur_task_unwinding()
    }
}

pub fn set_unwinding(val: bool) {
    if schedule::is_running_in_isr() {
        set_isr_unwinding(val)
    } else {
        set_cur_task_unwinding(val)
    }
}

/// Continue unwinding to the next stack frame. If the current stack frame has
/// a landing pad to invoke, return it with `Some`.
pub fn unwind_next_function(unw_state_ptr: *mut UnwindState) -> Option<u32> {
    let unw_state = unsafe { &mut *unw_state_ptr };

    // If the unwind state corresponds to the first function to be unwound,
    // we should just work on this state.
    if unw_state.is_initial {
        unw_state.is_initial = false;
    // Otherwise, we just came back after unwinding the function represented
    // by the state. We step the state to its caller function.
    } else {
        unw_state.step().unwrap_or_die();
    }

    #[cfg(feature = "debug_unwind")]
    {
        heprintln!("continue_unwind: current state:");
        heprintln!("{:#?}", unw_state);
    }

    // Get unwind information.
    let unw_info = match &unw_state.unw_ability {
        UnwindAbility::CantUnwind => unrecoverable::die_with_arg("continue_unwind: can't unwind."),
        UnwindAbility::CanUnwind(unw_info) => unw_info,
    };

    let call_site_tbl_entry = match unw_info.lsda {
        // If the current stack frame has an LSDA, we try to find the
        // call site table entry for it.
        Some(lsda_table) => {
            match lsda_table
                .call_site_table_entry_for_address(unw_state.gp_regs[ARMGPReg::PC] as u32)
            {
                Ok(call_site_tbl_entry) => call_site_tbl_entry,

                // No call site table entry contains the given address.
                // We have no landing pad to call, so we continue to
                // the next stack frame.
                Err(_) => {
                    #[cfg(feature = "debug_unwind")]
                    heprintln!("continue_unwind: no matching call site table entry.");

                    return None;
                }
            }
        }

        // The current stack frame has no LSDA. We have no landing pad to call,
        // so we continue to the next stack frame.
        None => {
            #[cfg(feature = "debug_unwind")]
            heprintln!("continue_unwind: no LSDA.");

            return None;
        }
    };

    let land_addr = match call_site_tbl_entry.landing_pad_address() {
        // If a landing address exists, we set the lowest bit because
        // we run in thumb mode.
        Some(addr) => addr | 0x1,

        // We have no landing address, thus no landing pad to call,
        // so we continue to the next stack frame.
        None => {
            #[cfg(feature = "debug_unwind")]
            heprintln!("continue_unwind: no landing pad address.");

            return None;
        }
    };

    // Preserve unwind state pointer.
    unw_state.save_unw_state_ptr(unw_state_ptr);

    #[cfg(feature = "debug_unwind")]
    heprintln!("continue_unwind: landing to {:010x}", land_addr);

    return Some(land_addr);
}

/// Resume unwinding when a landing pad has finished executing and the unwinder
/// is invoked again to proceed to the next stack frame. The function is marked
/// `unsafe` because it should not be invoked by any programmer's code.
unsafe extern "C" fn resume_unwind<'a>(
    unw_state_ptr: *mut UnwindState<'a>,
    land_info: &mut LandInfo<'a>,
) {
    // Make a context switch if preemption is not in use.
    // Don't let the unwinder take the CPU for a very long time.
    // When preeption is enabled, the unwinder will not be chosen to run unless
    // no other priority task is ready.
    if !config::ALLOW_TASK_PREEMPTION {
        if !schedule::is_running_in_isr() {
            svc::svc_yield_current_task();
        }
    }

    // Continue unwinding until a landing pad needs to be invoked.
    loop {
        match unwind_next_function(unw_state_ptr) {
            Some(land_addr) => {
                land_info.state_ptr = unw_state_ptr;
                land_info.land_addr = land_addr;
                land_info.gp_regs_ptr = unsafe { &mut (*unw_state_ptr).gp_regs };
                land_info.dpfp_regs_ptr = unsafe { &mut (*unw_state_ptr).dpfp_regs };
                return;
            }
            None => {}
        }
    }
}

/// The compiler automatically invokes this function at the end of
/// each cleanup routine. The function is marked `unsafe` because it
/// should not be invoked by any programmer's code.
#[no_mangle]
#[naked]
unsafe extern "C" fn _Unwind_Resume(unw_state_ptr: *mut UnwindState) -> ! {
    unsafe {
        asm!(
            // If we are in an ISR, skip the following SVC, because we need not a new
            // stacklet since the code is already running in the contiguous stack.
            "mrs    r3, ipsr",            // Read the active ISR number.
            "cbnz   r3, 0f",              // If non-zero, an ISR is active. Skip the SVC.

            // Allocate the initial stacklet for the unwinder.
            "svc    {task_unwind_prep}",  // Allocate a new stacklet for unwinder.
            ".short 512",                 // Stacklet request size 2048 bytes.
            ".short 0",                   // No stack argument.

            // Prepare register arguments and call the unwinder.
            // `r0` is holding the unwind state pointer.
            "0:",
            "sub    sp, #16",             // Allocate space for `LandInfo`
            "mov    r1, sp",              // Let `r1` point to `LandInfo` struct.
            "bl     {resume_unwind}",     // Call `resume_unwind()`

            // The unwinder returns the information for landing in the `LandInfo`
            // struct. Here we restore callee-saved registers. Later, the SVC call
            // at the end will take care of restoring caller-saved registers.
            "pop    {{r0-r3}}",           // Get the 4 fields of `LandInfo` into `r0-r3`.
            "add    r2, #4",              // Let `r2` point to `gp_regs[4]`.
            "ldmia  r2, {{r4-r11}}",      // Restore `r4` to `r11`.
            "vldmia r3, {{d8-d15}}",      // Restore `d8` to `d15`.

            // If we are in an ISR, skip the following SVC, because we need not free any
            // stacklet since the code is already running in the contiguous stack. Also,
            // we perform the landing directly without invoking SVC. We maintain the
            // invariant that SVC shall not be invoked from CPU handler mode.
            "mrs    r3, ipsr",            // Read the active ISR number.
            "cbnz   r3, 1f",              // If non-zero, an ISR is active. Skip the SVC.

            // Invoke SVC to land if not running inside ISR.
            "svc    {task_unwind_land}",  // Invoke SVC to jump to the landing pad.
                                          // This SVC also frees the stacklet we allocated
                                          // above.

            // Callee-saved registers have been restored. The unwind state pointer is
            // already in `r0`. We just need to restore the stack pointer and jump to
            // the landing address.
            "1:",
            "ldr    sp, [r2, #32]",       // Restore the stack pointer.
            "bx     r1",                  // Jump to the landing address.
            resume_unwind = sym resume_unwind,
            task_unwind_prep = const(SVCNum::TaskUnwindPrepare as u8),
            task_unwind_land = const(SVCNum::TaskUnwindLand as u8),
            options(noreturn)
        )
    }
}

/// The Rust panic handler. The Rust compiler will call this function
/// whenever a panic is thrown. We start unwinding the stack from here.
/// The function is marked `unsafe` because it should not be invoked
/// by any programmer's code.
#[panic_handler]
unsafe fn panic(_info: &PanicInfo) -> ! {
    start_unwind_entry();
    loop {}
}

/* Below are unused personality routines. They are marked unsafe because */
/* they should not be invoked by any programmer's code. */

#[no_mangle]
unsafe extern "C" fn __aeabi_unwind_cpp_pr0() -> ! {
    unrecoverable::die_with_arg("__aeabi_unwind_cpp_pr0: unexpectedly invoked.")
}

#[no_mangle]
unsafe extern "C" fn __aeabi_unwind_cpp_pr1() -> ! {
    unrecoverable::die_with_arg("__aeabi_unwind_cpp_pr1: unexpectedly invoked.")
}

#[no_mangle]
unsafe extern "C" fn __aeabi_unwind_cpp_pr2() -> ! {
    unrecoverable::die_with_arg("__aeabi_unwind_cpp_pr2: unexpectedly invoked.")
}

#[lang = "eh_personality"]
unsafe extern "C" fn eh_personality() {
    unrecoverable::die_with_arg("eh_personality: unexpectedly invoked.")
}
