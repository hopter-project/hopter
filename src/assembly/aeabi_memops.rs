//! __aeabi_mem*() function implementation intended to use with segmented
//! stack (-fsplit-stack) on ARM EABI. These functions simply jump to
//! generic implementations of each operation.
//!
//! These functions should *NOT* consume any stack space. See [`memops`] for
//! details.

use super::memops;
use core::arch::{asm, global_asm};

#[cfg(armv7em)]
#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memset(ptr: *mut u8, cnt: u32, val: u8) {
    asm!(
        "mov r3, r2",
        "mov r2, r1",
        "mov r1, r3",
        "b   {memset}",
        memset = sym memops::memset,
        options(noreturn)
    )
}

#[cfg(armv6m)]
#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memset(ptr: *mut u8, cnt: u32, val: u8) {
    asm!(
        "mov r3, r2",
        "mov r2, r1",
        "mov r1, r3",
        "ldr r3, ={memset}",
        "bx  r3",
        memset = sym memops::memset,
        options(noreturn)
    )
}

global_asm!(
    ".global __aeabi_memset4",
    ".set __aeabi_memset4, __aeabi_memset",
    ".global __aeabi_memset8",
    ".set __aeabi_memset8, __aeabi_memset",
);

global_asm!(
    ".global __aeabi_memcpy",
    ".set __aeabi_memcpy, memcpy",
    ".global __aeabi_memcpy4",
    ".set __aeabi_memcpy4, memcpy",
    ".global __aeabi_memcpy8",
    ".set __aeabi_memcpy8, memcpy",
);

#[cfg(armv7em)]
#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memclr(ptr: *mut u8, cnt: u32) {
    asm!(
        "mov  r2, r1",
        "eors r1, r1",
        "b   {memset}",
        memset = sym memops::memset,
        options(noreturn)
    )
}

#[cfg(armv6m)]
#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memclr(ptr: *mut u8, cnt: u32) {
    asm!(
        "mov  r2, r1",
        "eors r1, r1",
        "ldr  r3, ={memset}",
        "bx   r3",
        memset = sym memops::memset,
        options(noreturn)
    )
}

global_asm!(
    ".global __aeabi_memclr4",
    ".set __aeabi_memclr4, __aeabi_memclr",
    ".global __aeabi_memclr8",
    ".set __aeabi_memclr8, __aeabi_memclr",
);

global_asm!(
    ".global __aeabi_memmove",
    ".set __aeabi_memmove, memmove",
    ".global __aeabi_memmove4",
    ".set __aeabi_memmove4, memmove",
    ".global __aeabi_memmove8",
    ".set __aeabi_memmove8, memmove",
);
