use crate::sync::Semaphore;

/// The semaphore controlling the concurrency of all breathing tasks. Each
/// breathing task acquires (`.down()`) the semaphore before proceeding to the
/// `work` function, and will release (`.up()`) the semaphore after the work
/// function finishes.
static CONCUR_CTRL_SEM: Semaphore = Semaphore::new(3, 3);

/// To prevent a panicked task from not releasing the concurrency control
/// semaphore, we create a guard after acquiring the semaphore. In this way
/// the drop handler will release the semaphore in both the normal and
/// unwinding path.
struct SemGuard;

impl Drop for SemGuard {
    fn drop(&mut self) {
        // `.up()` should suffice, but we just do not want to block in a drop
        // handler. Logically, the semaphore should never block on `.up()`, but
        // here we just try to be extra careful in case we have some other bugs.
        let _ = CONCUR_CTRL_SEM.try_up_allow_isr();
    }
}

/// Generate the construction function for breathing tasks. Given three
/// closures, `init`, `wait`, and `work`, the construction function generates
/// the entry closure that calls these three provided closures.
///
/// The constructed entry closure has *approximately* the following structure:
/// ```rust
/// move || {
///     let mut state = init());
///     loop {
///         let item = wait(&mut state);
///         CONCUR_CTRL_SEM.down();
///         work(&mut state, item);
///         CONCUR_CTRL_SEM.up();
///     }
/// }
/// ```
///
/// Technically, however, the `init`, `wait`, and `work` closure are outlined,
/// so that when the task blocks on [`CONCUR_CTRL_SEM`] the task's stack usage
/// will be low.
///
/// Also, the `.up()` part is guarded by [`SemGuard`], so even if the `work`
/// closure throws a panic, the semaphore can still be released.
macro_rules! define_breathing_task_entry_constructor {
    (
        $fn_name:ident,
        $gen_init:ident, $fn_trait_init:path, [$($bnd_init:tt)+],
        $gen_wait:ident, $fn_trait_wait:path, [$($bnd_wait:tt)+],
        $gen_work:ident, $fn_trait_work:path, [$($bnd_work:tt)+],
        $fn_trait_ret:path, [$($bnd_ret:tt)+],
    ) => {
        pub(super) fn $fn_name<$gen_init, $gen_wait, $gen_work, State, Item>(
            init: $gen_init,
            mut wait: $gen_wait,
            mut work: $gen_work,
        ) -> impl $fn_trait_ret + $($bnd_ret)+
        where
            $gen_init: $fn_trait_init + $($bnd_init)+,
            $gen_wait: $fn_trait_wait + $($bnd_wait)+,
            $gen_work: $fn_trait_work + $($bnd_work)+,
        {
            #[inline(never)]
            fn call_init<$gen_init, State>(init: $gen_init) -> State
            where
                $gen_init: $fn_trait_init + $($bnd_init)+
            {
                init()
            }

            #[inline(never)]
            fn call_wait<$gen_wait, State, Item>(state: &mut State, wait: &mut $gen_wait) -> Item
            where
                $gen_wait: $fn_trait_wait + $($bnd_wait)+,
            {
                wait(state)
            }

            #[inline(never)]
            fn call_work<$gen_work, State, Item>(state: &mut State, item: Item, work: &mut $gen_work)
            where
                $gen_work: $fn_trait_work + $($bnd_work)+
            {
                work(state, item)
            }

            move || {
                let mut state = call_init(init);
                loop {
                    let item = call_wait(&mut state, &mut wait);
                    CONCUR_CTRL_SEM.down();
                    let _guard = SemGuard;
                    call_work(&mut state, item, &mut work);
                }
            }
        }
    }
}

define_breathing_task_entry_constructor!(
    construct_breathing_task_entry,
    // `init` closure
    // F: FnOnce() -> State + Send + Sync + 'static
    F, FnOnce() -> State, [Send + Sync + 'static],
    // `wait` closure
    // G: FnMut(&mut State) -> Item + Send + Sync + 'static
    G, FnMut(&mut State) -> Item, [Send + Sync + 'static],
    // `work` closure
    // H: FnMut(&mut State, Item) + Send + Sync + 'static
    H, FnMut(&mut State, Item), [Send + Sync + 'static],
    // Constructed closure
    // FnOnce() + Send + Sync + 'static
    FnOnce(), [Send + Sync + 'static],
);

define_breathing_task_entry_constructor!(
    construct_restartable_breathing_task_entry,
    // `init` closure
    // F: FnOnce() -> State + Clone + Send + Sync + 'static
    F, FnOnce() -> State, [Clone + Send + Sync + 'static],
    // `wait` closure
    // G: FnMut(&mut State) -> Item + Clone + Send + Sync + 'static
    G, FnMut(&mut State) -> Item, [Clone + Send + Sync + 'static],
    // `work` closure
    // H: FnMut(&mut State, Item) + Clone + Send + Sync + 'static
    H, FnMut(&mut State, Item), [Clone + Send + Sync + 'static],
    // Constructed closure
    // FnOnce() + Clone + Send + Sync + 'static
    FnOnce(), [Clone + Send + Sync + 'static],
);
