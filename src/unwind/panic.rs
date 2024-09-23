use crate::unrecoverable;
use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    unrecoverable::die();
}

/* Below are unused personality routines. They are marked unsafe because */
/* they should not be invoked by any programmer's code. */

#[no_mangle]
unsafe extern "C" fn __aeabi_unwind_cpp_pr0() -> ! {
    unrecoverable::die_with_arg("__aeabi_unwind_cpp_pr0: unexpectedly invoked.")
}

#[no_mangle]
unsafe extern "C" fn __aeabi_unwind_cpp_pr1() -> ! {
    unrecoverable::die_with_arg("__aeabi_unwind_cpp_pr1: unexpectedly invoked.")
}

#[no_mangle]
unsafe extern "C" fn __aeabi_unwind_cpp_pr2() -> ! {
    unrecoverable::die_with_arg("__aeabi_unwind_cpp_pr2: unexpectedly invoked.")
}

#[lang = "eh_personality"]
unsafe extern "C" fn eh_personality() {
    unrecoverable::die_with_arg("eh_personality: unexpectedly invoked.")
}
