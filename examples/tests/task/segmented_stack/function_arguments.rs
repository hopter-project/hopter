//! Test function arguments passing via both registers and the stack when a new
//! stacklet is allocated for a function call.

#![no_std]
#![no_main]
#![feature(naked_functions)]

extern crate alloc;
use core::arch::asm;
use hopter::{debug::semihosting, hprintln, task, task::main};

#[naked]
extern "C" fn prepare_regs_stack() {
    unsafe {
        asm!(
            // Segmented stack prologue.
            // Stacklet allocation size 36, 20 for preserved values plus 16 for
            // stack arguments.
            // Stack argument size 0.
            "mov.w  r12, #0x20000000",
            "ldr.w  r12, [r12]",
            "subs.w r12, sp, r12",
            "cmp.w  r12, #36",
            "bge.n  0f",
            "svc    #255",
            ".short 9",
            ".short 0",

            // Preserve callee-saved registers and return address.
            "0:",
            "push {{r4-r7, lr}}",

            // Prepare arguments in registers r0-r3.
            "mov r0, #1",
            "mov r1, #2",
            "mov r2, #3",
            "mov r3, #4",

            // Prepare arguments on stack.
            "mov r4, #5",
            "mov r5, #6",
            "mov r6, #7",
            "mov r7, #8",
            "push {{r4-r7}}",

            // Call `verify_arguments` function.
            "bl {verify_arguments}",

            // Discard stack arguments.
            "add sp, #16",

            // Restore callee-saved registers and return.
            "pop {{r4-r7, pc}}",

            verify_arguments = sym verify_arguments,
            options(noreturn)
        )
    }
}

#[naked]
extern "C" fn verify_arguments() {
    unsafe {
        asm!(
            // Segmented stack prologue. Request a huge stack frame of size
            // 16384 bytes, which will very likely cause a new stacklet
            // allocation.
            //
            // Stacklet allocation size 16384.
            // Stack argument size 16.
            "mov.w  r12, #0x20000000",
            "ldr.w  r12, [r12]",
            "subs.w r12, sp, r12",
            "cmp.w  r12, #16384",
            "bge.n  0f",
            "svc    #255",
            ".short 4096",
            ".short 4",

            "0:",
            // Verify register arguments.
            "cmp r0, #1",
            "bne {error}",
            "cmp r1, #2",
            "bne {error}",
            "cmp r2, #3",
            "bne {error}",
            "cmp r3, #4",
            "bne {error}",

            // Verify stack arguments.
            "ldr r0, [sp, #0]",
            "cmp r0, #5",
            "bne {error}",
            "ldr r0, [sp, #4]",
            "cmp r0, #6",
            "bne {error}",
            "ldr r0, [sp, #8]",
            "cmp r0, #7",
            "bne {error}",
            "ldr r0, [sp, #12]",
            "cmp r0, #8",
            "bne {error}",

            // Print success message.
            // This also tests tail call optimization.
            "b   {success}",

            error = sym error,
            success = sym success,
            options(noreturn)
        )
    }
}

extern "C" fn success() {
    hprintln!("Test Passed");
}

extern "C" fn error() {
    hprintln!("Test Failed");
    semihosting::terminate(false);
}

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build()
        .set_entry(|| prepare_regs_stack())
        .spawn()
        .unwrap();
    task::change_current_priority(10).unwrap();
    semihosting::terminate(true);
}
