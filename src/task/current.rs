use crate::{config, interrupt::svc, schedule::current};

pub fn yield_current() {
    svc::svc_yield_current_task();
}

pub fn change_current_priority(prio: u8) -> Result<(), ()> {
    if prio >= config::TASK_PRIORITY_LEVELS - 1 {
        return Err(());
    }
    current::with_current_task(|cur_task| cur_task.change_intrinsic_priority(prio));
    svc::svc_yield_current_task();
    Ok(())
}

pub fn get_current_id() -> u8 {
    current::with_current_task(|cur_task| cur_task.get_id())
}
