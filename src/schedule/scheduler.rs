use super::{current, idle};
use crate::{
    config,
    interrupt::context_switch,
    sync::{Access, AllowPendOp, Holdable, RefCellSchedSafe, RunPendedOp, SoftLock, Spin},
    task::{Task, TaskListAdapter, TaskListInterfaces, TaskState},
    unrecoverable::{self, Lethal},
};
use alloc::sync::Arc;
use core::{
    arch::asm,
    sync::atomic::{AtomicBool, AtomicUsize, Ordering},
};
use heapless::mpmc::MpMcQueue;
use intrusive_collections::LinkedList;

/// A ready task queue. Ready tasks will be popped out with respect to
/// their priorities.
type ReadyQueue = RefCellSchedSafe<SoftLock<Inner>>;

/// The inner content of a ready task queue.
struct Inner {
    /// The lock-free circular buffer holding `Arc<Task>`s which are not yet
    /// linked into the ready linked list.
    insert_buffer: InsertBuffer,
    /// Ready tasks linked together as a linked list, allowing us to remove the
    /// one with the highest priority. This linked list is *not* sorted.
    ready_linked_list: Spin<LinkedList<TaskListAdapter>>,
}

/// A lock-free circular buffer holding `Arc<Task>`. When the ready queue is
/// under contention, new ready tasks will be placed into this buffer and will
/// be linked into the ready linked list at a later time.
type InsertBuffer = MpMcQueue<Arc<Task>, { config::MAX_TASK_NUMBER }>;

impl Inner {
    const fn new() -> Self {
        Self {
            insert_buffer: InsertBuffer::new(),
            ready_linked_list: Spin::new(LinkedList::new(TaskListAdapter::NEW)),
        }
    }
}

/// Representing full access to the queue.
struct InnerFullAccessor<'a> {
    insert_buffer: &'a InsertBuffer,
    ready_linked_list: &'a Spin<LinkedList<TaskListAdapter>>,
}

/// Representing pend-only access to the queue. Using this accessor one can only
/// enqueue a task struct `Arc` into the circular buffer. Later the buffer will
/// be consumed and get the tasks linked into the linked list.
struct InnerPendAccessor<'a> {
    insert_buffer: &'a InsertBuffer,
}

/// If the insert buffer is not empty, we should pop these tasks out and get
/// them linked.
impl<'a> RunPendedOp for InnerFullAccessor<'a> {
    fn run_pended_op(&mut self) {
        current::with_cur_task(|cur_task| {
            let mut locked_list = self.ready_linked_list.lock_now_or_die();
            while let Some(task) = self.insert_buffer.dequeue() {
                if task.should_preempt(cur_task) {
                    PENDING_CTXT_SWITCH.store(true, Ordering::SeqCst);
                }
                task.set_state(TaskState::Ready);
                locked_list.push_back(task);
            }
        })
    }
}

/// Bind the accessor types.
impl<'a> AllowPendOp<'a> for Inner {
    type FullAccessor = InnerFullAccessor<'a>;
    type PendOnlyAccessor = InnerPendAccessor<'a>;
    fn full_access(&'a self) -> Self::FullAccessor {
        InnerFullAccessor {
            insert_buffer: &self.insert_buffer,
            ready_linked_list: &self.ready_linked_list,
        }
    }
    fn pend_only_access(&'a self) -> Self::PendOnlyAccessor {
        InnerPendAccessor {
            insert_buffer: &self.insert_buffer,
        }
    }
}

/// The ready task queue.
static READY_TASK_QUEUE: ReadyQueue = RefCellSchedSafe::new(SoftLock::new(Inner::new()));

/// The number of existing tasks.
static EXIST_TASK_NUM: AtomicUsize = AtomicUsize::new(0);

/// Whether the currently running task is the idle task.
static CUR_TASK_IDLE: AtomicBool = AtomicBool::new(false);

/// A boolean flag set to true after the scheduler has been started.
static STARTED: AtomicBool = AtomicBool::new(false);

/// When the counter is positive the scheduler will be suspended and no context
/// switch will occur.
static SUSPEND_CNT: AtomicUsize = AtomicUsize::new(0);

/// Whether a context switch should be performed after the scheduler is resumed.
static PENDING_CTXT_SWITCH: AtomicBool = AtomicBool::new(false);

/// The scheduler is a singleton in the system. Logically, the components of
/// the scheduler are defined by the static variables in the
/// [scheduler](crate::schedule::scheduler) module.
pub(crate) struct Scheduler;

impl Scheduler {
    /// Start the scheduler and start to run tasks.
    ///
    /// Safety: This function should only be called at system initialization
    /// stage when the system is still running with MSP.
    pub(crate) unsafe fn start() -> ! {
        let quota = Self::request_task_quota().unwrap_or_die();
        let mut idle_task = Task::build_idle(quota);

        let stack_bottom = idle_task.get_sp();
        let idle_stk_bound = idle_task.get_stk_bound();

        // Set the idle task as the currently running task.
        current::update_cur_task(Arc::new(idle_task));

        CUR_TASK_IDLE.store(true, Ordering::SeqCst);

        STARTED.store(true, Ordering::SeqCst);

        unsafe {
            // Run the idle task.
            asm!(
                // Set the idle task's stack pointer.
                "msr psp, r0",
                // Set the idle task's TLS fields.
                "ldr r0, ={tls_mem_addr}",
                "str r1, [r0]",
                "mov r1, #0",
                "str r1, [r0, #4]",
                "str r1, [r0, #8]",
                // Start to use PSP instead of MSP.
                // PSP is for running tasks.
                // MSP is for the kernel.
                "mrs r0, control",
                "orr r0, #2",
                "msr control, r0",
                // Let MSP point to the kernel stack bottom.
                "ldr r0, ={kern_stk_bottom}",
                "msr msp, r0",
                // Execute a floating point instruction, so that the CPU will
                // have the internal floating point context bit set, and later
                // upon SVC the CPU will push a trap frame with floating point
                // registers. Just enabling FPU is NOT enough for the CPU to
                // push floating point registers upon exception.
                "vmov.f32 s0, s0",
                // With the stack pointer and boundary updated, now the code
                // runs in the idle task's context. Jump to the idle task entry.
                "b {idle_task}",
                idle_task = sym idle::idle_task,
                tls_mem_addr = const config::__TLS_MEM_ADDR,
                kern_stk_bottom = const config::_CONTIGUOUS_STACK_BOTTOM,
                in("r0") stack_bottom,
                in("r1") idle_stk_bound,
                options(noreturn)
            )
        }
    }

    /// Choose the next task to run. The chosen task will be reflected by the
    /// updated global variable [`CUR_TASK_CTXT_PTR`](current::CUR_TASK_CTXT_PTR).
    /// Semantically, the pointer has exclusive mutable access to the context
    /// struct it points to. The pointer will be used by the context switch
    /// assembly instruction sequence in [`crate::interrupt::context_switch`].
    pub(crate) fn pick_next() {
        // Sanity check that the scheduler is not being suspended.
        if SUSPEND_CNT.load(Ordering::SeqCst) > 0 {
            unrecoverable::die();
        }

        READY_TASK_QUEUE.with_suspended_scheduler(|queue, sched_guard| {
            queue.must_with_full_access(|full_access| {
                let mut locked_list = full_access.ready_linked_list.lock_now_or_die();

                // Clean up for the current task.
                current::with_cur_task_arc_explicit_sched_suspend(sched_guard, |cur_task| {
                    match cur_task.get_state() {
                        // Put the current task back to the ready queue only if the
                        // task is in `Running` state.
                        TaskState::Running => {
                            cur_task.set_state(TaskState::Ready);
                            locked_list.push_back(cur_task);
                        }
                        // A `Blocked` task should have been put to a waiting queue and
                        // maintain a positive `Arc` reference count there.
                        //
                        // A `Destructing` task have no `Arc` reference elsewhere other
                        // than the one maintained by the `current` module. We want to
                        // drop the only reference.
                        //
                        // In both cases, we will not put the task back to the ready
                        // queue and will later use `current::set_cur_task` to overwrite
                        // the current task reference maintained by the `current` module.
                        TaskState::Blocked | TaskState::Destructing => {}
                        // The current task can be set into the `Ready` state under a
                        // rare circumstance: The task was first set to `Blocked` state
                        // and was pushed to a sleeping or waiting queue. But before the
                        // task was removed from the CPU, i.e. while the task still the
                        // current task, i.e. the scheduler has not been invoked yet, the
                        // task was woken up. During the wake up procedure, the task's
                        // `Arc` will be moved from the sleeping or waiting queue to the
                        // scheduler's ready queue and the task's state will be set to
                        // `Ready`. Since the task already has a copy of its `Arc` in the
                        // ready queue, we do nothing here.
                        TaskState::Ready => {}
                        // The current task should never be in the `Initializing` state.
                        TaskState::Initializing => unrecoverable::die(),
                    }
                });

                // Pick the next task based on the priority. An idle task
                // guarantees that the ready queue will always be non-empty.
                let next_task = locked_list.pop_highest_priority().unwrap_or_die();
                next_task.set_state(TaskState::Running);

                let next_idle = next_task.is_idle();

                // Load if the current task is the idle task and also set it to
                // the new value.
                let was_idle = CUR_TASK_IDLE.swap(next_idle, Ordering::SeqCst);

                // Invoke idle callbacks if the idle task is switched in or out.
                {
                    let locked_callbacks = idle::lock_idle_callbacks();

                    // When the idle task is switched out of CPU.
                    if was_idle {
                        for callback in locked_callbacks.iter() {
                            callback.idle_end();
                        }
                    }

                    // When the idle task is switched on to the CPU.
                    if next_idle {
                        for callback in locked_callbacks.iter() {
                            callback.idle_begin();
                        }
                    }
                }

                // Set the chosen task to be current.
                current::update_cur_task(next_task);

                // Clear the context switch request flag because we just
                // performed one.
                PENDING_CTXT_SWITCH.store(false, Ordering::SeqCst);
            })
        })
    }

    /// Return if the scheduler has been started.
    pub(crate) fn has_started() -> bool {
        STARTED.load(Ordering::SeqCst)
    }

    /// Check whether the existing task number has already reached the allowed
    /// maximum ([`MAX_TASK_NUMBER`](config::MAX_TASK_NUMBER)). If not, return
    /// a [`TaskQuota`] which is a token allowing new task creation.
    pub(crate) fn request_task_quota() -> Result<TaskQuota, ()> {
        TaskQuota::new()
    }

    /// Insert a task to the scheduler's ready queue.
    pub(crate) fn accept_task(task: Arc<Task>) {
        Self::insert_task_to_ready_queue(task)
    }

    /// Internal implementation to insert a task to the ready queue.
    fn insert_task_to_ready_queue(task: Arc<Task>) {
        READY_TASK_QUEUE.with_suspended_scheduler(|queue, sched_guard| {
            queue.with_access(|access| match access {
                // The queue is not under contention. Directly put the task to the
                // linked list.
                Access::Full { full_access } => {
                    // Request a context switch if the incoming ready task has a
                    // higher priority than the current task. Check it only when
                    // the scheduler has started otherwise there will be no current
                    // task.
                    if Scheduler::has_started() {
                        current::with_cur_task_explicit_sched_suspend(sched_guard, |cur_task| {
                            if task.should_preempt(cur_task) {
                                PENDING_CTXT_SWITCH.store(true, Ordering::SeqCst);
                            }
                        });
                    }

                    // Put the ready task to the linked list.
                    task.set_state(TaskState::Ready);
                    let mut locked_list = full_access.ready_linked_list.lock_now_or_die();
                    locked_list.push_back(task);
                }
                // The queue is under contention. The current execution context, which
                // must be an ISR, preempted another context that is holding the full
                // access. Place the task in the lock-free buffer. The full access
                // holder will later put it back to the linked list.
                Access::PendOnly { pend_access } => {
                    pend_access.insert_buffer.enqueue(task).unwrap_or_die();
                }
            })
        });
    }

    /// Prevent any context switch while the returned guard type is not dropped.
    pub(crate) fn suspend() -> SchedSuspendGuard {
        SUSPEND_CNT.fetch_add(1, Ordering::SeqCst);
        SchedSuspendGuard
    }

    /// Resume context switch if all suspension guard have been dropped, and
    /// perform a context switch immediately if one has been requested during
    /// the suspension.
    fn resume() {
        SUSPEND_CNT.fetch_sub(1, Ordering::SeqCst);

        if SUSPEND_CNT.load(Ordering::SeqCst) == 0 && PENDING_CTXT_SWITCH.load(Ordering::SeqCst) {
            // If the code is currently running in an ISR context, the context
            // switch (performed by the PendSV handler) will begin after the
            // return from all ISRs, because PendSV has the lowest priority.
            // If the code is running in a task's context, the context switch
            // will happen immediately.
            context_switch::yield_current_task();
        }
    }

    /// Return if the scheduler is suspended.
    pub(crate) fn is_suspended() -> bool {
        SUSPEND_CNT.load(Ordering::SeqCst) > 0
    }

    /// Drop the task struct of the currently running task and switch to
    /// another ready task.
    pub(crate) fn drop_current_task_from_svc() {
        // Mark the task state as `Destructing` so that the scheduler will drop
        // the task struct upon a later context switch.
        current::with_cur_task(|cur_task| cur_task.set_state(TaskState::Destructing));

        // Tail chain a PendSV to perform a context switch.
        cortex_m::peripheral::SCB::set_pendsv()
    }
}

/// The guard type returned when suspending the scheduler. The scheduler will
/// be resumed when the guard is dropped.
pub(crate) struct SchedSuspendGuard;

impl Drop for SchedSuspendGuard {
    fn drop(&mut self) {
        Scheduler::resume();
    }
}

/// The guard must not be sent across threads.
impl !Send for SchedSuspendGuard {}

impl Holdable for Scheduler {
    type GuardType = SchedSuspendGuard;

    fn hold() -> SchedSuspendGuard {
        Scheduler::suspend()
    }

    unsafe fn force_unhold() {
        Scheduler::resume();
    }
}

/// The struct represents the permission to create a new task, created by
/// calling [`request_task_quota`](Scheduler::request_task_quota). The number
/// of existing tasks will be incremented each time a quota instance is built,
/// and will be decremented when a quota is dropped.
///
/// The [`Task`] holds the quota as a struct field, so when a task is dropped
/// the number of existing tasks will also be decremented.
pub(crate) struct TaskQuota(Seal);

impl TaskQuota {
    fn new() -> Result<Self, ()> {
        loop {
            let exist_task_num = EXIST_TASK_NUM.load(Ordering::SeqCst);

            // If we can still hold more tasks, temporarily increment the task
            // number and return a `Quota`.
            if exist_task_num < config::MAX_TASK_NUMBER {
                match EXIST_TASK_NUM.compare_exchange_weak(
                    exist_task_num,
                    exist_task_num + 1,
                    Ordering::SeqCst,
                    Ordering::SeqCst,
                ) {
                    Ok(_) => return Ok(Self(Seal)),
                    // In rare case where we have a contention on the counter,
                    // try again with the test.
                    Err(_) => continue,
                }
            // Maximum number of tasks reached, return error.
            } else {
                return Err(());
            }
        }
    }
}

/// Decrement the existing task number counter when the struct is dropped.
impl Drop for TaskQuota {
    fn drop(&mut self) {
        EXIST_TASK_NUM.fetch_sub(1, Ordering::SeqCst);
    }
}

/// Declared as a private struct so that no [`TaskQuota`] instance can be
/// forged outside this module.
struct Seal;
