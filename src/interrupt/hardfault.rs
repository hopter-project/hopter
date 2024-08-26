use super::trap_frame::TrapFrame;
use core::arch::asm;

/// Prepare r0 register to point to the trap frame, so that later we can
/// examine it.
#[export_name = "HardFaultTrampoline"]
#[naked]
pub(crate) unsafe extern "C" fn hardfault_trampoline() {
    asm!(
        // See whether it was running with MSP or PSP before the hardfault.
        "mov r0, lr",
        "mov r1, #4",
        "tst r0, r1",
        "bne 0f",
        // Was running with MSP.
        "mrs r0, MSP",
        "b {hardfault_handler}",
        // Was running with PSP.
        "0:",
        "mrs r0, PSP",
        // Jump to and loop in the hardfault handler.
        "b {hardfault_handler}",
        hardfault_handler = sym hardfault_handler,
        options(noreturn)
    )
}

/// Loop if we run into a hardfault.
#[export_name = "HardFault"]
#[naked]
unsafe extern "C" fn hardfault_handler(_ef: &TrapFrame) -> ! {
    asm!("0:", "b 0b", options(noreturn))
}

/// Loop if default handler is invoked. This means we saw an IRQ but is not
/// prepared to handle it.
#[export_name = "DefaultHandler"]
#[naked]
unsafe extern "C" fn default_handler(_ex_num: i16) {
    asm!("0:", "b 0b", options(noreturn))
}
