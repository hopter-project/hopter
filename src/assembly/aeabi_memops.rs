//! __aeabi_mem*() function implementation intended to use with segmented
//! stack (-fsplit-stack) on ARM EABI. These functions simply jump to
//! generic implementations of each operation.
//! 
//! These functions should *NOT* consume any stack space. See [`memops`] for
//! details.

use super::memops;
use core::arch::asm;

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

#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memset4(ptr: *mut u8, cnt: u32, val: u8) {
    asm!(
        "b {aeabi_memset}",
        aeabi_memset = sym __aeabi_memset,
        options(noreturn)
    )
}

#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memset8(ptr: *mut u8, cnt: u32, val: u8) {
    asm!(
        "b {aeabi_memset}",
        aeabi_memset = sym __aeabi_memset,
        options(noreturn)
    )
}

#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memcpy(dst: *mut u8, src: *const u8, cnt: u32) {
    asm!(
        "b {memcpy}",
        memcpy = sym memops::memcpy,
        options(noreturn)
    )
}

#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memcpy4(dst: *mut u8, src: *const u8, cnt: u32) {
    asm!(
        "b {memcpy}",
        memcpy = sym memops::memcpy,
        options(noreturn)
    )
}

#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memcpy8(dst: *mut u8, src: *const u8, cnt: u32) {
    asm!(
        "b {memcpy}",
        memcpy = sym memops::memcpy,
        options(noreturn)
    )
}

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

#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memclr4(ptr: *mut u8, cnt: u32) {
    asm!(
        "mov  r2, r1",
        "eors r1, r1",
        "b   {memset}",
        memset = sym memops::memset,
        options(noreturn)
    )
}

#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memclr8(ptr: *mut u8, cnt: u32) {
    asm!(
        "mov  r2, r1",
        "eors r1, r1",
        "b   {memset}",
        memset = sym memops::memset,
        options(noreturn)
    )
}

#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memmove(dst: *mut u8, src: *const u8, cnt: u32) {
    asm!(
        "b {memmove}",
        memmove = sym memops::memmove,
        options(noreturn)
    )
}

#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memmove4(dst: *mut u8, src: *const u8, cnt: u32) {
    asm!(
        "b {memmove}",
        memmove = sym memops::memmove,
        options(noreturn)
    )
}

#[no_mangle]
#[naked]
unsafe extern "C" fn __aeabi_memmove8(dst: *mut u8, src: *const u8, cnt: u32) {
    asm!(
        "b {memmove}",
        memmove = sym memops::memmove,
        options(noreturn)
    )
}
