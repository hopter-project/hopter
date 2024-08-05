//! This file is derived from `cortex-m-rt` crate, with `Reset`
//! function modified.

use super::{config, interrupt::default};
use core::{arch::asm, slice};
pub use hopter_proc_macro::main;

mod entry;

#[link_section = ".vector_table.reset_vector"]
#[no_mangle]
pub static __RESET_VECTOR: unsafe extern "C" fn() -> ! = Reset;

static mut EXIDX_START: usize = 0usize;
static mut EXIDX_END: usize = 0usize;
static mut EXTAB_START: usize = 0usize;
static mut EXTAB_END: usize = 0usize;

#[allow(unused)]
pub fn get_exidx() -> &'static [u8] {
    let start = unsafe { EXIDX_START } as *const u8;
    let len = unsafe { EXIDX_END - EXIDX_START };
    unsafe { slice::from_raw_parts(start, len) }
}

#[allow(unused)]
pub fn get_extab() -> &'static [u8] {
    let start = unsafe { EXTAB_START } as *const u8;
    let len = unsafe { EXTAB_END - EXTAB_START };
    unsafe { slice::from_raw_parts(start, len) }
}

/// Returns a pointer to the start of the heap
/// The returned pointer is guaranteed to be 4-byte aligned.
#[allow(unused)]
#[inline]
pub fn heap_start() -> u32 {
    extern "C" {
        static mut __sheap: u32;
    }

    let p: u32;
    unsafe {
        asm!(
            "ldr  {r}, ={sheap}",
            r = out(reg) p,
            sheap = sym __sheap
        );
    }
    p
}

#[link_section = ".Reset"]
#[allow(non_snake_case)]
#[export_name = "Reset"]
#[naked]
unsafe extern "C" fn Reset() -> ! {
    extern "C" {
        // These symbols come from `link.ld`
        static mut __sbss: u32;
        static mut __ebss: u32;
        static mut __sdata: u32;
        static mut __edata: u32;
        static __sidata: u32;
        static __sarm_exidx: u32;
        static __earm_exidx: u32;
        static __sarm_extab: u32;
        static __earm_extab: u32;
        static __tmp_stack: u32;
        fn memclr(ptr: *mut u8, len: usize);
        fn memcpy(dst: *mut u8, src: *const u8, len: usize);
        fn memset(ptr: *mut u8, val: u8, len: usize);
    }
    asm!(
        "ldr r0, ={sbss}",
        "ldr r1, ={ebss}",
        "sub r1, r1, r0",
        "bl  {memclr}",
        "ldr r0, ={sdata}",
        "ldr r1, ={sidata}",
        "ldr r2, ={edata}",
        "sub r2, r2, r0",
        "bl  {memcpy}",
        "mov r0, #0x20000000",
        "mov r1, #0xAA",
        "ldr r2, ={kern_stk_len}",
        "bl  {memset}",
        "ldr r0, ={sexidx}",
        "ldr r1, ={ptr_exidx_start}",
        "str r0, [r1]",
        "ldr r0, ={eexidx}",
        "ldr r1, ={ptr_exidx_end}",
        "str r0, [r1]",
        "ldr r0, ={sextab}",
        "ldr r1, ={ptr_extab_start}",
        "str r0, [r1]",
        "ldr r0, ={eextab}",
        "ldr r1, ={ptr_extab_end}",
        "str r0, [r1]",
        "ldr r1, ={kern_stk_boundary}",
        "ldr r0, ={stklet_boundary_mem_addr}",
        "str r1, [r0]",
        "mov r1, #0",
        "str r1, [r0, #4]",
        "str r1, [r0, #8]",
        "mov lr, #0",
        "b  {entry}",
        sbss = sym __sbss,
        ebss = sym __ebss,
        sdata = sym __sdata,
        edata = sym __edata,
        sidata = sym __sidata,
        sexidx = sym __sarm_exidx,
        eexidx = sym __earm_exidx,
        ptr_exidx_start = sym EXIDX_START,
        ptr_exidx_end = sym EXIDX_END,
        sextab = sym __sarm_extab,
        eextab = sym __earm_extab,
        ptr_extab_start = sym EXTAB_START,
        ptr_extab_end = sym EXTAB_END,
        kern_stk_len = const { config::CONTIGUOUS_STACK_BOTTOM - 0x2000_0000 },
        kern_stk_boundary = const config::CONTIGUOUS_STACK_BOUNDARY,
        stklet_boundary_mem_addr = const config::TLS_MEM_ADDR,
        memclr = sym memclr,
        memcpy = sym memcpy,
        memset = sym memset,
        entry = sym entry::entry,
        options(noreturn)
    );
}

pub union Vector {
    handler: unsafe extern "C" fn(),
    reserved: usize,
}

#[link_section = ".vector_table.exceptions"]
#[no_mangle]
pub static __EXCEPTIONS: [Vector; 14] = [
    // Exception 2: Non Maskable Interrupt.
    Vector {
        handler: NonMaskableInt,
    },
    // Exception 3: Hard Fault Interrupt.
    Vector {
        handler: default::hardfault_trampoline,
    },
    // Exception 4: Memory Management Interrupt [not on Cortex-M0 variants].
    #[cfg(not(armv6m))]
    Vector {
        handler: MemoryManagement,
    },
    #[cfg(armv6m)]
    Vector { reserved: 0 },
    // Exception 5: Bus Fault Interrupt [not on Cortex-M0 variants].
    #[cfg(not(armv6m))]
    Vector { handler: BusFault },
    #[cfg(armv6m)]
    Vector { reserved: 0 },
    // Exception 6: Usage Fault Interrupt [not on Cortex-M0 variants].
    #[cfg(not(armv6m))]
    Vector {
        handler: UsageFault,
    },
    #[cfg(armv6m)]
    Vector { reserved: 0 },
    // Exception 7: Secure Fault Interrupt [only on Armv8-M].
    #[cfg(armv8m)]
    Vector {
        handler: SecureFault,
    },
    #[cfg(not(armv8m))]
    Vector { reserved: 0 },
    // 8-10: Reserved
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    // Exception 11: SV Call Interrupt.
    Vector { handler: SVCall },
    // Exception 12: Debug Monitor Interrupt [not on Cortex-M0 variants].
    #[cfg(not(armv6m))]
    Vector {
        handler: DebugMonitor,
    },
    #[cfg(armv6m)]
    Vector { reserved: 0 },
    // 13: Reserved
    Vector { reserved: 0 },
    // Exception 14: Pend SV Interrupt [not on Cortex-M0 variants].
    Vector { handler: PendSV },
    // Exception 15: System Tick Interrupt.
    Vector { handler: SysTick },
];

extern "C" {
    fn NonMaskableInt();

    #[cfg(not(armv6m))]
    fn MemoryManagement();

    #[cfg(not(armv6m))]
    fn BusFault();

    #[cfg(not(armv6m))]
    fn UsageFault();

    #[cfg(armv8m)]
    fn SecureFault();

    fn SVCall();

    #[cfg(not(armv6m))]
    fn DebugMonitor();

    fn PendSV();

    fn SysTick();
}

extern "C" {
    fn WWDG();
    fn PVD();
    fn TAMP_STAMP();
    fn RTC_WKUP();
    fn RCC();
    fn EXTI0();
    fn EXTI1();
    fn EXTI2();
    fn EXTI3();
    fn EXTI4();
    fn DMA1_STREAM0();
    fn DMA1_STREAM1();
    fn DMA1_STREAM2();
    fn DMA1_STREAM3();
    fn DMA1_STREAM4();
    fn DMA1_STREAM5();
    fn DMA1_STREAM6();
    fn ADC();
    fn CAN1_TX();
    fn CAN1_RX0();
    fn CAN1_RX1();
    fn CAN1_SCE();
    fn EXTI9_5();
    fn TIM1_BRK_TIM9();
    fn TIM1_UP_TIM10();
    fn TIM1_TRG_COM_TIM11();
    fn TIM1_CC();
    fn TIM2();
    fn TIM3();
    fn TIM4();
    fn I2C1_EV();
    fn I2C1_ER();
    fn I2C2_EV();
    fn I2C2_ER();
    fn SPI1();
    fn SPI2();
    fn USART1();
    fn USART2();
    fn USART3();
    fn EXTI15_10();
    fn RTC_ALARM();
    fn OTG_FS_WKUP();
    fn TIM8_BRK_TIM12();
    fn TIM8_UP_TIM13();
    fn TIM8_TRG_COM_TIM14();
    fn TIM8_CC();
    fn DMA1_STREAM7();
    fn FSMC();
    fn SDIO();
    fn TIM5();
    fn SPI3();
    fn UART4();
    fn UART5();
    fn TIM6_DAC();
    fn TIM7();
    fn DMA2_STREAM0();
    fn DMA2_STREAM1();
    fn DMA2_STREAM2();
    fn DMA2_STREAM3();
    fn DMA2_STREAM4();
    fn ETH();
    fn ETH_WKUP();
    fn CAN2_TX();
    fn CAN2_RX0();
    fn CAN2_RX1();
    fn CAN2_SCE();
    fn OTG_FS();
    fn DMA2_STREAM5();
    fn DMA2_STREAM6();
    fn DMA2_STREAM7();
    fn USART6();
    fn I2C3_EV();
    fn I2C3_ER();
    fn OTG_HS_EP1_OUT();
    fn OTG_HS_EP1_IN();
    fn OTG_HS_WKUP();
    fn OTG_HS();
    fn DCMI();
    fn CRYP();
    fn HASH_RNG();
    fn FPU();
    fn LTDC();
    fn LTDC_ER();
}

#[link_section = ".vector_table.interrupts"]
#[no_mangle]
pub static __INTERRUPTS: [Vector; 90] = [
    Vector { handler: WWDG },
    Vector { handler: PVD },
    Vector {
        handler: TAMP_STAMP,
    },
    Vector { handler: RTC_WKUP },
    Vector { reserved: 0 },
    Vector { handler: RCC },
    Vector { handler: EXTI0 },
    Vector { handler: EXTI1 },
    Vector { handler: EXTI2 },
    Vector { handler: EXTI3 },
    Vector { handler: EXTI4 },
    Vector {
        handler: DMA1_STREAM0,
    },
    Vector {
        handler: DMA1_STREAM1,
    },
    Vector {
        handler: DMA1_STREAM2,
    },
    Vector {
        handler: DMA1_STREAM3,
    },
    Vector {
        handler: DMA1_STREAM4,
    },
    Vector {
        handler: DMA1_STREAM5,
    },
    Vector {
        handler: DMA1_STREAM6,
    },
    Vector { handler: ADC },
    Vector { handler: CAN1_TX },
    Vector { handler: CAN1_RX0 },
    Vector { handler: CAN1_RX1 },
    Vector { handler: CAN1_SCE },
    Vector { handler: EXTI9_5 },
    Vector {
        handler: TIM1_BRK_TIM9,
    },
    Vector {
        handler: TIM1_UP_TIM10,
    },
    Vector {
        handler: TIM1_TRG_COM_TIM11,
    },
    Vector { handler: TIM1_CC },
    Vector { handler: TIM2 },
    Vector { handler: TIM3 },
    Vector { handler: TIM4 },
    Vector { handler: I2C1_EV },
    Vector { handler: I2C1_ER },
    Vector { handler: I2C2_EV },
    Vector { handler: I2C2_ER },
    Vector { handler: SPI1 },
    Vector { handler: SPI2 },
    Vector { handler: USART1 },
    Vector { handler: USART2 },
    Vector { handler: USART3 },
    Vector { handler: EXTI15_10 },
    Vector { handler: RTC_ALARM },
    Vector {
        handler: OTG_FS_WKUP,
    },
    Vector {
        handler: TIM8_BRK_TIM12,
    },
    Vector {
        handler: TIM8_UP_TIM13,
    },
    Vector {
        handler: TIM8_TRG_COM_TIM14,
    },
    Vector { handler: TIM8_CC },
    Vector {
        handler: DMA1_STREAM7,
    },
    Vector { handler: FSMC },
    Vector { handler: SDIO },
    Vector { handler: TIM5 },
    Vector { handler: SPI3 },
    Vector { handler: UART4 },
    Vector { handler: UART5 },
    Vector { handler: TIM6_DAC },
    Vector { handler: TIM7 },
    Vector {
        handler: DMA2_STREAM0,
    },
    Vector {
        handler: DMA2_STREAM1,
    },
    Vector {
        handler: DMA2_STREAM2,
    },
    Vector {
        handler: DMA2_STREAM3,
    },
    Vector {
        handler: DMA2_STREAM4,
    },
    Vector { handler: ETH },
    Vector { handler: ETH_WKUP },
    Vector { handler: CAN2_TX },
    Vector { handler: CAN2_RX0 },
    Vector { handler: CAN2_RX1 },
    Vector { handler: CAN2_SCE },
    Vector { handler: OTG_FS },
    Vector {
        handler: DMA2_STREAM5,
    },
    Vector {
        handler: DMA2_STREAM6,
    },
    Vector {
        handler: DMA2_STREAM7,
    },
    Vector { handler: USART6 },
    Vector { handler: I2C3_EV },
    Vector { handler: I2C3_ER },
    Vector {
        handler: OTG_HS_EP1_OUT,
    },
    Vector {
        handler: OTG_HS_EP1_IN,
    },
    Vector {
        handler: OTG_HS_WKUP,
    },
    Vector { handler: OTG_HS },
    Vector { handler: DCMI },
    Vector { handler: CRYP },
    Vector { handler: HASH_RNG },
    Vector { handler: FPU },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { handler: LTDC },
    Vector { handler: LTDC_ER },
];
