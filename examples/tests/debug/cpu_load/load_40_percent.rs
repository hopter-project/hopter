//! Tests if the CPU load inspector returns the correct load value.

#![no_main]
#![no_std]
#![feature(naked_functions)]

extern crate alloc;

use alloc::{sync::Arc, vec::Vec};
use hopter::{
    debug::{
        cpu_load::{LoadInspector, MicrosecPrecision},
        semihosting::dbg_println,
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
struct Timestamp(Arc<SpinIrqSafe<TIM5, Tim5Irq>>);

impl MicrosecPrecision for Timestamp {
    #[cfg(feature = "qemu")]
    fn read_clock_us(&self) -> u64 {
        let tim5 = self.0.lock();
        tim5.cnt.read().cnt().bits() as u64
    }

    #[cfg(not(feature = "qemu"))]
    fn read_clock_us(&self) -> u64 {
        let tim5 = self.0.lock();

        // Get the higher half of the counter.
        let prev_high = TIMESTAMP_HIGH.load(Ordering::SeqCst);

        // Get the lower half of the counter.
        let cnt = tim5.cnt.read().cnt().bits();

        // Get the higher half of the counter again.
        let cur_high = TIMESTAMP_HIGH.load(Ordering::SeqCst);

        // If the higher half was not incremented during our read of the lower half,
        // combine the higher and lower half and return the result.
        if prev_high == cur_high {
            (prev_high as u64) << 16 | (cnt as u64)

        // Otherwise, the higher half was just incremented. The lower half we just
        // read possibly just wrapped round to a very small value. We should read
        // the lower half again and combine it with the new higher half. We do not
        // expect to see the higher half get incremented again very soon.
        } else {
            let cnt = tim5.cnt.read().cnt().bits();
            (cur_high as u64) << 16 | (cnt as u64)
        }
    }
}

#[main]
fn main(_cp: cortex_m::Peripherals) {
    // Can't use `.take()` because internally it calls
    // `cortex_m::interrupt::free()`.
    let dp = unsafe { Peripherals::steal() };

    let rcc = dp.RCC.constrain();

    // For unknown reason QEMU accepts only the following clock frequency.
    #[cfg(feature = "qemu")]
    rcc.cfgr.sysclk(16.MHz()).pclk1(8.MHz()).freeze();

    // Bring to the max frequency of stm32f411.
    #[cfg(feature = "stm32f411")]
    rcc.cfgr
        .use_hse(8.MHz())
        .sysclk(100.MHz())
        .pclk1(25.MHz())
        .pclk2(50.MHz())
        .freeze();

    // Bring to the max frequency of stm32f407.
    #[cfg(feature = "stm32f407")]
    rcc.cfgr
        .use_hse(8.MHz())
        .sysclk(168.MHz())
        .pclk1(42.MHz())
        .pclk2(84.MHz())
        .freeze();

    // Initialize TIM5 to provide microsecond timestamp.
    let tim5 = Arc::new(SpinIrqSafe::new(init_tim5(dp.TIM5)));

    // Construct load inspector.
    let load_inspector = LoadInspector::new(Timestamp(Arc::clone(&tim5)));

    #[cfg(not(feature = "qemu"))]
    {
        *TIM5.lock() = Some(tim5);
        unsafe {
            cortex_m::peripheral::NVIC::unmask(stm32f4xx_hal::pac::Interrupt::TIM5);
        }
    }

    // Spawn a task that occupies the CPU by 40%.
    task::build()
        .set_entry(occupy_cpu_40_percent)
        .spawn()
        .unwrap();

    // Spawn a task that prints out CPU load.
    task::build()
        .set_entry(move || print_load(&load_inspector))
        .spawn()
        .unwrap();
}

fn print_load(load_inspector: &LoadInspector<Timestamp>) {
    // Wait a while so that the CPU load is stabilized after boot.
    time::sleep_ms(3000).unwrap();

    let mut vec = Vec::new();

    // Print the CPU load 10 times.
    for _ in 0..10 {
        time::sleep_ms(500).unwrap();
        vec.push(load_inspector.get_cpu_load());
    }

    for (x, y) in vec {
        dbg_println!("CPU load {}.{}%", x, y);
    }

    #[cfg(feature = "qemu")]
    hopter::debug::semihosting::terminate(true);
    #[cfg(not(feature = "qemu"))]
    {
        dbg_println!("test complete!");
        loop {}
    }
}

fn occupy_cpu_40_percent() {
    // Sleep 6 ms and spin 4 ms, thus 40% CPU load.
    loop {
        time::sleep_ms(6).unwrap();
        let cur_tick = time::get_tick();
        while time::get_tick() < cur_tick + 4 {}
    }
}

/// This is hackish reverse engineering. QEMU is weired that the emulated TIM
/// peripheral behaves in a crazy way. By observing the emulated TIM behavior,
/// this initialization sequence configure TIM5 in a way that we can get the
/// microsecond timestamp from its internal counter.
#[cfg(feature = "qemu")]
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

#[cfg(not(feature = "qemu"))]
use hopter::interrupt::declare::handler;

#[cfg(not(feature = "qemu"))]
use core::sync::atomic::{AtomicU32, Ordering};

#[cfg(not(feature = "qemu"))]
static TIMESTAMP_HIGH: AtomicU32 = AtomicU32::new(0);

#[cfg(not(feature = "qemu"))]
static TIM5: SpinIrqSafe<Option<Arc<SpinIrqSafe<TIM5, Tim5Irq>>>, Tim5Irq> = SpinIrqSafe::new(None);

#[cfg(not(feature = "qemu"))]
fn init_tim5(tim5: TIM5) -> TIM5 {
    // The following configuration sequence follows the code in the
    // `stm32f4xx-hal` crate.

    // Enable the clock for TIM5.
    unsafe {
        TIM5::enable_unchecked();
        TIM5::reset_unchecked();
    }

    // Let the counter increment every microsecond.
    #[cfg(feature = "stm32f407")]
    tim5.psc.write(|w| w.psc().bits(83));
    #[cfg(feature = "stm32f411")]
    tim5.psc.write(|w| w.psc().bits(49));

    // tim5.enable_counter(false);
    tim5.cr1.modify(|_, w| w.cen().clear_bit());

    // tim.reset_counter();
    tim5.cnt.reset();

    // tim.clear_interrupt_flag(Flag::Update.into());
    tim5.sr.write(|w| unsafe { w.bits(0xffff & !(1 as u32)) });

    // Let the counter overflow at 65536.
    tim5.arr.write(|w| w.bits(65535));

    // When the counter overflows, generate an interrupt.
    tim5.dier.modify(|_, w| w.uie().set_bit());

    // tim.trigger_update();
    tim5.cr1.modify(|_, w| w.urs().set_bit());
    tim5.egr.write(|w| w.ug().set_bit());
    tim5.cr1.modify(|_, w| w.urs().clear_bit());

    // tim.enable_counter(true);
    tim5.cr1.modify(|_, w| w.cen().set_bit());

    tim5
}

#[cfg(not(feature = "qemu"))]
#[handler(TIM5)]
fn tim5_handler() {
    // Increase the high half of the timestamp.
    TIMESTAMP_HIGH.fetch_add(1, Ordering::SeqCst);

    // Acknowledge the interrupt.
    let mut tim5 = TIM5.lock();
    let tim5 = tim5.as_mut().unwrap();
    let tim5 = tim5.lock();
    tim5.sr.modify(|_, w| w.uif().clear_bit());
}
