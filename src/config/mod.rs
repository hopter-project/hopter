use static_assertions::{const_assert, const_assert_eq};

#[macro_use]
mod helper;

/* ############################ */
/* ### Clock Configurations ### */
/* ############################ */

#[doc(inline)]
pub use hopter_conf_params::SYSTICK_FREQUENCY_HZ;
assert_value_type!(SYSTICK_FREQUENCY_HZ, u32);

// Must be a multiple of 1000 so that Hopter can get an interrupt at
// 1 millisecond interval.
const_assert!(SYSTICK_FREQUENCY_HZ % 1000 == 0);

/* ############################ */
/* ### Stack Configurations ### */
/* ############################ */

#[doc(inline)]
pub use hopter_conf_params::ALLOW_DYNAMIC_STACK;
assert_value_type!(ALLOW_DYNAMIC_STACK, bool);

#[doc(inline)]
pub use hopter_conf_params::STACKLET_ADDITION_ALLOC_SIZE;
assert_value_type!(STACKLET_ADDITION_ALLOC_SIZE, usize);

// The additional allocation size should be a multiple of 8
const_assert!(STACKLET_ADDITION_ALLOC_SIZE % 8 == 0);

#[doc(inline)]
pub use hopter_conf_params::HOT_SPLIT_PREVENTION_CACHE_SIZE;
assert_value_type!(HOT_SPLIT_PREVENTION_CACHE_SIZE, usize);

#[doc(inline)]
pub use hopter_conf_params::HOT_SPLIT_DETECTION_THRESHOLD;
assert_value_type!(HOT_SPLIT_DETECTION_THRESHOLD, usize);

#[doc(inline)]
pub use hopter_conf_params::MAIN_TASK_INITIAL_STACK_SIZE;
assert_value_type!(MAIN_TASK_INITIAL_STACK_SIZE, usize);

// Either the stack of the main task is configured to have non-zero size
// or it is allocated completely dynamically.
const_assert!(MAIN_TASK_INITIAL_STACK_SIZE > 0 || ALLOW_DYNAMIC_STACK);

#[doc(inline)]
pub use hopter_conf_params::_IDLE_TASK_INITIAL_STACK_SIZE;
assert_value_type!(_IDLE_TASK_INITIAL_STACK_SIZE, usize);

// Either the stack of the idle task is configured to have non-zero size
// or it is allocated completely dynamically.
const_assert!(_IDLE_TASK_INITIAL_STACK_SIZE > 0 || ALLOW_DYNAMIC_STACK);

#[doc(inline)]
pub use hopter_conf_params::__CONTIGUOUS_STACK_BOUNDARY;
assert_value_type!(__CONTIGUOUS_STACK_BOUNDARY, u32);

#[doc(inline)]
pub use hopter_conf_params::_CONTIGUOUS_STACK_BOTTOM;
assert_value_type!(_CONTIGUOUS_STACK_BOTTOM, u32);

// Stacks are assumed to grow downwards.
const_assert!(__CONTIGUOUS_STACK_BOUNDARY < _CONTIGUOUS_STACK_BOTTOM);
// Stacks should be 8-byte aligned.
const_assert!(__CONTIGUOUS_STACK_BOUNDARY % 8 == 0);
const_assert!(__CONTIGUOUS_STACK_BOUNDARY % 8 == 0);

/* ########################### */
/* ### Heap Configurations ### */
/* ########################### */

#[doc(inline)]
pub use hopter_conf_params::RAM_END_ADDR;
assert_value_type!(RAM_END_ADDR, u32);

#[doc(inline)]
pub use hopter_conf_params::__MEM_CHUNK_LINK_OFFSET;
assert_value_type!(__MEM_CHUNK_LINK_OFFSET, u32);

/* ################################ */
/* ### Interrupt Configurations ### */
/* ################################ */

#[doc(inline)]
pub use hopter_conf_params::IRQ_PRIORITY_GRANULARITY;
assert_value_type!(IRQ_PRIORITY_GRANULARITY, u8);

#[doc(inline)]
pub use hopter_conf_params::IRQ_MAX_PRIORITY;
assert_value_type!(IRQ_MAX_PRIORITY, u8);

#[doc(inline)]
pub use hopter_conf_params::IRQ_HIGH_PRIORITY;
assert_value_type!(IRQ_HIGH_PRIORITY, u8);

#[doc(inline)]
pub use hopter_conf_params::IRQ_NORMAL_PRIORITY;
assert_value_type!(IRQ_NORMAL_PRIORITY, u8);

#[doc(inline)]
pub use hopter_conf_params::IRQ_LOW_PRIORITY;
assert_value_type!(IRQ_LOW_PRIORITY, u8);

#[doc(inline)]
pub use hopter_conf_params::IRQ_MIN_PRIORITY;
assert_value_type!(IRQ_MIN_PRIORITY, u8);

// Smaller numerical value represents higher priority.
const_assert!(IRQ_MIN_PRIORITY > IRQ_MAX_PRIORITY);

#[doc(inline)]
pub use hopter_conf_params::SYSTICK_PRIORITY;
assert_value_type!(SYSTICK_PRIORITY, u8);

// SysTick's priority should fall between allowed IRQ priority levels.
const_assert!(SYSTICK_PRIORITY >= IRQ_MAX_PRIORITY);
const_assert!(SYSTICK_PRIORITY <= IRQ_MIN_PRIORITY);

#[doc(inline)]
pub use hopter_conf_params::IRQ_ENABLE_BASEPRI_PRIORITY;
assert_value_type!(IRQ_ENABLE_BASEPRI_PRIORITY, u8);

// When all interrupts are enabled, the BASEPRI register should be set to 0.
const_assert!(IRQ_ENABLE_BASEPRI_PRIORITY == 0);

#[doc(inline)]
pub use hopter_conf_params::IRQ_DISABLE_BASEPRI_PRIORITY;
assert_value_type!(IRQ_DISABLE_BASEPRI_PRIORITY, u8);

// The highest priority interrupt must be disabled when the interrupt is
// globally masked.
const_assert!(IRQ_DISABLE_BASEPRI_PRIORITY <= IRQ_MAX_PRIORITY);

#[doc(inline)]
pub use hopter_conf_params::SVC_NORMAL_PRIORITY;
assert_value_type!(SVC_NORMAL_PRIORITY, u8);

// SVC should have a lower priority than all IRQs.
const_assert!(SVC_NORMAL_PRIORITY > IRQ_MIN_PRIORITY);

#[doc(inline)]
pub use hopter_conf_params::PENDSV_PRIORITY;
assert_value_type!(PENDSV_PRIORITY, u8);

// PendSV's priority must be lower than SVC.
const_assert!(PENDSV_PRIORITY >= SVC_NORMAL_PRIORITY);

/* ########################### */
/* ### Task Configurations ### */
/* ########################### */

#[doc(inline)]
pub use hopter_conf_params::MAX_TASK_NUMBER;
assert_value_type!(MAX_TASK_NUMBER, usize);

// Maximum task number must be a power of 2 due to internal implementation
// constraints.
const_assert!(helper::is_power_of_2(MAX_TASK_NUMBER as u32));

#[doc(inline)]
pub use hopter_conf_params::ALLOW_TASK_PREEMPTION;
assert_value_type!(ALLOW_TASK_PREEMPTION, bool);

#[doc(inline)]
pub use hopter_conf_params::BREATHING_CONCURRENCY;
assert_value_type!(BREATHING_CONCURRENCY, usize);

#[doc(inline)]
pub use hopter_conf_params::TASK_PRIORITY_LEVELS;
assert_value_type!(TASK_PRIORITY_LEVELS, u8);

// Should have at least four allowed task priority levels.
const_assert!(TASK_PRIORITY_LEVELS >= 4);

#[doc(inline)]
pub use hopter_conf_params::IDLE_TASK_PRIORITY;
assert_value_type!(IDLE_TASK_PRIORITY, u8);

// The idle task's priority should be one of the allowed priority levels.
const_assert!(IDLE_TASK_PRIORITY < TASK_PRIORITY_LEVELS);

#[doc(inline)]
pub use hopter_conf_params::MAIN_TASK_PRIORITY;
assert_value_type!(MAIN_TASK_PRIORITY, u8);

// The main task's priority should be one of the allowed priority levels.
const_assert!(MAIN_TASK_PRIORITY < TASK_PRIORITY_LEVELS);

#[doc(inline)]
pub use hopter_conf_params::DEFAULT_TASK_PRIORITY;
assert_value_type!(DEFAULT_TASK_PRIORITY, u8);

// The default priority should be one of the allowed priority levels.
const_assert!(DEFAULT_TASK_PRIORITY < TASK_PRIORITY_LEVELS);

#[doc(inline)]
pub use hopter_conf_params::UNWIND_PRIORITY;
assert_value_type!(UNWIND_PRIORITY, u8);

// Unwind priority should be higher than idle priority.
const_assert!(UNWIND_PRIORITY < IDLE_TASK_PRIORITY);

#[doc(inline)]
pub use hopter_conf_params::IDLE_TASK_ID;
assert_value_type!(IDLE_TASK_ID, u8);

#[doc(inline)]
pub use hopter_conf_params::MAIN_TASK_ID;
assert_value_type!(MAIN_TASK_ID, u8);

#[doc(inline)]
pub use hopter_conf_params::DEFAULT_TASK_ID;
assert_value_type!(DEFAULT_TASK_ID, u8);

#[doc(inline)]
pub use hopter_conf_params::__TLS_MEM_ADDR;
assert_value_type!(__TLS_MEM_ADDR, u32);
const_assert_eq!(__TLS_MEM_ADDR, 0x2000_0000);

// The memory address should be encodable as a thumb2 instruction constant,
// so that we can use a `mov.w` instruction to load the address into a register.
const_assert!(helper::is_thumb2_allowed_constant(__TLS_MEM_ADDR));
