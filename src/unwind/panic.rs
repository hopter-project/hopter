use crate::unrecoverable;
use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    unrecoverable::die();
}
