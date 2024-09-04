#[cfg(feature = "stm32f413")]
use super::Vector;

#[cfg(feature = "stm32f413")]
extern "C" {
    fn PVD();
    fn TAMP_STAMP();
    fn RTC_WKUP();
    fn FLASH();
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
    fn I2C1_EVT();
    fn I2C1_ERR();
    fn I2C2_EVT();
    fn I2C2_ERR();
    fn SPI1();
    fn SPI2();
    fn USART1();
    fn USART2();
    fn USART3();
    fn EXTI15_10();
    fn EXTI17_RTC_ALARM();
    fn TIM8_BRK_TIM12();
    fn TIM8_UP_TIM13();
    fn TIM8_TRG_COM_TIM14();
    fn TIM8_CC();
    fn DMA1_STREAM7();
    fn FSMC();
    fn SDIO();
    fn TIM5();
    fn SPI3();
    fn USART4();
    fn UART5();
    fn TIM6_GLB_IT_DAC1_DAC2();
    fn TIM7();
    fn DMA2_STREAM0();
    fn DMA2_STREAM1();
    fn DMA2_STREAM2();
    fn DMA2_STREAM3();
    fn DMA2_STREAM4();
    fn DFSDM1_FLT0();
    fn DFSDM1_FLT1();
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
    fn CAN3_TX();
    fn CAN3_RX0();
    fn CAN3_RX1();
    fn CAN3_SCE();
    fn CRYPTO();
    fn RNG();
    fn FPU();
    fn USART7();
    fn USART8();
    fn SPI4();
    fn SPI5();
    fn SAI1();
    fn UART9();
    fn UART10();
    fn QUADSPI();
    fn I2CFMP1EVENT();
    fn I2CFMP1ERROR();
    fn LPTIM1_OR_IT_EIT_23();
    fn DFSDM2_FILTER1();
    fn DFSDM2_FILTER2();
    fn DFSDM2_FILTER3();
    fn DFSDM2_FILTER4();
}

#[cfg(feature = "stm32f413")]
#[link_section = ".hopter_vector_table.interrupts"]
#[no_mangle]
pub static __HOPTER_INTERRUPTS: [Vector; 102] = [
    Vector { reserved: 0 },
    Vector { handler: PVD },
    Vector {
        handler: TAMP_STAMP,
    },
    Vector { handler: RTC_WKUP },
    Vector { handler: FLASH },
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
    Vector { handler: I2C1_EVT },
    Vector { handler: I2C1_ERR },
    Vector { handler: I2C2_EVT },
    Vector { handler: I2C2_ERR },
    Vector { handler: SPI1 },
    Vector { handler: SPI2 },
    Vector { handler: USART1 },
    Vector { handler: USART2 },
    Vector { handler: USART3 },
    Vector { handler: EXTI15_10 },
    Vector {
        handler: EXTI17_RTC_ALARM,
    },
    Vector { reserved: 0 },
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
    Vector { handler: USART4 },
    Vector { handler: UART5 },
    Vector {
        handler: TIM6_GLB_IT_DAC1_DAC2,
    },
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
    Vector {
        handler: DFSDM1_FLT0,
    },
    Vector {
        handler: DFSDM1_FLT1,
    },
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
    Vector { handler: CAN3_TX },
    Vector { handler: CAN3_RX0 },
    Vector { handler: CAN3_RX1 },
    Vector { handler: CAN3_SCE },
    Vector { reserved: 0 },
    Vector { handler: CRYPTO },
    Vector { handler: RNG },
    Vector { handler: FPU },
    Vector { handler: USART7 },
    Vector { handler: USART8 },
    Vector { handler: SPI4 },
    Vector { handler: SPI5 },
    Vector { reserved: 0 },
    Vector { handler: SAI1 },
    Vector { handler: UART9 },
    Vector { handler: UART10 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { handler: QUADSPI },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector {
        handler: I2CFMP1EVENT,
    },
    Vector {
        handler: I2CFMP1ERROR,
    },
    Vector {
        handler: LPTIM1_OR_IT_EIT_23,
    },
    Vector {
        handler: DFSDM2_FILTER1,
    },
    Vector {
        handler: DFSDM2_FILTER2,
    },
    Vector {
        handler: DFSDM2_FILTER3,
    },
    Vector {
        handler: DFSDM2_FILTER4,
    },
];
