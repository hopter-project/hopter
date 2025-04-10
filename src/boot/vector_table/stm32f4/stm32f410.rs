use super::super::Vector;

extern "C" {
    fn WWDG();
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
    fn EXTI9_5();
    fn TIM1_BRK_TIM9();
    fn PWM1_UP();
    fn TIM1_TRG_COM_TIM11();
    fn TIM1_CC();
    fn I2C1_EV();
    fn I2C1_ER();
    fn I2C2_EV();
    fn I2C2_ER();
    fn SPI1();
    fn SPI2();
    fn USART1();
    fn USART2();
    fn EXTI15_10();
    fn RTC_ALARM();
    fn DMA1_STREAM7();
    fn TIM5();
    fn TIM6_DAC1();
    fn DMA2_STREAM0();
    fn DMA2_STREAM1();
    fn DMA2_STREAM2();
    fn DMA2_STREAM3();
    fn DMA2_STREAM4();
    fn EXTI19();
    fn DMA2_STREAM5();
    fn DMA2_STREAM6();
    fn DMA2_STREAM7();
    fn USART6();
    fn EXTI20();
    fn RNG();
    fn FPU();
    fn SPI5();
    fn I2C4_EV();
    fn I2C4_ER();
    fn LPTIM1();
}

#[link_section = ".hopter_vector_table.interrupts"]
#[no_mangle]
pub static __HOPTER_INTERRUPTS: [Vector; 98] = [
    Vector { handler: WWDG },
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
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { handler: EXTI9_5 },
    Vector {
        handler: TIM1_BRK_TIM9,
    },
    Vector { handler: PWM1_UP },
    Vector {
        handler: TIM1_TRG_COM_TIM11,
    },
    Vector { handler: TIM1_CC },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { handler: I2C1_EV },
    Vector { handler: I2C1_ER },
    Vector { handler: I2C2_EV },
    Vector { handler: I2C2_ER },
    Vector { handler: SPI1 },
    Vector { handler: SPI2 },
    Vector { handler: USART1 },
    Vector { handler: USART2 },
    Vector { reserved: 0 },
    Vector { handler: EXTI15_10 },
    Vector { handler: RTC_ALARM },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector {
        handler: DMA1_STREAM7,
    },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { handler: TIM5 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { handler: TIM6_DAC1 },
    Vector { reserved: 0 },
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
    Vector { reserved: 0 },
    Vector { handler: EXTI19 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
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
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { handler: EXTI20 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { handler: RNG },
    Vector { handler: FPU },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { handler: SPI5 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { reserved: 0 },
    Vector { handler: I2C4_EV },
    Vector { handler: I2C4_ER },
    Vector { handler: LPTIM1 },
];
