use super::super::{schedule, unrecoverable, unwind::unw_catch};
use alloc::boxed::Box;
use core::any::Any;

/// The bundle struct of the entry closure and arguments to start a
/// non-restartable task.
pub(super) struct EntryClosureArg<F, A>
where
    F: FnOnce(A) + Send + 'static,
{
    entry_closure: F,
    entry_arg: A,
}

impl<F, A> EntryClosureArg<F, A>
where
    F: FnOnce(A) + Send + 'static,
{
    pub(super) fn new(entry_closure: F, entry_arg: A) -> Self {
        Self {
            entry_closure,
            entry_arg,
        }
    }
}

/// The entry trampoline function of a non-restartable task. This function is
/// invoked through an exception return, thus the ABI is marked as `extern "C"`
/// and the argument is a raw pointer.
pub(super) extern "C" fn task_entry<F, A>(entry_closure_arg_ptr: *mut u8)
where
    F: FnOnce(A) + Send + 'static,
{
    // Get the bundled entry closure and argument from the raw pointer.
    //
    // Safety: the raw pointer is created through `Box::into_raw`, and the
    // current code is the only one that will ever access the data behind the
    // raw pointer.
    let closure_arg = unsafe { Box::from_raw(entry_closure_arg_ptr as *mut EntryClosureArg<F, A>) };

    // Invoke the task entry closure with the entry argument.
    // Regardless of whether the return was normal or because of panic,
    // silently return the entry trampoline function so that the current task
    // struct will be released.
    let _ = unw_catch::catch_unwind_with_arg(closure_arg.entry_closure, closure_arg.entry_arg);
}

/// The bundle struct of the entry closure and arguments to start a restartable
/// task. The closure and argument has stricter trait bounds than the
/// non-restartable counterpart.
pub(super) struct RestartableEntryFuncArg<F, A>
where
    F: FnOnce(A) + Send + Sync + Clone + 'static,
    A: Send + Sync + Clone + 'static,
{
    entry_closure: F,
    entry_arg: A,
}

impl<F, A> RestartableEntryFuncArg<F, A>
where
    F: FnOnce(A) + Send + Sync + Clone + 'static,
    A: Send + Sync + Clone + 'static,
{
    pub(super) fn new(entry_closure: F, entry_arg: A) -> Self {
        Self {
            entry_closure,
            entry_arg,
        }
    }
}

/// The entry trampoline function of a restartable task. This function is
/// invoked through an exception return, thus the ABI is marked as `extern "C"`
/// and the argument is a raw pointer.
pub(super) extern "C" fn restartable_task_entry<F, A>(entry_closure_arg_ptr: *const u8)
where
    F: FnOnce(A) + Send + Sync + Clone + 'static,
    A: Send + Sync + Clone + 'static,
{
    // Get the bundled entry closure and argument from the raw pointer.
    //
    // Safety: the task struct of the current task holds the ownership of the
    // bundle struct with an `Arc`, thus the raw pointer cannot dangle. Since
    // all the fields of `RestartableEntryFuncArg` are `Sync`, it is safe to
    // access them even if in concurrent with other tasks.
    let closure_arg = unsafe { &*(entry_closure_arg_ptr as *const RestartableEntryFuncArg<F, A>) };

    loop {
        // Execute the task entry closure with the argument. If the task entry
        // closure returns normally, the `catch_result` will be `Ok(())`.
        // Otherwise, if the entry closure returns due to a panic,
        // `catch_result` will be `Err(())`.
        let catch_result = unw_catch::catch_unwind_with_arg(
            closure_arg.entry_closure.clone(),
            closure_arg.entry_arg.clone(),
        );

        // When the task entry closure returns the execution normally, break
        // the loop so that the task can terminate.
        if let Ok(_) = catch_result {
            break;
        }

        // If the task panicked, check if it has already been restarted with
        // another task struct. If yes, we break the loop to let the current
        // task struct terminates.
        if schedule::with_current_task(|cur_task| cur_task.has_restarted()) {
            break;
        }

        // If we reach here, it means the task panicked but has not been
        // restarted yet. Let the loop run over again so that the task can
        // restart execution with the entry closure again.
    }
}

/// Given a `&dyn Any` that points to a `RestartableEntryFuncArg` object,
/// return a `*const u8` pointer that points to the object.
pub(super) fn downcast_to_ptr<F, A>(
    entry_closure_arg: &(dyn Any + Send + Sync + 'static),
) -> *const u8
where
    F: FnOnce(A) + Send + Sync + Clone + 'static,
    A: Send + Sync + Clone + 'static,
{
    match entry_closure_arg.downcast_ref::<RestartableEntryFuncArg<F, A>>() {
        Some(r) => r as *const _ as *const u8,
        None => unrecoverable::die(),
    }
}
