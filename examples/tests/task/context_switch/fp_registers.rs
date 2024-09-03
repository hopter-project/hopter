//! Tests that a context switch maintains all floating point registers.

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

/// Whether the verifier task is running.
static TEST_STARTED: AtomicBool = AtomicBool::new(false);

/// Whether the cloberring task has executed.
static CLOBBERED: AtomicBool = AtomicBool::new(false);

static mut KNOWN_VALUE: [f32; 32] = [
    1f32, 2f32, 3f32, 4f32, 5f32, 6f32, 7f32, 8f32, 9f32, 10f32, 11f32, 12f32, 13f32, 14f32, 15f32,
    16f32, 17f32, 18f32, 19f32, 20f32, 21f32, 22f32, 23f32, 24f32, 25f32, 26f32, 27f32, 28f32,
    29f32, 30f32, 31f32, 32f32,
];

static mut CLOBBERED_VALUE: [f32; 32] = [0f32; 32];

#[main]
fn main(_: cortex_m::Peripherals) {
    // Two tasks have the same priority so will be scheduled round-robin.
    task::build()
        .set_entry(|| verify_registers())
        .set_priority(config::DEFAULT_TASK_PRIORITY)
        .spawn()
        .unwrap();
    task::build()
        .set_entry(|| clobber_all_fp_regs())
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
            // Set `TEST_STARTED` to true.
            "ldr    r0, ={test_started}",
            "mov    r1, #1",
            "strb   r1, [r0]",
            "0:",
            // Set register `s0-s15` to known values.
            "ldr    r0, ={known_value}",
            "vldmia r0, {{s0-s15}}",
            // Trigger context switch.
            "svc    #1",
            // Examine the values of registers `s0-s15`. They should remain the
            // same as before the context switch.
            "ldr    r0, ={known_value}",
            "vldmia r0, {{s16-s31}}",
            "bl     {compare_fp_regs}",
            // Set register `s16-s31` to known values.
            "ldr    r0, ={known_value} + 64",
            "vldmia r0, {{s16-s31}}",
            // Trigger context switch.
            "svc    #1",
            // Examine the values of registers `s16-s31`. They should remain the
            // same as before the context switch.
            "ldr    r0, ={known_value} + 64",
            "vldmia r0, {{s0-s15}}",
            "bl     {compare_fp_regs}",
            // See if the clobbering task has run.
            "ldr    r0, ={clobber}",
            "ldrb   r0, [r0]",
            // If the clobbering task has not run yet, we loop back and do
            // everything another time.
            "cmp    r0, #0",
            "beq    0b",
            // If the clobbering task has run, then we have verified that the
            // registers in this task's context were not affected. Declare
            // success.
            "b     {success}",
            test_started = sym TEST_STARTED,
            known_value = sym KNOWN_VALUE,
            compare_fp_regs = sym compare_fp_regs,
            clobber = sym clobber_all_fp_regs,
            success = sym success,
            options(noreturn)
        )
    }
}

/// After the verifier task has started, write `0xffffffff` to all general
/// purpose registers.
#[naked]
extern "C" fn clobber_all_fp_regs() -> ! {
    unsafe {
        asm!(
            "ldr    r0, ={test_started}",
            "0:",
            // Load the current value of `TEST_STARTED`.
            "ldrb   r1, [r0]",
            "cmp    r1, #0",
            // Goto cloberring the register if has started.
            "bne    1f",
            // Otherwise, perform a context switch and try again.
            "svc    #1",
            "b      0b",
            // The verify task is running now. Clobber all registers. This
            // should not affect the registers in the verify task's context.
            "1:",
            // Set `CLOBERRED` to true.
            "ldr    r0, ={cloberred}",
            "mov    r1, #1",
            "strb   r1, [r0]",
            // Clobber registers.
            "ldr    r0, ={clobbered_value}",
            "vldmia r0, {{s0-s31}}",
            // Perform context switch so that the verifier task can perform
            // the check.
            "2:",
            "svc    #1",
            "b      2b",
            test_started = sym TEST_STARTED,
            clobbered_value = sym CLOBBERED_VALUE,
            cloberred = sym CLOBBERED,
            options(noreturn)
        )
    }
}

/// Verify that floating point register `s{x}` contains the same value as in
/// `s{x+16}` for x in 0..16.
#[naked]
extern "C" fn compare_fp_regs() {
    unsafe {
        asm!(
            "vcmp.f32 s0, s16",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s1, s17",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s2, s18",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s3, s19",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s4, s20",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s5, s21",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s6, s22",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s7, s23",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s8, s24",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s9, s25",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s10, s26",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s11, s27",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s12, s28",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s13, s29",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s14, s30",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "vcmp.f32 s15, s31",
            "vmrs     apsr_nzcv, fpscr",
            "bne      {error}",
            "bx       lr",
            error = sym error,
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
