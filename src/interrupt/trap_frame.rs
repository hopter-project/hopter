/// Trap frame that is pushed automatically by hardware upon interrupt.
#[repr(C)]
#[derive(Clone, Default)]
pub struct TrapFrame {
    pub gp_regs: TrapFrameGPRegs,
    pub fp_regs: TrapFrameFPRegs,
}

/// Sometimes the CPU adds a padding to ensure that the trap frame is 8-byte
/// aligned. The padding is 4 bytes, placed after the trap frame. This padding
/// is additional to the one in [`TrapFrameFPRegs`].
pub const TRAP_FRAME_PAD_SIZE: usize = 4;

/// The general purpose registers preserved in a trap frame.
#[repr(C)]
#[derive(Clone, Default)]
pub struct TrapFrameGPRegs {
    pub r0: u32,
    pub r1: u32,
    pub r2: u32,
    pub r3: u32,
    pub r12: u32,
    pub lr: u32,
    pub pc: u32,
    pub xpsr: u32,
}

/// The floating point registers preserved in a trap frame.
/// The `_padding` is to ensure the whole struct is a multiple of 8 bytes.
#[repr(C)]
#[derive(Clone, Default)]
pub struct TrapFrameFPRegs {
    pub s0: u32,
    pub s1: u32,
    pub s2: u32,
    pub s3: u32,
    pub s4: u32,
    pub s5: u32,
    pub s6: u32,
    pub s7: u32,
    pub s8: u32,
    pub s9: u32,
    pub s10: u32,
    pub s11: u32,
    pub s12: u32,
    pub s13: u32,
    pub s14: u32,
    pub s15: u32,
    pub fpcsr: u32,
    pub _padding: u32,
}
