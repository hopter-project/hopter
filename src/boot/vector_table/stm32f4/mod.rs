//! Adapted from the `stm32f4` crate:
//! https://crates.io/crates/stm32f4

#[cfg(feature = "stm32f401")]
mod stm32f401;
#[cfg(feature = "stm32f405")]
mod stm32f405;
#[cfg(feature = "stm32f407")]
mod stm32f407;
#[cfg(feature = "stm32f410")]
mod stm32f410;
#[cfg(feature = "stm32f411")]
mod stm32f411;
#[cfg(feature = "stm32f412")]
mod stm32f412;
#[cfg(feature = "stm32f413")]
mod stm32f413;
#[cfg(feature = "stm32f427")]
mod stm32f427;
#[cfg(feature = "stm32f429")]
mod stm32f429;
#[cfg(feature = "stm32f446")]
mod stm32f446;
#[cfg(feature = "stm32f469")]
mod stm32f469;
