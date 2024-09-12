//! This module parses the ARM exception handling index and table structure
//! stored in `.ARM.exidx` and `.ARM.extab` section. It follows the ARM official
//! document: Exception Handling ABI for the Arm Architecture. The chapters
//! mentioned in below comments all refer to this document.

use crate::unrecoverable::{self, Lethal};

/// Prel31 offset is a position relative pointer. The value represented
/// by a prel31 offset is *the address of the prel31 data itself plus
/// the value it stored*. A prel31 offset has 32 bits, but the most
/// significant bit is used for storing arbitrary data, which does
/// not participate in value calculation. The reset 31 bits have two's
/// complement representation.
#[derive(Debug)]
pub struct Prel31 {
    /// The raw bits of the prel31 offset. The most significant bit
    /// stores arbitraty data. The reset 31 bits are two's complement
    /// offset from its address.
    offset_raw: i32,

    /// The address of a prel31 offset.
    self_addr: u32,
}

impl Prel31 {
    /// Construct a prel31 offset from little-endian bytes.
    pub fn from_bytes(bytes: &[u8; 4]) -> Self {
        Prel31 {
            offset_raw: i32::from_le_bytes(*bytes),
            self_addr: &bytes[0] as *const _ as u32,
        }
    }

    /// Get the address it points to.
    pub fn value(&self) -> u32 {
        self.self_addr.wrapping_add(self.offset_value() as u32)
    }

    /// Get the offset value.
    pub fn offset_value(&self) -> i32 {
        (self.offset_raw << 1) >> 1
    }

    /// Get the raw bits.
    pub fn raw(&self) -> i32 {
        self.offset_raw
    }

    /// Check if the most significant bit is set. Note that
    /// the most significant bit does not participate in offset
    /// calculation.
    pub fn is_msb_set(&self) -> bool {
        (self.offset_raw as u32 & 0x8000_0000) != 0
    }
}

/// The type of an exidx entry. There are three variants.
/// Document chapter 6 (Index table entries).
#[derive(Debug)]
enum ExIdxEntryContent<'a> {
    /// The generic variant. The value should be read as a
    /// prel31 offset. We store the decoded address here.
    ExTabEntryAddr(u32),

    /// The compact variant. Bit 31 must be 1. Bits [27:24]
    /// indicate the compact module personality routine number.
    /// Bits [23:16], [15:8], [7:0] are the data for the personality
    /// routine. In reality they are ARM unwind instructions.
    /// Other bits are reserved.
    Compact(PersonalityType, UnwindInstrIter<'a>),

    /// The 0x0000_0001 bit pattern, indicating that this
    /// function cannot unwind. No unwind instruction is
    /// present for this function.
    CantUnwind,
}

impl<'a> ExIdxEntryContent<'a> {
    /// Extract the exidx entry type from a prel31 offset.
    fn from_raw(prel31: Prel31, bytes: &'a [u8; 4]) -> Self {
        // If the raw pattern is 0x0000_0001, then can't unwind.
        if prel31.raw() == 0x1 {
            return Self::CantUnwind;
        }

        // If the most significant bit is set, this is the compact model.
        if prel31.is_msb_set() {
            // Bits [27:24] are the personality routine selector.
            let pers_sel = (((prel31.raw() & 0x0f_00_00_00) as u32) >> 24) as u8;

            // Create the byte iterator over the other 3 bytes. The `from_bytes` method
            // requires the slice to have a length of a multiple of 4. Thus, we create
            // the iterator from the full 4-byte slice and immediately skip the first byte.
            let mut byte_iter = UnwindByteIter::from_bytes(&bytes[..]).unwrap_or_die();
            byte_iter.next();

            // Adapt the byte iterator into unwind instruction iterator.
            let unw_instr_iter = UnwindInstrIter::from_byte_iter(byte_iter);

            return Self::Compact(PersonalityType::Compact(pers_sel), unw_instr_iter);
        }

        // Otherwise, this is the generic version. We decode the address
        // pointing to the extab.
        return Self::ExTabEntryAddr(prel31.value());
    }
}

/// An exidx entry. Each entry in the exidx section consists of two 32-bit
/// words. The first word is a prel31 offset to a function. The other is the
/// compound content. Entries are sorted according to the function address in
/// the exidx section.
#[derive(Debug)]
pub struct ExIdxEntry<'a> {
    /// The corresponding function address. We store the decoded address
    /// here rather than the raw prel31 offset.
    func_addr: u32,

    /// The content enum. It has three variants.
    content: ExIdxEntryContent<'a>,
}

impl<'a> ExIdxEntry<'a> {
    /// Construct a new exidx entry from raw bytes. Note that we must read
    /// the .ARM.exidx section in place without any data copy, because
    /// prel31 offset is relative to the address of itself.
    pub fn from_bytes(bytes: &'a [u8; 8]) -> Result<Self, &'static str> {
        // Make sure we don't copy anything, just manipulating types.
        let func_offset = Prel31::from_bytes(
            <&[u8; 4]>::try_from(&bytes[0..4])
                .map_err(|_| "ExIdxEntry::from_bytes: array reference conversion failed.")
                .unwrap_or_die(),
        );
        let content_bytes_ref = <&[u8; 4]>::try_from(&bytes[4..8])
            .map_err(|_| "ExIdxEntry::from_bytes: array reference conversion failed.")
            .unwrap_or_die();
        let content_prel31 = Prel31::from_bytes(content_bytes_ref);

        // Sanity check. Citing from the document chapter 6:
        // "The first word contains a prel31 offset to the start
        // of a function, with bit 31 clear."
        if func_offset.is_msb_set() {
            return Err("ExIdxEntry::from_bytes: corrupted entry.");
        }

        Ok(ExIdxEntry {
            func_addr: func_offset.value() as u32,
            content: ExIdxEntryContent::from_raw(content_prel31, content_bytes_ref),
        })
    }

    /// Check if the entry describes a function that can unwind.
    pub fn can_unwind(&self) -> bool {
        match self.content {
            ExIdxEntryContent::ExTabEntryAddr(_) => true,
            ExIdxEntryContent::Compact(_, _) => true,
            ExIdxEntryContent::CantUnwind => false,
        }
    }

    /// Check if the entry has compact representation.
    pub fn is_compact(&self) -> bool {
        if let ExIdxEntryContent::Compact(..) = self.content {
            true
        } else {
            false
        }
    }

    /// Get the unwind instructions from the compact representation.
    /// Precondition: `is_compact()` must return true.
    pub fn get_unw_instr_iter(&self) -> UnwindInstrIter<'a> {
        match &self.content {
            ExIdxEntryContent::Compact(_, iter) => iter.clone(),
            _ => unrecoverable::die_with_arg("ExIdxEntry::into_unw_instr_iter: not compact."),
        }
    }

    /// Get the the personality function from the compact representation.
    /// Precondition: `is_compact()` must return true.
    pub fn get_personality(&self) -> PersonalityType {
        match &self.content {
            ExIdxEntryContent::Compact(pers, _) => pers.clone(),
            _ => unrecoverable::die_with_arg("ExIdxEntry::get_personality: not compact."),
        }
    }

    /// Get the .ARM.extab entry address from the generic representation.
    /// Precondition: `is_compact()` must return false, `can_unwind` must
    /// return true.
    pub fn get_extab_entry_addr(&self) -> u32 {
        match self.content {
            ExIdxEntryContent::ExTabEntryAddr(offset) => offset,
            _ => unrecoverable::die_with_arg("ExIdxEntry::get_unw_tbl_entry_addr: not generic."),
        }
    }

    /// Get the function address represented by this entry.
    pub fn get_func_addr(&self) -> u32 {
        self.func_addr
    }
}

/// The type of a personality function.
#[derive(Debug, PartialEq, Clone)]
pub enum PersonalityType {
    /// The compact variant. The enclosed value is the selector
    /// to compact personality routines. Valid range [0, 15].
    Compact(u8),

    /// The generic variant. The enclosed value is the address
    /// of the personality routine.
    Generic(u32),
}

/// The variants of unwind instructions. All variants are listed here
/// but only integer variants are supported for now. See
/// `UnwindState::step` for how these instructions are applied.
#[derive(Debug)]
#[allow(unused)]
pub enum UnwindInstruction {
    DataPop { size: u32 },
    DataPush { size: u32 },
    RegPop { mask: u32 },
    RegToSp { reg_num: u8 },
    VfpPop { start_reg_num: u8, count: u8 },
    WregPop,
    WcgrPop,
    Finish,
    Refused,
    Reserved,
    Unimplemented,
    Error,
}

impl UnwindInstruction {
    /// Step the raw byte iterator and return a new unwind instruction.
    /// It follows the document chapter 10.3 (Frame unwinding instructions)
    /// the table Arm-defined frame-unwinding instructions. When the iteration
    /// reaches the end, it returns `Ok(None)`. When it can still yield another
    /// unwind instruction, it returns it with `Ok(Some(..))`. When there is
    /// unexpected error, it returns `Err(..)`.
    ///
    /// Reference implementation:
    /// <https://github.com/libunwind/libunwind/blob/e07b43c02d/src/arm/Gex_tables.c>
    fn step_iter(iter: &mut impl Iterator<Item = u8>) -> Result<Option<Self>, &'static str> {
        static ERR_MSG: &str = "UnwindInstruction::step_iter: unexpected end of iterator.";
        let op = match iter.next() {
            Some(op) => op,
            None => return Ok(None),
        };

        if (op & 0xc0) == 0x00 {
            return Ok(Some(Self::DataPop {
                size: (((op & 0x3f) as u32) << 2) + 4,
            }));
        } else if (op & 0xc0) == 0x40 {
            return Ok(Some(Self::DataPush {
                size: (((op & 0x3f) as u32) << 2) + 4,
            }));
        } else if (op & 0xf0) == 0x80 {
            let op2 = iter.next().ok_or(ERR_MSG)?;
            if op == 0x80 && op2 == 0x00 {
                return Ok(Some(Self::Refused));
            } else {
                let mut mask = (((op & 0x0f) as u32) << 8) | (op2 as u32);
                if mask == 0 {
                    return Ok(Some(Self::Error));
                }
                mask <<= 4;
                return Ok(Some(Self::RegPop { mask }));
            }
        } else if (op & 0xf0) == 0x90 {
            if op == 0x9d || op == 0x9f {
                return Ok(Some(Self::Reserved));
            }
            let reg_num = op & 0x0f;
            return Ok(Some(Self::RegToSp { reg_num }));
        } else if (op & 0xf0) == 0xa0 {
            let end = op & 0x07;
            let mut mask = (1u32 << (end + 1)) - 1;
            mask <<= 4;
            if (op & 0x08) != 0 {
                mask |= 1 << 14;
            }
            return Ok(Some(Self::RegPop { mask }));
        } else if op == 0xb0 {
            return Ok(Some(Self::Finish));
        } else if op == 0xb1 {
            let op2 = iter.next().ok_or(ERR_MSG)?;
            if op2 == 0 || (op2 & 0xf0) != 0 {
                return Ok(Some(Self::Reserved));
            }
            let mask = (op2 & 0x0f) as u32;
            return Ok(Some(Self::RegPop { mask }));
        } else if op == 0xb2 {
            let mut offset = 0u32;
            let mut shift = 0;
            loop {
                let byte = iter.next().ok_or(ERR_MSG)?;
                offset |= ((byte & 0x7f) as u32) << shift;
                shift += 7;
                if (byte & 0x80) == 0 {
                    break;
                }
            }
            offset = offset * 4 + 0x204;
            return Ok(Some(Self::DataPop { size: offset }));
        } else if op == 0xc8 {
            let op2 = iter.next().ok_or(ERR_MSG)?;
            let start_reg_num = (op2 >> 4) + 16;
            let count = (op2 & 0x0f) + 1;
            return Ok(Some(Self::VfpPop {
                start_reg_num,
                count,
            }));
        } else if op == 0xc9 {
            let op2 = iter.next().ok_or(ERR_MSG)?;
            let start_reg_num = op2 >> 4;
            let count = (op2 & 0x0f) + 1;
            return Ok(Some(Self::VfpPop {
                start_reg_num,
                count,
            }));
        } else if op == 0xb3 {
            return Ok(Some(Self::Unimplemented));
        } else if (op & 0xf8) == 0xb8 || (op & 0xf8) == 0xd0 {
            return Ok(Some(Self::Unimplemented));
        } else if op >= 0xc0 && op <= 0xc5 {
            return Ok(Some(Self::Unimplemented));
        } else if op == 0xc6 {
            return Ok(Some(Self::Unimplemented));
        } else if op == 0xc7 {
            return Ok(Some(Self::Unimplemented));
        } else {
            return Ok(Some(Self::Unimplemented));
        }
    }
}

/// An iterator on raw bytes of unwind instructions.
/// ARM defines a weird byte order:
/// - Bytes are divided into 4-byte words, reading from the least
///   significant one to the most significant one.
/// - Inside each word, read from the most significant byte to
///   the least significant byte.
#[derive(Debug, Clone)]
pub struct UnwindByteIter<'a> {
    bytes: &'a [u8],
    pos: usize,
}

impl<'a> UnwindByteIter<'a> {
    /// Create an unwind instruction iterator on its raw byte representation.
    /// Precondition: the byte length must be a multiple of 4.
    fn from_bytes(bytes: &'a [u8]) -> Result<Self, &'static str> {
        if bytes.len() % 4 != 0 {
            return Err("UnwindInstrIter::from_bytes: bytes length not a multiple of 4.");
        }
        Ok(Self { bytes, pos: 0 })
    }
}

impl<'a> Iterator for UnwindByteIter<'a> {
    type Item = u8;

    /// Advance the iterator and return a byte. At 4-byte word level,
    /// read from the least significant to the most significant. Inside
    /// a word, read from the most significant to the least.
    fn next(&mut self) -> Option<Self::Item> {
        if self.pos >= self.bytes.len() {
            return None;
        }
        let word_pos = self.pos / 4;
        let byte_pos = 3 - self.pos % 4;
        self.pos += 1;
        Some(self.bytes[word_pos * 4 + byte_pos])
    }
}

/// An iterator that yields unwind instructions by reading from either the exception
/// table or the exception indicies. This iterator uses `UnwindByteIter` to get the
/// raw bytes.
#[derive(Debug, Clone)]
pub struct UnwindInstrIter<'a> {
    byte_iter: UnwindByteIter<'a>,
}

impl<'a> Iterator for UnwindInstrIter<'a> {
    type Item = UnwindInstruction;

    fn next(&mut self) -> Option<Self::Item> {
        match UnwindInstruction::step_iter(&mut self.byte_iter) {
            Ok(instr) => instr,
            Err(_) => Some(UnwindInstruction::Error),
        }
    }
}

impl<'a> UnwindInstrIter<'a> {
    fn from_byte_iter(byte_iter: UnwindByteIter<'a>) -> Self {
        Self { byte_iter }
    }
}

/// An exception table entry. Each raw entry indicates a personality routine,
/// followed by a sequence of unwind instructions, and then optionally
/// a LSDA (language specific data area). This structure only deals with
/// the language agnostic part, deferring parsing the LSDA to other module.
pub struct ExTabEntry<'a> {
    /// The personality routine. Can be either the compact model
    /// or the generic model.
    personality: PersonalityType,

    /// An iterator that yields unwind instructions.
    unw_instr_iter: UnwindInstrIter<'a>,
}

impl<'a> ExTabEntry<'a> {
    /// Construct an exception table entry from raw bytes. The `entry_offset` is
    /// the offset into the `.ARM.extab` section. We can obtain it from binary
    /// searching the `.ARM.exidx` section.
    /// If the method runs successfully, it returns an exception table entry plus
    /// the slice of raw bytes following the entry. We need the following bytes
    /// because it might be an LSDA. We will later pass it to the LSDA parser.
    ///
    /// Reference implementation:
    /// <https://github.com/libunwind/libunwind/blob/e07b43c02d/src/arm/Gex_tables.c>
    pub fn from_bytes(
        extab: &'a [u8],
        entry_offset: usize,
    ) -> Result<(Self, &'a [u8]), &'static str> {
        if entry_offset % 4 != 0 {
            return Err("ExTabEntry::from_bytes: offset not multiple of 4.");
        }

        let personality;
        let mut iter;
        let lsda_offset;

        // Read the most significant byte in the first word. It distinguishes
        // the compact model between the generic model.
        let raw_pers = extab[entry_offset + 3];

        // If the most significant bit is set, it is the compact model.
        if (raw_pers & 0x80) == 0x80 {
            // Personality selector. Currently only 0, 1, 2 are defined. Others
            // are reserved.
            let pers_sel = raw_pers & 0x0f;

            // Following the reference implementation, if the selector is 1 or 2,
            // bits [23:16] in the first word indicates the number of additional
            // words following the first word. Bits [15:8] and [7:0] are unwind
            // instructions.
            if pers_sel == 1 || pers_sel == 2 {
                personality = PersonalityType::Compact(pers_sel);
                let extra_word_num = extab[entry_offset + 2] as usize;
                let word_aligned_bytes =
                    &extab[entry_offset..entry_offset + 4 + 4 * extra_word_num];
                iter = UnwindByteIter::from_bytes(word_aligned_bytes)?;
                iter.next();
                iter.next();
                lsda_offset = entry_offset + 4 + 4 * extra_word_num;

            // Following the reference implementation, if the selector is 0,
            // there is no extra word. The rest 3 bytes [23:16], [15:8], [7:0]
            // are unwind instructions.
            } else if pers_sel == 0 {
                personality = PersonalityType::Compact(pers_sel);
                let word_aligned_bytes = &extab[entry_offset..entry_offset + 4];
                iter = UnwindByteIter::from_bytes(word_aligned_bytes)?;
                iter.next();
                lsda_offset = entry_offset + 4;

            // Sanity check. Return an error if we see reserved numbers.
            } else {
                return Err("ExTabEntry::from_bytes: unexpected compact personality number.");
            }

        // If the most significant bit is not set, it is the generic model.
        // The first word is the prel31 offset to the personality function.
        // The most significant byte of the second word indicates the number
        // of additional words following the second word. The remaining 3
        // bytes in the second word are unwind instructions.
        } else {
            let pers_offset = Prel31::from_bytes(
                <&[u8; 4]>::try_from(&extab[entry_offset..entry_offset + 4])
                    .map_err(|_| "ExTabEntry::from_bytes: array reference conversion failed.")
                    .unwrap_or_die(),
            );
            personality = PersonalityType::Generic(pers_offset.value());
            let extra_word_num = extab[entry_offset + 7] as usize;
            let word_aligned_bytes =
                &extab[entry_offset + 4..entry_offset + 8 + 4 * extra_word_num];
            iter = UnwindByteIter::from_bytes(word_aligned_bytes)?;
            iter.next();
            lsda_offset = entry_offset + 8 + 4 * extra_word_num;
        }

        // let unw_instrs = UnwindInstruction::collect_from_iter(&mut iter)?;
        let unw_instr_iter = UnwindInstrIter::from_byte_iter(iter);

        // Return the byte slice following the unwind instructions.
        // The slice actually extends to the end of the whole `.ARM.extab`
        // section, but it does not matter since the LSDA parser knows
        // when to stop the parsing, in other words there is a header in
        // LSDA that marks the actual length of it.
        let lsda_slice = &extab[lsda_offset..];

        Ok((
            ExTabEntry {
                personality,
                unw_instr_iter,
            },
            lsda_slice,
        ))
    }

    // Get the personality function.
    pub fn get_personality(&self) -> PersonalityType {
        self.personality.clone()
    }

    // Get the unwind instruction iterator.
    pub fn get_unw_instr_iter(&self) -> UnwindInstrIter<'a> {
        self.unw_instr_iter.clone()
    }
}
