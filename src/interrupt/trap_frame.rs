/// Trap frame that is pushed automatically by hardware upon interrupt.
#[repr(C)]
#[derive(Clone, Default)]
pub(crate) struct TrapFrame {
    pub gp_regs: TrapFrameGPRegs,
}

/// Sometimes the CPU adds a padding to ensure that the trap frame is 8-byte
/// aligned. The padding is 4 bytes, placed after the trap frame. This padding
/// is additional to the one in [`TrapFrameFPRegs`].
pub(crate) const TRAP_FRAME_PAD_SIZE: usize = 4;

/// The general purpose registers preserved in a trap frame.
#[repr(C)]
#[derive(Clone, Default)]
pub(crate) struct TrapFrameGPRegs {
    pub r0: u32,
    pub r1: u32,
    pub r2: u32,
    pub r3: u32,
    pub r12: u32,
    pub lr: u32,
    pub pc: u32,
    pub xpsr: u32,
}
