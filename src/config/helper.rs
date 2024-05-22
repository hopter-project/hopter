/// Return if the given constant can be encoded in a thumb2 instruction
/// immediate field. Thumb2 instruction set allows the following four cases:
/// 1. Any constant that can be produced by shifting an 8-bit value left by
///    any number of bits.
/// 2. Any replicated halfword constant of the form 0x00XY00XY.
/// 3. Any replicated halfword constant of the form 0xXY00XY00.
/// 4. Any replicated byte constant of the form 0xXYXYXYXY.
#[allow(unused)]
pub(super) const fn is_thumb2_allowed_constant(x: u32) -> bool {
    // Any constant that can be produced by shifting an 8-bit value left by any number of bits.
    let shifted = x >> x.trailing_zeros();
    if shifted.leading_zeros() >= 24 {
        return true;
    }

    let bits7_0 = x & 0xff;
    let bits15_8 = (x >> 8) & 0xff;
    let bits23_16 = (x >> 16) & 0xff;
    let bits31_24 = (x >> 24) & 0xff;

    // Any replicated halfword constant of the form 0x00XY00XY.
    if bits7_0 == bits23_16 && bits15_8 == 0 && bits31_24 == 0 {
        return true;
    }

    // Any replicated halfword constant of the form 0xXY00XY00.
    if bits15_8 == bits31_24 && bits7_0 == 0 && bits23_16 == 0 {
        return true;
    }

    // Any replicated byte constant of the form 0xXYXYXYXY.
    if bits7_0 == bits15_8 && bits15_8 == bits23_16 && bits23_16 == bits31_24 {
        return true;
    }

    false
}

/// Return whether a given `u32` value is a power of 2.
#[allow(unused)]
pub(super) const fn is_power_of_2(x: u32) -> bool {
    x.leading_zeros() + x.trailing_zeros() == 31
}

/// Assert that a given value has a given type. Compilation will fail if the
/// types mismatch, but the diagnostic message might be obscure.
macro_rules! assert_value_type {
    ($A:ident, $B:ty) => {
        concat_idents::concat_idents!(mod_name = __check_, $A {
            #[allow(nonstandard_style)]
            mod mod_name {
                fn __consume(_x: $B) {}
                fn __check_type() {
                    __consume(super::$A);
                }
            }
        });
    };
}
