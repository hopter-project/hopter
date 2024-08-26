//! Test function return values via registers.

#![no_std]
#![no_main]
#![feature(naked_functions)]

extern crate alloc;
use core::arch::asm;
use hopter::{
    debug::semihosting::{self, dbg_println},
    task,
    task::main,
};

#[naked]
extern "C" fn callee() {
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
            // Set r0-r3 to known values as the return values.
            "mov r0, #25",
            "mov r1, #26",
            "mov r2, #27",
            "mov r3, #28",
            // Return.
            "bx lr",
            options(noreturn)
        )
    }
}

#[naked]
extern "C" fn caller() {
    unsafe {
        asm!(
            // Segmented stack prologue.
            // Stacklet allocation size 4 for preserved return address.
            // stack arguments.
            // Stack argument size 0.
            "mov.w  r12, #0x20000000",
            "ldr.w  r12, [r12]",
            "subs.w r12, sp, r12",
            "cmp.w  r12, #4",
            "bge.n  0f",
            "svc    #255",
            ".short 1",
            ".short 0",

            "0:",
            // Preserve return address.
            "push {{lr}}",

            // Call the callee function.
            "bl {callee}",

            // verify return values in registers r0-r3
            "cmp r0, #25",
            "bne {error}",
            "cmp r1, #26",
            "bne {error}",
            "cmp r2, #27",
            "bne {error}",
            "cmp r3, #28",
            "bne {error}",

            // Print success message.
            "bl {success}",

            // Return.
            "pop {{pc}}",

            callee = sym callee,
            error = sym error,
            success = sym success,
            options(noreturn)
        )
    }
}

extern "C" fn success() {
    dbg_println!("Test Passed");
}

extern "C" fn error() {
    dbg_println!("Test Failed");
    semihosting::terminate(false);
}

#[main]
fn main(_: cortex_m::Peripherals) {
    task::build().set_entry(|| caller()).spawn().unwrap();
    task::change_current_priority(10).unwrap();
    semihosting::terminate(true);
}
