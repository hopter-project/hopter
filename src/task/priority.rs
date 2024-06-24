use crate::unrecoverable::{self, Lethal};
use static_assertions::const_assert_eq;

/// Represent the priority of a task.
///
/// This struct is configured to have 4-byte alignment and a size of 4 bytes so
/// that it can be stored behind a lock-free `AtomicCell`.
#[derive(Clone, Copy)]
pub(crate) struct TaskPriority(PriorityVariant);
const_assert_eq!(core::mem::size_of::<TaskPriority>(), 4);
const_assert_eq!(core::mem::align_of::<TaskPriority>(), 4);

/// Two variants of the task priority: either intrinsic or inherited.
/// Smaller numerical numbers represent higher priority.
///
/// This enum is configured to have 4-byte alignment and a size of 4 bytes so
/// that it can be stored behind a lock-free `AtomicCell`.
#[derive(Clone, Copy)]
enum PriorityVariant {
    /// Intrinsic priority of a task. This is set when a task is spawned.
    Intrinsic(u8),
    /// Inhereted priority of a task. Priority can be inherited for example
    /// to resolve priority inversion during mutex contention. The intrinsic
    /// field keeps track of its intrinsic priority before inheriting one from
    /// another task.
    Inherited { inherited: u8, intrinsic: u8 },
    /// To ensure this enum is 4-byte aligned and has a size of 4 bytes.
    _Padding([u32; 0]),
}

impl TaskPriority {
    /// Return the priority level when the task participates in prioritized
    /// scheduling. When the task is not inheriting other priorities, return
    /// its intrinsic priority, otherwise return its inherited priority.
    pub(crate) fn effective_priority(&self) -> u8 {
        match self.0 {
            PriorityVariant::Intrinsic(prio) => prio,
            PriorityVariant::Inherited { inherited, .. } => inherited,
            PriorityVariant::_Padding(..) => unrecoverable::die(),
        }
    }

    /// Return the intrinsic priority, regardless of whether the task is
    /// currently having a different effective priority inherited from
    /// another task.
    pub(crate) fn intrinsic_priority(&self) -> u8 {
        match self.0 {
            PriorityVariant::Intrinsic(prio) => prio,
            PriorityVariant::Inherited { intrinsic, .. } => intrinsic,
            PriorityVariant::_Padding(..) => unrecoverable::die(),
        }
    }

    /// Try to inherit the effective priority of another task. Succeed if the
    /// other task has higher effective priority, and fail otherwise. Return
    /// the new priority if successful.
    ///
    /// The function signature intends to clarify that it returns a new
    /// `TaskPriority` struct instead of modifying existing ones.
    pub(crate) fn try_inherit_from(this: &Self, other: &Self) -> Result<Self, ()> {
        if this.effective_priority() <= other.effective_priority() {
            Err(())
        } else {
            Ok(TaskPriority(PriorityVariant::Inherited {
                inherited: other.effective_priority(),
                intrinsic: this.intrinsic_priority(),
            }))
        }
    }

    /// Construct a `TaskPriority` struct with a given intrinsic priority level.
    /// Note that smaller numerical value represents higher priority.
    pub(crate) const fn new_intrinsic(prio: u8) -> Self {
        TaskPriority(PriorityVariant::Intrinsic(prio))
    }

    /// Regardless of whether the currently effective priority is inherited or
    /// not, construct from it a `TaskPriority` struct that contains only its
    /// intrisic priority component. This method is usually used when a task
    /// wants to discard the inherited priority.
    ///
    /// The function signature intends to clarify that it returns a new
    /// `TaskPriority` struct instead of modifying the existing one.
    pub(crate) fn restore_intrinsic(this: &Self) -> Self {
        Self::new_intrinsic(this.intrinsic_priority())
    }
}

/// `TaskPriority` struct establishes the ordering with its effective priority.
impl PartialEq for TaskPriority {
    fn eq(&self, other: &Self) -> bool {
        self.effective_priority() == other.effective_priority()
    }
}
impl Eq for TaskPriority {}
impl PartialOrd for TaskPriority {
    fn partial_cmp(&self, other: &Self) -> Option<core::cmp::Ordering> {
        self.effective_priority()
            .partial_cmp(&other.effective_priority())
    }
}
impl Ord for TaskPriority {
    fn cmp(&self, other: &Self) -> core::cmp::Ordering {
        self.partial_cmp(other).unwrap_or_die()
    }
}
