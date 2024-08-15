use super::{current, idle};
use crate::{
    config,
    interrupt::svc,
    sync::{Access, AllowPendOp, Interruptable, RefCellSchedSafe, RunPendedOp, Spin},
    task::{Task, TaskBuildError, TaskListAdapter, TaskListInterfaces, TaskState},
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
type ReadyQueue = RefCellSchedSafe<Interruptable<Inner>>;

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
        current::with_current_task(|cur_task| {
            let mut locked_list = self.ready_linked_list.lock_now_or_die();
            while let Some(task) = self.insert_buffer.dequeue() {
                if task.should_preempt(cur_task) {
                    request_context_switch();
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
static READY_TASK_QUEUE: ReadyQueue = RefCellSchedSafe::new(Interruptable::new(Inner::new()));

/// Existing task number.
static EXIST_TASK_NUM: AtomicUsize = AtomicUsize::new(0);

/// Whether the currently running task is the idle task.
static CUR_TASK_IDLE: AtomicBool = AtomicBool::new(false);

/// Choose the next task to run. The chosen task will be reflected by the
/// updated global variable [`CUR_TASK_CTXT_PTR`](current::CUR_TASK_CTXT_PTR).
/// Semantically, the pointer has exclusive mutable access to the context
/// struct it points to. The pointer will be used by the context switch
/// assembly instruction sequence in [`crate::interrupt::context_switch`].
pub(crate) fn pick_next() {
    // Sanity check that the scheduler is not being suspended.
    if SCHEDULER_SUSPEND_CNT.load(Ordering::SeqCst) > 0 {
        unrecoverable::die();
    }

    READY_TASK_QUEUE
        .lock()
        .must_with_full_access(|full_access| {
            let mut locked_list = full_access.ready_linked_list.lock_now_or_die();

            // Clean up for the current task.
            current::with_current_task_arc(|cur_task| {
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
                    // The current task should never be in the `Ready` or
                    // `Initializing` state.
                    TaskState::Ready | TaskState::Initializing => unrecoverable::die(),
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
            CONTEXT_SWITCH_REQUESTED.store(false, Ordering::SeqCst);
        })
}

/// Start the scheduler and start to run tasks.
///
/// Safety: This function should only be called at system initialization stage
/// when the system is still running with MSP.
pub(crate) unsafe fn start() -> ! {
    let mut idle_task = Task::build_idle();

    let stack_bottom = idle_task.get_sp();
    let idle_stk_bound = idle_task.get_stk_bound();

    // Set the idle task as the currently running task.
    current::update_cur_task(Arc::new(idle_task));

    // The current task, i.e. idle task, becomes the first existing task.
    EXIST_TASK_NUM.fetch_add(1, Ordering::SeqCst);

    CUR_TASK_IDLE.store(true, Ordering::SeqCst);

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
            // registers. Just enabling FPU is NOT enough for the CPU to push
            // floating point registers upon exception.
            "vmov.f32 s0, s0",
            // Jump to the idle function.
            "b {idle_task}",
            idle_task = sym idle::idle_task,
            tls_mem_addr = const config::TLS_MEM_ADDR,
            kern_stk_bottom = const config::CONTIGUOUS_STACK_BOTTOM,
            in("r0") stack_bottom,
            in("r1") idle_stk_bound,
            options(noreturn)
        )
    }
}

/// Destroy the task struct of the currently running task and switch to another
/// ready task.
pub(crate) fn destroy_current_task_and_schedule() {
    EXIST_TASK_NUM.fetch_sub(1, Ordering::SeqCst);

    // Mark the task state as `Destructing` so that the scheduler will drop
    // the task struct upon a later context switch.
    current::with_current_task(|cur_task| cur_task.set_state(TaskState::Destructing));

    // Just request a context switch without putting the currently running task
    // back to the ready queue. Although `svc_task_block()` is implemented in
    // the same way, the difference is that prior to some task calling to block,
    // the task struct of the blocking task would have been put onto a wait queue
    // and thus not get dropped.
    cortex_m::peripheral::SCB::set_pendsv()
}

static SCHEDULER_STARTED: AtomicBool = AtomicBool::new(false);

pub(crate) fn has_started() -> bool {
    SCHEDULER_STARTED.load(Ordering::SeqCst)
}

pub(super) fn set_started() {
    SCHEDULER_STARTED.store(true, Ordering::SeqCst)
}

static SCHEDULER_SUSPEND_CNT: AtomicUsize = AtomicUsize::new(0);

pub(crate) fn increment_suspend_count() {
    SCHEDULER_SUSPEND_CNT.fetch_add(1, Ordering::SeqCst);
}

pub(crate) fn decrement_suspend_count() {
    SCHEDULER_SUSPEND_CNT.fetch_sub(1, Ordering::SeqCst);
}

pub(crate) fn yield_cur_task_from_isr() {
    cortex_m::peripheral::SCB::set_pendsv()
}

static CONTEXT_SWITCH_REQUESTED: AtomicBool = AtomicBool::new(false);

fn request_context_switch() {
    CONTEXT_SWITCH_REQUESTED.store(true, Ordering::SeqCst);
}

pub(crate) fn yield_for_preemption() {
    if !CONTEXT_SWITCH_REQUESTED.load(Ordering::SeqCst)
        || SCHEDULER_SUSPEND_CNT.load(Ordering::SeqCst) > 0
    {
        return;
    }

    if !current::is_in_isr_context() {
        svc::svc_yield_current_task();
    } else if !current::is_in_pendsv_context() {
        yield_cur_task_from_isr();
    }
}

/// Insert a new task to the scheduler's ready queue. The task must not be an
/// existing task, but can be a new restarted instance of a panicked task.
///
/// # Return
/// - `Ok(())` if the new task is ready to be run by the scheduler
/// - `Err(TaskBuildError::NoMoreTask)` if the maximum number of tasks has
///    been reached.
pub(crate) fn accept_new_task(task: Arc<Task>) -> Result<(), TaskBuildError> {
    // Return error if reached maximum task number, otherwise increment it.
    if EXIST_TASK_NUM.load(Ordering::SeqCst) >= config::MAX_TASK_NUMBER {
        return Err(TaskBuildError::NoMoreTask);
    }
    EXIST_TASK_NUM.fetch_add(1, Ordering::SeqCst);

    insert_task_to_ready_queue(task);

    Ok(())
}

/// Insert a task back to the scheduler's ready queue. The task should
/// previously be blocked or sleeping.
pub(crate) fn accept_notified_task(task: Arc<Task>) {
    insert_task_to_ready_queue(task)
}

/// Internal implementation to insert a task to the ready queue.
fn insert_task_to_ready_queue(task: Arc<Task>) {
    READY_TASK_QUEUE.lock().with_access(|access| match access {
        // The queue is not under contention. Directly put the task to the
        // linked list.
        Access::Full { full_access } => {
            // Request a context switch if the incoming ready task has a
            // higher priority than the current task. Check it only when
            // the scheduler has started otherwise there will be no current
            // task.
            if has_started() {
                current::with_current_task(|cur_task| {
                    if task.should_preempt(cur_task) {
                        request_context_switch();
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
    });
}
