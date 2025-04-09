//! The module defines the assembly sequence to execute when the system is just
//! powered on or reset. It sets up basic environment so that Rust code can
//! then execute.

use super::system_init;
use crate::config;
use core::arch::asm;

#[cfg(feature = "unwind")]
use crate::unwind;

/// The very first instruction executed after power on or reset.
#[link_section = ".HopterReset"]
#[export_name = "HopterReset"]
#[naked]
pub(super) unsafe extern "C" fn entry() -> ! {
    asm!(
        // Jump to perform memory initialization.
        "ldr r0, ={memory_init}",
        "bx  r0",
        memory_init = sym memory_init,
        options(noreturn)
    );
}

/// Zero out `.bss` section and copy initial values of `.data` section from flash.
#[naked]
unsafe extern "C" fn memory_init() {
    extern "C" {
        // These symbols come from `link.ld`.
        static mut __sbss: u32;
        static mut __ebss: u32;
        static mut __sdata: u32;
        static mut __edata: u32;
        static __sidata: u32;
        // These symbols come from `crate::assembly::memops`.
        fn memclr(ptr: *mut u8, len: usize);
        fn memcpy(dst: *mut u8, src: *const u8, len: usize) -> *mut u8;
        fn memset(ptr: *mut u8, val: u8, len: usize) -> *mut u8;
    }

    asm!(
        // Fill zero to `.bss` section in SRAM.
        "ldr  r0, ={sbss}",
        "ldr  r1, ={ebss}",
        "subs r1, r1, r0",
        "bl   {memclr}",
        // Copy the `.data` section from flash to SRAM.
        "ldr  r0, ={sdata}",
        "ldr  r1, ={sidata}",
        "ldr  r2, ={edata}",
        "subs r2, r2, r0",
        "bl   {memcpy}",
        // Fill 0xAA to the contiguous stack region. Will help us diagnose
        // stack overflow.
        "ldr  r0, =0x20000000",
        "movs r1, #0xAA",
        "ldr  r2, ={cont_stk_len}",
        "bl   {memset}",
        // Next, perform TLS area initialization.
        "ldr  r0, ={tls_init}",
        "bx   r0",
        sbss = sym __sbss,
        ebss = sym __ebss,
        sdata = sym __sdata,
        edata = sym __edata,
        sidata = sym __sidata,
        cont_stk_len = const { config::_CONTIGUOUS_STACK_BOTTOM - 0x2000_0000 },
        memclr = sym memclr,
        memcpy = sym memcpy,
        memset = sym memset,
        tls_init = sym tls_init,
        options(noreturn)
    )
}

/// Fill the TLS area with initial values.
#[naked]
unsafe extern "C" fn tls_init() {
    asm!(
        // Setting the task local storage (TLS) area.
        // See `task::TaskLocalStorage` for details.
        // Set the `stklet_bound` field.
        "ldr  r1, ={cont_stk_boundary}",
        "ldr  r0, ={stklet_boundary_mem_addr}",
        "str  r1, [r0]",
        // Set the `nested_drop_cnt` and `unwind_pending` field.
        "movs r1, #0",
        "str  r1, [r0, #4]",
        "str  r1, [r0, #8]",
        // Next, perform deferred forced unwinding initialization.
        "ldr  r0, ={deferred_unwind_init}",
        "bx   r0",
        cont_stk_boundary = const config::__CONTIGUOUS_STACK_BOUNDARY,
        stklet_boundary_mem_addr = const config::__TLS_MEM_ADDR,
        deferred_unwind_init = sym deferred_unwind_init,
        options(noreturn)
    )
}

/// Set the deferred forced unwinding entry address.
#[cfg(feature = "unwind")]
#[naked]
unsafe extern "C" fn deferred_unwind_init() {
    asm!(
        // Set the function pointer for deferred forced unwinding. See
        // `unwind::forced` for details.
        "ldr  r0, ={stklet_boundary_mem_addr}",
        "ldr  r1, ={deferred_unwind}",
        "str  r1, [r0, #12]",
        "movs r1, #0",
        "mov  lr, r1",
        // Call into Rust code.
        "ldr  r0, ={system_start}",
        "bx   r0",
        stklet_boundary_mem_addr = const config::__TLS_MEM_ADDR,
        deferred_unwind = sym unwind::forced::deferred_unwind,
        system_start = sym system_init::system_start,
        options(noreturn)
    )
}

#[cfg(not(feature = "unwind"))]
#[naked]
unsafe extern "C" fn deferred_unwind_init() {
    asm!(
        // Call into Rust code when unwinding is not enabled.
        "ldr  r0, ={system_start}",
        "bx   r0",
        system_start = sym system_init::system_start,
        options(noreturn)
    )
}
