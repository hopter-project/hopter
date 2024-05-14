use core::arch::asm;
use hopter_proc_macro::handler;

#[cfg(feature = "exti1_panic")]
#[handler(EXTI1)]
unsafe extern "C" fn exti1_handler() {
    panic!()
}
