//! mem*() function implementation intended to use with
//! segmented stack (-fsplit-stack) on ARM EABI.
//!
//! These functions should *NOT* consume any stack space.
//! Compiler intrinsic functions may call these functions.
//! However, these functions do not check stacklet overflow
//! nor allocate new stacklet, because stacklet allocation
//! functions may call these functions through compiler
//! intrinsic functions.
//!
//! Example: __morestack    : will allocate a new chunk
//!       -> __malloc       : will set the bit map
//!       -> __aeabi_memset : compiler invoked intrinsic
//!       -> memset         : SHOULD NOT CALL __morestack

use core::arch::asm;

#[cfg(armv7em)]
#[no_mangle]
#[naked]
pub(super) unsafe extern "C" fn memset(ptr: *mut u8, val: u8, cnt: u32) -> *mut u8 {
    asm!(
        "cbz  r2, 1f",
        "mov  r3, r0",
        "0:",
        "subs r2, #1",
        "strb r1, [r3], #1",
        "bne  0b",
        "1:",
        "bx   lr",
        options(noreturn)
    )
}

#[cfg(armv6m)]
#[no_mangle]
#[naked]
pub(super) unsafe extern "C" fn memset(ptr: *mut u8, val: u8, cnt: u32) -> *mut u8 {
    asm!(
        "cmp  r2, #0",
        "beq  1f",
        "mov  r3, r0",
        "0:",
        "strb r1, [r3]",
        "adds r3, #1",
        "subs r2, #1",
        "bne  0b",
        "1:",
        "bx   lr",
        options(noreturn)
    )
}

#[cfg(armv7em)]
#[no_mangle]
#[naked]
pub(super) unsafe extern "C" fn memclr(ptr: *mut u8, cnt: u32) {
    asm!(
        "mov  r2, r1",
        "eors r1, r1",
        "b    {memset}",
        memset = sym memset,
        options(noreturn)
    )
}

#[cfg(armv6m)]
#[no_mangle]
#[naked]
pub(super) unsafe extern "C" fn memclr(ptr: *mut u8, cnt: u32) {
    asm!(
        "mov  r2, r1",
        "eors r1, r1",
        "ldr  r3, ={memset}",
        "bx   r3",
        memset = sym memset,
        options(noreturn)
    )
}

#[cfg(armv7em)]
#[no_mangle]
#[naked]
pub(super) unsafe extern "C" fn memcpy(dst: *mut u8, src: *const u8, cnt: u32) -> *mut u8 {
    asm!(
        "cbz  r2, 1f",
        "0:",
        "subs r2, #1",
        "ldrb r3, [r1, r2]",
        "strb r3, [r0, r2]",
        "bne  0b",
        "1:",
        "bx   lr",
        options(noreturn)
    )
}

#[cfg(armv6m)]
#[no_mangle]
#[naked]
pub(super) unsafe extern "C" fn memcpy(dst: *mut u8, src: *const u8, cnt: u32) -> *mut u8 {
    asm!(
        "cmp  r2, #0",
        "beq  1f",
        "0:",
        "subs r2, #1",
        "ldrb r3, [r1, r2]",
        "strb r3, [r0, r2]",
        "bne  0b",
        "1:",
        "bx   lr",
        options(noreturn)
    )
}

#[cfg(armv7em)]
#[no_mangle]
#[naked]
pub(super) unsafe extern "C" fn memcpy_fwd(dst: *mut u8, src: *const u8, cnt: u32) -> *mut u8 {
    asm!(
        "cbz  r2, 1f",
        "mov  r12, r0",
        "adds r2, r0",
        "0:",
        "ldrb r3, [r1], #1",
        "strb r3, [r0], #1",
        "cmp  r2, r0",
        "bne  0b",
        "mov  r0, r12",
        "1:",
        "bx   lr",
        options(noreturn)
    )
}

#[cfg(armv6m)]
#[no_mangle]
#[naked]
pub(super) unsafe extern "C" fn memcpy_fwd(dst: *mut u8, src: *const u8, cnt: u32) -> *mut u8 {
    asm!(
        "cmp  r2, #0",
        "beq  1f",
        "mov  r12, r0",
        "adds r2, r0",
        "0:",
        "ldrb r3, [r1]",
        "adds r1, #1",
        "strb r3, [r0]",
        "adds r0, #1",
        "cmp  r2, r0",
        "bne  0b",
        "mov  r0, r12",
        "1:",
        "bx   lr",
        options(noreturn)
    )
}

#[cfg(armv7em)]
#[no_mangle]
#[naked]
pub(super) unsafe extern "C" fn memmove(dst: *mut u8, src: *const u8, cnt: u32) -> *mut u8 {
    asm!(
        "cmp r0, r1",
        "ble 0f",
        "b {memcpy_bkwd}",
        "0:",
        "b {memcpy_fwd}",
        memcpy_bkwd = sym memcpy,
        memcpy_fwd = sym memcpy_fwd,
        options(noreturn)
    )
}

#[cfg(armv6m)]
#[no_mangle]
#[naked]
pub(super) unsafe extern "C" fn memmove(dst: *mut u8, src: *const u8, cnt: u32) -> *mut u8 {
    asm!(
        "cmp r0, r1",
        "ble 0f",
        "ldr r3, ={memcpy_bkwd}",
        "bx  r3",
        "0:",
        "ldr r3, ={memcpy_fwd}",
        "bx  r3",
        memcpy_bkwd = sym memcpy,
        memcpy_fwd = sym memcpy_fwd,
        options(noreturn)
    )
}
