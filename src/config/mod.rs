pub const KERNEL_STACK_BOUNDARY: u32 = 0x2000_0010;

pub const KERNEL_STACK_BOTTOM: u32 = 0x2000_1000;

pub const STACKLET_BOUNDARY_MEM_ADDR: u32 = 0x2000_0000;

pub const IRQ_PRIORITY_GRANULARITY: u8 = 16;

#[allow(unused)]
pub const IRQ_MAX_PRIORITY: u8 = 8 * IRQ_PRIORITY_GRANULARITY;

pub const IRQ_HIGH_PRIORITY: u8 = 9 * IRQ_PRIORITY_GRANULARITY;

pub const IRQ_DEFAULT_PRIORITY: u8 = 10 * IRQ_PRIORITY_GRANULARITY;

pub const IRQ_BASEPRI_ENABLE_PRIORITY: u8 = 14 * IRQ_PRIORITY_GRANULARITY;

pub const IRQ_BASEPRI_DISABLE_PRIORITY: u8 = 7 * IRQ_PRIORITY_GRANULARITY;

#[allow(unused)]
pub const IRQ_MIN_PRIORITY: u8 = 11 * IRQ_PRIORITY_GRANULARITY;

pub const SVC_HIGH_PRIORITY: u8 = 0 * IRQ_PRIORITY_GRANULARITY;

pub const SVC_REDUCED_PRIORITY: u8 = 12 * IRQ_PRIORITY_GRANULARITY;

pub const CTXT_SWITCH_PRIORITY: u8 = 13 * IRQ_PRIORITY_GRANULARITY;

pub const EXCEPTION_RETURN_TO_PSP_WITH_FP: u32 = 0xffffffed;

pub const MAX_TASK_NUMBER: usize = 16;

pub const USE_PREEMPTION: bool = true;

/// Maximum priority number. Lower numerical numbers represent higher priorities.
/// Allowed priority range: 0 to (TASK_PRIORITY_LEVELS - 1).
pub const TASK_PRIORITY_LEVELS: u8 = 16;

pub const IDLE_PRIORITY: u8 = TASK_PRIORITY_LEVELS - 1;

/// FIXME: rethink the priority for unwinding.
pub const UNWIND_PRIORITY: u8 = TASK_PRIORITY_LEVELS - 3;

pub const STKLET_ADDITION_ALLOC_SIZE: usize = 64;

pub const MAIN_TASK_PRIORITY: u8 = 0;
