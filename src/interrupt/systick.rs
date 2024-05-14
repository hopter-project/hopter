use core::arch::asm;

/// Entry function for handling SysTick interrupt.
/// Prepare the handler in the r0 register and start the IRQ handling.
#[naked]
#[export_name = "SysTick"]
unsafe extern "C" fn systick_entry() {
    asm!(
        "ldr r0, ={systick_handler}",
        "b {fast_irq_entry}",
        fast_irq_entry = sym super::default::fast_irq_entry,
        systick_handler = sym systick_handler,
        options(noreturn)
    )
}

/// We simply need to advance the tick count when SysTick fires.
unsafe extern "C" fn systick_handler() {
    use super::super::time;
    time::advance_tick();
    time::wake_sleeping_tasks();
}
