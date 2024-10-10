//! Tests that panics can be caught in an interrupt handler.

#![no_main]
#![no_std]
#![feature(naked_functions)]
#![feature(asm_const)]

extern crate alloc;

use core::sync::atomic::{AtomicUsize, Ordering};
use hopter::{
    debug::semihosting::{self, dbg_println},
    interrupt::declare::{handler, irq},
    sync::{self, CondVar, Consumer, Mailbox, Mutex, Semaphore, SpinIrqSafe},
    task::main,
    time,
};
use stm32f4xx_hal::{
    pac::{Interrupt, Peripherals, TIM2},
    prelude::*,
    timer::{CounterUs, Event},
};

irq!(Tim2Irq, Interrupt::TIM2);
static TIMER: SpinIrqSafe<Option<CounterUs<TIM2>>, Tim2Irq> = SpinIrqSafe::new(None);

static CONS: SpinIrqSafe<Option<Consumer<(), 4>>, Tim2Irq> = SpinIrqSafe::new(None);

#[main]
fn main(_cp: cortex_m::Peripherals) {
    let (prod, cons) = sync::create_channel::<(), 4>();
    {
        CONS.lock().replace(cons);
    }

    // Prevent the channel from being dropped during test.
    core::mem::forget(prod);

    let dp = unsafe { Peripherals::steal() };

    // For unknown reason QEMU accepts only the following clock frequency.
    let rcc = dp.RCC.constrain();

    #[cfg(feature = "qemu")]
    let clocks = rcc.cfgr.sysclk(16.MHz()).pclk1(8.MHz()).freeze();
    #[cfg(feature = "stm32f411")]
    let clocks = rcc
        .cfgr
        .use_hse(8.MHz())
        .sysclk(100.MHz())
        .pclk1(25.MHz())
        .pclk2(50.MHz())
        .freeze();
    #[cfg(feature = "stm32f407")]
    let clocks = rcc
        .cfgr
        .use_hse(8.MHz())
        .sysclk(168.MHz())
        .pclk1(42.MHz())
        .pclk2(84.MHz())
        .freeze();

    let mut timer = dp.TIM2.counter(&clocks);

    // Generate an interrupt when the timer expires.
    timer.listen(Event::Update);

    // Enable TIM2 interrupt.
    unsafe {
        cortex_m::peripheral::NVIC::unmask(Interrupt::TIM2);
    }

    // Set the timer to expire every 1 second.
    // Empirically when set to 62 seconds the interval is actually
    // approximately 1 second. Weird QEMU.
    #[cfg(feature = "qemu")]
    timer.start(62.secs()).unwrap();
    #[cfg(not(feature = "qemu"))]
    timer.start(1.secs()).unwrap();

    // Move the timer into the global storage to prevent it from being dropped.
    *TIMER.lock() = Some(timer);
}

/// Get invoked approximately every 1 second.
#[handler(TIM2)]
fn tim2_handler() {
    TIMER.lock().as_mut().unwrap().wait().unwrap();

    static IRQ_CNT: AtomicUsize = AtomicUsize::new(0);
    let prev_cnt = IRQ_CNT.fetch_add(1, Ordering::SeqCst);

    match prev_cnt {
        0 => panic_with_semaphore(),
        1 => panic_with_mutex(),
        2 => panic_with_channel(),
        3 => panic_with_condvar(),
        4 => panic_with_mailbox(),
        5 => panic_with_sleep(),
        _ => {}
    }

    if prev_cnt >= 6 {
        #[cfg(feature = "qemu")]
        semihosting::terminate(true);
        #[cfg(not(feature = "qemu"))]
        {
            dbg_println!("test complete!");
            loop {}
        }
    }
}

fn panic_with_semaphore() {
    static SEM: Semaphore = Semaphore::new(1, 0);

    let pod = PrintOnDrop("Panicked with semaphore.");
    SEM.down();

    // Don't print if not panic.
    core::mem::forget(pod);
}

fn panic_with_mutex() {
    static MTX: Mutex<()> = Mutex::new(());

    let pod = PrintOnDrop("Panicked with mutex.");

    let _mtx_gurad = MTX.lock();
    MTX.lock();

    // Don't print if not panic.
    core::mem::forget(pod);
}

fn panic_with_channel() {
    let cons = { CONS.lock().take().unwrap() };
    let pod = PrintOnDrop("Panicked with channel.");
    cons.consume();

    // Don't print if not panic.
    core::mem::forget(pod);
}

fn panic_with_condvar() {
    static CV: CondVar = CondVar::new();

    let pod = PrintOnDrop("Panicked with condvar.");
    CV.wait_without_lock_until(|| false);

    // Don't print if not panic.
    core::mem::forget(pod);
}

fn panic_with_mailbox() {
    static MAILBOX: Mailbox = Mailbox::new();

    let pod = PrintOnDrop("Panicked with mailbox.");
    MAILBOX.wait();

    // Don't print if not panic.
    core::mem::forget(pod);
}

fn panic_with_sleep() {
    let pod = PrintOnDrop("Panicked with sleep.");
    time::sleep_ms(1000).unwrap();

    // Don't print if not panic.
    core::mem::forget(pod);
}

struct PrintOnDrop(&'static str);

impl Drop for PrintOnDrop {
    fn drop(&mut self) {
        dbg_println!("{}", self.0);
    }
}
