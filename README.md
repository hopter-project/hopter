<img src="./.github/assets/hopter-logo.png" alt="Hopter's Logo" width="400"/>

Hopter is a Rust-based embedded operating system designed to enable memory-safe, robust, and responsive embedded applications.
Applications built with Hopter require a [customized Rust compiler](https://github.com/hopter-project/hopter-compiler-toolchain) that generates instrumented code in cooperation with the kernel.
The compiler helps enhance memory safety and system reliability without altering standard Rust syntax.

Hopter achieves memory safety purely through software, without relying on hardware protection mechanisms.
Memory safety is guaranteed for applications that are written entirely in safe Rust.
Hopter forestalls stack overflows via compiler instrumentation while preventing other memory safety errors with the help of Rust.
While Hopter strongly encourages using safe Rust, it also permits the cautious use of unsafe Rust code.
Therefore, Hopter expects benign but not malicious applications, and its threat model is similar to that assumed by FreeRTOS.

Hopter can interoperate with community-driven open-source HAL libraries, such as [`stm32f4xx-hal`](https://crates.io/crates/stm32f4xx-hal/0.22.1).

Hopter currently supports two architectures: ARMv7em (`thumbv7em-none-eabihf`) and ARMv6m (`thumbv6m-none-eabi`).
It currently supports the following families of microcontrollers:
- STM32F4
- STM32F0

Adding support for new microcontrollers simply involves defining an interrupt vector in `boot/vector_table`.
Contributions to extend support to other microcontrollers are highly welcomed and appreciated.

# Getting Started

- Quick Start Guide: Visit our [quick start guide](https://github.com/hopter-project/hopter-quick-start) for instructions on setting up your environment and an introduction to Hopter's API.
- Demo Gateway Firmware: Explore our [demo gateway firmware](https://github.com/hopter-project/hopter-gateway) for a more extensive setup and demo application.
- Flight Control Firmware: Check out our [flight control firmware](https://github.com/hopter-project/hopter-crazyflie) that powers the Crazyflie 2.1 drone.

[Documentation](https://docs.rs/hopter/latest/hopter/) is available on Docs.rs.

# Feature Overview

## Memory Safety

Hopter prevents stack overflows alongside other memory safety guarantees provided by Rust.
The customized compiler generates a function prologue (initial instructions executed at function entry) that checks available stack space before executing the function body.
If the prologue detects an impending overflow, control flow transfers to the kernel, which decides either to extend the stack or terminate the task and reclaim resources.

## Robustness

Hopter gracefully recovers applications from Rust panics by running a stack unwinder, which cleans up panicked tasks or IRQ handlers.
The unwinder iterates through stack frames and invokes the drop handlers for live objects, properly releasing resources.

Hopter supports *restartable tasks* that automatically restarts execution from the entry closure after a panic.
To minimize downtime, Hopter employs *concurrent restarts*:
A new task instance starts immediately upon the panic, while the stack unwinder cleans up the panicked instance at a later time, leveraging otherwise idle CPU cycles.

Additionally, Hopter converts stack space exhaustion into a panic and allows recovery using the same mechanism.
The customized compiler helps avoid edge cases where unwinding might inadvertently start within a drop handler.

## Responsiveness

Hopter features zero-latency IRQ handling.
The kernel never disables IRQs, even within traditionally critical sections, ensuring immediate handling of pending IRQs.
Hopter achieves it through a novel internal synchronization primitive called soft-locks, which resolves race conditions between IRQs and tasks without disabling IRQs.

## Temporal Memory Efficiency (Experimental)

Hopter can allocate stacks on-demand in small chunks called stacklets, therefore time-multiplexing the stack memory among tasks.
The technique is known as the segmented stack.
Hopter may extend a stack by allocating a new stacklet upon a function call and free it when the call returns.

Hopter provides the breathing task API to better facilitate time-multiplexing the stack memory.
Hopter also alleviates the performance drop due to segmented stack hot-split by dynamically increase the stacklet allocation granularity.

# Contribution

We welcome your contributions!
Please report bugs through GitHub issues or submit pull requests.
For further questions or discussions, feel free to reach out to the author at `zhiyao.ma.98 AT gmail.com`.
