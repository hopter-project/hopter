//! Support for catching a panic while a panicked `Task` is being unwound.
//!
//! The source code is adopted from Theseus OS:
//! <https://github.com/theseus-os/Theseus/blob/23bcfce0eb/kernel/catch_unwind/src/lib.rs>
//!

use super::unwind::UnwindState;
use core::mem::ManuallyDrop;

/// Invokes the given closure `f`, catching a panic as it is unwinding the stack.
///
/// Returns `Ok(R)` if the closure `f` executes and returns successfully,
/// otherwise returns `Err(cause)` if the closure panics, where `cause` is the original cause of the panic.
/// Currently `cause` is always `()`. We reserve it for future use.
///  
/// This function behaves similarly to the libstd version,
/// so please see its documentation here: <https://doc.rust-lang.org/std/panic/fn.catch_unwind.html>.
pub fn catch_unwind<F, R>(f: F) -> Result<R, ()>
where
    F: FnOnce() -> R,
{
    // The `try()` intrinsic accepts only one "data" pointer as its only argument.
    let mut ti_arg = TryIntrinsicArg {
        func: ManuallyDrop::new(f),
        // The initial value of `ret` doesn't matter. It will get replaced in all code paths.
        ret: ManuallyDrop::new(Err(())),
    };

    // Invoke the actual try() intrinsic, which will jump to `try_intrinsic_trampoline`
    let _try_val = unsafe {
        core::intrinsics::catch_unwind(
            try_intrinsic_trampoline::<F, R>,
            &mut ti_arg as *mut _ as *mut u8,
            panic_callback::<F, R>,
        )
    };

    // When `try` returns zero, it means the function ran successfully without panicking.
    // The `Ok(R)` value was assigned to `ret` at the end of `try_intrinsic_trampoline()` below.
    // When `try` returns non-zero, it means the function panicked.
    // The `panic_callback()` would have already been invoked, and it would have set `ret` to `Err(())`.
    //
    // In both cases, we can just return the value `ret` field, which has been assigned the proper value.
    ManuallyDrop::into_inner(ti_arg.ret)
}

/// This function will be automatically invoked by the `try` intrinsic above
/// upon catching a panic.
/// # Arguments
/// * a pointer to the try arguments,
/// * a pointer to the arbitrary object passed around during the unwinding process,
///   which is a pointer to the `UnwindState`.
fn panic_callback<F, R>(ti_arg_ptr: *mut u8, unwind_state_ptr: *mut u8)
where
    F: FnOnce() -> R,
{
    let data = unsafe { &mut *(ti_arg_ptr as *mut TryIntrinsicArg<F, R>) };
    unsafe { UnwindState::drop_from_ptr(unwind_state_ptr as *mut UnwindState) };
    data.ret = ManuallyDrop::new(Err(()));
}

/// A struct to accommodate the weird signature of `core::intrinsics::try`,
/// which accepts only a single pointer to this structure.
/// We model this after Rust libstd's wrappers around gcc-based unwinding, but modify it to contain one argument.
struct TryIntrinsicArg<F, R>
where
    F: FnOnce() -> R,
{
    /// The function that will be invoked in the `try()` intrinsic.
    func: ManuallyDrop<F>,
    /// The return value of the above function, which is an output parameter.
    /// Note that this is only filled in by the `try()` intrinsic if the function returns successfully.
    ret: ManuallyDrop<Result<R, ()>>,
}

/// This is the function that the `try()` intrinsic will jump to.
/// Since that intrinsic requires a `fn` ptr, we can't just directly call a closure `F` here because it's a `FnOnce` trait.
///
/// This function should not be called directly in our code.
fn try_intrinsic_trampoline<F, R>(try_intrinsic_arg: *mut u8)
where
    F: FnOnce() -> R,
{
    unsafe {
        let data = try_intrinsic_arg as *mut TryIntrinsicArg<F, R>;
        let data = &mut *data;
        let f = ManuallyDrop::take(&mut data.func);
        data.ret = ManuallyDrop::new(
            Ok(f()), // actually invoke the function
        );
    }
}
