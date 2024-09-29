use crate::{
    config,
    interrupt::svc,
    schedule::{current, scheduler::Scheduler},
};

/// Switch the current task out of the CPU and let the scheduler pick the next
/// task to run.
pub fn yield_current() {
    // Yield only if the scheduler is not suspended.
    if !Scheduler::is_suspended() {
        svc::svc_yield_current_task();
    }
}

/// Change the priority of the currently running task. Return `Ok(())` if the
/// priority is successfully changed. Return `Err(())` if the given new
/// priority is not allowed by the configuration settings.
///
/// If successful, the new priority will have taken effect when the function
/// returns. If the priority is reduced, any ready task that becomes having a
/// higher priority than the current task will have preempted the current task.
pub fn change_current_priority(prio: u8) -> Result<(), ()> {
    if prio >= config::TASK_PRIORITY_LEVELS - 1 {
        return Err(());
    }
    current::with_cur_task(|cur_task| cur_task.change_intrinsic_priority(prio));
    svc::svc_yield_current_task();
    Ok(())
}

/// Return the ID of the current task. The ID is only for diagnostic purpose
/// and does not have any functional purpose.
pub fn get_current_id() -> u8 {
    current::with_cur_task(|cur_task| cur_task.get_id())
}
