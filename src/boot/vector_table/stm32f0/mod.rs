//! Adapted from the `stm32f0` crate:
//! https://crates.io/crates/stm32f0

#[cfg(any(
    feature = "stm32f030",
    feature = "stm32f030x4",
    feature = "stm32f030x6",
    feature = "stm32f030x8",
    feature = "stm32f030xc",
    feature = "stm32f070",
    feature = "stm32f070x6",
    feature = "stm32f070xb",
))]
mod stm32f0x0;
#[cfg(any(
    feature = "stm32f031",
    feature = "stm32f051",
    feature = "stm32f071",
    feature = "stm32f091",
))]
mod stm32f0x1;
#[cfg(any(feature = "stm32f042", feature = "stm32f072",))]
mod stm32f0x2;
#[cfg(any(
    feature = "stm32f038",
    feature = "stm32f048",
    feature = "stm32f058",
    feature = "stm32f078",
    feature = "stm32f098",
))]
mod stm32f0x8;
