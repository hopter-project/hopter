use super::super::Vector;

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

#[link_section = ".hopter_vector_table.interrupts"]
#[no_mangle]
pub static __HOPTER_INTERRUPTS: [Vector; 90] = [
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
