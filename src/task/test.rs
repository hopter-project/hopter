use super::super::{interrupt::SVCNum, unrecoverable};
use core::arch::asm;

#[no_mangle]
static mut FLOAT_CONST: [f32; 32] = [
    1f32, 2f32, 3f32, 4f32, 5f32, 6f32, 7f32, 8f32, 9f32, 10f32, 11f32, 12f32, 13f32, 14f32, 15f32,
    16f32, 17f32, 18f32, 19f32, 20f32, 21f32, 22f32, 23f32, 24f32, 25f32, 26f32, 27f32, 28f32,
    29f32, 30f32, 31f32, 32f32,
];

#[naked]
extern "C" fn verify_ctxt_switch_low_gp_regs() -> ! {
    unsafe {
        asm!(
            // Prepare constant in low registers.
            "mov r0, #1",
            "mov r1, #2",
            "mov r2, #3",
            "mov r3, #4",
            "mov r4, #5",
            "mov r5, #6",
            "mov r6, #7",
            "mov r7, #8",
            // Trigger context switch.
            "svc {task_yield}",
            // Test low registers after context switch.
            "cmp r0, #1",
            "bne {error}",
            "cmp r1, #2",
            "bne {error}",
            "cmp r2, #3",
            "bne {error}",
            "cmp r3, #4",
            "bne {error}",
            "cmp r4, #5",
            "bne {error}",
            "cmp r5, #6",
            "bne {error}",
            "cmp r6, #7",
            "bne {error}",
            "cmp r7, #8",
            "bne {error}",
            "bx lr",
            task_yield = const(SVCNum::TaskYield as u8),
            error = sym context_switch_error,
            options(noreturn)
        )
    }
}

#[naked]
extern "C" fn verify_ctxt_switch_high_gp_regs() -> ! {
    unsafe {
        asm!(
            // Prepare constant in high registers.
            "mov r8, #9",
            "mov r10, #11",
            "mov r11, #12",
            "mov r12, #13",
            // Trigger context switch.
            "svc {task_yield}",
            // Test high registers after context switch.
            "cmp r8, #9",
            "bne {error}",
            "cmp r10, #11",
            "bne {error}",
            "cmp r11, #12",
            "bne {error}",
            "cmp r12, #13",
            "bne {error}",
            "bx lr",
            task_yield = const(SVCNum::TaskYield as u8),
            error = sym context_switch_error,
            options(noreturn)
        )
    }
}

#[naked]
extern "C" fn verify_ctxt_switch_special_gp_regs() -> ! {
    unsafe {
        asm!(
            // Prepare special registers.
            "push {{r9, lr}}",
            // Trigger context switch.
            "svc {task_yield}",
            // Test special registers after context switch.
            "pop {{r0, r1}}",
            "cmp r0, r9",
            "bne {error}",
            "cmp r1, lr",
            "bne {error}",
            "bx lr",
            task_yield = const(SVCNum::TaskYield as u8),
            error = sym context_switch_error,
            options(noreturn)
        )
    }
}

#[naked]
extern "C" fn verify_ctxt_switch_low_fp_regs() -> ! {
    unsafe {
        asm!(
            // Prepare low floating point registers.
            "movw r0, :lower16:{float_const}",
            "movt r0, :upper16:{float_const}",
            "vldmia r0, {{s0-s15}}",
            // Trigger context switch.
            "svc {task_yield}",
            // Test low floating point registers after context switch.
            "movw r0, :lower16:{float_const}",
            "movt r0, :upper16:{float_const}",
            "vldmia r0, {{s16-s31}}",
            "b {cmp_fp_regs}",
            float_const = sym FLOAT_CONST,
            task_yield = const(SVCNum::TaskYield as u8),
            cmp_fp_regs = sym verify_ctxt_switch_cmp_fp_regs,
            options(noreturn)
        )
    }
}

#[naked]
extern "C" fn verify_ctxt_switch_high_fp_regs() -> ! {
    unsafe {
        asm!(
            // Prepare high floating point registers.
            "movw r0, :lower16:{float_const}",
            "movt r0, :upper16:{float_const}",
            "add  r0, #64",
            "vldmia r0, {{s16-s31}}",
            // Trigger context switch.
            "svc {task_yield}",
            // Test high floating point registers after context switch.
            "movw r0, :lower16:{float_const}",
            "movt r0, :upper16:{float_const}",
            "add  r0, #64",
            "vldmia r0, {{s0-s15}}",
            "b {cmp_fp_regs}",
            float_const = sym FLOAT_CONST,
            task_yield = const(SVCNum::TaskYield as u8),
            cmp_fp_regs = sym verify_ctxt_switch_cmp_fp_regs,
            options(noreturn)
        )
    }
}

#[naked]
extern "C" fn verify_ctxt_switch_cmp_fp_regs() -> ! {
    unsafe {
        asm!(
            "vcmp.f32 s0, s16",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s1, s17",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s2, s18",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s3, s19",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s4, s20",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s5, s21",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s6, s22",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s7, s23",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s8, s24",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s9, s25",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s10, s26",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s11, s27",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s12, s28",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s13, s29",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s14, s30",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "vcmp.f32 s15, s31",
            "vmrs apsr_nzcv, fpscr",
            "bne {error}",
            "bx lr",
            error = sym context_switch_error,
            options(noreturn)
        )
    }
}

#[allow(unused)]
#[naked]
pub extern "C" fn verify_context_switch() -> ! {
    unsafe {
        asm!(
            "0:",
            "bl {test_low_gp_regs}",
            "bl {test_high_gp_regs}",
            "bl {test_special_gp_regs}",
            "bl {test_low_fp_regs}",
            "bl {test_high_fp_regs}",
            "b 0b",
            test_low_gp_regs = sym verify_ctxt_switch_low_gp_regs,
            test_high_gp_regs = sym verify_ctxt_switch_high_gp_regs,
            test_special_gp_regs = sym verify_ctxt_switch_special_gp_regs,
            test_low_fp_regs = sym verify_ctxt_switch_low_fp_regs,
            test_high_fp_regs = sym verify_ctxt_switch_high_fp_regs,
            options(noreturn)
        )
    }
}

extern "C" fn context_switch_error() -> ! {
    unrecoverable::die()
}
