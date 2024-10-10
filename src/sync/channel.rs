use super::Semaphore;
use crate::unrecoverable::Lethal;
use alloc::sync::Arc;
use heapless::mpmc::MpMcQueue;

/// A multi-producer multi-consumer channel.
struct Channel<T, const N: usize> {
    /// The underlying lock-free ring buffer.
    buffer: MpMcQueue<T, N>,
    /// The semaphore counting on the empty slots.
    sem_empty: Semaphore,
    /// The semaphore counting on the occupied slots.
    sem_occupied: Semaphore,
}

/// A producer of a channel. It can be cloned.
#[derive(Clone)]
pub struct Producer<T, const N: usize> {
    channel: Arc<Channel<T, N>>,
}

/// The consumer of a channel. It can be cloned.
#[derive(Clone)]
pub struct Consumer<T, const N: usize> {
    channel: Arc<Channel<T, N>>,
}

impl<T, const N: usize> Channel<T, N> {
    /// Create a new channel with the given buffering capacity.
    fn new() -> Self {
        Self {
            buffer: MpMcQueue::new(),
            sem_empty: Semaphore::new(N, N),
            sem_occupied: Semaphore::new(N, 0),
        }
    }

    /// Push an element into the channel. If the channel buffer is already full,
    /// the task will be blocked until there is an empty slot.
    ///
    /// Important: *must not* call this method in ISR context.
    fn push(&self, data: T) {
        self.sem_empty.down();
        self.buffer.enqueue(data).ok().unwrap_or_die();
        self.sem_occupied.up();
    }

    /// Pop out an element from the channel. If the channel buffer is empty,
    /// the task will be blocked until there is an element.
    ///
    /// Important: *must not* call this method in ISR context.
    fn pop(&self) -> T {
        self.sem_occupied.down();
        let data = self.buffer.dequeue().unwrap_or_die();
        self.sem_empty.up();
        data
    }

    /// Try to pop an element from the buffer. If there is no element, return
    /// `None`. Otherwise, return the element in `Some`.
    ///
    /// Calling this method in ISR context is allowed.
    fn try_pop_allow_isr(&self) -> Option<T> {
        if self.sem_occupied.try_down_allow_isr().is_err() {
            return None;
        }

        let data = self.buffer.dequeue().unwrap_or_die();
        self.sem_empty.try_up_allow_isr().unwrap_or_die();

        Some(data)
    }

    /// Push an element into the buffer. If the buffer is already full,
    /// return the element with `Err`. Otherwise, push in the element and
    /// return `Ok`.
    ///
    /// Calling this method in ISR context is allowed.
    fn try_push_allow_isr(&self, data: T) -> Result<(), T> {
        // If there is empty space in the buffer, simply push it.
        if self.sem_empty.try_down_allow_isr().is_ok() {
            self.buffer.enqueue(data).ok().unwrap_or_die();
            self.sem_occupied.try_up_allow_isr().unwrap_or_die();
            return Ok(());
        }

        // Otherwise, there is no empty space left in the buffer.
        return Err(data);
    }
}

impl<T, const N: usize> Producer<T, N> {
    /// Create a new producer for the given channel.
    fn new(chan: Arc<Channel<T, N>>) -> Self {
        Self { channel: chan }
    }

    /// Push an element into the corresponding channel. If the channel is
    /// already full, block until there is an empty slot and it can proceed.
    ///
    /// Important: *Must not* call this method in ISR context. An ISR
    /// attempting to block will result in a panic.
    pub fn produce(&self, data: T) {
        self.channel.push(data)
    }

    /// Push an element into the corresponding channel. If the channel is
    /// already full, return the element with `Err`. Otherwise, push in the
    /// element and return `Ok`.
    ///
    /// Calling this method in ISR context is allowed.
    pub fn try_produce_allow_isr(&self, data: T) -> Result<(), T> {
        self.channel.try_push_allow_isr(data)
    }
}

impl<T, const N: usize> Consumer<T, N> {
    /// Create a new consumer for the given channel.
    fn new(chan: Arc<Channel<T, N>>) -> Self {
        Self { channel: chan }
    }

    /// Pop an element from the corresponding channel. If the channel is
    /// empty, block until there is an element and it can proceed.
    ///
    /// Important: *Must not* call this method in ISR context. An ISR
    /// attempting to block will result in a panic.
    pub fn consume(&self) -> T {
        self.channel.pop()
    }

    /// Try to pop an element from the corresponding channel. If the channel
    /// is empty, return `None`. Otherwise, return the element with `Some`.
    ///
    /// Calling this method in ISR context is allowed.
    pub fn try_consume_allow_isr(&self) -> Option<T> {
        self.channel.try_pop_allow_isr()
    }
}

/// Create a channel with the given buffering capacity. Return a producer and
/// a consumer corresponding with the channel. The producer and consumer are
/// cloneable The channel will be dropped after all producers and consumers
/// corresponding to it are dropped.
pub fn create_channel<T, const N: usize>() -> (Producer<T, N>, Consumer<T, N>) {
    let chan = Arc::new(Channel::new());
    let producer = Producer::new(chan.clone());
    let consumer = Consumer::new(chan);
    (producer, consumer)
}
