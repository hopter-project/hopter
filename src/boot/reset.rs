//! The module defines the assembly sequence to execute when the system is just
//! powered on or reset. It sets up basic environment so that Rust code can
//! then execute.

use super::system_init;
use crate::{config, unwind};
use core::arch::asm;

#[link_section = ".HopterReset"]
#[export_name = "HopterReset"]
#[naked]
pub(super) unsafe extern "C" fn entry() -> ! {
    extern "C" {
        // These symbols come from `link.ld`
        static mut __sbss: u32;
        static mut __ebss: u32;
        static mut __sdata: u32;
        static mut __edata: u32;
        static __sidata: u32;
        fn memclr(ptr: *mut u8, len: usize);
        fn memcpy(dst: *mut u8, src: *const u8, len: usize);
        fn memset(ptr: *mut u8, val: u8, len: usize);
    }
    asm!(
        // Fill zero to `.bss` section in SRAM.
        "ldr r0, ={sbss}",
        "ldr r1, ={ebss}",
        "sub r1, r1, r0",
        "bl  {memclr}",
        // Copy the `.data` section from flash to SRAM.
        "ldr r0, ={sdata}",
        "ldr r1, ={sidata}",
        "ldr r2, ={edata}",
        "sub r2, r2, r0",
        "bl  {memcpy}",
        // Fill 0xAA to the contiguous stack region. Will help us diagnose
        // stack overflow.
        "mov r0, #0x20000000",
        "mov r1, #0xAA",
        "ldr r2, ={cont_stk_len}",
        "bl  {memset}",
        // Setting the task local storage (TLS) area.
        // See `task::TaskLocalStorage` for details.
        // Set the `stklet_bound` field.
        "ldr r1, ={cont_stk_boundary}",
        "ldr r0, ={stklet_boundary_mem_addr}",
        "str r1, [r0]",
        // Set the `nested_drop_cnt` and `unwind_pending` field.
        "mov r1, #0",
        "str r1, [r0, #4]",
        "str r1, [r0, #8]",
        // Set the function pointer for deferred forced unwinding. See
        // `unwind::forced` for details.
        "ldr r1, ={deferred_unwind}",
        "str r1, [r0, #12]",
        "mov lr, #0",
        // Call into Rust code.
        "b  {system_start}",
        sbss = sym __sbss,
        ebss = sym __ebss,
        sdata = sym __sdata,
        edata = sym __edata,
        sidata = sym __sidata,
        cont_stk_len = const { config::CONTIGUOUS_STACK_BOTTOM - 0x2000_0000 },
        cont_stk_boundary = const config::CONTIGUOUS_STACK_BOUNDARY,
        stklet_boundary_mem_addr = const config::TLS_MEM_ADDR,
        deferred_unwind = sym unwind::forced::deferred_unwind,
        memclr = sym memclr,
        memcpy = sym memcpy,
        memset = sym memset,
        system_start = sym system_init::system_start,
        options(noreturn)
    );
}
