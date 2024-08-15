use alloc::boxed::Box;

#[cfg(feature = "unwind")]
use crate::unwind::unw_catch;

/// The entry trampoline function of a non-restartable task. This function is
/// invoked through an exception return, thus the ABI is marked as `extern "C"`
/// and the parameter is a raw pointer.
pub(super) extern "C" fn task_entry<F>(closure_ptr: *mut u8)
where
    F: FnOnce() + Send + 'static,
{
    // Recover the boxed entry closure from the raw pointer.
    //
    // Safety: the raw pointer is created through `Box::into_raw`, and the
    // current code is the only one that will ever access the data behind the
    // raw pointer.
    let closure = unsafe { Box::from_raw(closure_ptr as *mut F) };

    // Invoke the task entry closure.
    // Regardless of whether the return was normal or because of panic,
    // silently return the entry trampoline function so that the current task
    // struct will be released.
    #[cfg(feature = "unwind")]
    let _ = unw_catch::catch_unwind(*closure);

    #[cfg(not(feature = "unwind"))]
    (*closure)();
}

#[cfg(feature = "unwind")]
use crate::{schedule::current, unrecoverable};
#[cfg(feature = "unwind")]
use core::any::Any;

/// The entry trampoline function of a restartable task. This function is
/// invoked through an exception return, thus the ABI is marked as `extern "C"`
/// and the parameter is a raw pointer.
#[cfg(feature = "unwind")]
pub(super) extern "C" fn restartable_task_entry<F>(closure_ptr: *const u8)
where
    F: FnOnce() + Send + Sync + Clone + 'static,
{
    // Recover the boxed entry closure from the raw pointer.
    //
    // Safety: the task struct of the current task holds the ownership of the
    // bundle struct with an `Arc`, thus the raw pointer cannot dangle. Since
    // the closure is `Sync`, it is safe to access them even if in concurrent
    // with other tasks.
    let closure = unsafe { &*(closure_ptr as *const F) };

    loop {
        // Execute the task entry closure. If the task entry
        // closure returns normally, the `catch_result` will be `Ok(())`.
        // Otherwise, if the entry closure returns due to a panic,
        // `catch_result` will be `Err(())`.
        let catch_result = unw_catch::catch_unwind(closure.clone());

        // When the task entry closure returns the execution normally, break
        // the loop so that the task can terminate.
        if let Ok(_) = catch_result {
            break;
        }

        // If the task panicked, check if it has already been restarted with
        // another task struct. If yes, we break the loop to let the current
        // task struct terminates.
        if current::with_current_task(|cur_task| cur_task.has_restarted()) {
            break;
        }

        // If we reach here, it means the task panicked but has not been
        // restarted yet. Let the loop run over again so that the task can
        // restart execution with the entry closure again.
    }
}

/// Given a `&dyn Any` that points to a closure object that is a restartable
/// entry, return a `*const u8` pointer that points to the object.
#[cfg(feature = "unwind")]
pub(super) fn downcast_to_ptr<F>(closure: &(dyn Any + Send + Sync + 'static)) -> *const u8
where
    F: FnOnce() + Send + Sync + Clone + 'static,
{
    match closure.downcast_ref::<F>() {
        Some(r) => r as *const _ as *const u8,
        None => unrecoverable::die(),
    }
}
