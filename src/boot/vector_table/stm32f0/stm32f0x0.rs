use super::super::Vector;

extern "C" {
    fn WWDG();
    fn PVD();
    fn RTC();
    fn FLASH();
    fn RCC();
    fn EXTI0_1();
    fn EXTI2_3();
    fn EXTI4_15();
    fn DMA1_CH1();
    fn DMA1_CH2_3();
    fn DMA1_CH4_5();
    fn ADC();
    fn TIM1_BRK_UP_TRG_COM();
    fn TIM1_CC();
    fn TIM3();
    fn TIM6();
    fn TIM14();
    fn TIM15();
    fn TIM16();
    fn TIM17();
    fn I2C1();
    fn I2C2();
    fn SPI1();
    fn SPI2();
    fn USART1();
    fn USART2();
    fn USART3_4_5_6();
    fn USB();
}

#[link_section = ".hopter_vector_table.interrupts"]
#[no_mangle]
pub static __HOPTER_INTERRUPTS: [Vector; 32] = [
    Vector { handler: WWDG },
    Vector { handler: PVD },
    Vector { handler: RTC },
    Vector { handler: FLASH },
    Vector { handler: RCC },
    Vector { handler: EXTI0_1 },
    Vector { handler: EXTI2_3 },
    Vector { handler: EXTI4_15 },
    Vector { reserved: 0 },
    Vector { handler: DMA1_CH1 },
    Vector {
        handler: DMA1_CH2_3,
    },
    Vector {
        handler: DMA1_CH4_5,
    },
    Vector { handler: ADC },
    Vector {
        handler: TIM1_BRK_UP_TRG_COM,
    },
    Vector { handler: TIM1_CC },
    Vector { reserved: 0 },
    Vector { handler: TIM3 },
    Vector { handler: TIM6 },
    Vector { reserved: 0 },
    Vector { handler: TIM14 },
    Vector { handler: TIM15 },
    Vector { handler: TIM16 },
    Vector { handler: TIM17 },
    Vector { handler: I2C1 },
    Vector { handler: I2C2 },
    Vector { handler: SPI1 },
    Vector { handler: SPI2 },
    Vector { handler: USART1 },
    Vector { handler: USART2 },
    Vector {
        handler: USART3_4_5_6,
    },
    Vector { reserved: 0 },
    Vector { handler: USB },
];
