use super::IdleCallback;
use core::sync::atomic::{AtomicBool, AtomicU32, AtomicUsize, Ordering};

/// Each slot corresponds to `US_PER_SLOT` microseconds. Each slot count the number
/// of microseconds that the idle task is running during the preriod it corresponds to.
/// This is roughly one second.
const US_PER_SLOT: u32 = 1 << 20;

/// A bit mask used for calculating the number of microseconds that falls in a slot.
const SLOT_PERIOD_MASK: u32 = US_PER_SLOT - 1;

pub struct CpuUsage<Clock>
where
    Clock: MicrosecPrecision + Send + Sync,
{
    idle_start_time_low: AtomicU32,
    idle_start_time_high: AtomicU32,
    slots: [AtomicU32; 4],
    recent_slot_idx: AtomicUsize,
    completely_idle: AtomicBool,
    clock: Clock,
}

impl<Clock> CpuUsage<Clock>
where
    Clock: MicrosecPrecision + Send + Sync,
{
    pub fn new(clock: Clock) -> Self {
        Self {
            idle_start_time_low: Default::default(),
            idle_start_time_high: Default::default(),
            slots: Default::default(),
            recent_slot_idx: Default::default(),
            completely_idle: Default::default(),
            clock,
        }
    }

    /// Set the saved timestamp to the given value and return the previous value.
    /// The timestamp is the time when the idle task is chosen by the scheduler to run.
    fn swap_idle_start_timestamp(&self, cur_ts: u64) -> u64 {
        let prev_low = self.idle_start_time_low.load(Ordering::Acquire);
        let prev_high = self.idle_start_time_high.load(Ordering::Acquire);
        let cur_low = cur_ts as u32;
        let cur_high = (cur_ts >> 32) as u32;
        self.idle_start_time_low.store(cur_low, Ordering::Release);
        self.idle_start_time_high.store(cur_high, Ordering::Release);

        ((prev_high as u64) << 32) | (prev_low as u64)
    }

    fn update_slots(&self, from_ts: u64, to_ts: u64) {
        let from_ts_high = from_ts / (US_PER_SLOT as u64);
        let to_ts_high = to_ts / (US_PER_SLOT as u64);

        // If the last run of the idle task spans across 3 slots, it must have
        // continuously run more than 1 second. We treat this as completely idle.
        // We set the completely idle flag and clear the slots.
        // FIXME: maybe should not clear all of the slots?
        if to_ts_high - from_ts_high >= 2 {
            self.completely_idle.store(true, Ordering::Relaxed);
            for slot in self.slots.iter() {
                slot.store(0, Ordering::Relaxed);
            }
            return;
        }

        // The last idle execution spans from `from_slot_idx` to `to_slot_idx`.
        let from_slot_idx = (from_ts_high % 4) as usize;
        let to_slot_idx = (to_ts_high % 4) as usize;

        // Clear the two slots in the future.
        for idx in (to_slot_idx + 1)..=(to_slot_idx + 2) {
            let idx = idx % 4;
            self.slots[idx].store(0, Ordering::Relaxed);
        }

        // Count the microseconds that the idle task ran through into the
        // corresponding slots.
        for idx in from_slot_idx..=to_slot_idx {
            let idx = idx % 4;

            if idx == from_slot_idx && idx == to_slot_idx {
                let incr = (to_ts - from_ts) as u32;
                self.slots[idx].fetch_add(incr, Ordering::Relaxed);
            } else if idx == from_slot_idx {
                let incr = US_PER_SLOT - ((from_ts as u32) & SLOT_PERIOD_MASK);
                self.slots[idx].fetch_add(incr, Ordering::Relaxed);
            } else {
                let incr = (to_ts as u32) & SLOT_PERIOD_MASK;
                self.slots[idx].fetch_add(incr, Ordering::Relaxed);
            }
        }

        // Update the recent slot index.
        self.recent_slot_idx.store(to_slot_idx, Ordering::Relaxed);
    }

    /// Get the current CPU load. The load is returned in a pair, representing the
    /// integer part (x) and the decimal part (y) of the CPU load. The load should be
    /// interpreted as a percentage (x.y%).
    pub fn get_cpu_load(&self) -> (u8, u8) {
        if self.completely_idle.load(Ordering::Relaxed) {
            return (0, 0);
        }

        // FIXME: when the idle task has not been chosen to run for a very long time,
        // the number reported should be 100.0%. Currently the logic cannot handle this.

        // The slot that the CPU load report should be based on is the one before the
        // recent slot. This is because the previous slot has just finished counting
        // the number of idle microseconds, while the recent slot is in progress of
        // counting.
        let recent_slot = self.recent_slot_idx.load(Ordering::Relaxed);
        let slot = (recent_slot + 3) % 4;

        // Calculate the ratio of the time spent by the idle task. Since we are
        // calculating using integers, we scale up the ratio by 1000 so the result
        // will fall into [0, 1000].
        let idle_us = self.slots[slot].load(Ordering::Relaxed);
        let idle_ratio_x1000 = idle_us * 1000 / US_PER_SLOT;

        // The load is the ratio of time not running in idle.
        let load_x1000 = 1000 - idle_ratio_x1000;
        let integer = load_x1000 / 10;
        let decimal = load_x1000 % 10;
        (integer as u8, decimal as u8)
    }
}

impl<Clock> IdleCallback for CpuUsage<Clock>
where
    Clock: MicrosecPrecision + Send + Sync,
{
    fn idle_begin_callback(&self) {
        // Save the timestamp that the idle task resumes.
        let cur_ts = self.clock.read_clock_us();
        self.swap_idle_start_timestamp(cur_ts);
    }

    fn idle_end_callback(&self) {
        // If the idle task was running but it is now switched out, update
        // the slots used to calculate CPU load.
        let cur_ts = self.clock.read_clock_us();
        let prev_ts = self.swap_idle_start_timestamp(cur_ts);
        self.update_slots(prev_ts, cur_ts);
    }
}

/// Trait for a microsecond precision clock.
pub trait MicrosecPrecision {
    /// Get the current timestamp in microseconds.
    fn read_clock_us(&self) -> u64;
}
