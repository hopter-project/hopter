use core::{
    alloc::{GlobalAlloc, Layout},
    arch::asm,
    sync::atomic::{AtomicBool, Ordering},
};

use super::{
    boot,
    interrupt::{svc, trap_frame::TrapFrame},
    schedule::scheduler,
    task,
    unrecoverable::{self, Lethal},
};

mod heap;

#[no_mangle]
static mut ADJUSTED_HIGH_WATER_MARK: u32 = 0;

struct Allocator {
    /// If the allocator has been initialized.
    initialized: AtomicBool,
    /// If the allocator is currently running. It is used to prevent re-entering
    /// the allocator, for example, from an IRQ that interrupts an ongoing
    /// allocation.
    active: AtomicBool,
}

impl Allocator {
    /// Create a new global allocator.
    ///
    /// Safety: at most one instance can be created.
    const unsafe fn new() -> Self {
        Self {
            initialized: AtomicBool::new(false),
            active: AtomicBool::new(false),
        }
    }

    /// Initialize the allocator.
    pub fn init(&self) {
        if !self.initialized.load(Ordering::SeqCst) {
            // Safety: the boot module should provide the correct
            // starting address of the heap. The heap will extend to
            // the end of the SRAM address space.
            unsafe {
                heap::mcu_heap_init(boot::heap_start());
            }
        }
        self.initialized.store(true, Ordering::SeqCst);
    }

    /// Allocate memory when running in the kernel, i.e., handler mode.
    fn kernel_malloc(&self, size: usize) -> *mut u8 {
        die_if_not_in_svc();

        // Make sure the heap is initialized.
        while !self.initialized.load(Ordering::SeqCst) {}

        // Spin if the allocater is re-entered.
        while self.active.load(Ordering::SeqCst) {}
        self.active.store(true, Ordering::SeqCst);

        // Safety: the C function being called must be correct.
        let ptr = unsafe { heap::mcu_malloc(size as u32) };

        self.active.store(false, Ordering::SeqCst);
        if ptr.is_null() {
            cortex_m::interrupt::free(|_| loop {})
        }

        unsafe {
            if heap::HIGH_WATER_MARK_JUST_UPDATED {
                heap::HIGH_WATER_MARK_JUST_UPDATED = false;
                ADJUSTED_HIGH_WATER_MARK =
                    heap::HIGH_WATER_MARK - 108 * task::get_active_stacklet_count() as u32;
            }
        }

        ptr
    }

    /// Free memory when running in the kernel, i.e., handler mode.
    fn kernel_free(&self, ptr: *mut u8) {
        die_if_not_in_svc_or_pendsv();

        // Make sure the heap is initialized.
        while !self.initialized.load(Ordering::SeqCst) {}

        // Spin if the allocater is re-entered.
        while self.active.load(Ordering::SeqCst) {}
        self.active.store(true, Ordering::SeqCst);

        // Safety: the C function being called must be correct.
        unsafe {
            heap::mcu_free(ptr);
        }
        self.active.store(false, Ordering::SeqCst);
    }

    /// The actual implementation for allocation. The function differentiates
    /// between running in kernel, i.e., handler mode, or in a task, i.e.,
    /// thread mode. It invokes different functions based on the mode running.
    #[naked]
    extern "C" fn alloc_impl(&self, size: usize) -> *mut u8 {
        unsafe {
            asm!(
                "mrs  r12, CONTROL",
                "ands r12, r12, #2",
                "beq  {kernel_malloc}",
                "mov  r0, r1",
                "b    {task_malloc}",
                kernel_malloc = sym Allocator::kernel_malloc,
                task_malloc = sym svc::svc_malloc,
                options(noreturn)
            )
        }
    }

    /// The actual implementation for free. The function differentiates
    /// between running in kernel, i.e., handler mode, or in a task, i.e.,
    /// thread mode. It invokes different functions based on the mode running.
    #[naked]
    extern "C" fn free_impl(&self, ptr: *mut u8) {
        unsafe {
            asm!(
                "mrs  r12, CONTROL",
                "ands r12, r12, #2",
                "beq  {kernel_free}",
                "mov  r0, r1",
                "b    {task_free}",
                kernel_free = sym Allocator::kernel_free,
                task_free = sym svc::svc_free,
                options(noreturn)
            )
        }
    }
}

/// The global allocator instance.
#[global_allocator]
static GLOBAL_ALLOC: Allocator = unsafe { Allocator::new() };

unsafe impl GlobalAlloc for Allocator {
    unsafe fn alloc(&self, layout: core::alloc::Layout) -> *mut u8 {
        self.alloc_impl(layout.size())
    }

    unsafe fn dealloc(&self, ptr: *mut u8, _layout: core::alloc::Layout) {
        self.free_impl(ptr)
    }
}

/// Treat out-of-memory as a fatal error and hang everything.
#[alloc_error_handler]
fn alloc_error(_layout: core::alloc::Layout) -> ! {
    cortex_m::interrupt::free(|_| loop {})
}

/// Initialize the allocator. If the allocator has already been initialized,
/// it does nothing.
pub fn init_allocator() {
    GLOBAL_ALLOC.init()
}

fn die_if_not_in_svc() {
    // Only perform sanity check after the scheduler has started, otherwise
    // we may still be running with the bootstrap stack with MSP.
    if !scheduler::has_started() {
        return;
    }

    let ipsr: u32;

    unsafe {
        asm!(
            "mrs {}, IPSR",
            out(reg) ipsr,
            options(nomem, nostack)
        );
    }

    if ipsr != 11 {
        loop {}
    }
}

fn die_if_not_in_svc_or_pendsv() {
    // Only perform sanity check after the scheduler has started, otherwise
    // we may still be running with the bootstrap stack with MSP.
    if !scheduler::has_started() {
        return;
    }

    let ipsr: u32;

    unsafe {
        asm!(
            "mrs {}, IPSR",
            out(reg) ipsr,
            options(nomem, nostack)
        );
    }

    if ipsr != 11 && ipsr != 14 {
        loop {}
    }
}

pub(super) fn task_malloc(tf: &mut TrapFrame) {
    let size = tf.gp_regs.r0 as usize;
    // FIXME: need not go through `alloc::alloc` again.
    let ptr = unsafe { alloc::alloc::alloc(Layout::from_size_align(size, 4).unwrap_or_die()) };
    unrecoverable::die_if(|| ptr.is_null());
    tf.gp_regs.r0 = ptr as u32;
}

pub(super) fn task_free(tf: &TrapFrame) {
    // FIXME: need not go through `alloc::alloc` again.
    unsafe { alloc::alloc::dealloc(tf.gp_regs.r0 as *mut u8, Layout::new::<u8>()) }
}
