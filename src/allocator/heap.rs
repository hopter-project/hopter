//! The heap implementation largely follows the two-level segregated fit (TLSF)
//! algorithm proposed by M. Masmano et. al.
//!
//! Below shows the SRAM region layout:
//! ```plain
//! +----------------------+ 0x2002_0000 (RAM end, heap end)
//! |         Heap         |
//! +----------------------+ 0x2000_1010 + x (heap start)
//! |     .data + .bss     |
//! +----------------------+ 0x2000_1000 (contiguous stack bottom)
//! |   Contiguous Stack   |
//! +----------------------+ 0x2000_0020 (contiguous stack boundary)
//! |  Task Local Storage  |
//! +----------------------+ 0x2000_0000 (RAM begin)
//! ```
//!
//! Free chunk layout:
//! ```plain
//! +-----------+-----------+-----------+-----+-----------+
//! |   Header  | Prev Link | Next Link | ... |   Footer  |
//! +-----------+-----------+-----------+-----+-----------+
//! |  32 bits  |  16 bits  |  16 bits  | ... |  32 bits  |
//! ```
//!
//! Allocated chunk layout:
//! ```plain
//! +-----------+-----------------------------------------+
//! |   Header  |                Payload                  |
//! +-----------+-----------------------------------------+
//! |  32 bits  |                  ...                    |
//! ^           ^
//! 4-byte      8-byte
//! aligned     aligned
//! ```
//!
//! Header layout:
//! ```plain
//! +--------------+----------------+----------------+
//! | Chunk Length | Self Allocated | Left Allocated |
//! +--------------+----------------+----------------+
//! |    30 bits   |      1 bit     |      1 bit     |
//! ```
//!
//! Footer layout:
//! ```plain
//! +--------------+---------------------------------+
//! | Chunk Length |          Always Zero            |
//! +--------------+---------------------------------+
//! |    30 bits   |             2 bits              |
//! ```
//!
//! Description of fields:
//! - Chunk length: The length of the chunk, including the header and
//!      the footer. The length should always be a multiple of 4. Thus
//!      the lower two bits can be used as flags.
//! - Payload: The chunk as the return value of malloc() back to the
//!      user. It should always be 4-byte aligned.
//! - Self allocated: Indicates whether the current chunk is allocated.
//! - Left allocated: Indicates whether the left neighboring chunk is
//!      allocated. This is used for merging free chunks. The left
//!      neighbor chunk has the footer only when it is free. We use
//!      the length recorded in the footer to calculate the header
//!      address of the left neighbor chunk when it is free.
//! - Prev link / Next link: Free chunks that fall into the same size
//!      category will be linked into a double linked list. These two
//!      fields are the link pointer to adjacent free chunks in the
//!      list. Real header addresses are subtracted with 0x20000000 and
//!      shifted right by 2 bits to be saved in link pointer.

use crate::{
    config::__MEM_CHUNK_LINK_OFFSET,
    unrecoverable::{self, Lethal},
};
use core::{
    arch::asm,
    sync::atomic::{AtomicPtr, Ordering},
};
use static_assertions::const_assert_eq;

type Header = u32;
type Footer = u32;
type Link = u16;

const HDR_SIZE: u32 = core::mem::size_of::<Header>() as u32;
const GUARD_SIZE: u32 = core::mem::size_of::<Header>() as u32;
const FREE_CHUNK_MIN_SIZE: u32 = (core::mem::size_of::<Header>()
    + core::mem::size_of::<Footer>()
    + 2 * core::mem::size_of::<Link>()) as u32;

// The header size must be 4 to ensure the payload in each allocated chunk
// is 8-byte aligned. This is because each chunk is 4-byte aligned but not
// 8-byte aligned. See allocated chunk layout for details.
const_assert_eq!(HDR_SIZE, 4);

/// Given the pointer to header, return the pointer to payload.
#[inline(always)]
fn hdr_to_payload(hdr: *mut Header) -> *mut u8 {
    hdr.wrapping_byte_add(4) as *mut u8
}

/// Given the pointer to payload, return the pointer to header.
#[inline(always)]
fn payload_to_hdr(ptr: *mut u8) -> *mut Header {
    ptr.wrapping_byte_sub(4) as *mut Header
}

/// Given the pointer to header, return chunk size.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn get_hdr_chunk_size(hdr: *mut Header) -> u32 {
    *hdr & (!0x3)
}

/// Set chunk size in header and leave flags unmodified.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
/// - `size` must be a multiple of 4.
///
/// FIXME: double check safety condition
#[inline(always)]
unsafe fn set_hdr_chunk_size(hdr: *mut Header, size: u32) {
    *hdr = (size & (!0x3)) | (*hdr & 0x3);
}

/// Write zeros to the header field. This will initialize the field.
///
/// Safety:
/// - `hdr` must point to a header field, not necessarily initialized.
#[inline(always)]
unsafe fn clear_hdr(hdr: *mut Header) {
    *hdr = 0;
}

/// Given the pointer to header, return the pointer to footer.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn hdr_to_ftr(hdr: *mut Header) -> *mut Footer {
    hdr.wrapping_byte_add(get_hdr_chunk_size(hdr) as usize)
        .wrapping_byte_sub(4) as *mut Footer
}

/// Set chunk size in footer.
///
/// Safety:
/// - `ftr` must point to a footer field, not necessarily initialized.
/// - `size` must be a multiple of 4.
#[inline(always)]
unsafe fn set_ftr_chunk_size(ftr: *mut Footer, size: u32) {
    *ftr = size;
}

/// Given the pointer to header, return the right neighbor's header.
///
/// Safety:
/// `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn hdr_to_right_hdr(hdr: *mut Header) -> *mut Header {
    hdr.wrapping_byte_add(get_hdr_chunk_size(hdr) as usize)
}

/// Given the pointer to header, return the left neighbor's footer.
/// `hdr` must point to an initialized header field, and its left neighbor
/// chunk must be free. Otherwise, the returned pointer will be invalid.
#[inline(always)]
fn hdr_to_left_ftr(hdr: *mut Header) -> *mut Footer {
    hdr.wrapping_byte_sub(4) as *mut Footer
}

/// Given the pointer to header, return the left neighbor's header.
///
/// Safety:
/// - `hdr` must point to an initialized header field, and its left neighbor
///    chunk must be free.
#[inline(always)]
unsafe fn hdr_to_left_hdr(hdr: *mut Header) -> *mut Header {
    hdr.wrapping_byte_sub(*hdr_to_left_ftr(hdr) as usize)
}

/// Given the pointer to header, return whether the chunk is free.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn is_this_free(hdr: *mut Header) -> bool {
    (*hdr & 0x2) == 0
}

/// Given the pointer to header, return whether the left neighbor chunk
/// is allocated. Note: this is done by reading flags in the *current*
/// header.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn is_left_free(hdr: *mut Header) -> bool {
    (*hdr & 0x1) == 0
}

/// Given the pointer to header, return whether the right neighbor chunk
/// is allocated. Note: this is done by reading flags in the *right
/// neighbor's* header.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn is_right_free(hdr: *mut Header) -> bool {
    is_this_free(hdr_to_right_hdr(hdr))
}

/// Mark the given chunk as free.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn set_this_free(hdr: *mut Header) {
    *hdr &= !0x2;
}

/// Mark the given chunk as allocated.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn set_self_allocated(hdr: *mut Header) {
    *hdr |= 0x2;
}

/// Mark the left neighbor chunk as allocated *in the current header*.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn set_left_allocated(hdr: *mut Header) {
    *hdr |= 0x1;
}

/// Mark the left neighbor chunk as free *in the current header*.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn set_left_free(hdr: *mut Header) {
    *hdr &= !0x1;
}

/// Convert a `Link` to a pointer.
#[inline(always)]
fn link_to_ptr<T>(link: Link) -> *mut T {
    (__MEM_CHUNK_LINK_OFFSET + ((link as u32) << 2)) as *mut T
}

/// Convert a pointer to a `Link`.
#[inline(always)]
fn ptr_to_link<T>(ptr: *mut T) -> Link {
    (((ptr as u32) - __MEM_CHUNK_LINK_OFFSET) >> 2) as Link
}

/// Given a pointer to header, return the pointer to the `prev` field.
#[inline(always)]
fn hdr_to_prev_field(hdr: *mut Header) -> *mut Link {
    hdr.wrapping_byte_add(4) as *mut Link
}

/// Given a pointer to header, return the pointer to the `next` field.
#[inline(always)]
fn hdr_to_next_field(hdr: *mut Header) -> *mut Link {
    hdr.wrapping_byte_add(6) as *mut Link
}

/// Given the pointer to header, return header of the previous free chunk in
/// the linked list.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn hdr_to_prev_hdr(hdr: *mut Header) -> *mut Header {
    link_to_ptr(*hdr_to_prev_field(hdr)) as *mut Header
}

/// Given the pointer to header, return header of the next free chunk in the
/// linked list.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
#[inline(always)]
unsafe fn hdr_to_next_hdr(hdr: *mut Header) -> *mut Header {
    link_to_ptr(*hdr_to_next_field(hdr)) as *mut Header
}

/// A `Sentinel` represents the beginning and the ending in a circular linked
/// list.
#[repr(C)]
struct Sentinel {
    hdr: Header,
    prev: Link,
    next: Link,
}

impl Sentinel {
    const fn new() -> Self {
        Self {
            hdr: 0,
            prev: 0,
            next: 0,
        }
    }
}

/// There are 6 linked lists, one for each chunk size category.
/// Index : Size Range
/// 0 : 16 - 31
/// 1 : 32 - 63
/// 2 : 64 - 127
/// 3 : 128 - 255
/// 4 : 256 - 511
/// 5 : 512 and above
static mut SENTINELS: [Sentinel; 6] = [
    Sentinel::new(),
    Sentinel::new(),
    Sentinel::new(),
    Sentinel::new(),
    Sentinel::new(),
    Sentinel::new(),
];

/// The starting address of heap. Set upon initialization.
static mut HEAP_START: *mut u8 = core::ptr::null_mut();

/// One cached chunk upon free().
static mut CACHED: AtomicPtr<Header> = AtomicPtr::new(core::ptr::null_mut());

/// The right most position the heap has ever grown to.
pub(crate) static mut HIGH_WATER_MARK: u32 = 0;

/// If the high water mark has just been updated.
pub(crate) static mut HIGH_WATER_MARK_JUST_UPDATED: bool = false;

/// Sum of all currently allocated size.
static mut CUR_ALLOC_SIZE: u32 = 0;

/// Historical maximum of the sum of all currently allocated size.
static mut MAX_ALLOC_SIZE: u32 = 0;

/// Unlink the given chunk from the free list.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
unsafe fn unlink_chunk(hdr: *mut Header) {
    let prev_hdr = hdr_to_prev_hdr(hdr);
    let next_hdr = hdr_to_next_hdr(hdr);
    *hdr_to_next_field(prev_hdr) = ptr_to_link(next_hdr);
    *hdr_to_prev_field(next_hdr) = ptr_to_link(prev_hdr);
}

/// Link the given chunk back to the free list. It will be placed right
/// after `prev_hdr`.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
/// - `prev_hdr` must point to an initialized header field.
unsafe fn link_chunk(prev_hdr: *mut Header, hdr: *mut Header) {
    let next_hdr = hdr_to_next_hdr(prev_hdr);
    *hdr_to_next_field(prev_hdr) = ptr_to_link(hdr);
    *hdr_to_prev_field(next_hdr) = ptr_to_link(hdr);
    *hdr_to_next_field(hdr) = ptr_to_link(next_hdr);
    *hdr_to_prev_field(hdr) = ptr_to_link(prev_hdr);
}

/// Unlink the right neighbor chunk from the free list and merge it
/// with the given chunk. Return header of the merged chunk. The size
/// field in the new header is updated to the merged size.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
unsafe fn unlink_and_merge_right(hdr: *mut Header) -> *mut Header {
    let right_hdr = hdr_to_right_hdr(hdr);
    unlink_chunk(right_hdr);
    let total_size = get_hdr_chunk_size(hdr) + get_hdr_chunk_size(right_hdr);
    set_hdr_chunk_size(hdr, total_size);
    hdr
}

/// Unlink the left neighbor chunk from the free list and merge it
/// with the given chunk. Return header of the merged chunk. The size
/// field in the new header is updated to the merged size.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
unsafe fn unlink_and_merge_left(hdr: *mut Header) -> *mut Header {
    let left_hdr = hdr_to_left_hdr(hdr);
    unlink_chunk(left_hdr);
    let total_size = get_hdr_chunk_size(hdr) + get_hdr_chunk_size(left_hdr);
    set_hdr_chunk_size(left_hdr, total_size);
    left_hdr
}

/// Unlink both the left and right neighbor chunk from the free list
/// and merge it with the given chunk. Return header of the merged chunk.
/// The size field in the new header is updated to the merged size.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
unsafe fn unlink_and_merge_neighbor(hdr: *mut Header) -> *mut Header {
    let left_hdr = hdr_to_left_hdr(hdr);
    let right_hdr = hdr_to_right_hdr(hdr);
    unlink_chunk(left_hdr);
    unlink_chunk(right_hdr);
    let total_size =
        get_hdr_chunk_size(hdr) + get_hdr_chunk_size(left_hdr) + get_hdr_chunk_size(right_hdr);
    set_hdr_chunk_size(left_hdr, total_size);
    left_hdr
}

/// If any neighbor block is also free, merge with them. Return header of
/// the merged block. The size field in the new header is updated to the
/// merged size.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
unsafe fn merge_neighbor_if_possible(hdr: *mut Header) -> *mut Header {
    let left_free = is_left_free(hdr);
    let right_free = is_right_free(hdr);
    match left_free as u8 + (right_free as u8) * 2 {
        0 => hdr,
        1 => unlink_and_merge_left(hdr),
        2 => unlink_and_merge_right(hdr),
        3 => unlink_and_merge_neighbor(hdr),
        _ => loop {},
    }
}

/// Set the chunk as free and update its header and footer to contain the
/// given chunk size.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
/// - `size` must be a multiple of 4.
unsafe fn set_free_chunk_hdr_ftr(hdr: *mut Header, size: u32) {
    clear_hdr(hdr);
    set_hdr_chunk_size(hdr, size);
    let ftr = hdr_to_ftr(hdr);
    set_ftr_chunk_size(ftr, size);
    set_this_free(hdr);
}

/// Return the starting index of free lists to search from.
/// See also [`SENTINELS`].
fn chunk_size_to_list_index(size: u32) -> usize {
    27u32.saturating_sub(size.leading_zeros()).min(5) as usize
}

/// If the candidate free chunk is sufficiently larger than the requested
/// allocation size, we split it into two and put the excessive part back
/// to the free lists. The remaining part, still being pointed to by `hdr`,
/// will be used for allocation.
///
/// Safety:
/// - `hdr` must point to an initialized header field.
/// - `size` must be a multiple of 4.
unsafe fn return_excess_to_free_list(hdr: *mut Header, size: u32) {
    let total_size = get_hdr_chunk_size(hdr);
    if total_size < size + FREE_CHUNK_MIN_SIZE {
        return;
    }

    let right_size = total_size - size;
    let right_hdr = hdr.wrapping_byte_add(size as usize);
    set_free_chunk_hdr_ftr(right_hdr, right_size);
    let idx = chunk_size_to_list_index(right_size);
    link_chunk(&raw mut SENTINELS[idx].hdr, right_hdr);

    set_hdr_chunk_size(hdr, size);
}

/// Search the free lists using the first fit strategy. Return a null pointer
/// when the requested allocation size cannot be satisfied.
fn search_first_fit(size: u32) -> *mut Header {
    let idx_fit = (chunk_size_to_list_index(size) + 1).min(5);

    // Safety: All header fields in a free linked list are already initialized.
    // The header fields form circular linked lists.
    unsafe {
        for idx in idx_fit..=5 {
            let end = &raw mut SENTINELS[idx].hdr;
            let mut cur = link_to_ptr(SENTINELS[idx].next);
            while cur != end {
                if get_hdr_chunk_size(cur) >= size {
                    return cur;
                }
                cur = hdr_to_next_hdr(cur);
            }
        }
    }

    core::ptr::null_mut()
}

/// Return an allocated chunk back to the heap free lists.
///
/// Safety:
/// - `payload` must be a pointer previously returned by [`mcu_malloc`].
pub(crate) unsafe fn mcu_free(payload: *mut u8) {
    let mut hdr = payload_to_hdr(payload);

    // Cache the chunk if the cache is empty.
    if CACHED.load(Ordering::SeqCst).is_null() {
        CACHED.store(hdr, Ordering::SeqCst);
        return;
    // Otherwise, make this new chunk as the cache.
    // Free the old cached chunk.
    } else {
        hdr = CACHED.swap(hdr, Ordering::SeqCst);
    }

    CUR_ALLOC_SIZE -= get_hdr_chunk_size(hdr);

    // Always merge with neighboring free chunks if possible.
    // We maintain the invariant that there is no adjacent free
    // chunks, i.e. they will always be merged into one.
    let merged_hdr = merge_neighbor_if_possible(hdr);
    set_this_free(merged_hdr);
    let merged_ftr = hdr_to_ftr(merged_hdr);
    set_ftr_chunk_size(merged_ftr, get_hdr_chunk_size(merged_hdr));

    // Whenever we can merge free chunks, we always merge them.
    // Thus, after merging, the left neighbor must be allocated.
    set_left_allocated(merged_hdr);

    // The right neighbor chunk should see the current chunk
    // as free.
    let right_hdr = hdr_to_right_hdr(merged_hdr);
    set_left_free(right_hdr);

    // Link the chunk into the free list.
    let size = get_hdr_chunk_size(merged_hdr);
    let idx = chunk_size_to_list_index(size);
    link_chunk(&raw mut SENTINELS[idx].hdr, merged_hdr);
}

/// Allocate a chunk with payload size that is no less than `size`.
/// Return a pointer to the allocated chunk, or null when the requested size
/// cannot be satisfied.
///
/// Safety:
/// - The heap must be initialized before calling this funcion.
pub(crate) unsafe fn mcu_malloc(mut size: u32) -> *mut u8 {
    if size == 0 {
        return core::ptr::null_mut();
    }

    // Add the header overhead.
    size += HDR_SIZE;
    // Round up to minimum allocation size. This is because a free
    // block must be larger than 16 bytes.
    size = size.max(16);
    // Round up to a multiple of 8.
    size = (size + 7) & (!7);

    // If the cached chunk satisfies the request, use it.
    let cached = CACHED.load(Ordering::SeqCst);
    if !cached.is_null()
        && get_hdr_chunk_size(cached) >= size
        && get_hdr_chunk_size(cached) - size <= 512
    {
        let payload = hdr_to_payload(cached);
        CACHED.store(core::ptr::null_mut(), Ordering::SeqCst);
        return payload;
    }

    // Otherwise, search the free list to find one.
    let hdr = search_first_fit(size);
    if hdr.is_null() {
        return core::ptr::null_mut();
    }

    unlink_chunk(hdr);
    return_excess_to_free_list(hdr, size);
    set_self_allocated(hdr);

    // Since we maintain the invariant that there will not be
    // two adjacent free chunks, the left neighbor chunk must
    // be allocated.
    set_left_allocated(hdr);

    // Mark the flag in the right neighbor chunk that the current
    // chunk has been allocated.
    let right_hdr = hdr_to_right_hdr(hdr);
    set_left_allocated(right_hdr);

    // Update high water mark.
    if right_hdr as u32 > HIGH_WATER_MARK {
        HIGH_WATER_MARK = right_hdr as u32;
        HIGH_WATER_MARK_JUST_UPDATED = true;
    }

    CUR_ALLOC_SIZE += get_hdr_chunk_size(hdr);
    if CUR_ALLOC_SIZE >= MAX_ALLOC_SIZE {
        MAX_ALLOC_SIZE = CUR_ALLOC_SIZE;
    }

    hdr_to_payload(hdr)
}

// Initialize the heap structure.
pub(crate) unsafe fn mcu_heap_init(mut data_end: u32) {
    // Round up to a multiple of 4.
    data_end = data_end.checked_add(3).unwrap_or_die() & (!3);

    // Round up so that data_end % 8 == 4.
    // This is to ensure that the payload of every allocated chunk is
    // 8-byte aligned.
    data_end = if data_end % 8 == 0 {
        data_end.checked_add(4).unwrap_or_die()
    } else {
        data_end
    };

    let ram_end_addr = get_ram_end_addr();

    if ram_end_addr < data_end {
        unrecoverable::die_with_arg("No memory for heap.");
    }
    if ram_end_addr - data_end < FREE_CHUNK_MIN_SIZE {
        unrecoverable::die_with_arg("No memory for heap.");
    }

    // Set the heap start address.
    HEAP_START = data_end as *mut u8;

    // Calculate free size for the entire heap.
    let buffer_size = ram_end_addr - data_end;

    // Initialize free lists. Mark all of them as empty.
    for idx in 0..=5 {
        SENTINELS[idx].next = ptr_to_link(&raw mut SENTINELS[idx].hdr);
        SENTINELS[idx].prev = ptr_to_link(&raw mut SENTINELS[idx].hdr);
    }

    // Make the whole heap space a single free chunk.
    let hdr = HEAP_START as *mut Header;
    let init_size = buffer_size - GUARD_SIZE;
    set_free_chunk_hdr_ftr(hdr, init_size);

    // Pretend that the memory on the left is an allocated
    // chunk so that free chunks will not try to merge with it.
    set_left_allocated(hdr);

    // At the end of the heap space, we put a gurad which is
    // essentially a header. Thus, the operations on chunks are
    // uniform regardless of whether a chunk is at the boundary
    // of the heap.
    let guard = hdr_to_right_hdr(hdr);
    clear_hdr(guard);
    set_hdr_chunk_size(guard, 0);
    set_self_allocated(guard);
    set_left_free(guard);

    // Put the initial chunk into the free list.
    link_chunk(
        &raw mut SENTINELS[chunk_size_to_list_index(init_size)].hdr,
        hdr,
    );
}

fn get_ram_end_addr() -> u32 {
    extern "C" {
        // The symbol comes from `link.ld`.
        static __ram_end: u32;
    }

    let end: u32;
    unsafe {
        asm!(
            "ldr {end}, ={ram_end}",
            end = out(reg) end,
            ram_end = sym __ram_end,
        )
    }
    end
}
