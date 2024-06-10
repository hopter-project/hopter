//! Enable printing to and the termination of the debugging agent.
//!
//! When running with QEMU with `-semihosting-config enable=on,target=native`,
//! printed characters will appear on the QEMU console, and [`terminate`]
//! causes QEMU to exit.
//!
//! When running with physical hardware connected to an OpenOCD session,
//! printed characters will appear on the OpenOCD terminal. [`terminate`]
//! should *not* be used in this setup, because it will clobber OpenOCD's
//! internal states.
//!
//! The source file is adapted from the `cortex-m-semihosting` crate version 5.0.
//! Modification is done to avoid using `cortex_m::interrupt::free`, as it will
//! cause HardFault if the segmented stack tries to extend when the interrupt is
//! globally masked.
//!
//! Original license: https://opensource.org/license/mit

use super::super::sync::{AllIrqExceptSvc, SpinSchedIrqSafe};
use core::fmt::{self, Write};
use cortex_m_semihosting::{
    debug,
    hio::{self, HostStream},
};

pub fn terminate(success: bool) -> ! {
    if success {
        debug::exit(debug::EXIT_SUCCESS);
    } else {
        debug::exit(debug::EXIT_FAILURE);
    }
    loop {}
}

static HSTDOUT: SpinSchedIrqSafe<Option<HostStream>, AllIrqExceptSvc> = SpinSchedIrqSafe::new(None);

pub fn hstdout_str(s: &str) {
    let mut hstdout = HSTDOUT.lock_now_or_die();
    if hstdout.is_none() {
        *hstdout = Some(hio::hstdout().unwrap());
    }

    let _ = hstdout.as_mut().unwrap().write_str(s).map_err(drop);
}

pub fn hstdout_fmt(args: fmt::Arguments) {
    let mut hstdout = HSTDOUT.lock_now_or_die();
    if hstdout.is_none() {
        *hstdout = Some(hio::hstdout().unwrap());
    }

    let _ = hstdout.as_mut().unwrap().write_fmt(args).map_err(drop);
}

static HSTDERR: SpinSchedIrqSafe<Option<HostStream>, AllIrqExceptSvc> = SpinSchedIrqSafe::new(None);

pub fn hstderr_str(s: &str) {
    let mut hstderr = HSTDERR.lock_now_or_die();
    if hstderr.is_none() {
        *hstderr = Some(hio::hstderr().unwrap());
    }

    let _ = hstderr.as_mut().unwrap().write_str(s).map_err(drop);
}

pub fn hstderr_fmt(args: fmt::Arguments) {
    let mut hstderr = HSTDERR.lock_now_or_die();
    if hstderr.is_none() {
        *hstderr = Some(hio::hstderr().unwrap());
    }

    let _ = hstderr.as_mut().unwrap().write_fmt(args).map_err(drop);
}

/// Macro for printing to the HOST standard output.
///
/// This is similar to the `print!` macro in the standard library. Both will panic on any failure to
/// print.
#[macro_export]
macro_rules! hprint {
    ($s:expr) => {
        $crate::debug::semihosting::hstdout_str($s)
    };
    ($($tt:tt)*) => {
        $crate::debug::semihosting::hstdout_fmt(format_args!($($tt)*))
    };
}

/// Macro for printing to the HOST standard output, with a newline.
///
/// This is similar to the `println!` macro in the standard library. Both will panic on any failure to
/// print.
#[macro_export]
macro_rules! hprintln {
    () => {
        $crate::debug::semihosting::hstdout_str("\n")
    };
    ($s:expr) => {
        $crate::debug::semihosting::hstdout_str(concat!($s, "\n"))
    };
    ($s:expr, $($tt:tt)*) => {
        $crate::debug::semihosting::hstdout_fmt(format_args!(concat!($s, "\n"), $($tt)*))
    };
}

/// Macro for printing to the HOST standard error.
///
/// This is similar to the `eprint!` macro in the standard library. Both will panic on any failure
/// to print.
#[macro_export]
macro_rules! heprint {
    ($s:expr) => {
        $crate::debug::semihosting::hstderr_str($s)
    };
    ($($tt:tt)*) => {
        $crate::debug::semihosting::hstderr_fmt(format_args!($($tt)*))
    };
}

/// Macro for printing to the HOST standard error, with a newline.
///
/// This is similar to the `eprintln!` macro in the standard library. Both will panic on any failure
/// to print.
#[macro_export]
macro_rules! heprintln {
    () => {
        $crate::debug::semihosting::hstderr_str("\n")
    };
    ($s:expr) => {
        $crate::debug::semihosting::hstderr_str(concat!($s, "\n"))
    };
    ($s:expr, $($tt:tt)*) => {
        $crate::debug::semihosting::hstderr_fmt(format_args!(concat!($s, "\n"), $($tt)*))
    };
}
