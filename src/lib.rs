#![no_std]
#![feature(core_intrinsics)]
#![feature(naked_functions)]
#![feature(asm_const)]
#![feature(lang_items)]
#![feature(negative_impls)]
#![allow(internal_features)]
#![feature(new_uninit)]
#![feature(unchecked_math)]
#![feature(raw_ref_op)]
#![feature(alloc_error_handler)]

extern crate alloc;

mod allocator;
mod assembly;
mod boot;
mod schedule;
mod unrecoverable;

pub mod config;
pub mod debug;
pub mod interrupt;
pub mod sync;
pub mod task;
pub mod time;
pub mod unwind;
