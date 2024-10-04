//! Tests that a context switch maintains all general purpose registers.

#![no_std]
#![no_main]
#![feature(naked_functions)]

extern crate alloc;
use core::{arch::asm, sync::atomic::AtomicBool};
use hopter::{
    config,
    debug::semihosting::{self, dbg_println},
    task,
    task::main,
};

/// Whether the clobbering task should run.
static RUN_CLOBBER: AtomicBool = AtomicBool::new(false);

/// Whether the cloberring task has run.
static CLOBBERED: AtomicBool = AtomicBool::new(false);

#[main]
fn main(_: cortex_m::Peripherals) {
    // Two tasks have the same priority so will be scheduled round-robin.
    task::build()
        .set_entry(|| verify_registers())
        .set_priority(config::DEFAULT_TASK_PRIORITY)
        .set_stack_init_size(1024)
        .spawn()
        .unwrap();
    task::build()
        .set_entry(|| clobber_all_gp_regs())
        .set_priority(config::DEFAULT_TASK_PRIORITY)
        .spawn()
        .unwrap();
}

/// Write known values to registers and check that they remain the same value
/// after context switch.
#[naked]
extern "C" fn verify_registers() -> ! {
    unsafe {
        asm!(
            // Set `RUN_CLOBBER` to true.
            "0:",
            "ldr  r0, ={run_clobber}",
            "mov  r1, #1",
            "strb r1, [r0]",
            // Write some known values to the low registers.
            "mov  r0, #1",
            "mov  r1, #2",
            "mov  r2, #3",
            "mov  r3, #4",
            "mov  r4, #5",
            "mov  r5, #6",
            "mov  r6, #7",
            "mov  r7, #8",
            // Trigger context switch.
            "mov  r8, #0xe0",
            "msr  basepri, r8",
            "mov  r9, #0x10000000",
            "movw r8, #0xed04",
            "movt r8, #0xe000",
            "str  r9, [r8]",
            "mov  r8, #0",
            "msr  basepri, r8",
            // See if the clobbering task has run.
            "ldr  r8, ={clobber}",
            "ldrb r8, [r8]",
            // If the clobbering task has not run yet, we loop back and do
            // everything another time.
            "cmp  r8, #0",
            "beq  0b",
            // Examine the values of low registers. They should remain the same
            // as before the context switch.
            "cmp  r0, #1",
            "bne  {error}",
            "cmp  r1, #2",
            "bne  {error}",
            "cmp  r2, #3",
            "bne  {error}",
            "cmp  r3, #4",
            "bne  {error}",
            "cmp  r4, #5",
            "bne  {error}",
            "cmp  r5, #6",
            "bne  {error}",
            "cmp  r6, #7",
            "bne  {error}",
            "cmp  r7, #8",
            "bne  {error}",
            "1:",
            // Set `CLOBERRED` to false.
            "ldr  r0, ={cloberred}",
            "mov  r1, #1",
            "strb r1, [r0]",
            // Set `RUN_CLOBBER` to true.
            "ldr  r0, ={run_clobber}",
            "mov  r1, #1",
            "strb r1, [r0]",
            // Preserve the current stack pointer value in the stack.
            "mov  r0, sp",
            "push {{r0}}",
            // Write some known values to the high registers.
            "mov  r8, #9",
            "mov  r9, #10",
            "mov  r10, #11",
            "mov  r11, #12",
            "mov  r12, #13",
            "mov  lr, #14",
            // Trigger context switch.
            "mov  r0, #0xe0",
            "msr  basepri, r0",
            "mov  r1, #0x10000000",
            "movw r0, #0xed04",
            "movt r0, #0xe000",
            "str  r1, [r0]",
            "mov  r0, #0",
            "msr  basepri, r0",
            // See if the clobbering task has run.
            "ldr  r0, ={clobber}",
            "ldrb r0, [r0]",
            // If the clobbering task has not run yet, we loop back and do
            // everything another time.
            "cmp  r0, #0",
            "beq  1b",
            // Examine the values of high registers. They should remain the same
            // as before the context switch.
            "cmp  r8, #9",
            "bne  {error}",
            "cmp  r9, #10",
            "bne  {error}",
            "cmp  r10, #11",
            "bne  {error}",
            "cmp  r11, #12",
            "bne  {error}",
            "cmp  r12, #13",
            "bne  {error}",
            "cmp  lr, #14",
            "bne  {error}",
            // Restore the previous stack pointer value and compare it with the
            // current value. They should be the same.
            "pop  {{r0}}",
            "cmp  r0, sp",
            "bne  {error}",
            // If the clobbering task has run, then we have verified that the
            // registers in this task's context were not affected. Declare
            // success.
            "b   {success}",
            run_clobber = sym RUN_CLOBBER,
            cloberred = sym CLOBBERED,
            clobber = sym clobber_all_gp_regs,
            error = sym error,
            success = sym success,
            options(noreturn)
        )
    }
}

/// After the verifier task has started, write `0xffffffff` to all general
/// purpose registers.
#[naked]
extern "C" fn clobber_all_gp_regs() -> ! {
    unsafe {
        asm!(
            "0:",
            "ldr  r0, ={run_clobber}",
            // Load the current value of `RUN_CLOBBER`.
            "ldrb r1, [r0]",
            "cmp  r1, #0",
            // Goto cloberring the register if has started.
            "bne  1f",
            // Otherwise, perform a context switch and try again.
            "mov  r0, #0xe0",
            "msr  basepri, r0",
            "mov  r1, #0x10000000",
            "movw r0, #0xed04",
            "movt r0, #0xe000",
            "str  r1, [r0]",
            "mov  r0, #0",
            "msr  basepri, r0",
            "b    0b",
            // The verify task is running now. Clobber all registers. This
            // should not affect the registers in the verify task's context.
            "1:",
            // Set `CLOBERRED` to true.
            "ldr  r0, ={cloberred}",
            "mov  r1, #1",
            "strb r1, [r0]",
            // Clobber registers.
            "mov  r0, #0xffffffff",
            "mov  r1, #0xffffffff",
            "mov  r2, #0xffffffff",
            "mov  r3, #0xffffffff",
            "mov  r4, #0xffffffff",
            "mov  r5, #0xffffffff",
            "mov  r6, #0xffffffff",
            "mov  r7, #0xffffffff",
            "mov  r8, #0xffffffff",
            "mov  r9, #0xffffffff",
            "mov  r10, #0xffffffff",
            "mov  r11, #0xffffffff",
            "mov  r12, #0xffffffff",
            "mov  lr, #0xffffffff",
            // Set `RUN_CLOBBER` to false.
            "ldr  r0, ={run_clobber}",
            "mov  r1, #1",
            "strb r1, [r0]",
            // Perform context switch so that the verifier task can perform
            // the check.
            "mov  r0, #0xe0",
            "msr  basepri, r0",
            "mov  r1, #0x10000000",
            "movw r0, #0xed04",
            "movt r0, #0xe000",
            "str  r1, [r0]",
            "mov  r0, #0",
            "msr  basepri, r0",
            "b    0b",
            run_clobber = sym RUN_CLOBBER,
            cloberred = sym CLOBBERED,
            options(noreturn)
        )
    }
}

extern "C" fn error() -> ! {
    dbg_println!("Test Failed");
    #[cfg(feature = "qemu")]
    semihosting::terminate(false);
    #[cfg(not(feature = "qemu"))]
    {
        dbg_println!("test complete!");
        loop {}
    }
}

extern "C" fn success() -> ! {
    dbg_println!("Test Succeeded");
    #[cfg(feature = "qemu")]
    semihosting::terminate(true);
    #[cfg(not(feature = "qemu"))]
    {
        dbg_println!("test complete!");
        loop {}
    }
}
