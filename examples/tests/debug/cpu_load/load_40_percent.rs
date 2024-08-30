//! Tests if the CPU load inspector returns the correct load value.

#![no_main]
#![no_std]

extern crate alloc;

use alloc::sync::Arc;
use hopter::{
    debug::{
        cpu_load::{LoadInspector, MicrosecPrecision},
        semihosting::{self, dbg_println},
    },
    interrupt::declare::irq,
    sync::SpinIrqSafe,
    task,
    task::main,
    time,
};
use stm32f4xx_hal::{
    pac::{Peripherals, TIM5},
    prelude::*,
    rcc::{Enable, Reset},
};

irq!(Tim5Irq, stm32f4xx_hal::pac::Interrupt::TIM5);

/// Provide microsecond precision timestamp via TIM5.
struct Timestamp(SpinIrqSafe<TIM5, Tim5Irq>);

impl MicrosecPrecision for Timestamp {
    fn read_clock_us(&self) -> u64 {
        let tim5 = self.0.lock();
        tim5.cnt.read().cnt().bits() as u64
    }
}

static LOAD_INSPECTOR: SpinIrqSafe<Option<Arc<LoadInspector<Timestamp>>>, Tim5Irq> =
    SpinIrqSafe::new(None);

#[main]
fn main(_cp: cortex_m::Peripherals) {
    // Can't use `.take()` because internally it calls
    // `cortex_m::interrupt::free()`.
    let dp = unsafe { Peripherals::steal() };

    // For unknown reason QEMU accepts only the following clock frequency.
    let rcc = dp.RCC.constrain();

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

    // Initialize TIM5 to provide microsecond timestamp.
    let tim5 = init_tim5(dp.TIM5);

    // Construct load inspector.
    let usage = LoadInspector::new(Timestamp(SpinIrqSafe::new(tim5)));
    *LOAD_INSPECTOR.lock() = Some(usage);

    // Spawn a task that occupies the CPU by 40%.
    task::build()
        .set_entry(occupy_cpu_40_percent)
        .spawn()
        .unwrap();

    // Spawn a task that prints out CPU load.
    task::build().set_entry(print_load).spawn().unwrap();
}

fn print_load() {
    // Wait a while so that the CPU load is stabilized after boot.
    time::sleep_ms(3000);

    // Print the CPU load 10 times.
    for _ in 0..10 {
        time::sleep_ms(500);
        if let Some(usage) = LOAD_INSPECTOR.lock().as_ref() {
            let (x, y) = usage.get_cpu_load();
            dbg_println!("CPU load {}.{}%", x, y);
        }
    }
    // semihosting::terminate(true);
    semihosting::dbg_println!("test complete!");
    loop {}
}

fn occupy_cpu_40_percent() {
    // Sleep 6 ms and spin 4 ms, thus 40% CPU load.
    loop {
        time::sleep_ms(6);
        let cur_tick = time::get_tick();
        while time::get_tick() < cur_tick + 4 {}
    }
}

/// This is hackish reverse engineering. QEMU is weired that the emulated TIM
/// peripheral behaves in a crazy way. By observing the emulated TIM behavior,
/// this initialization sequence configure TIM5 in a way that we can get the
/// microsecond timestamp from its internal counter.
fn init_tim5(tim5: TIM5) -> TIM5 {
    // The following configuration sequence follows the code in the
    // `stm32f4xx-hal` crate.

    // Enable the clock for TIM5.
    unsafe {
        TIM5::enable_unchecked();
        TIM5::reset_unchecked();
    }

    // When setting the prescaler to the empirical value 995, the counter will
    // be incremented by approximately 1 MHz. Absolutely weird.
    tim5.psc.write(|w| w.psc().bits(995));

    // tim5.enable_counter(false);
    tim5.cr1.modify(|_, w| w.cen().bit(false));

    // tim.reset_counter();
    tim5.cnt.reset();

    // tim.clear_interrupt_flag(Flag::Update.into());
    tim5.sr.write(|w| unsafe { w.bits(0xffff & !(1 as u32)) });

    // Auto-reload configuration has no effect at all. Although the expected
    // behavior is to automatically reset the counter back to zero when it
    // reaches 65535, the emulated TIM5 actually counts all the way up to
    // 2^32 before wrapping around to zero.
    //
    // tim.set_auto_reload(65535)?;
    tim5.arr.write(|w| w.bits(65535));

    // tim.trigger_update();
    tim5.cr1.modify(|_, w| w.urs().set_bit());
    tim5.egr.write(|w| w.ug().set_bit());
    tim5.cr1.modify(|_, w| w.urs().clear_bit());

    // tim.enable_counter(true);
    tim5.cr1.modify(|_, w| w.cen().bit(true));

    // Now we can read the microsecond timestamp with
    // `tim5.cnt.read().cnt().bits()`.

    tim5
}
