
target/thumbv7em-none-eabihf/debug/examples/mailbox-00712b2fa143e073.o:	file format elf32-littlearm

Disassembly of section .text._ZN114_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$3new17h0656c50513ad9799E:

00000000 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f5bc 7f04    	.word	#0xf5bc7f04
      10: da02         	bge	0x18 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0084         	lsls	r4, r0, #0x2
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: f5ad 7d02    	.word	#0xf5ad7d02
      20: 9126         	str	r1, [sp, #0x98]
      22: 4601         	mov	r1, r0
      24: 9826         	ldr	r0, [sp, #0x98]
      26: 9035         	str	r0, [sp, #0xd4]
      28: 2000         	movs	r0, #0x0
      2a: f88d 00d2    	.word	#0xf88d00d2
      2e: f88d 00cf    	.word	#0xf88d00cf
      32: f88d 00d1    	.word	#0xf88d00d1
      36: f88d 00d0    	.word	#0xf88d00d0
      3a: 2001         	movs	r0, #0x1
      3c: f88d 00d2    	.word	#0xf88d00d2
      40: f88d 00d0    	.word	#0xf88d00d0
      44: f88d 00d1    	.word	#0xf88d00d1
      48: a828         	add	r0, sp, #0xa0
      4a: f7ff fffe    	bl	0x4a <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x4a> @ imm = #-0x4
      4e: e022         	b	0x96 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x96> @ imm = #0x44
      50: f89d 00d1    	.word	#0xf89d00d1
      54: 07c0         	lsls	r0, r0, #0x1f
      56: 2800         	cmp	r0, #0x0
      58: f040 8226    	.word	#0xf0408226
      5c: e21f         	b	0x49e <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x49e> @ imm = #0x43e
      5e: 9024         	str	r0, [sp, #0x90]
      60: 9125         	str	r1, [sp, #0x94]
      62: e7ff         	b	0x64 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x64> @ imm = #-0x2
      64: 9924         	ldr	r1, [sp, #0x90]
      66: 9825         	ldr	r0, [sp, #0x94]
      68: 9122         	str	r1, [sp, #0x88]
      6a: 9023         	str	r0, [sp, #0x8c]
      6c: e7ff         	b	0x6e <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x6e> @ imm = #-0x2
      6e: 9922         	ldr	r1, [sp, #0x88]
      70: 9823         	ldr	r0, [sp, #0x8c]
      72: 9120         	str	r1, [sp, #0x80]
      74: 9021         	str	r0, [sp, #0x84]
      76: e7ff         	b	0x78 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x78> @ imm = #-0x2
      78: 9920         	ldr	r1, [sp, #0x80]
      7a: 9821         	ldr	r0, [sp, #0x84]
      7c: 911e         	str	r1, [sp, #0x78]
      7e: 901f         	str	r0, [sp, #0x7c]
      80: e7ff         	b	0x82 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x82> @ imm = #-0x2
      82: 991e         	ldr	r1, [sp, #0x78]
      84: 981f         	ldr	r0, [sp, #0x7c]
      86: 911c         	str	r1, [sp, #0x70]
      88: 901d         	str	r0, [sp, #0x74]
      8a: e7ff         	b	0x8c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x8c> @ imm = #-0x2
      8c: 991c         	ldr	r1, [sp, #0x70]
      8e: 981d         	ldr	r0, [sp, #0x74]
      90: 9136         	str	r1, [sp, #0xd8]
      92: 9037         	str	r0, [sp, #0xdc]
      94: e7dc         	b	0x50 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x50> @ imm = #-0x48
      96: f7ff fffe    	bl	0x96 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x96> @ imm = #-0x4
      9a: e7ff         	b	0x9c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x9c> @ imm = #-0x2
      9c: f7ff fffe    	bl	0x9c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x9c> @ imm = #-0x4
      a0: e7ff         	b	0xa2 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xa2> @ imm = #-0x2
      a2: 9826         	ldr	r0, [sp, #0x98]
      a4: f7ff fffe    	bl	0xa4 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xa4> @ imm = #-0x4
      a8: 901b         	str	r0, [sp, #0x6c]
      aa: e7ff         	b	0xac <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xac> @ imm = #-0x2
      ac: 981b         	ldr	r0, [sp, #0x6c]
      ae: 902a         	str	r0, [sp, #0xa8]
      b0: a82a         	add	r0, sp, #0xa8
      b2: f7ff fffe    	bl	0xb2 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xb2> @ imm = #-0x4
      b6: 901a         	str	r0, [sp, #0x68]
      b8: e7ff         	b	0xba <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xba> @ imm = #-0x2
      ba: 981a         	ldr	r0, [sp, #0x68]
      bc: 9038         	str	r0, [sp, #0xe0]
      be: 9828         	ldr	r0, [sp, #0xa0]
      c0: 9019         	str	r0, [sp, #0x64]
      c2: 9039         	str	r0, [sp, #0xe4]
      c4: e7ff         	b	0xc6 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xc6> @ imm = #-0x2
      c6: 9819         	ldr	r0, [sp, #0x64]
      c8: 991a         	ldr	r1, [sp, #0x68]
      ca: ebb0 1f11    	.word	#0xebb01f11
      ce: d901         	bls	0xd4 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xd4> @ imm = #0x2
      d0: e7ff         	b	0xd2 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xd2> @ imm = #-0x2
      d2: e000         	b	0xd6 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xd6> @ imm = #0x0
      d4: e06c         	b	0x1b0 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x1b0> @ imm = #0xd8
      d6: 9819         	ldr	r0, [sp, #0x64]
      d8: 991a         	ldr	r1, [sp, #0x68]
      da: ebb0 0fd1    	.word	#0xebb00fd1
      de: d904         	bls	0xea <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xea> @ imm = #0x8
      e0: e7ff         	b	0xe2 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xe2> @ imm = #-0x2
      e2: 2003         	movs	r0, #0x3
      e4: f88d 009e    	.word	#0xf88d009e
      e8: e006         	b	0xf8 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xf8> @ imm = #0xc
      ea: 991a         	ldr	r1, [sp, #0x68]
      ec: 1848         	adds	r0, r1, r1
      ee: 4602         	mov	r2, r0
      f0: 9218         	str	r2, [sp, #0x60]
      f2: 4288         	cmp	r0, r1
      f4: d309         	blo	0x10a <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x10a> @ imm = #0x12
      f6: e007         	b	0x108 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x108> @ imm = #0xe
      f8: e7ff         	b	0xfa <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xfa> @ imm = #-0x2
      fa: f89d 009e    	.word	#0xf89d009e
      fe: f89d 109f    	.word	#0xf89d109f
     102: f50d 7d02    	.word	#0xf50d7d02
     106: bd80         	pop	{r7, pc}
     108: e00c         	b	0x124 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x124> @ imm = #0x18
     10a: f240 0000    	.word	#0xf2400000
     10e: f2c0 0000    	.word	#0xf2c00000
     112: f240 0200    	.word	#0xf2400200
     116: f2c0 0200    	.word	#0xf2c00200
     11a: 2121         	movs	r1, #0x21
     11c: f7ff fffe    	bl	0x11c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x11c> @ imm = #-0x4
     120: e7ff         	b	0x122 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x122> @ imm = #-0x2
     122: defe         	trap
     124: 9918         	ldr	r1, [sp, #0x60]
     126: 9819         	ldr	r0, [sp, #0x64]
     128: eb01 0050    	.word	#0xeb010050
     12c: 4602         	mov	r2, r0
     12e: 9217         	str	r2, [sp, #0x5c]
     130: 4288         	cmp	r0, r1
     132: d303         	blo	0x13c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x13c> @ imm = #0x6
     134: e7ff         	b	0x136 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x136> @ imm = #-0x2
     136: 9819         	ldr	r0, [sp, #0x64]
     138: b1d0         	cbz	r0, 0x170 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x170> @ imm = #0x34
     13a: e00b         	b	0x154 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x154> @ imm = #0x16
     13c: f240 0000    	.word	#0xf2400000
     140: f2c0 0000    	.word	#0xf2c00000
     144: f240 0200    	.word	#0xf2400200
     148: f2c0 0200    	.word	#0xf2c00200
     14c: 211c         	movs	r1, #0x1c
     14e: f7ff fffe    	bl	0x14e <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x14e> @ imm = #-0x4
     152: e7e6         	b	0x122 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x122> @ imm = #-0x34
     154: 9817         	ldr	r0, [sp, #0x5c]
     156: 9919         	ldr	r1, [sp, #0x64]
     158: fbb0 f0f1    	.word	#0xfbb0f0f1
     15c: 903a         	str	r0, [sp, #0xe8]
     15e: f000 010f    	.word	#0xf000010f
     162: 460a         	mov	r2, r1
     164: 9215         	str	r2, [sp, #0x54]
     166: 913b         	str	r1, [sp, #0xec]
     168: f020 000f    	.word	#0xf020000f
     16c: 9016         	str	r0, [sp, #0x58]
     16e: e00b         	b	0x188 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x188> @ imm = #0x16
     170: f240 0000    	.word	#0xf2400000
     174: f2c0 0000    	.word	#0xf2c00000
     178: f240 0200    	.word	#0xf2400200
     17c: f2c0 0200    	.word	#0xf2c00200
     180: 2119         	movs	r1, #0x19
     182: f7ff fffe    	bl	0x182 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x182> @ imm = #-0x4
     186: e7cc         	b	0x122 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x122> @ imm = #-0x68
     188: 9816         	ldr	r0, [sp, #0x58]
     18a: 9915         	ldr	r1, [sp, #0x54]
     18c: ea40 0051    	.word	#0xea400051
     190: 903c         	str	r0, [sp, #0xf0]
     192: 2101         	movs	r1, #0x1
     194: f88d 10b4    	.word	#0xf88d10b4
     198: 902e         	str	r0, [sp, #0xb8]
     19a: e7ff         	b	0x19c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x19c> @ imm = #-0x2
     19c: f89d 00b4    	.word	#0xf89d00b4
     1a0: f88d 00af    	.word	#0xf88d00af
     1a4: 982e         	ldr	r0, [sp, #0xb8]
     1a6: 902c         	str	r0, [sp, #0xb0]
     1a8: f7ff fffe    	bl	0x1a8 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x1a8> @ imm = #-0x4
     1ac: 9014         	str	r0, [sp, #0x50]
     1ae: e02d         	b	0x20c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x20c> @ imm = #0x5a
     1b0: 991a         	ldr	r1, [sp, #0x68]
     1b2: 9819         	ldr	r0, [sp, #0x64]
     1b4: eb01 0050    	.word	#0xeb010050
     1b8: 4602         	mov	r2, r0
     1ba: 9213         	str	r2, [sp, #0x4c]
     1bc: 4288         	cmp	r0, r1
     1be: d303         	blo	0x1c8 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x1c8> @ imm = #0x6
     1c0: e7ff         	b	0x1c2 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x1c2> @ imm = #-0x2
     1c2: 9819         	ldr	r0, [sp, #0x64]
     1c4: b1b0         	cbz	r0, 0x1f4 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x1f4> @ imm = #0x2c
     1c6: e00b         	b	0x1e0 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x1e0> @ imm = #0x16
     1c8: f240 0000    	.word	#0xf2400000
     1cc: f2c0 0000    	.word	#0xf2c00000
     1d0: f240 0200    	.word	#0xf2400200
     1d4: f2c0 0200    	.word	#0xf2c00200
     1d8: 211c         	movs	r1, #0x1c
     1da: f7ff fffe    	bl	0x1da <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x1da> @ imm = #-0x4
     1de: e7a0         	b	0x122 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x122> @ imm = #-0xc0
     1e0: 9813         	ldr	r0, [sp, #0x4c]
     1e2: 9919         	ldr	r1, [sp, #0x64]
     1e4: fbb0 f0f1    	.word	#0xfbb0f0f1
     1e8: 903d         	str	r0, [sp, #0xf4]
     1ea: 2100         	movs	r1, #0x0
     1ec: f88d 10b4    	.word	#0xf88d10b4
     1f0: 902e         	str	r0, [sp, #0xb8]
     1f2: e7d3         	b	0x19c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x19c> @ imm = #-0x5a
     1f4: f240 0000    	.word	#0xf2400000
     1f8: f2c0 0000    	.word	#0xf2c00000
     1fc: f240 0200    	.word	#0xf2400200
     200: f2c0 0200    	.word	#0xf2c00200
     204: 2119         	movs	r1, #0x19
     206: f7ff fffe    	bl	0x206 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x206> @ imm = #-0x4
     20a: e78a         	b	0x122 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x122> @ imm = #-0xec
     20c: 9814         	ldr	r0, [sp, #0x50]
     20e: 903e         	str	r0, [sp, #0xf8]
     210: f100 0108    	.word	#0xf1000108
     214: 4608         	mov	r0, r1
     216: 9011         	str	r0, [sp, #0x44]
     218: a82c         	add	r0, sp, #0xb0
     21a: 902f         	str	r0, [sp, #0xbc]
     21c: 982f         	ldr	r0, [sp, #0xbc]
     21e: 9012         	str	r0, [sp, #0x48]
     220: 914a         	str	r1, [sp, #0x128]
     222: 904b         	str	r0, [sp, #0x12c]
     224: e7ff         	b	0x226 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x226> @ imm = #-0x2
     226: 9812         	ldr	r0, [sp, #0x48]
     228: 2100         	movs	r1, #0x0
     22a: 9149         	str	r1, [sp, #0x124]
     22c: 9949         	ldr	r1, [sp, #0x124]
     22e: 914f         	str	r1, [sp, #0x13c]
     230: 914e         	str	r1, [sp, #0x138]
     232: 994e         	ldr	r1, [sp, #0x138]
     234: 9148         	str	r1, [sp, #0x120]
     236: a948         	add	r1, sp, #0x120
     238: 9147         	str	r1, [sp, #0x11c]
     23a: 9947         	ldr	r1, [sp, #0x11c]
     23c: f7ff fffe    	bl	0x23c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x23c> @ imm = #-0x4
     240: 9010         	str	r0, [sp, #0x40]
     242: e002         	b	0x24a <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x24a> @ imm = #0x4
     244: 904c         	str	r0, [sp, #0x130]
     246: 914d         	str	r1, [sp, #0x134]
     248: e008         	b	0x25c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x25c> @ imm = #0x10
     24a: 9811         	ldr	r0, [sp, #0x44]
     24c: 9910         	ldr	r1, [sp, #0x40]
     24e: 6809         	ldr	r1, [r1]
     250: 9050         	str	r0, [sp, #0x140]
     252: 9151         	str	r1, [sp, #0x144]
     254: 9052         	str	r0, [sp, #0x148]
     256: f7ff fffe    	bl	0x256 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x256> @ imm = #-0x4
     25a: e004         	b	0x266 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x266> @ imm = #0x8
     25c: 994c         	ldr	r1, [sp, #0x130]
     25e: 984d         	ldr	r0, [sp, #0x134]
     260: 911c         	str	r1, [sp, #0x70]
     262: 901d         	str	r0, [sp, #0x74]
     264: e712         	b	0x8c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x8c> @ imm = #-0x1dc
     266: e7ff         	b	0x268 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x268> @ imm = #-0x2
     268: 9814         	ldr	r0, [sp, #0x50]
     26a: 3010         	adds	r0, #0x10
     26c: 4601         	mov	r1, r0
     26e: 910f         	str	r1, [sp, #0x3c]
     270: 9043         	str	r0, [sp, #0x10c]
     272: e7ff         	b	0x274 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x274> @ imm = #-0x2
     274: 980f         	ldr	r0, [sp, #0x3c]
     276: 9044         	str	r0, [sp, #0x110]
     278: 2100         	movs	r1, #0x0
     27a: 9145         	str	r1, [sp, #0x114]
     27c: 9046         	str	r0, [sp, #0x118]
     27e: f7ff fffe    	bl	0x27e <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x27e> @ imm = #-0x4
     282: e7ff         	b	0x284 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x284> @ imm = #-0x2
     284: e7ff         	b	0x286 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x286> @ imm = #-0x2
     286: 9814         	ldr	r0, [sp, #0x50]
     288: 3014         	adds	r0, #0x14
     28a: 4601         	mov	r1, r0
     28c: 910e         	str	r1, [sp, #0x38]
     28e: 903f         	str	r0, [sp, #0xfc]
     290: e7ff         	b	0x292 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x292> @ imm = #-0x2
     292: 980e         	ldr	r0, [sp, #0x38]
     294: 9040         	str	r0, [sp, #0x100]
     296: 2100         	movs	r1, #0x0
     298: 9141         	str	r1, [sp, #0x104]
     29a: 9042         	str	r0, [sp, #0x108]
     29c: f7ff fffe    	bl	0x29c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x29c> @ imm = #-0x4
     2a0: e7ff         	b	0x2a2 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x2a2> @ imm = #-0x2
     2a2: e7ff         	b	0x2a4 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x2a4> @ imm = #-0x2
     2a4: 9814         	ldr	r0, [sp, #0x50]
     2a6: 300c         	adds	r0, #0xc
     2a8: 4601         	mov	r1, r0
     2aa: 910d         	str	r1, [sp, #0x34]
     2ac: a928         	add	r1, sp, #0xa0
     2ae: 1dca         	adds	r2, r1, #0x7
     2b0: 3106         	adds	r1, #0x6
     2b2: f10d 03af    	.word	#0xf10d03af
     2b6: 9330         	str	r3, [sp, #0xc0]
     2b8: 9231         	str	r2, [sp, #0xc4]
     2ba: 9132         	str	r1, [sp, #0xc8]
     2bc: 9059         	str	r0, [sp, #0x164]
     2be: 9830         	ldr	r0, [sp, #0xc0]
     2c0: 9931         	ldr	r1, [sp, #0xc4]
     2c2: 9a32         	ldr	r2, [sp, #0xc8]
     2c4: 9255         	str	r2, [sp, #0x154]
     2c6: 9154         	str	r1, [sp, #0x150]
     2c8: 9053         	str	r0, [sp, #0x14c]
     2ca: e7ff         	b	0x2cc <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x2cc> @ imm = #-0x2
     2cc: 2000         	movs	r0, #0x0
     2ce: 9058         	str	r0, [sp, #0x160]
     2d0: 9858         	ldr	r0, [sp, #0x160]
     2d2: 905d         	str	r0, [sp, #0x174]
     2d4: 905c         	str	r0, [sp, #0x170]
     2d6: 985c         	ldr	r0, [sp, #0x170]
     2d8: 9057         	str	r0, [sp, #0x15c]
     2da: a857         	add	r0, sp, #0x15c
     2dc: 9056         	str	r0, [sp, #0x158]
     2de: 9956         	ldr	r1, [sp, #0x158]
     2e0: a853         	add	r0, sp, #0x14c
     2e2: f7ff fffe    	bl	0x2e2 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x2e2> @ imm = #-0x4
     2e6: 900c         	str	r0, [sp, #0x30]
     2e8: e002         	b	0x2f0 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x2f0> @ imm = #0x4
     2ea: 905a         	str	r0, [sp, #0x168]
     2ec: 915b         	str	r1, [sp, #0x16c]
     2ee: e008         	b	0x302 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x302> @ imm = #0x10
     2f0: 980d         	ldr	r0, [sp, #0x34]
     2f2: 990c         	ldr	r1, [sp, #0x30]
     2f4: 6809         	ldr	r1, [r1]
     2f6: 905e         	str	r0, [sp, #0x178]
     2f8: 915f         	str	r1, [sp, #0x17c]
     2fa: 9060         	str	r0, [sp, #0x180]
     2fc: f7ff fffe    	bl	0x2fc <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x2fc> @ imm = #-0x4
     300: e004         	b	0x30c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x30c> @ imm = #0x8
     302: 995a         	ldr	r1, [sp, #0x168]
     304: 985b         	ldr	r0, [sp, #0x16c]
     306: 911e         	str	r1, [sp, #0x78]
     308: 901f         	str	r0, [sp, #0x7c]
     30a: e6ba         	b	0x82 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x82> @ imm = #-0x28c
     30c: e7ff         	b	0x30e <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x30e> @ imm = #-0x2
     30e: f89d 00a5    	.word	#0xf89d00a5
     312: 900b         	str	r0, [sp, #0x2c]
     314: 990b         	ldr	r1, [sp, #0x2c]
     316: e8df f001    	.word	#0xe8dff001

0000031a <$d.1>:
     31a: 03 0f 35 5b  	.word	0x5b350f03

0000031e <$t.2>:
     31e: defe         	trap
     320: 2000         	movs	r0, #0x0
     322: f88d 00d2    	.word	#0xf88d00d2
     326: 2101         	movs	r1, #0x1
     328: f88d 10cf    	.word	#0xf88d10cf
     32c: f88d 00d1    	.word	#0xf88d00d1
     330: f7ff fffe    	bl	0x330 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x330> @ imm = #-0x4
     334: 900a         	str	r0, [sp, #0x28]
     336: e07c         	b	0x432 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x432> @ imm = #0xf8
     338: 9814         	ldr	r0, [sp, #0x50]
     33a: 3014         	adds	r0, #0x14
     33c: 4601         	mov	r1, r0
     33e: 9109         	str	r1, [sp, #0x24]
     340: 906f         	str	r0, [sp, #0x1bc]
     342: e7ff         	b	0x344 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x344> @ imm = #-0x2
     344: 2000         	movs	r0, #0x0
     346: 906e         	str	r0, [sp, #0x1b8]
     348: 986e         	ldr	r0, [sp, #0x1b8]
     34a: 9073         	str	r0, [sp, #0x1cc]
     34c: 9072         	str	r0, [sp, #0x1c8]
     34e: 9872         	ldr	r0, [sp, #0x1c8]
     350: 906d         	str	r0, [sp, #0x1b4]
     352: a86d         	add	r0, sp, #0x1b4
     354: 906c         	str	r0, [sp, #0x1b0]
     356: 986c         	ldr	r0, [sp, #0x1b0]
     358: f7ff fffe    	bl	0x358 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x358> @ imm = #-0x4
     35c: 9008         	str	r0, [sp, #0x20]
     35e: e002         	b	0x366 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x366> @ imm = #0x4
     360: 9070         	str	r0, [sp, #0x1c0]
     362: 9171         	str	r1, [sp, #0x1c4]
     364: e008         	b	0x378 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x378> @ imm = #0x10
     366: 9809         	ldr	r0, [sp, #0x24]
     368: 9908         	ldr	r1, [sp, #0x20]
     36a: 6809         	ldr	r1, [r1]
     36c: 9074         	str	r0, [sp, #0x1d0]
     36e: 9175         	str	r1, [sp, #0x1d4]
     370: 9076         	str	r0, [sp, #0x1d8]
     372: f7ff fffe    	bl	0x372 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x372> @ imm = #-0x4
     376: e004         	b	0x382 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x382> @ imm = #0x8
     378: 9970         	ldr	r1, [sp, #0x1c0]
     37a: 9871         	ldr	r0, [sp, #0x1c4]
     37c: 9122         	str	r1, [sp, #0x88]
     37e: 9023         	str	r0, [sp, #0x8c]
     380: e675         	b	0x6e <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x6e> @ imm = #-0x316
     382: e04b         	b	0x41c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x41c> @ imm = #0x96
     384: 9814         	ldr	r0, [sp, #0x50]
     386: 3014         	adds	r0, #0x14
     388: 4601         	mov	r1, r0
     38a: 9107         	str	r1, [sp, #0x1c]
     38c: 9064         	str	r0, [sp, #0x190]
     38e: e7ff         	b	0x390 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x390> @ imm = #-0x2
     390: 2000         	movs	r0, #0x0
     392: 9063         	str	r0, [sp, #0x18c]
     394: 9863         	ldr	r0, [sp, #0x18c]
     396: 9068         	str	r0, [sp, #0x1a0]
     398: 9067         	str	r0, [sp, #0x19c]
     39a: 9867         	ldr	r0, [sp, #0x19c]
     39c: 9062         	str	r0, [sp, #0x188]
     39e: a862         	add	r0, sp, #0x188
     3a0: 9061         	str	r0, [sp, #0x184]
     3a2: 9861         	ldr	r0, [sp, #0x184]
     3a4: f7ff fffe    	bl	0x3a4 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x3a4> @ imm = #-0x4
     3a8: 9006         	str	r0, [sp, #0x18]
     3aa: e002         	b	0x3b2 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x3b2> @ imm = #0x4
     3ac: 9065         	str	r0, [sp, #0x194]
     3ae: 9166         	str	r1, [sp, #0x198]
     3b0: e008         	b	0x3c4 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x3c4> @ imm = #0x10
     3b2: 9807         	ldr	r0, [sp, #0x1c]
     3b4: 9906         	ldr	r1, [sp, #0x18]
     3b6: 6809         	ldr	r1, [r1]
     3b8: 9069         	str	r0, [sp, #0x1a4]
     3ba: 916a         	str	r1, [sp, #0x1a8]
     3bc: 906b         	str	r0, [sp, #0x1ac]
     3be: f7ff fffe    	bl	0x3be <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x3be> @ imm = #-0x4
     3c2: e004         	b	0x3ce <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x3ce> @ imm = #0x8
     3c4: 9965         	ldr	r1, [sp, #0x194]
     3c6: 9866         	ldr	r0, [sp, #0x198]
     3c8: 9120         	str	r1, [sp, #0x80]
     3ca: 9021         	str	r0, [sp, #0x84]
     3cc: e654         	b	0x78 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x78> @ imm = #-0x358
     3ce: e026         	b	0x41e <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x41e> @ imm = #0x4c
     3d0: 9814         	ldr	r0, [sp, #0x50]
     3d2: 3014         	adds	r0, #0x14
     3d4: 4601         	mov	r1, r0
     3d6: 9105         	str	r1, [sp, #0x14]
     3d8: 907a         	str	r0, [sp, #0x1e8]
     3da: e7ff         	b	0x3dc <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x3dc> @ imm = #-0x2
     3dc: 2000         	movs	r0, #0x0
     3de: 9079         	str	r0, [sp, #0x1e4]
     3e0: 9879         	ldr	r0, [sp, #0x1e4]
     3e2: 907e         	str	r0, [sp, #0x1f8]
     3e4: 907d         	str	r0, [sp, #0x1f4]
     3e6: 987d         	ldr	r0, [sp, #0x1f4]
     3e8: 9078         	str	r0, [sp, #0x1e0]
     3ea: a878         	add	r0, sp, #0x1e0
     3ec: 9077         	str	r0, [sp, #0x1dc]
     3ee: 9877         	ldr	r0, [sp, #0x1dc]
     3f0: f7ff fffe    	bl	0x3f0 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x3f0> @ imm = #-0x4
     3f4: 9004         	str	r0, [sp, #0x10]
     3f6: e002         	b	0x3fe <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x3fe> @ imm = #0x4
     3f8: 907b         	str	r0, [sp, #0x1ec]
     3fa: 917c         	str	r1, [sp, #0x1f0]
     3fc: e008         	b	0x410 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x410> @ imm = #0x10
     3fe: 9805         	ldr	r0, [sp, #0x14]
     400: 9904         	ldr	r1, [sp, #0x10]
     402: 6809         	ldr	r1, [r1]
     404: 907f         	str	r0, [sp, #0x1fc]
     406: 9180         	str	r1, [sp, #0x200]
     408: 9081         	str	r0, [sp, #0x204]
     40a: f7ff fffe    	bl	0x40a <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x40a> @ imm = #-0x4
     40e: e004         	b	0x41a <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x41a> @ imm = #0x8
     410: 997b         	ldr	r1, [sp, #0x1ec]
     412: 987c         	ldr	r0, [sp, #0x1f0]
     414: 9124         	str	r1, [sp, #0x90]
     416: 9025         	str	r0, [sp, #0x94]
     418: e624         	b	0x64 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x64> @ imm = #-0x3b8
     41a: e001         	b	0x420 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x420> @ imm = #0x2
     41c: e780         	b	0x320 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x320> @ imm = #-0x100
     41e: e77f         	b	0x320 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x320> @ imm = #-0x102
     420: e77e         	b	0x320 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x320> @ imm = #-0x104
     422: f89d 00cf    	.word	#0xf89d00cf
     426: 07c0         	lsls	r0, r0, #0x1f
     428: bbc0         	cbnz	r0, 0x49c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x49c> @ imm = #0x70
     42a: e611         	b	0x50 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x50> @ imm = #-0x3de
     42c: 9036         	str	r0, [sp, #0xd8]
     42e: 9137         	str	r1, [sp, #0xdc]
     430: e7f7         	b	0x422 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x422> @ imm = #-0x12
     432: 980a         	ldr	r0, [sp, #0x28]
     434: 2100         	movs	r1, #0x0
     436: f88d 10cf    	.word	#0xf88d10cf
     43a: f7ff fffe    	bl	0x43a <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x43a> @ imm = #-0x4
     43e: 9003         	str	r0, [sp, #0xc]
     440: e7ff         	b	0x442 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x442> @ imm = #-0x2
     442: 2000         	movs	r0, #0x0
     444: f88d 00cf    	.word	#0xf88d00cf
     448: f88d 00d0    	.word	#0xf88d00d0
     44c: f7ff fffe    	bl	0x44c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x44c> @ imm = #-0x4
     450: 9002         	str	r0, [sp, #0x8]
     452: e003         	b	0x45c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x45c> @ imm = #0x6
     454: e5fc         	b	0x50 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x50> @ imm = #-0x408
     456: 9036         	str	r0, [sp, #0xd8]
     458: 9137         	str	r1, [sp, #0xdc]
     45a: e7fb         	b	0x454 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x454> @ imm = #-0xa
     45c: 9802         	ldr	r0, [sp, #0x8]
     45e: f7ff fffe    	bl	0x45e <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x45e> @ imm = #-0x4
     462: 9001         	str	r0, [sp, #0x4]
     464: e7ff         	b	0x466 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x466> @ imm = #-0x2
     466: 9901         	ldr	r1, [sp, #0x4]
     468: 9803         	ldr	r0, [sp, #0xc]
     46a: f88d 00cd    	.word	#0xf88d00cd
     46e: f10d 00cd    	.word	#0xf10d00cd
     472: 3001         	adds	r0, #0x1
     474: f88d 10ce    	.word	#0xf88d10ce
     478: f89d 10a4    	.word	#0xf89d10a4
     47c: f7ff fffe    	bl	0x47c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x47c> @ imm = #-0x4
     480: e003         	b	0x48a <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x48a> @ imm = #0x6
     482: e5e5         	b	0x50 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x50> @ imm = #-0x436
     484: 9036         	str	r0, [sp, #0xd8]
     486: 9137         	str	r1, [sp, #0xdc]
     488: e7fb         	b	0x482 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x482> @ imm = #-0xa
     48a: f89d 10cd    	.word	#0xf89d10cd
     48e: f89d 00ce    	.word	#0xf89d00ce
     492: f88d 109e    	.word	#0xf88d109e
     496: f88d 009f    	.word	#0xf88d009f
     49a: e62e         	b	0xfa <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0xfa> @ imm = #-0x3a4
     49c: e5d8         	b	0x50 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x50> @ imm = #-0x450
     49e: f89d 00d0    	.word	#0xf89d00d0
     4a2: 07c0         	lsls	r0, r0, #0x1f
     4a4: b930         	cbnz	r0, 0x4b4 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x4b4> @ imm = #0xc
     4a6: e000         	b	0x4aa <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x4aa> @ imm = #0x0
     4a8: e7f9         	b	0x49e <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x49e> @ imm = #-0xe
     4aa: f89d 00d2    	.word	#0xf89d00d2
     4ae: 07c0         	lsls	r0, r0, #0x1f
     4b0: b928         	cbnz	r0, 0x4be <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x4be> @ imm = #0xa
     4b2: e000         	b	0x4b6 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x4b6> @ imm = #0x0
     4b4: e7f9         	b	0x4aa <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x4aa> @ imm = #-0xe
     4b6: 9836         	ldr	r0, [sp, #0xd8]
     4b8: f7ff fffe    	bl	0x4b8 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x4b8> @ imm = #-0x4
     4bc: defe         	trap
     4be: e7fa         	b	0x4b6 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::h0656c50513ad9799+0x4b6> @ imm = #-0xc

Disassembly of section .text._ZN114_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$3new28_$u7b$$u7b$closure$u7d$$u7d$17h21fb28ab7c5d2c86E:

00000000 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h21fb28ab7c5d2c86>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0ff8    	.word	#0xf1bc0ff8
      10: da02         	bge	0x18 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h21fb28ab7c5d2c86+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 003e         	movs	r6, r7
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b0bc         	sub	sp, #0xf0
      1e: 9103         	str	r1, [sp, #0xc]
      20: 9004         	str	r0, [sp, #0x10]
      22: 9106         	str	r1, [sp, #0x18]
      24: 912b         	str	r1, [sp, #0xac]
      26: 912d         	str	r1, [sp, #0xb4]
      28: 912c         	str	r1, [sp, #0xb0]
      2a: 9a2c         	ldr	r2, [sp, #0xb0]
      2c: 921b         	str	r2, [sp, #0x6c]
      2e: 921c         	str	r2, [sp, #0x70]
      30: 2301         	movs	r3, #0x1
      32: f807 3c7a    	.word	#0xf8073c7a
      36: 9a1c         	ldr	r2, [sp, #0x70]
      38: 921e         	str	r2, [sp, #0x78]
      3a: 6812         	ldr	r2, [r2]
      3c: f807 3c79    	.word	#0xf8073c79
      40: f8dd c070    	.word	#0xf8ddc070
      44: f8cd c0d0    	.word	#0xf8cdc0d0
      48: f442 5200    	.word	#0xf4425200
      4c: f8cc 2000    	.word	#0xf8cc2000
      50: 9131         	str	r1, [sp, #0xc4]
      52: 9133         	str	r1, [sp, #0xcc]
      54: 9132         	str	r1, [sp, #0xc8]
      56: 9a32         	ldr	r2, [sp, #0xc8]
      58: f8d0 c000    	.word	#0xf8d0c000
      5c: f89c e000    	.word	#0xf89ce000
      60: 920a         	str	r2, [sp, #0x28]
      62: f807 ecc2    	.word	#0xf807ecc2
      66: 9a0a         	ldr	r2, [sp, #0x28]
      68: 920c         	str	r2, [sp, #0x30]
      6a: 6812         	ldr	r2, [r2]
      6c: f422 4200    	.word	#0xf4224200
      70: f807 ecc1    	.word	#0xf807ecc1
      74: f8dd c028    	.word	#0xf8ddc028
      78: f8cd c0e4    	.word	#0xf8cdc0e4
      7c: ea42 32ce    	.word	#0xea4232ce
      80: f8cc 2000    	.word	#0xf8cc2000
      84: 9128         	str	r1, [sp, #0xa0]
      86: 912a         	str	r1, [sp, #0xa8]
      88: 9129         	str	r1, [sp, #0xa4]
      8a: 9a29         	ldr	r2, [sp, #0xa4]
      8c: 9213         	str	r2, [sp, #0x4c]
      8e: 9214         	str	r2, [sp, #0x50]
      90: f807 3c9a    	.word	#0xf8073c9a
      94: 9a14         	ldr	r2, [sp, #0x50]
      96: 9216         	str	r2, [sp, #0x58]
      98: 6812         	ldr	r2, [r2]
      9a: f807 3c99    	.word	#0xf8073c99
      9e: f8dd c050    	.word	#0xf8ddc050
      a2: f8cd c0d8    	.word	#0xf8cdc0d8
      a6: f042 0208    	.word	#0xf0420208
      aa: f8cc 2000    	.word	#0xf8cc2000
      ae: 9125         	str	r1, [sp, #0x94]
      b0: 9127         	str	r1, [sp, #0x9c]
      b2: 9126         	str	r1, [sp, #0x98]
      b4: 9a26         	ldr	r2, [sp, #0x98]
      b6: 9217         	str	r2, [sp, #0x5c]
      b8: 9218         	str	r2, [sp, #0x60]
      ba: f807 3c8a    	.word	#0xf8073c8a
      be: 9a18         	ldr	r2, [sp, #0x60]
      c0: 921a         	str	r2, [sp, #0x68]
      c2: 6812         	ldr	r2, [r2]
      c4: f807 3c89    	.word	#0xf8073c89
      c8: 9b18         	ldr	r3, [sp, #0x60]
      ca: 9335         	str	r3, [sp, #0xd4]
      cc: f042 0204    	.word	#0xf0420204
      d0: 601a         	str	r2, [r3]
      d2: 911f         	str	r1, [sp, #0x7c]
      d4: 9121         	str	r1, [sp, #0x84]
      d6: 9120         	str	r1, [sp, #0x80]
      d8: 9920         	ldr	r1, [sp, #0x80]
      da: 9101         	str	r1, [sp, #0x4]
      dc: 6840         	ldr	r0, [r0, #0x4]
      de: f240 0100    	.word	#0xf2400100
      e2: f2c0 0100    	.word	#0xf2c00100
      e6: f7ff fffe    	bl	0xe6 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h21fb28ab7c5d2c86+0xe6> @ imm = #-0x4
      ea: 9a01         	ldr	r2, [sp, #0x4]
      ec: 9903         	ldr	r1, [sp, #0xc]
      ee: 4684         	mov	r12, r0
      f0: 9804         	ldr	r0, [sp, #0x10]
      f2: 9207         	str	r2, [sp, #0x1c]
      f4: f807 ccce    	.word	#0xf807ccce
      f8: 9a07         	ldr	r2, [sp, #0x1c]
      fa: 9209         	str	r2, [sp, #0x24]
      fc: 6812         	ldr	r2, [r2]
      fe: f422 5280    	.word	#0xf4225280
     102: f807 cccd    	.word	#0xf807cccd
     106: 9b07         	ldr	r3, [sp, #0x1c]
     108: 933a         	str	r3, [sp, #0xe8]
     10a: ea42 320c    	.word	#0xea42320c
     10e: 601a         	str	r2, [r3]
     110: 912e         	str	r1, [sp, #0xb8]
     112: 9130         	str	r1, [sp, #0xc0]
     114: 912f         	str	r1, [sp, #0xbc]
     116: 992f         	ldr	r1, [sp, #0xbc]
     118: 9102         	str	r1, [sp, #0x8]
     11a: 6880         	ldr	r0, [r0, #0x8]
     11c: f240 0100    	.word	#0xf2400100
     120: f2c0 0100    	.word	#0xf2c00100
     124: f7ff fffe    	bl	0x124 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h21fb28ab7c5d2c86+0x124> @ imm = #-0x4
     128: 9a02         	ldr	r2, [sp, #0x8]
     12a: 9903         	ldr	r1, [sp, #0xc]
     12c: 4684         	mov	r12, r0
     12e: 9804         	ldr	r0, [sp, #0x10]
     130: 9210         	str	r2, [sp, #0x40]
     132: f807 ccaa    	.word	#0xf807ccaa
     136: 9a10         	ldr	r2, [sp, #0x40]
     138: 9212         	str	r2, [sp, #0x48]
     13a: 6812         	ldr	r2, [r2]
     13c: f422 6280    	.word	#0xf4226280
     140: f807 cca9    	.word	#0xf807cca9
     144: 9b10         	ldr	r3, [sp, #0x40]
     146: 9337         	str	r3, [sp, #0xdc]
     148: ea42 228c    	.word	#0xea42228c
     14c: 601a         	str	r2, [r3]
     14e: 9122         	str	r1, [sp, #0x88]
     150: 9124         	str	r1, [sp, #0x90]
     152: 9123         	str	r1, [sp, #0x8c]
     154: 9923         	ldr	r1, [sp, #0x8c]
     156: 9105         	str	r1, [sp, #0x14]
     158: 6880         	ldr	r0, [r0, #0x8]
     15a: f240 0100    	.word	#0xf2400100
     15e: f2c0 0100    	.word	#0xf2c00100
     162: f7ff fffe    	bl	0x162 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h21fb28ab7c5d2c86+0x162> @ imm = #-0x4
     166: 4602         	mov	r2, r0
     168: 9805         	ldr	r0, [sp, #0x14]
     16a: 900d         	str	r0, [sp, #0x34]
     16c: f807 2cb6    	.word	#0xf8072cb6
     170: 980d         	ldr	r0, [sp, #0x34]
     172: 900f         	str	r0, [sp, #0x3c]
     174: 6800         	ldr	r0, [r0]
     176: f420 7000    	.word	#0xf4207000
     17a: f807 2cb5    	.word	#0xf8072cb5
     17e: 990d         	ldr	r1, [sp, #0x34]
     180: 9138         	str	r1, [sp, #0xe0]
     182: ea40 2042    	.word	#0xea402042
     186: 6008         	str	r0, [r1]
     188: 980d         	ldr	r0, [sp, #0x34]
     18a: 903b         	str	r0, [sp, #0xec]
     18c: b03c         	add	sp, #0xf0
     18e: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN114_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$3new28_$u7b$$u7b$closure$u7d$$u7d$17h70589d94db125348E:

00000000 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h70589d94db125348>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f20    	.word	#0xf1bc0f20
      10: da02         	bge	0x18 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h70589d94db125348+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0008         	movs	r0, r1
      16: 0000         	movs	r0, r0
      18: b088         	sub	sp, #0x20
      1a: 9100         	str	r1, [sp]
      1c: 4601         	mov	r1, r0
      1e: 9800         	ldr	r0, [sp]
      20: 9101         	str	r1, [sp, #0x4]
      22: 9002         	str	r0, [sp, #0x8]
      24: 9901         	ldr	r1, [sp, #0x4]
      26: 6809         	ldr	r1, [r1]
      28: 9003         	str	r0, [sp, #0xc]
      2a: 9104         	str	r1, [sp, #0x10]
      2c: 9005         	str	r0, [sp, #0x14]
      2e: 9106         	str	r1, [sp, #0x18]
      30: 6001         	str	r1, [r0]
      32: 9007         	str	r0, [sp, #0x1c]
      34: b008         	add	sp, #0x20
      36: 4770         	bx	lr

Disassembly of section .text._ZN114_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$3new28_$u7b$$u7b$closure$u7d$$u7d$17h7f71ed3b16d46b56E:

00000000 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h7f71ed3b16d46b56>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f78    	.word	#0xf1bc0f78
      10: da02         	bge	0x18 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h7f71ed3b16d46b56+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 001e         	movs	r6, r3
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b09c         	sub	sp, #0x70
      1e: 9004         	str	r0, [sp, #0x10]
      20: 9013         	str	r0, [sp, #0x4c]
      22: 9015         	str	r0, [sp, #0x54]
      24: 9014         	str	r0, [sp, #0x50]
      26: 9914         	ldr	r1, [sp, #0x50]
      28: 9100         	str	r1, [sp]
      2a: 9106         	str	r1, [sp, #0x18]
      2c: 2001         	movs	r0, #0x1
      2e: 9001         	str	r0, [sp, #0x4]
      30: f807 0c59    	.word	#0xf8070c59
      34: f817 0c59    	.word	#0xf8170c59
      38: 9107         	str	r1, [sp, #0x1c]
      3a: f807 0c4d    	.word	#0xf8070c4d
      3e: f7ff fffe    	bl	0x3e <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h7f71ed3b16d46b56+0x3e> @ imm = #-0x4
      42: 9900         	ldr	r1, [sp]
      44: 4603         	mov	r3, r0
      46: 9801         	ldr	r0, [sp, #0x4]
      48: 9109         	str	r1, [sp, #0x24]
      4a: f807 3c46    	.word	#0xf8073c46
      4e: 9909         	ldr	r1, [sp, #0x24]
      50: 910b         	str	r1, [sp, #0x2c]
      52: 6809         	ldr	r1, [r1]
      54: f021 0140    	.word	#0xf0210140
      58: f807 3c45    	.word	#0xf8073c45
      5c: 9a09         	ldr	r2, [sp, #0x24]
      5e: 921a         	str	r2, [sp, #0x68]
      60: ea41 1183    	.word	#0xea411183
      64: 6011         	str	r1, [r2]
      66: 9909         	ldr	r1, [sp, #0x24]
      68: 9116         	str	r1, [sp, #0x58]
      6a: 9118         	str	r1, [sp, #0x60]
      6c: 9117         	str	r1, [sp, #0x5c]
      6e: 9917         	ldr	r1, [sp, #0x5c]
      70: 9102         	str	r1, [sp, #0x8]
      72: 910d         	str	r1, [sp, #0x34]
      74: f807 0c3d    	.word	#0xf8070c3d
      78: f817 0c3d    	.word	#0xf8170c3d
      7c: 910e         	str	r1, [sp, #0x38]
      7e: f807 0c31    	.word	#0xf8070c31
      82: f7ff fffe    	bl	0x82 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::h7f71ed3b16d46b56+0x82> @ imm = #-0x4
      86: 4602         	mov	r2, r0
      88: 9802         	ldr	r0, [sp, #0x8]
      8a: 9010         	str	r0, [sp, #0x40]
      8c: f807 2c2a    	.word	#0xf8072c2a
      90: 9810         	ldr	r0, [sp, #0x40]
      92: 9012         	str	r0, [sp, #0x48]
      94: 6800         	ldr	r0, [r0]
      96: f020 0080    	.word	#0xf0200080
      9a: f807 2c29    	.word	#0xf8072c29
      9e: 9910         	ldr	r1, [sp, #0x40]
      a0: 9119         	str	r1, [sp, #0x64]
      a2: ea40 10c2    	.word	#0xea4010c2
      a6: 6008         	str	r0, [r1]
      a8: 9810         	ldr	r0, [sp, #0x40]
      aa: 901b         	str	r0, [sp, #0x6c]
      ac: b01c         	add	sp, #0x70
      ae: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN114_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$3new28_$u7b$$u7b$closure$u7d$$u7d$17he2b1dbff8fdf4762E:

00000000 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::he2b1dbff8fdf4762>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f48    	.word	#0xf1bc0f48
      10: da02         	bge	0x18 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::he2b1dbff8fdf4762+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0012         	movs	r2, r2
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b090         	sub	sp, #0x40
      1e: 9003         	str	r0, [sp, #0xc]
      20: 900b         	str	r0, [sp, #0x2c]
      22: 900d         	str	r0, [sp, #0x34]
      24: 900c         	str	r0, [sp, #0x30]
      26: 990c         	ldr	r1, [sp, #0x30]
      28: 9101         	str	r1, [sp, #0x4]
      2a: 9105         	str	r1, [sp, #0x14]
      2c: 2001         	movs	r0, #0x1
      2e: f807 0c2d    	.word	#0xf8070c2d
      32: f817 0c2d    	.word	#0xf8170c2d
      36: 9106         	str	r1, [sp, #0x18]
      38: f807 0c21    	.word	#0xf8070c21
      3c: f7ff fffe    	bl	0x3c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::he2b1dbff8fdf4762+0x3c> @ imm = #-0x4
      40: 4602         	mov	r2, r0
      42: 9801         	ldr	r0, [sp, #0x4]
      44: 9008         	str	r0, [sp, #0x20]
      46: f807 2c1a    	.word	#0xf8072c1a
      4a: 9808         	ldr	r0, [sp, #0x20]
      4c: 900a         	str	r0, [sp, #0x28]
      4e: 6800         	ldr	r0, [r0]
      50: f020 0040    	.word	#0xf0200040
      54: f807 2c19    	.word	#0xf8072c19
      58: 9908         	ldr	r1, [sp, #0x20]
      5a: 910e         	str	r1, [sp, #0x38]
      5c: ea40 1082    	.word	#0xea401082
      60: 6008         	str	r0, [r1]
      62: 9808         	ldr	r0, [sp, #0x20]
      64: 900f         	str	r0, [sp, #0x3c]
      66: b010         	add	sp, #0x40
      68: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN114_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$3new28_$u7b$$u7b$closure$u7d$$u7d$17hf92485d2afc42939E:

00000000 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::hf92485d2afc42939>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f48    	.word	#0xf1bc0f48
      10: da02         	bge	0x18 <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::hf92485d2afc42939+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0012         	movs	r2, r2
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b090         	sub	sp, #0x40
      1e: 9003         	str	r0, [sp, #0xc]
      20: 900b         	str	r0, [sp, #0x2c]
      22: 900d         	str	r0, [sp, #0x34]
      24: 900c         	str	r0, [sp, #0x30]
      26: 990c         	ldr	r1, [sp, #0x30]
      28: 9101         	str	r1, [sp, #0x4]
      2a: 9105         	str	r1, [sp, #0x14]
      2c: 2001         	movs	r0, #0x1
      2e: f807 0c2d    	.word	#0xf8070c2d
      32: f817 0c2d    	.word	#0xf8170c2d
      36: 9106         	str	r1, [sp, #0x18]
      38: f807 0c21    	.word	#0xf8070c21
      3c: f7ff fffe    	bl	0x3c <_$LT$stm32f4..stm32f405..usart1..RegisterBlock$u20$as$u20$stm32f4xx_hal..serial..uart_impls..RegisterBlockImpl$GT$::new::_$u7b$$u7b$closure$u7d$$u7d$::hf92485d2afc42939+0x3c> @ imm = #-0x4
      40: 4602         	mov	r2, r0
      42: 9801         	ldr	r0, [sp, #0x4]
      44: 9008         	str	r0, [sp, #0x20]
      46: f807 2c1a    	.word	#0xf8072c1a
      4a: 9808         	ldr	r0, [sp, #0x20]
      4c: 900a         	str	r0, [sp, #0x28]
      4e: 6800         	ldr	r0, [r0]
      50: f020 0080    	.word	#0xf0200080
      54: f807 2c19    	.word	#0xf8072c19
      58: 9908         	ldr	r1, [sp, #0x20]
      5a: 910e         	str	r1, [sp, #0x38]
      5c: ea40 10c2    	.word	#0xea4010c2
      60: 6008         	str	r0, [r1]
      62: 9808         	ldr	r0, [sp, #0x20]
      64: 900f         	str	r0, [sp, #0x3c]
      66: b010         	add	sp, #0x40
      68: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN13stm32f4xx_hal3rcc5Reset15reset_unchecked17h33b879c7695a565bE:

00000000 <stm32f4xx_hal::rcc::Reset::reset_unchecked::h33b879c7695a565b>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f18    	.word	#0xf1bc0f18
      10: da02         	bge	0x18 <stm32f4xx_hal::rcc::Reset::reset_unchecked::h33b879c7695a565b+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0006         	movs	r6, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b084         	sub	sp, #0x10
      1e: f643 0000    	.word	#0xf6430000
      22: f2c4 0002    	.word	#0xf2c40002
      26: 9000         	str	r0, [sp]
      28: 9002         	str	r0, [sp, #0x8]
      2a: 9003         	str	r0, [sp, #0xc]
      2c: f7ff fffe    	bl	0x2c <stm32f4xx_hal::rcc::Reset::reset_unchecked::h33b879c7695a565b+0x2c> @ imm = #-0x4
      30: 2104         	movs	r1, #0x4
      32: 9101         	str	r1, [sp, #0x4]
      34: f7ff fffe    	bl	0x34 <stm32f4xx_hal::rcc::Reset::reset_unchecked::h33b879c7695a565b+0x34> @ imm = #-0x4
      38: 9800         	ldr	r0, [sp]
      3a: f7ff fffe    	bl	0x3a <stm32f4xx_hal::rcc::Reset::reset_unchecked::h33b879c7695a565b+0x3a> @ imm = #-0x4
      3e: 9901         	ldr	r1, [sp, #0x4]
      40: f7ff fffe    	bl	0x40 <stm32f4xx_hal::rcc::Reset::reset_unchecked::h33b879c7695a565b+0x40> @ imm = #-0x4
      44: b004         	add	sp, #0x10
      46: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN13stm32f4xx_hal3rcc6Enable16enable_unchecked17hefa798fd8f9b306dE:

00000000 <stm32f4xx_hal::rcc::Enable::enable_unchecked::hefa798fd8f9b306d>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <stm32f4xx_hal::rcc::Enable::enable_unchecked::hefa798fd8f9b306d+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: f643 0000    	.word	#0xf6430000
      22: f2c4 0002    	.word	#0xf2c40002
      26: 9000         	str	r0, [sp]
      28: 9001         	str	r0, [sp, #0x4]
      2a: f7ff fffe    	bl	0x2a <stm32f4xx_hal::rcc::Enable::enable_unchecked::hefa798fd8f9b306d+0x2a> @ imm = #-0x4
      2e: 2104         	movs	r1, #0x4
      30: f7ff fffe    	bl	0x30 <stm32f4xx_hal::rcc::Enable::enable_unchecked::hefa798fd8f9b306d+0x30> @ imm = #-0x4
      34: f7ff fffe    	bl	0x34 <stm32f4xx_hal::rcc::Enable::enable_unchecked::hefa798fd8f9b306d+0x34> @ imm = #-0x4
      38: b002         	add	sp, #0x8
      3a: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN13stm32f4xx_hal4gpio23Pin$LT$_$C$_$C$MODE$GT$3new17h043a60d1c3857944E:

00000000 <stm32f4xx_hal::gpio::Pin$LT$_$C$_$C$MODE$GT$::new::h043a60d1c3857944>:
       0: 4770         	bx	lr

Disassembly of section .text._ZN13stm32f4xx_hal4gpio23Pin$LT$_$C$_$C$MODE$GT$3new17ha9b32d217fa68583E:

00000000 <stm32f4xx_hal::gpio::Pin$LT$_$C$_$C$MODE$GT$::new::ha9b32d217fa68583>:
       0: 4770         	bx	lr

Disassembly of section .text._ZN13stm32f4xx_hal4gpio7convert62_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$14into_alternate17h5d45338eaddb6aa6E:

00000000 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f5bc 7fbc    	.word	#0xf5bc7fbc
      10: da02         	bge	0x18 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 005e         	lsls	r6, r3, #0x1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b0dc         	sub	sp, #0x170
      1e: f10d 003e    	.word	#0xf10d003e
      22: 901b         	str	r0, [sp, #0x6c]
      24: 2000         	movs	r0, #0x0
      26: b978         	cbnz	r0, 0x48 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x48> @ imm = #0x1e
      28: e7ff         	b	0x2a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x2a> @ imm = #-0x2
      2a: 2012         	movs	r0, #0x12
      2c: f88d 003f    	.word	#0xf88d003f
      30: f240 0000    	.word	#0xf2400000
      34: f2c0 0000    	.word	#0xf2c00000
      38: f240 0100    	.word	#0xf2400100
      3c: f2c0 0100    	.word	#0xf2c00100
      40: f7ff fffe    	bl	0x40 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x40> @ imm = #-0x4
      44: b9c8         	cbnz	r0, 0x7a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x7a> @ imm = #0x32
      46: e00b         	b	0x60 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x60> @ imm = #0x16
      48: f240 0000    	.word	#0xf2400000
      4c: f2c0 0000    	.word	#0xf2c00000
      50: f240 0200    	.word	#0xf2400200
      54: f2c0 0200    	.word	#0xf2c00200
      58: 2121         	movs	r1, #0x21
      5a: f7ff fffe    	bl	0x5a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x5a> @ imm = #-0x4
      5e: defe         	trap
      60: f240 0000    	.word	#0xf2400000
      64: f2c0 0000    	.word	#0xf2c00000
      68: f240 0100    	.word	#0xf2400100
      6c: f2c0 0100    	.word	#0xf2c00100
      70: f7ff fffe    	bl	0x70 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x70> @ imm = #-0x4
      74: 2800         	cmp	r0, #0x0
      76: d156         	bne	0x126 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x126> @ imm = #0xac
      78: e0c5         	b	0x206 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x206> @ imm = #0x18a
      7a: 2001         	movs	r0, #0x1
      7c: 9010         	str	r0, [sp, #0x40]
      7e: 2000         	movs	r0, #0x0
      80: 9011         	str	r0, [sp, #0x44]
      82: 9810         	ldr	r0, [sp, #0x40]
      84: 2801         	cmp	r0, #0x1
      86: d1eb         	bne	0x60 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x60> @ imm = #-0x2a
      88: e7ff         	b	0x8a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x8a> @ imm = #-0x2
      8a: 9811         	ldr	r0, [sp, #0x44]
      8c: 9012         	str	r0, [sp, #0x48]
      8e: f7ff fffe    	bl	0x8e <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x8e> @ imm = #-0x4
      92: 3004         	adds	r0, #0x4
      94: 4601         	mov	r1, r0
      96: 910c         	str	r1, [sp, #0x30]
      98: a912         	add	r1, sp, #0x48
      9a: 9113         	str	r1, [sp, #0x4c]
      9c: 9913         	ldr	r1, [sp, #0x4c]
      9e: 910d         	str	r1, [sp, #0x34]
      a0: 904e         	str	r0, [sp, #0x138]
      a2: 914f         	str	r1, [sp, #0x13c]
      a4: 2100         	movs	r1, #0x0
      a6: f807 1c39    	.word	#0xf8071c39
      aa: 2101         	movs	r1, #0x1
      ac: f807 1c39    	.word	#0xf8071c39
      b0: 9057         	str	r0, [sp, #0x15c]
      b2: 9058         	str	r0, [sp, #0x160]
      b4: f7ff fffe    	bl	0xb4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0xb4> @ imm = #-0x4
      b8: 900e         	str	r0, [sp, #0x38]
      ba: e7ff         	b	0xbc <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0xbc> @ imm = #-0x2
      bc: 980d         	ldr	r0, [sp, #0x34]
      be: 990e         	ldr	r1, [sp, #0x38]
      c0: 9152         	str	r1, [sp, #0x148]
      c2: 2200         	movs	r2, #0x0
      c4: f807 2c39    	.word	#0xf8072c39
      c8: 914a         	str	r1, [sp, #0x128]
      ca: 9a4a         	ldr	r2, [sp, #0x128]
      cc: 9254         	str	r2, [sp, #0x150]
      ce: 9253         	str	r2, [sp, #0x14c]
      d0: 9a53         	ldr	r2, [sp, #0x14c]
      d2: 9249         	str	r2, [sp, #0x124]
      d4: 914c         	str	r1, [sp, #0x130]
      d6: 994c         	ldr	r1, [sp, #0x130]
      d8: 9156         	str	r1, [sp, #0x158]
      da: 9155         	str	r1, [sp, #0x154]
      dc: 9955         	ldr	r1, [sp, #0x154]
      de: 914b         	str	r1, [sp, #0x12c]
      e0: a949         	add	r1, sp, #0x124
      e2: 9147         	str	r1, [sp, #0x11c]
      e4: a94b         	add	r1, sp, #0x12c
      e6: 9148         	str	r1, [sp, #0x120]
      e8: 9947         	ldr	r1, [sp, #0x11c]
      ea: 9a48         	ldr	r2, [sp, #0x120]
      ec: f7ff fffe    	bl	0xec <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0xec> @ imm = #-0x4
      f0: 900b         	str	r0, [sp, #0x2c]
      f2: e00a         	b	0x10a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x10a> @ imm = #0x14
      f4: f817 0c39    	.word	#0xf8170c39
      f8: 07c0         	lsls	r0, r0, #0x1f
      fa: b990         	cbnz	r0, 0x122 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x122> @ imm = #0x24
      fc: e00e         	b	0x11c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x11c> @ imm = #0x1c
      fe: 9050         	str	r0, [sp, #0x140]
     100: 9151         	str	r1, [sp, #0x144]
     102: e7f7         	b	0xf4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0xf4> @ imm = #-0x12
     104: 9050         	str	r0, [sp, #0x140]
     106: 9151         	str	r1, [sp, #0x144]
     108: e7f4         	b	0xf4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0xf4> @ imm = #-0x18
     10a: 980c         	ldr	r0, [sp, #0x30]
     10c: 990b         	ldr	r1, [sp, #0x2c]
     10e: 6809         	ldr	r1, [r1]
     110: 9059         	str	r0, [sp, #0x164]
     112: 915a         	str	r1, [sp, #0x168]
     114: 905b         	str	r0, [sp, #0x16c]
     116: f7ff fffe    	bl	0x116 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x116> @ imm = #-0x4
     11a: e003         	b	0x124 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x124> @ imm = #0x6
     11c: 9850         	ldr	r0, [sp, #0x140]
     11e: 900a         	str	r0, [sp, #0x28]
     120: e0c0         	b	0x2a4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x2a4> @ imm = #0x180
     122: e7fb         	b	0x11c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x11c> @ imm = #-0xa
     124: e79c         	b	0x60 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x60> @ imm = #-0xc8
     126: 2001         	movs	r0, #0x1
     128: 9014         	str	r0, [sp, #0x50]
     12a: 2007         	movs	r0, #0x7
     12c: 9015         	str	r0, [sp, #0x54]
     12e: 9814         	ldr	r0, [sp, #0x50]
     130: 2801         	cmp	r0, #0x1
     132: d168         	bne	0x206 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x206> @ imm = #0xd0
     134: e7ff         	b	0x136 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x136> @ imm = #-0x2
     136: 9815         	ldr	r0, [sp, #0x54]
     138: 9016         	str	r0, [sp, #0x58]
     13a: 2000         	movs	r0, #0x0
     13c: 2800         	cmp	r0, #0x0
     13e: d156         	bne	0x1ee <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x1ee> @ imm = #0xac
     140: e7ff         	b	0x142 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x142> @ imm = #-0x2
     142: 2004         	movs	r0, #0x4
     144: f88d 005f    	.word	#0xf88d005f
     148: f7ff fffe    	bl	0x148 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x148> @ imm = #-0x4
     14c: 3024         	adds	r0, #0x24
     14e: 4601         	mov	r1, r0
     150: 9106         	str	r1, [sp, #0x18]
     152: f10d 015f    	.word	#0xf10d015f
     156: 9118         	str	r1, [sp, #0x60]
     158: a916         	add	r1, sp, #0x58
     15a: 9119         	str	r1, [sp, #0x64]
     15c: 9a18         	ldr	r2, [sp, #0x60]
     15e: 9207         	str	r2, [sp, #0x1c]
     160: 9919         	ldr	r1, [sp, #0x64]
     162: 9108         	str	r1, [sp, #0x20]
     164: 9038         	str	r0, [sp, #0xe0]
     166: 9239         	str	r2, [sp, #0xe4]
     168: 913a         	str	r1, [sp, #0xe8]
     16a: 2100         	movs	r1, #0x0
     16c: f807 1c91    	.word	#0xf8071c91
     170: 2101         	movs	r1, #0x1
     172: f807 1c91    	.word	#0xf8071c91
     176: 9042         	str	r0, [sp, #0x108]
     178: 9043         	str	r0, [sp, #0x10c]
     17a: f7ff fffe    	bl	0x17a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x17a> @ imm = #-0x4
     17e: 9009         	str	r0, [sp, #0x24]
     180: e7ff         	b	0x182 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x182> @ imm = #-0x2
     182: 9908         	ldr	r1, [sp, #0x20]
     184: 9807         	ldr	r0, [sp, #0x1c]
     186: 9a09         	ldr	r2, [sp, #0x24]
     188: 923d         	str	r2, [sp, #0xf4]
     18a: 2300         	movs	r3, #0x0
     18c: f807 3c91    	.word	#0xf8073c91
     190: 9234         	str	r2, [sp, #0xd0]
     192: 9b34         	ldr	r3, [sp, #0xd0]
     194: 933f         	str	r3, [sp, #0xfc]
     196: 933e         	str	r3, [sp, #0xf8]
     198: 9b3e         	ldr	r3, [sp, #0xf8]
     19a: 9333         	str	r3, [sp, #0xcc]
     19c: 9236         	str	r2, [sp, #0xd8]
     19e: 9a36         	ldr	r2, [sp, #0xd8]
     1a0: 9241         	str	r2, [sp, #0x104]
     1a2: 9240         	str	r2, [sp, #0x100]
     1a4: 9a40         	ldr	r2, [sp, #0x100]
     1a6: 9235         	str	r2, [sp, #0xd4]
     1a8: aa33         	add	r2, sp, #0xcc
     1aa: 9231         	str	r2, [sp, #0xc4]
     1ac: aa35         	add	r2, sp, #0xd4
     1ae: 9232         	str	r2, [sp, #0xc8]
     1b0: 9a31         	ldr	r2, [sp, #0xc4]
     1b2: 9b32         	ldr	r3, [sp, #0xc8]
     1b4: f7ff fffe    	bl	0x1b4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x1b4> @ imm = #-0x4
     1b8: 9005         	str	r0, [sp, #0x14]
     1ba: e00a         	b	0x1d2 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x1d2> @ imm = #0x14
     1bc: f817 0c91    	.word	#0xf8170c91
     1c0: 07c0         	lsls	r0, r0, #0x1f
     1c2: b990         	cbnz	r0, 0x1ea <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x1ea> @ imm = #0x24
     1c4: e00e         	b	0x1e4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x1e4> @ imm = #0x1c
     1c6: 903b         	str	r0, [sp, #0xec]
     1c8: 913c         	str	r1, [sp, #0xf0]
     1ca: e7f7         	b	0x1bc <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x1bc> @ imm = #-0x12
     1cc: 903b         	str	r0, [sp, #0xec]
     1ce: 913c         	str	r1, [sp, #0xf0]
     1d0: e7f4         	b	0x1bc <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x1bc> @ imm = #-0x18
     1d2: 9806         	ldr	r0, [sp, #0x18]
     1d4: 9905         	ldr	r1, [sp, #0x14]
     1d6: 6809         	ldr	r1, [r1]
     1d8: 9044         	str	r0, [sp, #0x110]
     1da: 9145         	str	r1, [sp, #0x114]
     1dc: 9046         	str	r0, [sp, #0x118]
     1de: f7ff fffe    	bl	0x1de <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x1de> @ imm = #-0x4
     1e2: e003         	b	0x1ec <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x1ec> @ imm = #0x6
     1e4: 983b         	ldr	r0, [sp, #0xec]
     1e6: 900a         	str	r0, [sp, #0x28]
     1e8: e05c         	b	0x2a4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x2a4> @ imm = #0xb8
     1ea: e7fb         	b	0x1e4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x1e4> @ imm = #-0xa
     1ec: e00b         	b	0x206 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x206> @ imm = #0x16
     1ee: f240 0000    	.word	#0xf2400000
     1f2: f2c0 0000    	.word	#0xf2c00000
     1f6: f240 0200    	.word	#0xf2400200
     1fa: f2c0 0200    	.word	#0xf2c00200
     1fe: 2121         	movs	r1, #0x21
     200: f7ff fffe    	bl	0x200 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x200> @ imm = #-0x4
     204: defe         	trap
     206: f7ff fffe    	bl	0x206 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x206> @ imm = #-0x4
     20a: 4601         	mov	r1, r0
     20c: 9102         	str	r1, [sp, #0x8]
     20e: f10d 013f    	.word	#0xf10d013f
     212: 911a         	str	r1, [sp, #0x68]
     214: 991a         	ldr	r1, [sp, #0x68]
     216: 9103         	str	r1, [sp, #0xc]
     218: 9023         	str	r0, [sp, #0x8c]
     21a: 9124         	str	r1, [sp, #0x90]
     21c: 2100         	movs	r1, #0x0
     21e: f807 1ce5    	.word	#0xf8071ce5
     222: 2101         	movs	r1, #0x1
     224: f807 1ce5    	.word	#0xf8071ce5
     228: 902c         	str	r0, [sp, #0xb0]
     22a: 902d         	str	r0, [sp, #0xb4]
     22c: f7ff fffe    	bl	0x22c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x22c> @ imm = #-0x4
     230: 9004         	str	r0, [sp, #0x10]
     232: e7ff         	b	0x234 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x234> @ imm = #-0x2
     234: 9803         	ldr	r0, [sp, #0xc]
     236: 9904         	ldr	r1, [sp, #0x10]
     238: 9127         	str	r1, [sp, #0x9c]
     23a: 2200         	movs	r2, #0x0
     23c: f807 2ce5    	.word	#0xf8072ce5
     240: 911f         	str	r1, [sp, #0x7c]
     242: 9a1f         	ldr	r2, [sp, #0x7c]
     244: 9229         	str	r2, [sp, #0xa4]
     246: 9228         	str	r2, [sp, #0xa0]
     248: 9a28         	ldr	r2, [sp, #0xa0]
     24a: 921e         	str	r2, [sp, #0x78]
     24c: 9121         	str	r1, [sp, #0x84]
     24e: 9921         	ldr	r1, [sp, #0x84]
     250: 912b         	str	r1, [sp, #0xac]
     252: 912a         	str	r1, [sp, #0xa8]
     254: 992a         	ldr	r1, [sp, #0xa8]
     256: 9120         	str	r1, [sp, #0x80]
     258: a91e         	add	r1, sp, #0x78
     25a: 911c         	str	r1, [sp, #0x70]
     25c: a920         	add	r1, sp, #0x80
     25e: 911d         	str	r1, [sp, #0x74]
     260: 991c         	ldr	r1, [sp, #0x70]
     262: 9a1d         	ldr	r2, [sp, #0x74]
     264: f7ff fffe    	bl	0x264 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x264> @ imm = #-0x4
     268: 9001         	str	r0, [sp, #0x4]
     26a: e00a         	b	0x282 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x282> @ imm = #0x14
     26c: f817 0ce5    	.word	#0xf8170ce5
     270: 07c0         	lsls	r0, r0, #0x1f
     272: b990         	cbnz	r0, 0x29a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x29a> @ imm = #0x24
     274: e00e         	b	0x294 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x294> @ imm = #0x1c
     276: 9025         	str	r0, [sp, #0x94]
     278: 9126         	str	r1, [sp, #0x98]
     27a: e7f7         	b	0x26c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x26c> @ imm = #-0x12
     27c: 9025         	str	r0, [sp, #0x94]
     27e: 9126         	str	r1, [sp, #0x98]
     280: e7f4         	b	0x26c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x26c> @ imm = #-0x18
     282: 9802         	ldr	r0, [sp, #0x8]
     284: 9901         	ldr	r1, [sp, #0x4]
     286: 6809         	ldr	r1, [r1]
     288: 902e         	str	r0, [sp, #0xb8]
     28a: 912f         	str	r1, [sp, #0xbc]
     28c: 9030         	str	r0, [sp, #0xc0]
     28e: f7ff fffe    	bl	0x28e <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x28e> @ imm = #-0x4
     292: e003         	b	0x29c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x29c> @ imm = #0x6
     294: 9825         	ldr	r0, [sp, #0x94]
     296: 900a         	str	r0, [sp, #0x28]
     298: e004         	b	0x2a4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x2a4> @ imm = #0x8
     29a: e7fb         	b	0x294 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x294> @ imm = #-0xa
     29c: f7ff fffe    	bl	0x29c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x29c> @ imm = #-0x4
     2a0: b05c         	add	sp, #0x170
     2a2: bd80         	pop	{r7, pc}
     2a4: 980a         	ldr	r0, [sp, #0x28]
     2a6: f7ff fffe    	bl	0x2a6 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::h5d45338eaddb6aa6+0x2a6> @ imm = #-0x4
     2aa: defe         	trap

Disassembly of section .text._ZN13stm32f4xx_hal4gpio7convert62_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$14into_alternate17ha36359304dd99904E:

00000000 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f5bc 7fbc    	.word	#0xf5bc7fbc
      10: da02         	bge	0x18 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 005e         	lsls	r6, r3, #0x1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b0dc         	sub	sp, #0x170
      1e: f10d 003e    	.word	#0xf10d003e
      22: 901b         	str	r0, [sp, #0x6c]
      24: 2000         	movs	r0, #0x0
      26: b978         	cbnz	r0, 0x48 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x48> @ imm = #0x1e
      28: e7ff         	b	0x2a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x2a> @ imm = #-0x2
      2a: 2014         	movs	r0, #0x14
      2c: f88d 003f    	.word	#0xf88d003f
      30: f240 0000    	.word	#0xf2400000
      34: f2c0 0000    	.word	#0xf2c00000
      38: f240 0100    	.word	#0xf2400100
      3c: f2c0 0100    	.word	#0xf2c00100
      40: f7ff fffe    	bl	0x40 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x40> @ imm = #-0x4
      44: b9c8         	cbnz	r0, 0x7a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x7a> @ imm = #0x32
      46: e00b         	b	0x60 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x60> @ imm = #0x16
      48: f240 0000    	.word	#0xf2400000
      4c: f2c0 0000    	.word	#0xf2c00000
      50: f240 0200    	.word	#0xf2400200
      54: f2c0 0200    	.word	#0xf2c00200
      58: 2121         	movs	r1, #0x21
      5a: f7ff fffe    	bl	0x5a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x5a> @ imm = #-0x4
      5e: defe         	trap
      60: f240 0000    	.word	#0xf2400000
      64: f2c0 0000    	.word	#0xf2c00000
      68: f240 0100    	.word	#0xf2400100
      6c: f2c0 0100    	.word	#0xf2c00100
      70: f7ff fffe    	bl	0x70 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x70> @ imm = #-0x4
      74: 2800         	cmp	r0, #0x0
      76: d156         	bne	0x126 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x126> @ imm = #0xac
      78: e0c5         	b	0x206 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x206> @ imm = #0x18a
      7a: 2001         	movs	r0, #0x1
      7c: 9010         	str	r0, [sp, #0x40]
      7e: 2000         	movs	r0, #0x0
      80: 9011         	str	r0, [sp, #0x44]
      82: 9810         	ldr	r0, [sp, #0x40]
      84: 2801         	cmp	r0, #0x1
      86: d1eb         	bne	0x60 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x60> @ imm = #-0x2a
      88: e7ff         	b	0x8a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x8a> @ imm = #-0x2
      8a: 9811         	ldr	r0, [sp, #0x44]
      8c: 9012         	str	r0, [sp, #0x48]
      8e: f7ff fffe    	bl	0x8e <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x8e> @ imm = #-0x4
      92: 3004         	adds	r0, #0x4
      94: 4601         	mov	r1, r0
      96: 910c         	str	r1, [sp, #0x30]
      98: a912         	add	r1, sp, #0x48
      9a: 9113         	str	r1, [sp, #0x4c]
      9c: 9913         	ldr	r1, [sp, #0x4c]
      9e: 910d         	str	r1, [sp, #0x34]
      a0: 9023         	str	r0, [sp, #0x8c]
      a2: 9124         	str	r1, [sp, #0x90]
      a4: 2100         	movs	r1, #0x0
      a6: f807 1ce5    	.word	#0xf8071ce5
      aa: 2101         	movs	r1, #0x1
      ac: f807 1ce5    	.word	#0xf8071ce5
      b0: 902c         	str	r0, [sp, #0xb0]
      b2: 902d         	str	r0, [sp, #0xb4]
      b4: f7ff fffe    	bl	0xb4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0xb4> @ imm = #-0x4
      b8: 900e         	str	r0, [sp, #0x38]
      ba: e7ff         	b	0xbc <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0xbc> @ imm = #-0x2
      bc: 980d         	ldr	r0, [sp, #0x34]
      be: 990e         	ldr	r1, [sp, #0x38]
      c0: 9127         	str	r1, [sp, #0x9c]
      c2: 2200         	movs	r2, #0x0
      c4: f807 2ce5    	.word	#0xf8072ce5
      c8: 911f         	str	r1, [sp, #0x7c]
      ca: 9a1f         	ldr	r2, [sp, #0x7c]
      cc: 9229         	str	r2, [sp, #0xa4]
      ce: 9228         	str	r2, [sp, #0xa0]
      d0: 9a28         	ldr	r2, [sp, #0xa0]
      d2: 921e         	str	r2, [sp, #0x78]
      d4: 9121         	str	r1, [sp, #0x84]
      d6: 9921         	ldr	r1, [sp, #0x84]
      d8: 912b         	str	r1, [sp, #0xac]
      da: 912a         	str	r1, [sp, #0xa8]
      dc: 992a         	ldr	r1, [sp, #0xa8]
      de: 9120         	str	r1, [sp, #0x80]
      e0: a91e         	add	r1, sp, #0x78
      e2: 911c         	str	r1, [sp, #0x70]
      e4: a920         	add	r1, sp, #0x80
      e6: 911d         	str	r1, [sp, #0x74]
      e8: 991c         	ldr	r1, [sp, #0x70]
      ea: 9a1d         	ldr	r2, [sp, #0x74]
      ec: f7ff fffe    	bl	0xec <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0xec> @ imm = #-0x4
      f0: 900b         	str	r0, [sp, #0x2c]
      f2: e00a         	b	0x10a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x10a> @ imm = #0x14
      f4: f817 0ce5    	.word	#0xf8170ce5
      f8: 07c0         	lsls	r0, r0, #0x1f
      fa: b990         	cbnz	r0, 0x122 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x122> @ imm = #0x24
      fc: e00e         	b	0x11c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x11c> @ imm = #0x1c
      fe: 9025         	str	r0, [sp, #0x94]
     100: 9126         	str	r1, [sp, #0x98]
     102: e7f7         	b	0xf4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0xf4> @ imm = #-0x12
     104: 9025         	str	r0, [sp, #0x94]
     106: 9126         	str	r1, [sp, #0x98]
     108: e7f4         	b	0xf4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0xf4> @ imm = #-0x18
     10a: 980c         	ldr	r0, [sp, #0x30]
     10c: 990b         	ldr	r1, [sp, #0x2c]
     10e: 6809         	ldr	r1, [r1]
     110: 902e         	str	r0, [sp, #0xb8]
     112: 912f         	str	r1, [sp, #0xbc]
     114: 9030         	str	r0, [sp, #0xc0]
     116: f7ff fffe    	bl	0x116 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x116> @ imm = #-0x4
     11a: e003         	b	0x124 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x124> @ imm = #0x6
     11c: 9825         	ldr	r0, [sp, #0x94]
     11e: 900a         	str	r0, [sp, #0x28]
     120: e0c0         	b	0x2a4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x2a4> @ imm = #0x180
     122: e7fb         	b	0x11c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x11c> @ imm = #-0xa
     124: e79c         	b	0x60 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x60> @ imm = #-0xc8
     126: 2001         	movs	r0, #0x1
     128: 9014         	str	r0, [sp, #0x50]
     12a: 2007         	movs	r0, #0x7
     12c: 9015         	str	r0, [sp, #0x54]
     12e: 9814         	ldr	r0, [sp, #0x50]
     130: 2801         	cmp	r0, #0x1
     132: d168         	bne	0x206 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x206> @ imm = #0xd0
     134: e7ff         	b	0x136 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x136> @ imm = #-0x2
     136: 9815         	ldr	r0, [sp, #0x54]
     138: 9016         	str	r0, [sp, #0x58]
     13a: 2000         	movs	r0, #0x0
     13c: 2800         	cmp	r0, #0x0
     13e: d156         	bne	0x1ee <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x1ee> @ imm = #0xac
     140: e7ff         	b	0x142 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x142> @ imm = #-0x2
     142: 2008         	movs	r0, #0x8
     144: f88d 005f    	.word	#0xf88d005f
     148: f7ff fffe    	bl	0x148 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x148> @ imm = #-0x4
     14c: 3024         	adds	r0, #0x24
     14e: 4601         	mov	r1, r0
     150: 9106         	str	r1, [sp, #0x18]
     152: f10d 015f    	.word	#0xf10d015f
     156: 9118         	str	r1, [sp, #0x60]
     158: a916         	add	r1, sp, #0x58
     15a: 9119         	str	r1, [sp, #0x64]
     15c: 9a18         	ldr	r2, [sp, #0x60]
     15e: 9207         	str	r2, [sp, #0x1c]
     160: 9919         	ldr	r1, [sp, #0x64]
     162: 9108         	str	r1, [sp, #0x20]
     164: 9038         	str	r0, [sp, #0xe0]
     166: 9239         	str	r2, [sp, #0xe4]
     168: 913a         	str	r1, [sp, #0xe8]
     16a: 2100         	movs	r1, #0x0
     16c: f807 1c91    	.word	#0xf8071c91
     170: 2101         	movs	r1, #0x1
     172: f807 1c91    	.word	#0xf8071c91
     176: 9042         	str	r0, [sp, #0x108]
     178: 9043         	str	r0, [sp, #0x10c]
     17a: f7ff fffe    	bl	0x17a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x17a> @ imm = #-0x4
     17e: 9009         	str	r0, [sp, #0x24]
     180: e7ff         	b	0x182 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x182> @ imm = #-0x2
     182: 9908         	ldr	r1, [sp, #0x20]
     184: 9807         	ldr	r0, [sp, #0x1c]
     186: 9a09         	ldr	r2, [sp, #0x24]
     188: 923d         	str	r2, [sp, #0xf4]
     18a: 2300         	movs	r3, #0x0
     18c: f807 3c91    	.word	#0xf8073c91
     190: 9234         	str	r2, [sp, #0xd0]
     192: 9b34         	ldr	r3, [sp, #0xd0]
     194: 933f         	str	r3, [sp, #0xfc]
     196: 933e         	str	r3, [sp, #0xf8]
     198: 9b3e         	ldr	r3, [sp, #0xf8]
     19a: 9333         	str	r3, [sp, #0xcc]
     19c: 9236         	str	r2, [sp, #0xd8]
     19e: 9a36         	ldr	r2, [sp, #0xd8]
     1a0: 9241         	str	r2, [sp, #0x104]
     1a2: 9240         	str	r2, [sp, #0x100]
     1a4: 9a40         	ldr	r2, [sp, #0x100]
     1a6: 9235         	str	r2, [sp, #0xd4]
     1a8: aa33         	add	r2, sp, #0xcc
     1aa: 9231         	str	r2, [sp, #0xc4]
     1ac: aa35         	add	r2, sp, #0xd4
     1ae: 9232         	str	r2, [sp, #0xc8]
     1b0: 9a31         	ldr	r2, [sp, #0xc4]
     1b2: 9b32         	ldr	r3, [sp, #0xc8]
     1b4: f7ff fffe    	bl	0x1b4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x1b4> @ imm = #-0x4
     1b8: 9005         	str	r0, [sp, #0x14]
     1ba: e00a         	b	0x1d2 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x1d2> @ imm = #0x14
     1bc: f817 0c91    	.word	#0xf8170c91
     1c0: 07c0         	lsls	r0, r0, #0x1f
     1c2: b990         	cbnz	r0, 0x1ea <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x1ea> @ imm = #0x24
     1c4: e00e         	b	0x1e4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x1e4> @ imm = #0x1c
     1c6: 903b         	str	r0, [sp, #0xec]
     1c8: 913c         	str	r1, [sp, #0xf0]
     1ca: e7f7         	b	0x1bc <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x1bc> @ imm = #-0x12
     1cc: 903b         	str	r0, [sp, #0xec]
     1ce: 913c         	str	r1, [sp, #0xf0]
     1d0: e7f4         	b	0x1bc <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x1bc> @ imm = #-0x18
     1d2: 9806         	ldr	r0, [sp, #0x18]
     1d4: 9905         	ldr	r1, [sp, #0x14]
     1d6: 6809         	ldr	r1, [r1]
     1d8: 9044         	str	r0, [sp, #0x110]
     1da: 9145         	str	r1, [sp, #0x114]
     1dc: 9046         	str	r0, [sp, #0x118]
     1de: f7ff fffe    	bl	0x1de <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x1de> @ imm = #-0x4
     1e2: e003         	b	0x1ec <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x1ec> @ imm = #0x6
     1e4: 983b         	ldr	r0, [sp, #0xec]
     1e6: 900a         	str	r0, [sp, #0x28]
     1e8: e05c         	b	0x2a4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x2a4> @ imm = #0xb8
     1ea: e7fb         	b	0x1e4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x1e4> @ imm = #-0xa
     1ec: e00b         	b	0x206 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x206> @ imm = #0x16
     1ee: f240 0000    	.word	#0xf2400000
     1f2: f2c0 0000    	.word	#0xf2c00000
     1f6: f240 0200    	.word	#0xf2400200
     1fa: f2c0 0200    	.word	#0xf2c00200
     1fe: 2121         	movs	r1, #0x21
     200: f7ff fffe    	bl	0x200 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x200> @ imm = #-0x4
     204: defe         	trap
     206: f7ff fffe    	bl	0x206 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x206> @ imm = #-0x4
     20a: 4601         	mov	r1, r0
     20c: 9102         	str	r1, [sp, #0x8]
     20e: f10d 013f    	.word	#0xf10d013f
     212: 911a         	str	r1, [sp, #0x68]
     214: 991a         	ldr	r1, [sp, #0x68]
     216: 9103         	str	r1, [sp, #0xc]
     218: 904e         	str	r0, [sp, #0x138]
     21a: 914f         	str	r1, [sp, #0x13c]
     21c: 2100         	movs	r1, #0x0
     21e: f807 1c39    	.word	#0xf8071c39
     222: 2101         	movs	r1, #0x1
     224: f807 1c39    	.word	#0xf8071c39
     228: 9057         	str	r0, [sp, #0x15c]
     22a: 9058         	str	r0, [sp, #0x160]
     22c: f7ff fffe    	bl	0x22c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x22c> @ imm = #-0x4
     230: 9004         	str	r0, [sp, #0x10]
     232: e7ff         	b	0x234 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x234> @ imm = #-0x2
     234: 9803         	ldr	r0, [sp, #0xc]
     236: 9904         	ldr	r1, [sp, #0x10]
     238: 9152         	str	r1, [sp, #0x148]
     23a: 2200         	movs	r2, #0x0
     23c: f807 2c39    	.word	#0xf8072c39
     240: 914a         	str	r1, [sp, #0x128]
     242: 9a4a         	ldr	r2, [sp, #0x128]
     244: 9254         	str	r2, [sp, #0x150]
     246: 9253         	str	r2, [sp, #0x14c]
     248: 9a53         	ldr	r2, [sp, #0x14c]
     24a: 9249         	str	r2, [sp, #0x124]
     24c: 914c         	str	r1, [sp, #0x130]
     24e: 994c         	ldr	r1, [sp, #0x130]
     250: 9156         	str	r1, [sp, #0x158]
     252: 9155         	str	r1, [sp, #0x154]
     254: 9955         	ldr	r1, [sp, #0x154]
     256: 914b         	str	r1, [sp, #0x12c]
     258: a949         	add	r1, sp, #0x124
     25a: 9147         	str	r1, [sp, #0x11c]
     25c: a94b         	add	r1, sp, #0x12c
     25e: 9148         	str	r1, [sp, #0x120]
     260: 9947         	ldr	r1, [sp, #0x11c]
     262: 9a48         	ldr	r2, [sp, #0x120]
     264: f7ff fffe    	bl	0x264 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x264> @ imm = #-0x4
     268: 9001         	str	r0, [sp, #0x4]
     26a: e00a         	b	0x282 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x282> @ imm = #0x14
     26c: f817 0c39    	.word	#0xf8170c39
     270: 07c0         	lsls	r0, r0, #0x1f
     272: b990         	cbnz	r0, 0x29a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x29a> @ imm = #0x24
     274: e00e         	b	0x294 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x294> @ imm = #0x1c
     276: 9050         	str	r0, [sp, #0x140]
     278: 9151         	str	r1, [sp, #0x144]
     27a: e7f7         	b	0x26c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x26c> @ imm = #-0x12
     27c: 9050         	str	r0, [sp, #0x140]
     27e: 9151         	str	r1, [sp, #0x144]
     280: e7f4         	b	0x26c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x26c> @ imm = #-0x18
     282: 9802         	ldr	r0, [sp, #0x8]
     284: 9901         	ldr	r1, [sp, #0x4]
     286: 6809         	ldr	r1, [r1]
     288: 9059         	str	r0, [sp, #0x164]
     28a: 915a         	str	r1, [sp, #0x168]
     28c: 905b         	str	r0, [sp, #0x16c]
     28e: f7ff fffe    	bl	0x28e <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x28e> @ imm = #-0x4
     292: e003         	b	0x29c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x29c> @ imm = #0x6
     294: 9850         	ldr	r0, [sp, #0x140]
     296: 900a         	str	r0, [sp, #0x28]
     298: e004         	b	0x2a4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x2a4> @ imm = #0x8
     29a: e7fb         	b	0x294 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x294> @ imm = #-0xa
     29c: f7ff fffe    	bl	0x29c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x29c> @ imm = #-0x4
     2a0: b05c         	add	sp, #0x170
     2a2: bd80         	pop	{r7, pc}
     2a4: 980a         	ldr	r0, [sp, #0x28]
     2a6: f7ff fffe    	bl	0x2a6 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::into_alternate::ha36359304dd99904+0x2a6> @ imm = #-0x4
     2aa: defe         	trap

Disassembly of section .text._ZN13stm32f4xx_hal4gpio7convert62_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$4mode28_$u7b$$u7b$closure$u7d$$u7d$17h0bd6b6781352a293E:

00000000 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h0bd6b6781352a293>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f50    	.word	#0xf1bc0f50
      10: da02         	bge	0x18 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h0bd6b6781352a293+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0014         	movs	r4, r2
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b092         	sub	sp, #0x48
      1e: 9304         	str	r3, [sp, #0x10]
      20: 9007         	str	r0, [sp, #0x1c]
      22: 9108         	str	r1, [sp, #0x20]
      24: 9209         	str	r2, [sp, #0x24]
      26: 930a         	str	r3, [sp, #0x28]
      28: 920b         	str	r2, [sp, #0x2c]
      2a: 920c         	str	r2, [sp, #0x30]
      2c: 6810         	ldr	r0, [r2]
      2e: 9005         	str	r0, [sp, #0x14]
      30: 9807         	ldr	r0, [sp, #0x1c]
      32: 7800         	ldrb	r0, [r0]
      34: 4601         	mov	r1, r0
      36: 9106         	str	r1, [sp, #0x18]
      38: 281f         	cmp	r0, #0x1f
      3a: d812         	bhi	0x62 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h0bd6b6781352a293+0x62> @ imm = #0x24
      3c: e7ff         	b	0x3e <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h0bd6b6781352a293+0x3e> @ imm = #-0x2
      3e: 9805         	ldr	r0, [sp, #0x14]
      40: 9906         	ldr	r1, [sp, #0x18]
      42: f001 021f    	.word	#0xf001021f
      46: 210f         	movs	r1, #0xf
      48: 4091         	lsls	r1, r2
      4a: 4388         	bics	r0, r1
      4c: 9001         	str	r0, [sp, #0x4]
      4e: 9807         	ldr	r0, [sp, #0x1c]
      50: 9908         	ldr	r1, [sp, #0x20]
      52: 6809         	ldr	r1, [r1]
      54: 9102         	str	r1, [sp, #0x8]
      56: 7800         	ldrb	r0, [r0]
      58: 4601         	mov	r1, r0
      5a: 9103         	str	r1, [sp, #0xc]
      5c: 2820         	cmp	r0, #0x20
      5e: d30c         	blo	0x7a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h0bd6b6781352a293+0x7a> @ imm = #0x18
      60: e01b         	b	0x9a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h0bd6b6781352a293+0x9a> @ imm = #0x36
      62: f240 0000    	.word	#0xf2400000
      66: f2c0 0000    	.word	#0xf2c00000
      6a: f240 0200    	.word	#0xf2400200
      6e: f2c0 0200    	.word	#0xf2c00200
      72: 2123         	movs	r1, #0x23
      74: f7ff fffe    	bl	0x74 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h0bd6b6781352a293+0x74> @ imm = #-0x4
      78: defe         	trap
      7a: 9804         	ldr	r0, [sp, #0x10]
      7c: 9901         	ldr	r1, [sp, #0x4]
      7e: 9a02         	ldr	r2, [sp, #0x8]
      80: 9b03         	ldr	r3, [sp, #0xc]
      82: f003 031f    	.word	#0xf003031f
      86: 409a         	lsls	r2, r3
      88: 4311         	orrs	r1, r2
      8a: 900d         	str	r0, [sp, #0x34]
      8c: 910e         	str	r1, [sp, #0x38]
      8e: 900f         	str	r0, [sp, #0x3c]
      90: 9110         	str	r1, [sp, #0x40]
      92: 6001         	str	r1, [r0]
      94: 9011         	str	r0, [sp, #0x44]
      96: b012         	add	sp, #0x48
      98: bd80         	pop	{r7, pc}
      9a: f240 0000    	.word	#0xf2400000
      9e: f2c0 0000    	.word	#0xf2c00000
      a2: f240 0200    	.word	#0xf2400200
      a6: f2c0 0200    	.word	#0xf2c00200
      aa: 2123         	movs	r1, #0x23
      ac: f7ff fffe    	bl	0xac <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h0bd6b6781352a293+0xac> @ imm = #-0x4
      b0: defe         	trap

Disassembly of section .text._ZN13stm32f4xx_hal4gpio7convert62_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$4mode28_$u7b$$u7b$closure$u7d$$u7d$17h430a6baa579f62a2E:

00000000 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h430a6baa579f62a2>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f48    	.word	#0xf1bc0f48
      10: da02         	bge	0x18 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h430a6baa579f62a2+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0012         	movs	r2, r2
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b090         	sub	sp, #0x40
      1e: 9203         	str	r2, [sp, #0xc]
      20: 9006         	str	r0, [sp, #0x18]
      22: 9107         	str	r1, [sp, #0x1c]
      24: 9208         	str	r2, [sp, #0x20]
      26: 9109         	str	r1, [sp, #0x24]
      28: 910a         	str	r1, [sp, #0x28]
      2a: 6808         	ldr	r0, [r1]
      2c: 9004         	str	r0, [sp, #0x10]
      2e: 9806         	ldr	r0, [sp, #0x18]
      30: 7800         	ldrb	r0, [r0]
      32: 4601         	mov	r1, r0
      34: 9105         	str	r1, [sp, #0x14]
      36: 281f         	cmp	r0, #0x1f
      38: d80f         	bhi	0x5a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h430a6baa579f62a2+0x5a> @ imm = #0x1e
      3a: e7ff         	b	0x3c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h430a6baa579f62a2+0x3c> @ imm = #-0x2
      3c: 9804         	ldr	r0, [sp, #0x10]
      3e: 9905         	ldr	r1, [sp, #0x14]
      40: f001 021f    	.word	#0xf001021f
      44: 2103         	movs	r1, #0x3
      46: 4091         	lsls	r1, r2
      48: 4388         	bics	r0, r1
      4a: 9001         	str	r0, [sp, #0x4]
      4c: 9806         	ldr	r0, [sp, #0x18]
      4e: 7800         	ldrb	r0, [r0]
      50: 4601         	mov	r1, r0
      52: 9102         	str	r1, [sp, #0x8]
      54: 2820         	cmp	r0, #0x20
      56: d30c         	blo	0x72 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h430a6baa579f62a2+0x72> @ imm = #0x18
      58: e01b         	b	0x92 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h430a6baa579f62a2+0x92> @ imm = #0x36
      5a: f240 0000    	.word	#0xf2400000
      5e: f2c0 0000    	.word	#0xf2c00000
      62: f240 0200    	.word	#0xf2400200
      66: f2c0 0200    	.word	#0xf2c00200
      6a: 2123         	movs	r1, #0x23
      6c: f7ff fffe    	bl	0x6c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h430a6baa579f62a2+0x6c> @ imm = #-0x4
      70: defe         	trap
      72: 9803         	ldr	r0, [sp, #0xc]
      74: 9901         	ldr	r1, [sp, #0x4]
      76: 9a02         	ldr	r2, [sp, #0x8]
      78: f002 031f    	.word	#0xf002031f
      7c: 2202         	movs	r2, #0x2
      7e: 409a         	lsls	r2, r3
      80: 4311         	orrs	r1, r2
      82: 900b         	str	r0, [sp, #0x2c]
      84: 910c         	str	r1, [sp, #0x30]
      86: 900d         	str	r0, [sp, #0x34]
      88: 910e         	str	r1, [sp, #0x38]
      8a: 6001         	str	r1, [r0]
      8c: 900f         	str	r0, [sp, #0x3c]
      8e: b010         	add	sp, #0x40
      90: bd80         	pop	{r7, pc}
      92: f240 0000    	.word	#0xf2400000
      96: f2c0 0000    	.word	#0xf2c00000
      9a: f240 0200    	.word	#0xf2400200
      9e: f2c0 0200    	.word	#0xf2c00200
      a2: 2123         	movs	r1, #0x23
      a4: f7ff fffe    	bl	0xa4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h430a6baa579f62a2+0xa4> @ imm = #-0x4
      a8: defe         	trap

Disassembly of section .text._ZN13stm32f4xx_hal4gpio7convert62_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$4mode28_$u7b$$u7b$closure$u7d$$u7d$17h5d195269f9628d9bE:

00000000 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h5d195269f9628d9b>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f50    	.word	#0xf1bc0f50
      10: da02         	bge	0x18 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h5d195269f9628d9b+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0014         	movs	r4, r2
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b092         	sub	sp, #0x48
      1e: 9304         	str	r3, [sp, #0x10]
      20: 9007         	str	r0, [sp, #0x1c]
      22: 9108         	str	r1, [sp, #0x20]
      24: 9209         	str	r2, [sp, #0x24]
      26: 930a         	str	r3, [sp, #0x28]
      28: 920b         	str	r2, [sp, #0x2c]
      2a: 920c         	str	r2, [sp, #0x30]
      2c: 6810         	ldr	r0, [r2]
      2e: 9005         	str	r0, [sp, #0x14]
      30: 9807         	ldr	r0, [sp, #0x1c]
      32: 7800         	ldrb	r0, [r0]
      34: 4601         	mov	r1, r0
      36: 9106         	str	r1, [sp, #0x18]
      38: 281f         	cmp	r0, #0x1f
      3a: d812         	bhi	0x62 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h5d195269f9628d9b+0x62> @ imm = #0x24
      3c: e7ff         	b	0x3e <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h5d195269f9628d9b+0x3e> @ imm = #-0x2
      3e: 9805         	ldr	r0, [sp, #0x14]
      40: 9906         	ldr	r1, [sp, #0x18]
      42: f001 021f    	.word	#0xf001021f
      46: 210f         	movs	r1, #0xf
      48: 4091         	lsls	r1, r2
      4a: 4388         	bics	r0, r1
      4c: 9001         	str	r0, [sp, #0x4]
      4e: 9807         	ldr	r0, [sp, #0x1c]
      50: 9908         	ldr	r1, [sp, #0x20]
      52: 6809         	ldr	r1, [r1]
      54: 9102         	str	r1, [sp, #0x8]
      56: 7800         	ldrb	r0, [r0]
      58: 4601         	mov	r1, r0
      5a: 9103         	str	r1, [sp, #0xc]
      5c: 2820         	cmp	r0, #0x20
      5e: d30c         	blo	0x7a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h5d195269f9628d9b+0x7a> @ imm = #0x18
      60: e01b         	b	0x9a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h5d195269f9628d9b+0x9a> @ imm = #0x36
      62: f240 0000    	.word	#0xf2400000
      66: f2c0 0000    	.word	#0xf2c00000
      6a: f240 0200    	.word	#0xf2400200
      6e: f2c0 0200    	.word	#0xf2c00200
      72: 2123         	movs	r1, #0x23
      74: f7ff fffe    	bl	0x74 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h5d195269f9628d9b+0x74> @ imm = #-0x4
      78: defe         	trap
      7a: 9804         	ldr	r0, [sp, #0x10]
      7c: 9901         	ldr	r1, [sp, #0x4]
      7e: 9a02         	ldr	r2, [sp, #0x8]
      80: 9b03         	ldr	r3, [sp, #0xc]
      82: f003 031f    	.word	#0xf003031f
      86: 409a         	lsls	r2, r3
      88: 4311         	orrs	r1, r2
      8a: 900d         	str	r0, [sp, #0x34]
      8c: 910e         	str	r1, [sp, #0x38]
      8e: 900f         	str	r0, [sp, #0x3c]
      90: 9110         	str	r1, [sp, #0x40]
      92: 6001         	str	r1, [r0]
      94: 9011         	str	r0, [sp, #0x44]
      96: b012         	add	sp, #0x48
      98: bd80         	pop	{r7, pc}
      9a: f240 0000    	.word	#0xf2400000
      9e: f2c0 0000    	.word	#0xf2c00000
      a2: f240 0200    	.word	#0xf2400200
      a6: f2c0 0200    	.word	#0xf2c00200
      aa: 2123         	movs	r1, #0x23
      ac: f7ff fffe    	bl	0xac <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h5d195269f9628d9b+0xac> @ imm = #-0x4
      b0: defe         	trap

Disassembly of section .text._ZN13stm32f4xx_hal4gpio7convert62_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$4mode28_$u7b$$u7b$closure$u7d$$u7d$17h73b4808041e59d8cE:

00000000 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h73b4808041e59d8c>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f50    	.word	#0xf1bc0f50
      10: da02         	bge	0x18 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h73b4808041e59d8c+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0014         	movs	r4, r2
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b092         	sub	sp, #0x48
      1e: 9304         	str	r3, [sp, #0x10]
      20: 9007         	str	r0, [sp, #0x1c]
      22: 9108         	str	r1, [sp, #0x20]
      24: 9209         	str	r2, [sp, #0x24]
      26: 930a         	str	r3, [sp, #0x28]
      28: 920b         	str	r2, [sp, #0x2c]
      2a: 920c         	str	r2, [sp, #0x30]
      2c: 6810         	ldr	r0, [r2]
      2e: 9005         	str	r0, [sp, #0x14]
      30: 9807         	ldr	r0, [sp, #0x1c]
      32: 7800         	ldrb	r0, [r0]
      34: 4601         	mov	r1, r0
      36: 9106         	str	r1, [sp, #0x18]
      38: 281f         	cmp	r0, #0x1f
      3a: d812         	bhi	0x62 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h73b4808041e59d8c+0x62> @ imm = #0x24
      3c: e7ff         	b	0x3e <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h73b4808041e59d8c+0x3e> @ imm = #-0x2
      3e: 9805         	ldr	r0, [sp, #0x14]
      40: 9906         	ldr	r1, [sp, #0x18]
      42: f001 021f    	.word	#0xf001021f
      46: 210f         	movs	r1, #0xf
      48: 4091         	lsls	r1, r2
      4a: 4388         	bics	r0, r1
      4c: 9001         	str	r0, [sp, #0x4]
      4e: 9807         	ldr	r0, [sp, #0x1c]
      50: 9908         	ldr	r1, [sp, #0x20]
      52: 6809         	ldr	r1, [r1]
      54: 9102         	str	r1, [sp, #0x8]
      56: 7800         	ldrb	r0, [r0]
      58: 4601         	mov	r1, r0
      5a: 9103         	str	r1, [sp, #0xc]
      5c: 2820         	cmp	r0, #0x20
      5e: d30c         	blo	0x7a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h73b4808041e59d8c+0x7a> @ imm = #0x18
      60: e01b         	b	0x9a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h73b4808041e59d8c+0x9a> @ imm = #0x36
      62: f240 0000    	.word	#0xf2400000
      66: f2c0 0000    	.word	#0xf2c00000
      6a: f240 0200    	.word	#0xf2400200
      6e: f2c0 0200    	.word	#0xf2c00200
      72: 2123         	movs	r1, #0x23
      74: f7ff fffe    	bl	0x74 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h73b4808041e59d8c+0x74> @ imm = #-0x4
      78: defe         	trap
      7a: 9804         	ldr	r0, [sp, #0x10]
      7c: 9901         	ldr	r1, [sp, #0x4]
      7e: 9a02         	ldr	r2, [sp, #0x8]
      80: 9b03         	ldr	r3, [sp, #0xc]
      82: f003 031f    	.word	#0xf003031f
      86: 409a         	lsls	r2, r3
      88: 4311         	orrs	r1, r2
      8a: 900d         	str	r0, [sp, #0x34]
      8c: 910e         	str	r1, [sp, #0x38]
      8e: 900f         	str	r0, [sp, #0x3c]
      90: 9110         	str	r1, [sp, #0x40]
      92: 6001         	str	r1, [r0]
      94: 9011         	str	r0, [sp, #0x44]
      96: b012         	add	sp, #0x48
      98: bd80         	pop	{r7, pc}
      9a: f240 0000    	.word	#0xf2400000
      9e: f2c0 0000    	.word	#0xf2c00000
      a2: f240 0200    	.word	#0xf2400200
      a6: f2c0 0200    	.word	#0xf2c00200
      aa: 2123         	movs	r1, #0x23
      ac: f7ff fffe    	bl	0xac <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h73b4808041e59d8c+0xac> @ imm = #-0x4
      b0: defe         	trap

Disassembly of section .text._ZN13stm32f4xx_hal4gpio7convert62_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$4mode28_$u7b$$u7b$closure$u7d$$u7d$17h8af4fd1a0cdd876fE:

00000000 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h8af4fd1a0cdd876f>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f2c    	.word	#0xf1bc0f2c
      10: da02         	bge	0x18 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h8af4fd1a0cdd876f+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 000b         	movs	r3, r1
      16: 0000         	movs	r0, r0
      18: b08b         	sub	sp, #0x2c
      1a: 9200         	str	r2, [sp]
      1c: 4602         	mov	r2, r0
      1e: 9800         	ldr	r0, [sp]
      20: 9201         	str	r2, [sp, #0x4]
      22: 9102         	str	r1, [sp, #0x8]
      24: 9003         	str	r0, [sp, #0xc]
      26: 9109         	str	r1, [sp, #0x24]
      28: 9104         	str	r1, [sp, #0x10]
      2a: 6809         	ldr	r1, [r1]
      2c: f421 6180    	.word	#0xf4216180
      30: 9a01         	ldr	r2, [sp, #0x4]
      32: 6812         	ldr	r2, [r2]
      34: ea41 2182    	.word	#0xea412182
      38: 9005         	str	r0, [sp, #0x14]
      3a: 9106         	str	r1, [sp, #0x18]
      3c: 9007         	str	r0, [sp, #0x1c]
      3e: 9108         	str	r1, [sp, #0x20]
      40: 6001         	str	r1, [r0]
      42: 900a         	str	r0, [sp, #0x28]
      44: b00b         	add	sp, #0x2c
      46: 4770         	bx	lr

Disassembly of section .text._ZN13stm32f4xx_hal4gpio7convert62_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$4mode28_$u7b$$u7b$closure$u7d$$u7d$17h926f32f74f4e92b8E:

00000000 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h926f32f74f4e92b8>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f48    	.word	#0xf1bc0f48
      10: da02         	bge	0x18 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h926f32f74f4e92b8+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0012         	movs	r2, r2
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b090         	sub	sp, #0x40
      1e: 9203         	str	r2, [sp, #0xc]
      20: 9006         	str	r0, [sp, #0x18]
      22: 9107         	str	r1, [sp, #0x1c]
      24: 9208         	str	r2, [sp, #0x20]
      26: 9109         	str	r1, [sp, #0x24]
      28: 910a         	str	r1, [sp, #0x28]
      2a: 6808         	ldr	r0, [r1]
      2c: 9004         	str	r0, [sp, #0x10]
      2e: 9806         	ldr	r0, [sp, #0x18]
      30: 7800         	ldrb	r0, [r0]
      32: 4601         	mov	r1, r0
      34: 9105         	str	r1, [sp, #0x14]
      36: 281f         	cmp	r0, #0x1f
      38: d80f         	bhi	0x5a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h926f32f74f4e92b8+0x5a> @ imm = #0x1e
      3a: e7ff         	b	0x3c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h926f32f74f4e92b8+0x3c> @ imm = #-0x2
      3c: 9804         	ldr	r0, [sp, #0x10]
      3e: 9905         	ldr	r1, [sp, #0x14]
      40: f001 021f    	.word	#0xf001021f
      44: 2103         	movs	r1, #0x3
      46: 4091         	lsls	r1, r2
      48: 4388         	bics	r0, r1
      4a: 9001         	str	r0, [sp, #0x4]
      4c: 9806         	ldr	r0, [sp, #0x18]
      4e: 7800         	ldrb	r0, [r0]
      50: 4601         	mov	r1, r0
      52: 9102         	str	r1, [sp, #0x8]
      54: 2820         	cmp	r0, #0x20
      56: d30c         	blo	0x72 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h926f32f74f4e92b8+0x72> @ imm = #0x18
      58: e01b         	b	0x92 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h926f32f74f4e92b8+0x92> @ imm = #0x36
      5a: f240 0000    	.word	#0xf2400000
      5e: f2c0 0000    	.word	#0xf2c00000
      62: f240 0200    	.word	#0xf2400200
      66: f2c0 0200    	.word	#0xf2c00200
      6a: 2123         	movs	r1, #0x23
      6c: f7ff fffe    	bl	0x6c <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h926f32f74f4e92b8+0x6c> @ imm = #-0x4
      70: defe         	trap
      72: 9803         	ldr	r0, [sp, #0xc]
      74: 9901         	ldr	r1, [sp, #0x4]
      76: 9a02         	ldr	r2, [sp, #0x8]
      78: f002 031f    	.word	#0xf002031f
      7c: 2202         	movs	r2, #0x2
      7e: 409a         	lsls	r2, r3
      80: 4311         	orrs	r1, r2
      82: 900b         	str	r0, [sp, #0x2c]
      84: 910c         	str	r1, [sp, #0x30]
      86: 900d         	str	r0, [sp, #0x34]
      88: 910e         	str	r1, [sp, #0x38]
      8a: 6001         	str	r1, [r0]
      8c: 900f         	str	r0, [sp, #0x3c]
      8e: b010         	add	sp, #0x40
      90: bd80         	pop	{r7, pc}
      92: f240 0000    	.word	#0xf2400000
      96: f2c0 0000    	.word	#0xf2c00000
      9a: f240 0200    	.word	#0xf2400200
      9e: f2c0 0200    	.word	#0xf2c00200
      a2: 2123         	movs	r1, #0x23
      a4: f7ff fffe    	bl	0xa4 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::h926f32f74f4e92b8+0xa4> @ imm = #-0x4
      a8: defe         	trap

Disassembly of section .text._ZN13stm32f4xx_hal4gpio7convert62_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$4mode28_$u7b$$u7b$closure$u7d$$u7d$17hd8f2ef8492114bbdE:

00000000 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::hd8f2ef8492114bbd>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f2c    	.word	#0xf1bc0f2c
      10: da02         	bge	0x18 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::hd8f2ef8492114bbd+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 000b         	movs	r3, r1
      16: 0000         	movs	r0, r0
      18: b08b         	sub	sp, #0x2c
      1a: 9200         	str	r2, [sp]
      1c: 4602         	mov	r2, r0
      1e: 9800         	ldr	r0, [sp]
      20: 9201         	str	r2, [sp, #0x4]
      22: 9102         	str	r1, [sp, #0x8]
      24: 9003         	str	r0, [sp, #0xc]
      26: 9109         	str	r1, [sp, #0x24]
      28: 9104         	str	r1, [sp, #0x10]
      2a: 6809         	ldr	r1, [r1]
      2c: f421 7100    	.word	#0xf4217100
      30: 9a01         	ldr	r2, [sp, #0x4]
      32: 6812         	ldr	r2, [r2]
      34: ea41 2142    	.word	#0xea412142
      38: 9005         	str	r0, [sp, #0x14]
      3a: 9106         	str	r1, [sp, #0x18]
      3c: 9007         	str	r0, [sp, #0x1c]
      3e: 9108         	str	r1, [sp, #0x20]
      40: 6001         	str	r1, [r0]
      42: 900a         	str	r0, [sp, #0x28]
      44: b00b         	add	sp, #0x2c
      46: 4770         	bx	lr

Disassembly of section .text._ZN13stm32f4xx_hal4gpio7convert62_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$4mode28_$u7b$$u7b$closure$u7d$$u7d$17hda1212793ee90633E:

00000000 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::hda1212793ee90633>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f50    	.word	#0xf1bc0f50
      10: da02         	bge	0x18 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::hda1212793ee90633+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0014         	movs	r4, r2
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b092         	sub	sp, #0x48
      1e: 9304         	str	r3, [sp, #0x10]
      20: 9007         	str	r0, [sp, #0x1c]
      22: 9108         	str	r1, [sp, #0x20]
      24: 9209         	str	r2, [sp, #0x24]
      26: 930a         	str	r3, [sp, #0x28]
      28: 920b         	str	r2, [sp, #0x2c]
      2a: 920c         	str	r2, [sp, #0x30]
      2c: 6810         	ldr	r0, [r2]
      2e: 9005         	str	r0, [sp, #0x14]
      30: 9807         	ldr	r0, [sp, #0x1c]
      32: 7800         	ldrb	r0, [r0]
      34: 4601         	mov	r1, r0
      36: 9106         	str	r1, [sp, #0x18]
      38: 281f         	cmp	r0, #0x1f
      3a: d812         	bhi	0x62 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::hda1212793ee90633+0x62> @ imm = #0x24
      3c: e7ff         	b	0x3e <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::hda1212793ee90633+0x3e> @ imm = #-0x2
      3e: 9805         	ldr	r0, [sp, #0x14]
      40: 9906         	ldr	r1, [sp, #0x18]
      42: f001 021f    	.word	#0xf001021f
      46: 210f         	movs	r1, #0xf
      48: 4091         	lsls	r1, r2
      4a: 4388         	bics	r0, r1
      4c: 9001         	str	r0, [sp, #0x4]
      4e: 9807         	ldr	r0, [sp, #0x1c]
      50: 9908         	ldr	r1, [sp, #0x20]
      52: 6809         	ldr	r1, [r1]
      54: 9102         	str	r1, [sp, #0x8]
      56: 7800         	ldrb	r0, [r0]
      58: 4601         	mov	r1, r0
      5a: 9103         	str	r1, [sp, #0xc]
      5c: 2820         	cmp	r0, #0x20
      5e: d30c         	blo	0x7a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::hda1212793ee90633+0x7a> @ imm = #0x18
      60: e01b         	b	0x9a <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::hda1212793ee90633+0x9a> @ imm = #0x36
      62: f240 0000    	.word	#0xf2400000
      66: f2c0 0000    	.word	#0xf2c00000
      6a: f240 0200    	.word	#0xf2400200
      6e: f2c0 0200    	.word	#0xf2c00200
      72: 2123         	movs	r1, #0x23
      74: f7ff fffe    	bl	0x74 <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::hda1212793ee90633+0x74> @ imm = #-0x4
      78: defe         	trap
      7a: 9804         	ldr	r0, [sp, #0x10]
      7c: 9901         	ldr	r1, [sp, #0x4]
      7e: 9a02         	ldr	r2, [sp, #0x8]
      80: 9b03         	ldr	r3, [sp, #0xc]
      82: f003 031f    	.word	#0xf003031f
      86: 409a         	lsls	r2, r3
      88: 4311         	orrs	r1, r2
      8a: 900d         	str	r0, [sp, #0x34]
      8c: 910e         	str	r1, [sp, #0x38]
      8e: 900f         	str	r0, [sp, #0x3c]
      90: 9110         	str	r1, [sp, #0x40]
      92: 6001         	str	r1, [r0]
      94: 9011         	str	r0, [sp, #0x44]
      96: b012         	add	sp, #0x48
      98: bd80         	pop	{r7, pc}
      9a: f240 0000    	.word	#0xf2400000
      9e: f2c0 0000    	.word	#0xf2c00000
      a2: f240 0200    	.word	#0xf2400200
      a6: f2c0 0200    	.word	#0xf2c00200
      aa: 2123         	movs	r1, #0x23
      ac: f7ff fffe    	bl	0xac <stm32f4xx_hal::gpio::convert::_$LT$impl$u20$stm32f4xx_hal..gpio..Pin$LT$_$C$_$C$MODE$GT$$GT$::mode::_$u7b$$u7b$closure$u7d$$u7d$::hda1212793ee90633+0xac> @ imm = #-0x4
      b0: defe         	trap

Disassembly of section .text._ZN13stm32f4xx_hal6serial10uart_impls106_$LT$impl$u20$stm32f4xx_hal..serial..RxListen$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$UART$C$WORD$GT$$GT$6listen17h9bae551ef30851edE:

00000000 <stm32f4xx_hal::serial::uart_impls::_$LT$impl$u20$stm32f4xx_hal..serial..RxListen$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$UART$C$WORD$GT$$GT$::listen::h9bae551ef30851ed>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f30    	.word	#0xf1bc0f30
      10: da02         	bge	0x18 <stm32f4xx_hal::serial::uart_impls::_$LT$impl$u20$stm32f4xx_hal..serial..RxListen$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$UART$C$WORD$GT$$GT$::listen::h9bae551ef30851ed+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 000c         	movs	r4, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b08a         	sub	sp, #0x28
      1e: 9003         	str	r0, [sp, #0xc]
      20: f7ff fffe    	bl	0x20 <stm32f4xx_hal::serial::uart_impls::_$LT$impl$u20$stm32f4xx_hal..serial..RxListen$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$UART$C$WORD$GT$$GT$::listen::h9bae551ef30851ed+0x20> @ imm = #-0x4
      24: 9002         	str	r0, [sp, #0x8]
      26: 9009         	str	r0, [sp, #0x24]
      28: 2000         	movs	r0, #0x0
      2a: 9004         	str	r0, [sp, #0x10]
      2c: 2020         	movs	r0, #0x20
      2e: 9008         	str	r0, [sp, #0x20]
      30: 9808         	ldr	r0, [sp, #0x20]
      32: f7ff fffe    	bl	0x32 <stm32f4xx_hal::serial::uart_impls::_$LT$impl$u20$stm32f4xx_hal..serial..RxListen$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$UART$C$WORD$GT$$GT$::listen::h9bae551ef30851ed+0x32> @ imm = #-0x4
      36: 4601         	mov	r1, r0
      38: 9802         	ldr	r0, [sp, #0x8]
      3a: 9107         	str	r1, [sp, #0x1c]
      3c: 2101         	movs	r1, #0x1
      3e: 9106         	str	r1, [sp, #0x18]
      40: 9904         	ldr	r1, [sp, #0x10]
      42: 9a05         	ldr	r2, [sp, #0x14]
      44: 9b06         	ldr	r3, [sp, #0x18]
      46: f8dd c01c    	.word	#0xf8ddc01c
      4a: 46ee         	mov	lr, sp
      4c: f8ce c000    	.word	#0xf8cec000
      50: f7ff fffe    	bl	0x50 <stm32f4xx_hal::serial::uart_impls::_$LT$impl$u20$stm32f4xx_hal..serial..RxListen$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$UART$C$WORD$GT$$GT$::listen::h9bae551ef30851ed+0x50> @ imm = #-0x4
      54: b00a         	add	sp, #0x28
      56: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN13stm32f4xx_hal6serial10uart_impls17RegisterBlockImpl7read_u817h170b886b3169879aE:

00000000 <stm32f4xx_hal::serial::uart_impls::RegisterBlockImpl::read_u8::h170b886b3169879a>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f18    	.word	#0xf1bc0f18
      10: da02         	bge	0x18 <stm32f4xx_hal::serial::uart_impls::RegisterBlockImpl::read_u8::h170b886b3169879a+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0006         	movs	r6, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b084         	sub	sp, #0x10
      1e: 9002         	str	r0, [sp, #0x8]
      20: f7ff fffe    	bl	0x20 <stm32f4xx_hal::serial::uart_impls::RegisterBlockImpl::read_u8::h170b886b3169879a+0x20> @ imm = #-0x4
      24: 9003         	str	r0, [sp, #0xc]
      26: 9803         	ldr	r0, [sp, #0xc]
      28: 9001         	str	r0, [sp, #0x4]
      2a: 9801         	ldr	r0, [sp, #0x4]
      2c: f7ff fffe    	bl	0x2c <stm32f4xx_hal::serial::uart_impls::RegisterBlockImpl::read_u8::h170b886b3169879a+0x2c> @ imm = #-0x4
      30: f000 0001    	.word	#0xf0000001
      34: b004         	add	sp, #0x10
      36: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN13stm32f4xx_hal6serial10uart_impls17RegisterBlockImpl7read_u828_$u7b$$u7b$closure$u7d$$u7d$17hffcf53c18debfc21E:

00000000 <stm32f4xx_hal::serial::uart_impls::RegisterBlockImpl::read_u8::_$u7b$$u7b$closure$u7d$$u7d$::hffcf53c18debfc21>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f04    	.word	#0xf1bc0f04
      10: da02         	bge	0x18 <stm32f4xx_hal::serial::uart_impls::RegisterBlockImpl::read_u8::_$u7b$$u7b$closure$u7d$$u7d$::hffcf53c18debfc21+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0001         	movs	r1, r0
      16: 0000         	movs	r0, r0
      18: b081         	sub	sp, #0x4
      1a: f8ad 0002    	.word	#0xf8ad0002
      1e: b001         	add	sp, #0x4
      20: 4770         	bx	lr

Disassembly of section .text._ZN13stm32f4xx_hal6serial10uart_impls67_$LT$impl$u20$stm32f4xx_hal..serial..SerialExt$u20$for$u20$UART$GT$6serial17h15f2789615863e35E:

00000000 <stm32f4xx_hal::serial::uart_impls::_$LT$impl$u20$stm32f4xx_hal..serial..SerialExt$u20$for$u20$UART$GT$::serial::h15f2789615863e35>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <stm32f4xx_hal::serial::uart_impls::_$LT$impl$u20$stm32f4xx_hal..serial..SerialExt$u20$for$u20$UART$GT$::serial::h15f2789615863e35+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9101         	str	r1, [sp, #0x4]
      20: f7ff fffe    	bl	0x20 <stm32f4xx_hal::serial::uart_impls::_$LT$impl$u20$stm32f4xx_hal..serial..SerialExt$u20$for$u20$UART$GT$::serial::h15f2789615863e35+0x20> @ imm = #-0x4
      24: b002         	add	sp, #0x8
      26: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN13stm32f4xx_hal6serial21Rx$LT$UART$C$WORD$GT$3new17h19e2997121d98ef1E:

00000000 <stm32f4xx_hal::serial::Rx$LT$UART$C$WORD$GT$::new::h19e2997121d98ef1>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f04    	.word	#0xf1bc0f04
      10: da02         	bge	0x18 <stm32f4xx_hal::serial::Rx$LT$UART$C$WORD$GT$::new::h19e2997121d98ef1+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0001         	movs	r1, r0
      16: 0000         	movs	r0, r0
      18: b081         	sub	sp, #0x4
      1a: f88d 0003    	.word	#0xf88d0003
      1e: f88d 0002    	.word	#0xf88d0002
      22: f89d 0002    	.word	#0xf89d0002
      26: b001         	add	sp, #0x4
      28: 4770         	bx	lr

Disassembly of section .text._ZN13stm32f4xx_hal6serial21Tx$LT$UART$C$WORD$GT$3new17h00434b06bd415e33E:

00000000 <stm32f4xx_hal::serial::Tx$LT$UART$C$WORD$GT$::new::h00434b06bd415e33>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f04    	.word	#0xf1bc0f04
      10: da02         	bge	0x18 <stm32f4xx_hal::serial::Tx$LT$UART$C$WORD$GT$::new::h00434b06bd415e33+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0001         	movs	r1, r0
      16: 0000         	movs	r0, r0
      18: b081         	sub	sp, #0x4
      1a: f88d 0003    	.word	#0xf88d0003
      1e: f88d 0001    	.word	#0xf88d0001
      22: f89d 0001    	.word	#0xf89d0001
      26: b001         	add	sp, #0x4
      28: 4770         	bx	lr

Disassembly of section .text._ZN13stm32f4xx_hal6serial25Serial$LT$UART$C$WORD$GT$5split17h8a9337e78b020436E:

00000000 <stm32f4xx_hal::serial::Serial$LT$UART$C$WORD$GT$::split::h8a9337e78b020436>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f04    	.word	#0xf1bc0f04
      10: da02         	bge	0x18 <stm32f4xx_hal::serial::Serial$LT$UART$C$WORD$GT$::split::h8a9337e78b020436+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0001         	movs	r1, r0
      16: 0000         	movs	r0, r0
      18: b081         	sub	sp, #0x4
      1a: f88d 0002    	.word	#0xf88d0002
      1e: f88d 1003    	.word	#0xf88d1003
      22: f88d 0000    	.word	#0xf88d0000
      26: f88d 1001    	.word	#0xf88d1001
      2a: f89d 0000    	.word	#0xf89d0000
      2e: f89d 1001    	.word	#0xf89d1001
      32: b001         	add	sp, #0x4
      34: 4770         	bx	lr

Disassembly of section .text._ZN13stm32f4xx_hal6serial26Serial$LT$USART$C$WORD$GT$3new17hf50362602b28d9d7E:

00000000 <stm32f4xx_hal::serial::Serial$LT$USART$C$WORD$GT$::new::hf50362602b28d9d7>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <stm32f4xx_hal::serial::Serial$LT$USART$C$WORD$GT$::new::hf50362602b28d9d7+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9101         	str	r1, [sp, #0x4]
      20: f7ff fffe    	bl	0x20 <stm32f4xx_hal::serial::Serial$LT$USART$C$WORD$GT$::new::hf50362602b28d9d7+0x20> @ imm = #-0x4
      24: b002         	add	sp, #0x8
      26: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN13stm32f4xx_hal6serial5hal_12nb98_$LT$impl$u20$embedded_hal_nb..serial..Read$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$USART$GT$$GT$4read17hf4d9590fa6c6aeeaE:

00000000 <stm32f4xx_hal::serial::hal_1::nb::_$LT$impl$u20$embedded_hal_nb..serial..Read$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$USART$GT$$GT$::read::hf4d9590fa6c6aeea>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <stm32f4xx_hal::serial::hal_1::nb::_$LT$impl$u20$embedded_hal_nb..serial..Read$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$USART$GT$$GT$::read::hf4d9590fa6c6aeea+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9001         	str	r0, [sp, #0x4]
      20: f7ff fffe    	bl	0x20 <stm32f4xx_hal::serial::hal_1::nb::_$LT$impl$u20$embedded_hal_nb..serial..Read$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$USART$GT$$GT$::read::hf4d9590fa6c6aeea+0x20> @ imm = #-0x4
      24: f7ff fffe    	bl	0x24 <stm32f4xx_hal::serial::hal_1::nb::_$LT$impl$u20$embedded_hal_nb..serial..Read$u20$for$u20$stm32f4xx_hal..serial..Rx$LT$USART$GT$$GT$::read::hf4d9590fa6c6aeea+0x24> @ imm = #-0x4
      28: f000 0001    	.word	#0xf0000001
      2c: b002         	add	sp, #0x8
      2e: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN194_$LT$stm32f4xx_hal..gpio..alt..f4..usart1..Tx$LT$Otype$GT$$u20$as$u20$core..convert..From$LT$stm32f4xx_hal..gpio..Pin$LT$_$C$9_u8$C$stm32f4xx_hal..gpio..Alternate$LT$7_u8$C$Otype$GT$$GT$$GT$$GT$4from17h9f6fb9e45e20959eE:

00000000 <_$LT$stm32f4xx_hal..gpio..alt..f4..usart1..Tx$LT$Otype$GT$$u20$as$u20$core..convert..From$LT$stm32f4xx_hal..gpio..Pin$LT$_$C$9_u8$C$stm32f4xx_hal..gpio..Alternate$LT$7_u8$C$Otype$GT$$GT$$GT$$GT$::from::h9f6fb9e45e20959e>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f04    	.word	#0xf1bc0f04
      10: da02         	bge	0x18 <_$LT$stm32f4xx_hal..gpio..alt..f4..usart1..Tx$LT$Otype$GT$$u20$as$u20$core..convert..From$LT$stm32f4xx_hal..gpio..Pin$LT$_$C$9_u8$C$stm32f4xx_hal..gpio..Alternate$LT$7_u8$C$Otype$GT$$GT$$GT$$GT$::from::h9f6fb9e45e20959e+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0001         	movs	r1, r0
      16: 0000         	movs	r0, r0
      18: b081         	sub	sp, #0x4
      1a: 2001         	movs	r0, #0x1
      1c: f88d 0002    	.word	#0xf88d0002
      20: f89d 0002    	.word	#0xf89d0002
      24: b001         	add	sp, #0x4
      26: 4770         	bx	lr

Disassembly of section .text._ZN195_$LT$stm32f4xx_hal..gpio..alt..f4..usart1..Rx$LT$Otype$GT$$u20$as$u20$core..convert..From$LT$stm32f4xx_hal..gpio..Pin$LT$_$C$10_u8$C$stm32f4xx_hal..gpio..Alternate$LT$7_u8$C$Otype$GT$$GT$$GT$$GT$4from17h4c3fae5e85cf6eb4E:

00000000 <_$LT$stm32f4xx_hal..gpio..alt..f4..usart1..Rx$LT$Otype$GT$$u20$as$u20$core..convert..From$LT$stm32f4xx_hal..gpio..Pin$LT$_$C$10_u8$C$stm32f4xx_hal..gpio..Alternate$LT$7_u8$C$Otype$GT$$GT$$GT$$GT$::from::h4c3fae5e85cf6eb4>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f04    	.word	#0xf1bc0f04
      10: da02         	bge	0x18 <_$LT$stm32f4xx_hal..gpio..alt..f4..usart1..Rx$LT$Otype$GT$$u20$as$u20$core..convert..From$LT$stm32f4xx_hal..gpio..Pin$LT$_$C$10_u8$C$stm32f4xx_hal..gpio..Alternate$LT$7_u8$C$Otype$GT$$GT$$GT$$GT$::from::h4c3fae5e85cf6eb4+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0001         	movs	r1, r0
      16: 0000         	movs	r0, r0
      18: b081         	sub	sp, #0x4
      1a: 2001         	movs	r0, #0x1
      1c: f88d 0002    	.word	#0xf88d0002
      20: f89d 0002    	.word	#0xf89d0002
      24: b001         	add	sp, #0x4
      26: 4770         	bx	lr

Disassembly of section .text._ZN4core3cmp9PartialEq2ne17haf7aea9492c67e0fE:

00000000 <core::cmp::PartialEq::ne::haf7aea9492c67e0f>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <core::cmp::PartialEq::ne::haf7aea9492c67e0f+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9000         	str	r0, [sp]
      20: 9101         	str	r1, [sp, #0x4]
      22: f7ff fffe    	bl	0x22 <core::cmp::PartialEq::ne::haf7aea9492c67e0f+0x22> @ imm = #-0x4
      26: f080 0001    	.word	#0xf0800001
      2a: b002         	add	sp, #0x8
      2c: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core3cmp9PartialEq2ne17hfac51f5548d55407E:

00000000 <core::cmp::PartialEq::ne::hfac51f5548d55407>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <core::cmp::PartialEq::ne::hfac51f5548d55407+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9000         	str	r0, [sp]
      20: 9101         	str	r1, [sp, #0x4]
      22: f7ff fffe    	bl	0x22 <core::cmp::PartialEq::ne::hfac51f5548d55407+0x22> @ imm = #-0x4
      26: f080 0001    	.word	#0xf0800001
      2a: b002         	add	sp, #0x8
      2c: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core3fmt9Arguments6new_v117h85145dc557018133E:

00000000 <core::fmt::Arguments::new_v1::h85145dc557018133>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f58    	.word	#0xf1bc0f58
      10: da02         	bge	0x18 <core::fmt::Arguments::new_v1::h85145dc557018133+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0016         	movs	r6, r2
      16: 0001         	movs	r1, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b094         	sub	sp, #0x50
      1e: 9303         	str	r3, [sp, #0xc]
      20: 9204         	str	r2, [sp, #0x10]
      22: 9105         	str	r1, [sp, #0x14]
      24: 9006         	str	r0, [sp, #0x18]
      26: 68b8         	ldr	r0, [r7, #0x8]
      28: 9007         	str	r0, [sp, #0x1c]
      2a: 9110         	str	r1, [sp, #0x40]
      2c: 9211         	str	r2, [sp, #0x44]
      2e: 9312         	str	r3, [sp, #0x48]
      30: 9013         	str	r0, [sp, #0x4c]
      32: 4282         	cmp	r2, r0
      34: d307         	blo	0x46 <core::fmt::Arguments::new_v1::h85145dc557018133+0x46> @ imm = #0xe
      36: e7ff         	b	0x38 <core::fmt::Arguments::new_v1::h85145dc557018133+0x38> @ imm = #-0x2
      38: 9907         	ldr	r1, [sp, #0x1c]
      3a: 1c48         	adds	r0, r1, #0x1
      3c: 4602         	mov	r2, r0
      3e: 9202         	str	r2, [sp, #0x8]
      40: 4288         	cmp	r0, r1
      42: d316         	blo	0x72 <core::fmt::Arguments::new_v1::h85145dc557018133+0x72> @ imm = #0x2c
      44: e010         	b	0x68 <core::fmt::Arguments::new_v1::h85145dc557018133+0x68> @ imm = #0x20
      46: f240 0100    	.word	#0xf2400100
      4a: f2c0 0100    	.word	#0xf2c00100
      4e: a808         	add	r0, sp, #0x20
      50: 9001         	str	r0, [sp, #0x4]
      52: 2201         	movs	r2, #0x1
      54: f7ff fffe    	bl	0x54 <core::fmt::Arguments::new_v1::h85145dc557018133+0x54> @ imm = #-0x4
      58: 9801         	ldr	r0, [sp, #0x4]
      5a: f240 0100    	.word	#0xf2400100
      5e: f2c0 0100    	.word	#0xf2c00100
      62: f7ff fffe    	bl	0x62 <core::fmt::Arguments::new_v1::h85145dc557018133+0x62> @ imm = #-0x4
      66: defe         	trap
      68: 9804         	ldr	r0, [sp, #0x10]
      6a: 9902         	ldr	r1, [sp, #0x8]
      6c: 4288         	cmp	r0, r1
      6e: d8ea         	bhi	0x46 <core::fmt::Arguments::new_v1::h85145dc557018133+0x46> @ imm = #-0x2c
      70: e00b         	b	0x8a <core::fmt::Arguments::new_v1::h85145dc557018133+0x8a> @ imm = #0x16
      72: f240 0000    	.word	#0xf2400000
      76: f2c0 0000    	.word	#0xf2c00000
      7a: f240 0200    	.word	#0xf2400200
      7e: f2c0 0200    	.word	#0xf2c00200
      82: 211c         	movs	r1, #0x1c
      84: f7ff fffe    	bl	0x84 <core::fmt::Arguments::new_v1::h85145dc557018133+0x84> @ imm = #-0x4
      88: defe         	trap
      8a: 9807         	ldr	r0, [sp, #0x1c]
      8c: 9906         	ldr	r1, [sp, #0x18]
      8e: 9a03         	ldr	r2, [sp, #0xc]
      90: 9b04         	ldr	r3, [sp, #0x10]
      92: f8dd c014    	.word	#0xf8ddc014
      96: f04f 0e00    	.word	#0xf04f0e00
      9a: f8cd e038    	.word	#0xf8cde038
      9e: f8c1 c000    	.word	#0xf8c1c000
      a2: 604b         	str	r3, [r1, #0x4]
      a4: f8dd c038    	.word	#0xf8ddc038
      a8: 9b0f         	ldr	r3, [sp, #0x3c]
      aa: f8c1 c010    	.word	#0xf8c1c010
      ae: 614b         	str	r3, [r1, #0x14]
      b0: 608a         	str	r2, [r1, #0x8]
      b2: 60c8         	str	r0, [r1, #0xc]
      b4: b014         	add	sp, #0x50
      b6: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core3fmt9Arguments9new_const17h8a485cf611802ce9E:

00000000 <core::fmt::Arguments::new_const::h8a485cf611802ce9>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f40    	.word	#0xf1bc0f40
      10: da02         	bge	0x18 <core::fmt::Arguments::new_const::h8a485cf611802ce9+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0010         	movs	r0, r2
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b08e         	sub	sp, #0x38
      1e: 9201         	str	r2, [sp, #0x4]
      20: 9102         	str	r1, [sp, #0x8]
      22: 9003         	str	r0, [sp, #0xc]
      24: 910c         	str	r1, [sp, #0x30]
      26: 920d         	str	r2, [sp, #0x34]
      28: 2a01         	cmp	r2, #0x1
      2a: d813         	bhi	0x54 <core::fmt::Arguments::new_const::h8a485cf611802ce9+0x54> @ imm = #0x26
      2c: e7ff         	b	0x2e <core::fmt::Arguments::new_const::h8a485cf611802ce9+0x2e> @ imm = #-0x2
      2e: 9903         	ldr	r1, [sp, #0xc]
      30: 9a01         	ldr	r2, [sp, #0x4]
      32: 9b02         	ldr	r3, [sp, #0x8]
      34: 2000         	movs	r0, #0x0
      36: 900a         	str	r0, [sp, #0x28]
      38: 600b         	str	r3, [r1]
      3a: 604a         	str	r2, [r1, #0x4]
      3c: 9b0a         	ldr	r3, [sp, #0x28]
      3e: 9a0b         	ldr	r2, [sp, #0x2c]
      40: 610b         	str	r3, [r1, #0x10]
      42: 614a         	str	r2, [r1, #0x14]
      44: f240 0200    	.word	#0xf2400200
      48: f2c0 0200    	.word	#0xf2c00200
      4c: 608a         	str	r2, [r1, #0x8]
      4e: 60c8         	str	r0, [r1, #0xc]
      50: b00e         	add	sp, #0x38
      52: bd80         	pop	{r7, pc}
      54: f240 0100    	.word	#0xf2400100
      58: f2c0 0100    	.word	#0xf2c00100
      5c: a804         	add	r0, sp, #0x10
      5e: 9000         	str	r0, [sp]
      60: 2201         	movs	r2, #0x1
      62: f7ff ffcd    	bl	0x0 <core::fmt::Arguments::new_const::h8a485cf611802ce9> @ imm = #-0x66
      66: 9800         	ldr	r0, [sp]
      68: f240 0100    	.word	#0xf2400100
      6c: f2c0 0100    	.word	#0xf2c00100
      70: f7ff fffe    	bl	0x70 <core::fmt::Arguments::new_const::h8a485cf611802ce9+0x70> @ imm = #-0x4
      74: defe         	trap

Disassembly of section .text._ZN4core3ptr156drop_in_place$LT$hopter..sync..suspend_scheduler..RefCellSchedSafe$LT$hopter..sync..interruptable..Interruptable$LT$hopter..sync..mailbox..Inner$GT$$GT$$GT$17hfe80b3c79bd2723fE:

00000000 <core::ptr::drop_in_place$LT$hopter..sync..suspend_scheduler..RefCellSchedSafe$LT$hopter..sync..interruptable..Interruptable$LT$hopter..sync..mailbox..Inner$GT$$GT$$GT$::hfe80b3c79bd2723f>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <core::ptr::drop_in_place$LT$hopter..sync..suspend_scheduler..RefCellSchedSafe$LT$hopter..sync..interruptable..Interruptable$LT$hopter..sync..mailbox..Inner$GT$$GT$$GT$::hfe80b3c79bd2723f+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9001         	str	r0, [sp, #0x4]
      20: f7ff fffe    	bl	0x20 <core::ptr::drop_in_place$LT$hopter..sync..suspend_scheduler..RefCellSchedSafe$LT$hopter..sync..interruptable..Interruptable$LT$hopter..sync..mailbox..Inner$GT$$GT$$GT$::hfe80b3c79bd2723f+0x20> @ imm = #-0x4
      24: b002         	add	sp, #0x8
      26: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core3ptr51drop_in_place$LT$hopter..sync..mailbox..Mailbox$GT$17h6eb7ffa88e39a05aE:

00000000 <core::ptr::drop_in_place$LT$hopter..sync..mailbox..Mailbox$GT$::h6eb7ffa88e39a05a>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <core::ptr::drop_in_place$LT$hopter..sync..mailbox..Mailbox$GT$::h6eb7ffa88e39a05a+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9001         	str	r0, [sp, #0x4]
      20: f7ff fffe    	bl	0x20 <core::ptr::drop_in_place$LT$hopter..sync..mailbox..Mailbox$GT$::h6eb7ffa88e39a05a+0x20> @ imm = #-0x4
      24: b002         	add	sp, #0x8
      26: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core3ptr65drop_in_place$LT$stm32f4xx_hal..serial..config..InvalidConfig$GT$17hfcd3730bb156d785E:

00000000 <core::ptr::drop_in_place$LT$stm32f4xx_hal..serial..config..InvalidConfig$GT$::hfcd3730bb156d785>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f04    	.word	#0xf1bc0f04
      10: da02         	bge	0x18 <core::ptr::drop_in_place$LT$stm32f4xx_hal..serial..config..InvalidConfig$GT$::hfcd3730bb156d785+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0001         	movs	r1, r0
      16: 0000         	movs	r0, r0
      18: b081         	sub	sp, #0x4
      1a: 9000         	str	r0, [sp]
      1c: b001         	add	sp, #0x4
      1e: 4770         	bx	lr

Disassembly of section .text._ZN4core3ptr66drop_in_place$LT$nb..Error$LT$stm32f4xx_hal..serial..Error$GT$$GT$17ha39f8fdbba268138E:

00000000 <core::ptr::drop_in_place$LT$nb..Error$LT$stm32f4xx_hal..serial..Error$GT$$GT$::ha39f8fdbba268138>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f04    	.word	#0xf1bc0f04
      10: da02         	bge	0x18 <core::ptr::drop_in_place$LT$nb..Error$LT$stm32f4xx_hal..serial..Error$GT$$GT$::ha39f8fdbba268138+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0001         	movs	r1, r0
      16: 0000         	movs	r0, r0
      18: b081         	sub	sp, #0x4
      1a: 9000         	str	r0, [sp]
      1c: b001         	add	sp, #0x4
      1e: 4770         	bx	lr

Disassembly of section .text._ZN4core3ptr6unique15Unique$LT$T$GT$13new_unchecked17h7fa3975c569e0885E:

00000000 <core::ptr::unique::Unique$LT$T$GT$::new_unchecked::h7fa3975c569e0885>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <core::ptr::unique::Unique$LT$T$GT$::new_unchecked::h7fa3975c569e0885+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9001         	str	r0, [sp, #0x4]
      20: f7ff fffe    	bl	0x20 <core::ptr::unique::Unique$LT$T$GT$::new_unchecked::h7fa3975c569e0885+0x20> @ imm = #-0x4
      24: 9000         	str	r0, [sp]
      26: 9800         	ldr	r0, [sp]
      28: b002         	add	sp, #0x8
      2a: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core3ptr79drop_in_place$LT$core..option..Option$LT$hopter..sync..mailbox..Mailbox$GT$$GT$17h68a0346e78be986eE:

00000000 <core::ptr::drop_in_place$LT$core..option..Option$LT$hopter..sync..mailbox..Mailbox$GT$$GT$::h68a0346e78be986e>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <core::ptr::drop_in_place$LT$core..option..Option$LT$hopter..sync..mailbox..Mailbox$GT$$GT$::h68a0346e78be986e+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9000         	str	r0, [sp]
      20: 9001         	str	r0, [sp, #0x4]
      22: 6800         	ldr	r0, [r0]
      24: b910         	cbnz	r0, 0x2c <core::ptr::drop_in_place$LT$core..option..Option$LT$hopter..sync..mailbox..Mailbox$GT$$GT$::h68a0346e78be986e+0x2c> @ imm = #0x4
      26: e7ff         	b	0x28 <core::ptr::drop_in_place$LT$core..option..Option$LT$hopter..sync..mailbox..Mailbox$GT$$GT$::h68a0346e78be986e+0x28> @ imm = #-0x2
      28: b002         	add	sp, #0x8
      2a: bd80         	pop	{r7, pc}
      2c: 9800         	ldr	r0, [sp]
      2e: 3004         	adds	r0, #0x4
      30: f7ff fffe    	bl	0x30 <core::ptr::drop_in_place$LT$core..option..Option$LT$hopter..sync..mailbox..Mailbox$GT$$GT$::h68a0346e78be986e+0x30> @ imm = #-0x4
      34: e7f8         	b	0x28 <core::ptr::drop_in_place$LT$core..option..Option$LT$hopter..sync..mailbox..Mailbox$GT$$GT$::h68a0346e78be986e+0x28> @ imm = #-0x10

Disassembly of section .text._ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$7is_null12runtime_impl17h592da8aaf0fa4f9cE:

00000000 <core::ptr::mut_ptr::_$LT$impl$u20$$BP$mut$u20$T$GT$::is_null::runtime_impl::h592da8aaf0fa4f9c>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f0c    	.word	#0xf1bc0f0c
      10: da02         	bge	0x18 <core::ptr::mut_ptr::_$LT$impl$u20$$BP$mut$u20$T$GT$::is_null::runtime_impl::h592da8aaf0fa4f9c+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0003         	movs	r3, r0
      16: 0000         	movs	r0, r0
      18: b083         	sub	sp, #0xc
      1a: 9000         	str	r0, [sp]
      1c: 9001         	str	r0, [sp, #0x4]
      1e: 9002         	str	r0, [sp, #0x8]
      20: fab0 f080    	.word	#0xfab0f080
      24: 0940         	lsrs	r0, r0, #0x5
      26: b003         	add	sp, #0xc
      28: 4770         	bx	lr

Disassembly of section .text._ZN4core3ptr7mut_ptr31_$LT$impl$u20$$BP$mut$u20$T$GT$7is_null17h261b3ebc6b4f129bE:

00000000 <core::ptr::mut_ptr::_$LT$impl$u20$$BP$mut$u20$T$GT$::is_null::h261b3ebc6b4f129b>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <core::ptr::mut_ptr::_$LT$impl$u20$$BP$mut$u20$T$GT$::is_null::h261b3ebc6b4f129b+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9001         	str	r0, [sp, #0x4]
      20: 9000         	str	r0, [sp]
      22: 9800         	ldr	r0, [sp]
      24: f7ff fffe    	bl	0x24 <core::ptr::mut_ptr::_$LT$impl$u20$$BP$mut$u20$T$GT$::is_null::h261b3ebc6b4f129b+0x24> @ imm = #-0x4
      28: b002         	add	sp, #0x8
      2a: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked17haf20622515fc1b5eE:

00000000 <core::ptr::non_null::NonNull$LT$T$GT$::new_unchecked::haf20622515fc1b5e>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f20    	.word	#0xf1bc0f20
      10: da02         	bge	0x18 <core::ptr::non_null::NonNull$LT$T$GT$::new_unchecked::haf20622515fc1b5e+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0008         	movs	r0, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b086         	sub	sp, #0x18
      1e: 9001         	str	r0, [sp, #0x4]
      20: 9004         	str	r0, [sp, #0x10]
      22: 2001         	movs	r0, #0x1
      24: b928         	cbnz	r0, 0x32 <core::ptr::non_null::NonNull$LT$T$GT$::new_unchecked::haf20622515fc1b5e+0x32> @ imm = #0xa
      26: e7ff         	b	0x28 <core::ptr::non_null::NonNull$LT$T$GT$::new_unchecked::haf20622515fc1b5e+0x28> @ imm = #-0x2
      28: 9801         	ldr	r0, [sp, #0x4]
      2a: 9002         	str	r0, [sp, #0x8]
      2c: 9802         	ldr	r0, [sp, #0x8]
      2e: b006         	add	sp, #0x18
      30: bd80         	pop	{r7, pc}
      32: 9801         	ldr	r0, [sp, #0x4]
      34: 9003         	str	r0, [sp, #0xc]
      36: 9803         	ldr	r0, [sp, #0xc]
      38: 9005         	str	r0, [sp, #0x14]
      3a: f7ff fffe    	bl	0x3a <core::ptr::non_null::NonNull$LT$T$GT$::new_unchecked::haf20622515fc1b5e+0x3a> @ imm = #-0x4
      3e: b140         	cbz	r0, 0x52 <core::ptr::non_null::NonNull$LT$T$GT$::new_unchecked::haf20622515fc1b5e+0x52> @ imm = #0x10
      40: e7ff         	b	0x42 <core::ptr::non_null::NonNull$LT$T$GT$::new_unchecked::haf20622515fc1b5e+0x42> @ imm = #-0x2
      42: f240 0000    	.word	#0xf2400000
      46: f2c0 0000    	.word	#0xf2c00000
      4a: 215d         	movs	r1, #0x5d
      4c: f7ff fffe    	bl	0x4c <core::ptr::non_null::NonNull$LT$T$GT$::new_unchecked::haf20622515fc1b5e+0x4c> @ imm = #-0x4
      50: defe         	trap
      52: e7e9         	b	0x28 <core::ptr::non_null::NonNull$LT$T$GT$::new_unchecked::haf20622515fc1b5e+0x28> @ imm = #-0x2e

Disassembly of section .text._ZN4core3ptr99drop_in_place$LT$hopter..sync..interruptable..Interruptable$LT$hopter..sync..mailbox..Inner$GT$$GT$17h0e5e39775fe33884E:

00000000 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..Interruptable$LT$hopter..sync..mailbox..Inner$GT$$GT$::h0e5e39775fe33884>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..Interruptable$LT$hopter..sync..mailbox..Inner$GT$$GT$::h0e5e39775fe33884+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9001         	str	r0, [sp, #0x4]
      20: f7ff fffe    	bl	0x20 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..Interruptable$LT$hopter..sync..mailbox..Inner$GT$$GT$::h0e5e39775fe33884+0x20> @ imm = #-0x4
      24: b002         	add	sp, #0x8
      26: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core4sync6atomic14compiler_fence17h1b6703cba8b438eeE:

00000000 <core::sync::atomic::compiler_fence::h1b6703cba8b438ee>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f30    	.word	#0xf1bc0f30
      10: da02         	bge	0x18 <core::sync::atomic::compiler_fence::h1b6703cba8b438ee+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 000c         	movs	r4, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b08a         	sub	sp, #0x28
      1e: f807 0c19    	.word	#0xf8070c19
      22: f817 0c19    	.word	#0xf8170c19
      26: 9002         	str	r0, [sp, #0x8]
      28: 9902         	ldr	r1, [sp, #0x8]
      2a: e8df f001    	.word	#0xe8dff001

0000002e <$d.48>:
      2e: 04 15 16 17  	.word	0x17161504
      32: 18 00        	.short	0x0018

00000034 <$t.49>:
      34: defe         	trap
      36: f240 0100    	.word	#0xf2400100
      3a: f2c0 0100    	.word	#0xf2c00100
      3e: a804         	add	r0, sp, #0x10
      40: 9001         	str	r0, [sp, #0x4]
      42: 2201         	movs	r2, #0x1
      44: f7ff fffe    	bl	0x44 <core::sync::atomic::compiler_fence::h1b6703cba8b438ee+0x44> @ imm = #-0x4
      48: 9801         	ldr	r0, [sp, #0x4]
      4a: f240 0100    	.word	#0xf2400100
      4e: f2c0 0100    	.word	#0xf2c00100
      52: f7ff fffe    	bl	0x52 <core::sync::atomic::compiler_fence::h1b6703cba8b438ee+0x52> @ imm = #-0x4
      56: defe         	trap
      58: e002         	b	0x60 <core::sync::atomic::compiler_fence::h1b6703cba8b438ee+0x60> @ imm = #0x4
      5a: e001         	b	0x60 <core::sync::atomic::compiler_fence::h1b6703cba8b438ee+0x60> @ imm = #0x2
      5c: e000         	b	0x60 <core::sync::atomic::compiler_fence::h1b6703cba8b438ee+0x60> @ imm = #0x0
      5e: e7ff         	b	0x60 <core::sync::atomic::compiler_fence::h1b6703cba8b438ee+0x60> @ imm = #-0x2
      60: b00a         	add	sp, #0x28
      62: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core6option15Option$LT$T$GT$6as_mut17h92369890894bdb1bE:

00000000 <core::option::Option$LT$T$GT$::as_mut::h92369890894bdb1b>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <core::option::Option$LT$T$GT$::as_mut::h92369890894bdb1b+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b084         	sub	sp, #0x10
      1a: 9000         	str	r0, [sp]
      1c: 9002         	str	r0, [sp, #0x8]
      1e: 6800         	ldr	r0, [r0]
      20: b918         	cbnz	r0, 0x2a <core::option::Option$LT$T$GT$::as_mut::h92369890894bdb1b+0x2a> @ imm = #0x6
      22: e7ff         	b	0x24 <core::option::Option$LT$T$GT$::as_mut::h92369890894bdb1b+0x24> @ imm = #-0x2
      24: 2000         	movs	r0, #0x0
      26: 9001         	str	r0, [sp, #0x4]
      28: e004         	b	0x34 <core::option::Option$LT$T$GT$::as_mut::h92369890894bdb1b+0x34> @ imm = #0x8
      2a: 9800         	ldr	r0, [sp]
      2c: 3004         	adds	r0, #0x4
      2e: 9003         	str	r0, [sp, #0xc]
      30: 9001         	str	r0, [sp, #0x4]
      32: e7ff         	b	0x34 <core::option::Option$LT$T$GT$::as_mut::h92369890894bdb1b+0x34> @ imm = #-0x2
      34: 9801         	ldr	r0, [sp, #0x4]
      36: b004         	add	sp, #0x10
      38: 4770         	bx	lr

Disassembly of section .text._ZN4core6option15Option$LT$T$GT$6as_mut17hf79fec48f02e0dc2E:

00000000 <core::option::Option$LT$T$GT$::as_mut::hf79fec48f02e0dc2>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <core::option::Option$LT$T$GT$::as_mut::hf79fec48f02e0dc2+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b084         	sub	sp, #0x10
      1a: 9000         	str	r0, [sp]
      1c: 9002         	str	r0, [sp, #0x8]
      1e: 7800         	ldrb	r0, [r0]
      20: 2803         	cmp	r0, #0x3
      22: d103         	bne	0x2c <core::option::Option$LT$T$GT$::as_mut::hf79fec48f02e0dc2+0x2c> @ imm = #0x6
      24: e7ff         	b	0x26 <core::option::Option$LT$T$GT$::as_mut::hf79fec48f02e0dc2+0x26> @ imm = #-0x2
      26: 2000         	movs	r0, #0x0
      28: 9001         	str	r0, [sp, #0x4]
      2a: e003         	b	0x34 <core::option::Option$LT$T$GT$::as_mut::hf79fec48f02e0dc2+0x34> @ imm = #0x6
      2c: 9800         	ldr	r0, [sp]
      2e: 9003         	str	r0, [sp, #0xc]
      30: 9001         	str	r0, [sp, #0x4]
      32: e7ff         	b	0x34 <core::option::Option$LT$T$GT$::as_mut::hf79fec48f02e0dc2+0x34> @ imm = #-0x2
      34: 9801         	ldr	r0, [sp, #0x4]
      36: b004         	add	sp, #0x10
      38: 4770         	bx	lr

Disassembly of section .text._ZN4core6option15Option$LT$T$GT$6unwrap17h2e92092453ad715dE:

00000000 <core::option::Option$LT$T$GT$::unwrap::h2e92092453ad715d>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f18    	.word	#0xf1bc0f18
      10: da02         	bge	0x18 <core::option::Option$LT$T$GT$::unwrap::h2e92092453ad715d+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0006         	movs	r6, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b084         	sub	sp, #0x10
      1e: 9101         	str	r1, [sp, #0x4]
      20: 9002         	str	r0, [sp, #0x8]
      22: 9802         	ldr	r0, [sp, #0x8]
      24: b948         	cbnz	r0, 0x3a <core::option::Option$LT$T$GT$::unwrap::h2e92092453ad715d+0x3a> @ imm = #0x12
      26: e7ff         	b	0x28 <core::option::Option$LT$T$GT$::unwrap::h2e92092453ad715d+0x28> @ imm = #-0x2
      28: 9a01         	ldr	r2, [sp, #0x4]
      2a: f240 0000    	.word	#0xf2400000
      2e: f2c0 0000    	.word	#0xf2c00000
      32: 212b         	movs	r1, #0x2b
      34: f7ff fffe    	bl	0x34 <core::option::Option$LT$T$GT$::unwrap::h2e92092453ad715d+0x34> @ imm = #-0x4
      38: defe         	trap
      3a: 9802         	ldr	r0, [sp, #0x8]
      3c: 9003         	str	r0, [sp, #0xc]
      3e: b004         	add	sp, #0x10
      40: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core6option15Option$LT$T$GT$6unwrap17h95e1c4183aad524eE:

00000000 <core::option::Option$LT$T$GT$::unwrap::h95e1c4183aad524e>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f18    	.word	#0xf1bc0f18
      10: da02         	bge	0x18 <core::option::Option$LT$T$GT$::unwrap::h95e1c4183aad524e+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0006         	movs	r6, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b084         	sub	sp, #0x10
      1e: 9101         	str	r1, [sp, #0x4]
      20: 9002         	str	r0, [sp, #0x8]
      22: 9802         	ldr	r0, [sp, #0x8]
      24: b948         	cbnz	r0, 0x3a <core::option::Option$LT$T$GT$::unwrap::h95e1c4183aad524e+0x3a> @ imm = #0x12
      26: e7ff         	b	0x28 <core::option::Option$LT$T$GT$::unwrap::h95e1c4183aad524e+0x28> @ imm = #-0x2
      28: 9a01         	ldr	r2, [sp, #0x4]
      2a: f240 0000    	.word	#0xf2400000
      2e: f2c0 0000    	.word	#0xf2c00000
      32: 212b         	movs	r1, #0x2b
      34: f7ff fffe    	bl	0x34 <core::option::Option$LT$T$GT$::unwrap::h95e1c4183aad524e+0x34> @ imm = #-0x4
      38: defe         	trap
      3a: 9802         	ldr	r0, [sp, #0x8]
      3c: 9003         	str	r0, [sp, #0xc]
      3e: b004         	add	sp, #0x10
      40: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN4core6result19Result$LT$T$C$E$GT$3map17h777aae74d8aecb7dE:

00000000 <core::result::Result$LT$T$C$E$GT$::map::h777aae74d8aecb7d>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f20    	.word	#0xf1bc0f20
      10: da02         	bge	0x18 <core::result::Result$LT$T$C$E$GT$::map::h777aae74d8aecb7d+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0008         	movs	r0, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b086         	sub	sp, #0x18
      1e: 9002         	str	r0, [sp, #0x8]
      20: 9802         	ldr	r0, [sp, #0x8]
      22: 9001         	str	r0, [sp, #0x4]
      24: 2000         	movs	r0, #0x0
      26: f807 0c06    	.word	#0xf8070c06
      2a: 2001         	movs	r0, #0x1
      2c: f807 0c06    	.word	#0xf8070c06
      30: f89d 0004    	.word	#0xf89d0004
      34: 07c0         	lsls	r0, r0, #0x1f
      36: b9a8         	cbnz	r0, 0x64 <core::result::Result$LT$T$C$E$GT$::map::h777aae74d8aecb7d+0x64> @ imm = #0x2a
      38: e7ff         	b	0x3a <core::result::Result$LT$T$C$E$GT$::map::h777aae74d8aecb7d+0x3a> @ imm = #-0x2
      3a: f8bd 0006    	.word	#0xf8bd0006
      3e: f8ad 0014    	.word	#0xf8ad0014
      42: 2100         	movs	r1, #0x0
      44: 9100         	str	r1, [sp]
      46: f807 1c06    	.word	#0xf8071c06
      4a: f8ad 0010    	.word	#0xf8ad0010
      4e: f8bd 0010    	.word	#0xf8bd0010
      52: f7ff fffe    	bl	0x52 <core::result::Result$LT$T$C$E$GT$::map::h777aae74d8aecb7d+0x52> @ imm = #-0x4
      56: 4601         	mov	r1, r0
      58: 9800         	ldr	r0, [sp]
      5a: f807 1c09    	.word	#0xf8071c09
      5e: f807 0c0a    	.word	#0xf8070c0a
      62: e009         	b	0x78 <core::result::Result$LT$T$C$E$GT$::map::h777aae74d8aecb7d+0x78> @ imm = #0x12
      64: f89d 0005    	.word	#0xf89d0005
      68: f807 0c01    	.word	#0xf8070c01
      6c: f807 0c09    	.word	#0xf8070c09
      70: 2001         	movs	r0, #0x1
      72: f807 0c0a    	.word	#0xf8070c0a
      76: e7ff         	b	0x78 <core::result::Result$LT$T$C$E$GT$::map::h777aae74d8aecb7d+0x78> @ imm = #-0x2
      78: f817 0c06    	.word	#0xf8170c06
      7c: 07c0         	lsls	r0, r0, #0x1f
      7e: b930         	cbnz	r0, 0x8e <core::result::Result$LT$T$C$E$GT$::map::h777aae74d8aecb7d+0x8e> @ imm = #0xc
      80: e7ff         	b	0x82 <core::result::Result$LT$T$C$E$GT$::map::h777aae74d8aecb7d+0x82> @ imm = #-0x2
      82: f817 0c0a    	.word	#0xf8170c0a
      86: f817 1c09    	.word	#0xf8171c09
      8a: b006         	add	sp, #0x18
      8c: bd80         	pop	{r7, pc}
      8e: e7f8         	b	0x82 <core::result::Result$LT$T$C$E$GT$::map::h777aae74d8aecb7d+0x82> @ imm = #-0x10

Disassembly of section .text._ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h1d4d84f84fe94fe8E:

00000000 <core::result::Result$LT$T$C$E$GT$::unwrap::h1d4d84f84fe94fe8>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f20    	.word	#0xf1bc0f20
      10: da02         	bge	0x18 <core::result::Result$LT$T$C$E$GT$::unwrap::h1d4d84f84fe94fe8+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0008         	movs	r0, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b086         	sub	sp, #0x18
      1e: 9201         	str	r2, [sp, #0x4]
      20: f807 0c0d    	.word	#0xf8070c0d
      24: f807 1c0c    	.word	#0xf8071c0c
      28: f817 0c0d    	.word	#0xf8170c0d
      2c: 2803         	cmp	r0, #0x3
      2e: d00a         	beq	0x46 <core::result::Result$LT$T$C$E$GT$::unwrap::h1d4d84f84fe94fe8+0x46> @ imm = #0x14
      30: e7ff         	b	0x32 <core::result::Result$LT$T$C$E$GT$::unwrap::h1d4d84f84fe94fe8+0x32> @ imm = #-0x2
      32: f817 0c0d    	.word	#0xf8170c0d
      36: f817 1c0c    	.word	#0xf8171c0c
      3a: f807 0c0a    	.word	#0xf8070c0a
      3e: f807 1c09    	.word	#0xf8071c09
      42: b006         	add	sp, #0x18
      44: bd80         	pop	{r7, pc}
      46: 9801         	ldr	r0, [sp, #0x4]
      48: 4669         	mov	r1, sp
      4a: 6008         	str	r0, [r1]
      4c: f240 0000    	.word	#0xf2400000
      50: f2c0 0000    	.word	#0xf2c00000
      54: f240 0300    	.word	#0xf2400300
      58: f2c0 0300    	.word	#0xf2c00300
      5c: 212b         	movs	r1, #0x2b
      5e: f1a7 020b    	.word	#0xf1a7020b
      62: f7ff fffe    	bl	0x62 <core::result::Result$LT$T$C$E$GT$::unwrap::h1d4d84f84fe94fe8+0x62> @ imm = #-0x4
      66: e006         	b	0x76 <core::result::Result$LT$T$C$E$GT$::unwrap::h1d4d84f84fe94fe8+0x76> @ imm = #0xc
      68: 9804         	ldr	r0, [sp, #0x10]
      6a: f7ff fffe    	bl	0x6a <core::result::Result$LT$T$C$E$GT$::unwrap::h1d4d84f84fe94fe8+0x6a> @ imm = #-0x4
      6e: defe         	trap
      70: 9004         	str	r0, [sp, #0x10]
      72: 9105         	str	r1, [sp, #0x14]
      74: e7f8         	b	0x68 <core::result::Result$LT$T$C$E$GT$::unwrap::h1d4d84f84fe94fe8+0x68> @ imm = #-0x10
      76: defe         	trap

Disassembly of section .text._ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h73b542f03bcd7459E:

00000000 <core::result::Result$LT$T$C$E$GT$::unwrap::h73b542f03bcd7459>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f20    	.word	#0xf1bc0f20
      10: da02         	bge	0x18 <core::result::Result$LT$T$C$E$GT$::unwrap::h73b542f03bcd7459+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0008         	movs	r0, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b086         	sub	sp, #0x18
      1e: 9202         	str	r2, [sp, #0x8]
      20: f88d 000c    	.word	#0xf88d000c
      24: f88d 100d    	.word	#0xf88d100d
      28: f89d 000c    	.word	#0xf89d000c
      2c: 07c0         	lsls	r0, r0, #0x1f
      2e: b930         	cbnz	r0, 0x3e <core::result::Result$LT$T$C$E$GT$::unwrap::h73b542f03bcd7459+0x3e> @ imm = #0xc
      30: e7ff         	b	0x32 <core::result::Result$LT$T$C$E$GT$::unwrap::h73b542f03bcd7459+0x32> @ imm = #-0x2
      32: f89d 000d    	.word	#0xf89d000d
      36: f807 0c09    	.word	#0xf8070c09
      3a: b006         	add	sp, #0x18
      3c: bd80         	pop	{r7, pc}
      3e: 9802         	ldr	r0, [sp, #0x8]
      40: f89d 100d    	.word	#0xf89d100d
      44: f807 1c0a    	.word	#0xf8071c0a
      48: 4669         	mov	r1, sp
      4a: 6008         	str	r0, [r1]
      4c: f240 0000    	.word	#0xf2400000
      50: f2c0 0000    	.word	#0xf2c00000
      54: f240 0300    	.word	#0xf2400300
      58: f2c0 0300    	.word	#0xf2c00300
      5c: 212b         	movs	r1, #0x2b
      5e: f1a7 020a    	.word	#0xf1a7020a
      62: f7ff fffe    	bl	0x62 <core::result::Result$LT$T$C$E$GT$::unwrap::h73b542f03bcd7459+0x62> @ imm = #-0x4
      66: e006         	b	0x76 <core::result::Result$LT$T$C$E$GT$::unwrap::h73b542f03bcd7459+0x76> @ imm = #0xc
      68: 9804         	ldr	r0, [sp, #0x10]
      6a: f7ff fffe    	bl	0x6a <core::result::Result$LT$T$C$E$GT$::unwrap::h73b542f03bcd7459+0x6a> @ imm = #-0x4
      6e: defe         	trap
      70: 9004         	str	r0, [sp, #0x10]
      72: 9105         	str	r1, [sp, #0x14]
      74: e7f8         	b	0x68 <core::result::Result$LT$T$C$E$GT$::unwrap::h73b542f03bcd7459+0x68> @ imm = #-0x10
      76: defe         	trap

Disassembly of section .text._ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h1a38324752bc68feE:

00000000 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h1a38324752bc68fe>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f20    	.word	#0xf1bc0f20
      10: da02         	bge	0x18 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h1a38324752bc68fe+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0008         	movs	r0, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b086         	sub	sp, #0x18
      1e: 9001         	str	r0, [sp, #0x4]
      20: 9002         	str	r0, [sp, #0x8]
      22: 9003         	str	r0, [sp, #0xc]
      24: f7ff fffe    	bl	0x24 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h1a38324752bc68fe+0x24> @ imm = #-0x4
      28: 9005         	str	r0, [sp, #0x14]
      2a: 9004         	str	r0, [sp, #0x10]
      2c: 9804         	ldr	r0, [sp, #0x10]
      2e: b006         	add	sp, #0x18
      30: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h492271a37cd1007eE:

00000000 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h492271a37cd1007e>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f04    	.word	#0xf1bc0f04
      10: da02         	bge	0x18 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h492271a37cd1007e+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0001         	movs	r1, r0
      16: 0000         	movs	r0, r0
      18: b081         	sub	sp, #0x4
      1a: f88d 0002    	.word	#0xf88d0002
      1e: f88d 0003    	.word	#0xf88d0003
      22: f89d 0003    	.word	#0xf89d0003
      26: b001         	add	sp, #0x4
      28: 4770         	bx	lr

Disassembly of section .text._ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h6dadf008f817ad54E:

00000000 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h6dadf008f817ad54>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h6dadf008f817ad54+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: f7ff fffe    	bl	0x1e <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h6dadf008f817ad54+0x1e> @ imm = #-0x4
      22: b002         	add	sp, #0x8
      24: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h75dd916b583ae142E:

00000000 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h75dd916b583ae142>:
       0: 460a         	mov	r2, r1
       2: 4601         	mov	r1, r0
       4: 6810         	ldr	r0, [r2]
       6: 6852         	ldr	r2, [r2, #0x4]
       8: 604a         	str	r2, [r1, #0x4]
       a: 6008         	str	r0, [r1]
       c: 4770         	bx	lr

Disassembly of section .text._ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17h8ba1ff5827e77de3E:

00000000 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h8ba1ff5827e77de3>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f04    	.word	#0xf1bc0f04
      10: da02         	bge	0x18 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::h8ba1ff5827e77de3+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0001         	movs	r1, r0
      16: 0000         	movs	r0, r0
      18: b081         	sub	sp, #0x4
      1a: f88d 0002    	.word	#0xf88d0002
      1e: f88d 0003    	.word	#0xf88d0003
      22: f89d 0003    	.word	#0xf89d0003
      26: b001         	add	sp, #0x4
      28: 4770         	bx	lr

Disassembly of section .text._ZN50_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$4into17hf8e690b6ce4c3839E:

00000000 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::hf8e690b6ce4c3839>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::hf8e690b6ce4c3839+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: f7ff fffe    	bl	0x1e <_$LT$T$u20$as$u20$core..convert..Into$LT$U$GT$$GT$::into::hf8e690b6ce4c3839+0x1e> @ imm = #-0x4
      22: b002         	add	sp, #0x8
      24: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN50_$LT$T$u20$as$u20$stm32f4xx_hal..rcc..BusClock$GT$5clock17hfb6b8d7cc0705a51E:

00000000 <_$LT$T$u20$as$u20$stm32f4xx_hal..rcc..BusClock$GT$::clock::hfb6b8d7cc0705a51>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <_$LT$T$u20$as$u20$stm32f4xx_hal..rcc..BusClock$GT$::clock::hfb6b8d7cc0705a51+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9001         	str	r0, [sp, #0x4]
      20: f7ff fffe    	bl	0x20 <_$LT$T$u20$as$u20$stm32f4xx_hal..rcc..BusClock$GT$::clock::hfb6b8d7cc0705a51+0x20> @ imm = #-0x4
      24: b002         	add	sp, #0x8
      26: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN55_$LT$nb..Error$LT$E$GT$$u20$as$u20$core..fmt..Debug$GT$3fmt17h1a254b80867fb87eE:

00000000 <_$LT$nb..Error$LT$E$GT$$u20$as$u20$core..fmt..Debug$GT$::fmt::h1a254b80867fb87e>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f20    	.word	#0xf1bc0f20
      10: da02         	bge	0x18 <_$LT$nb..Error$LT$E$GT$$u20$as$u20$core..fmt..Debug$GT$::fmt::h1a254b80867fb87e+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0008         	movs	r0, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b086         	sub	sp, #0x18
      1e: 9100         	str	r1, [sp]
      20: 9001         	str	r0, [sp, #0x4]
      22: 9003         	str	r0, [sp, #0xc]
      24: 9104         	str	r1, [sp, #0x10]
      26: 7800         	ldrb	r0, [r0]
      28: 2805         	cmp	r0, #0x5
      2a: d008         	beq	0x3e <_$LT$nb..Error$LT$E$GT$$u20$as$u20$core..fmt..Debug$GT$::fmt::h1a254b80867fb87e+0x3e> @ imm = #0x10
      2c: e7ff         	b	0x2e <_$LT$nb..Error$LT$E$GT$$u20$as$u20$core..fmt..Debug$GT$::fmt::h1a254b80867fb87e+0x2e> @ imm = #-0x2
      2e: 9900         	ldr	r1, [sp]
      30: 9801         	ldr	r0, [sp, #0x4]
      32: 9005         	str	r0, [sp, #0x14]
      34: f7ff fffe    	bl	0x34 <_$LT$nb..Error$LT$E$GT$$u20$as$u20$core..fmt..Debug$GT$::fmt::h1a254b80867fb87e+0x34> @ imm = #-0x4
      38: f807 0c0d    	.word	#0xf8070c0d
      3c: e00a         	b	0x54 <_$LT$nb..Error$LT$E$GT$$u20$as$u20$core..fmt..Debug$GT$::fmt::h1a254b80867fb87e+0x54> @ imm = #0x14
      3e: 9800         	ldr	r0, [sp]
      40: f240 0100    	.word	#0xf2400100
      44: f2c0 0100    	.word	#0xf2c00100
      48: 220a         	movs	r2, #0xa
      4a: f7ff fffe    	bl	0x4a <_$LT$nb..Error$LT$E$GT$$u20$as$u20$core..fmt..Debug$GT$::fmt::h1a254b80867fb87e+0x4a> @ imm = #-0x4
      4e: f807 0c0d    	.word	#0xf8070c0d
      52: e7ff         	b	0x54 <_$LT$nb..Error$LT$E$GT$$u20$as$u20$core..fmt..Debug$GT$::fmt::h1a254b80867fb87e+0x54> @ imm = #-0x2
      54: f817 0c0d    	.word	#0xf8170c0d
      58: b006         	add	sp, #0x18
      5a: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN5alloc5boxed12Box$LT$T$GT$8from_raw17h4775a22c2ebecb60E:

00000000 <alloc::boxed::Box$LT$T$GT$::from_raw::h4775a22c2ebecb60>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <alloc::boxed::Box$LT$T$GT$::from_raw::h4775a22c2ebecb60+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9001         	str	r0, [sp, #0x4]
      20: f7ff fffe    	bl	0x20 <alloc::boxed::Box$LT$T$GT$::from_raw::h4775a22c2ebecb60+0x20> @ imm = #-0x4
      24: b002         	add	sp, #0x8
      26: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN5alloc5boxed16Box$LT$T$C$A$GT$11from_raw_in17hdf0b8a680646309aE:

00000000 <alloc::boxed::Box$LT$T$C$A$GT$::from_raw_in::hdf0b8a680646309a>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f20    	.word	#0xf1bc0f20
      10: da02         	bge	0x18 <alloc::boxed::Box$LT$T$C$A$GT$::from_raw_in::hdf0b8a680646309a+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0008         	movs	r0, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b086         	sub	sp, #0x18
      1e: 9002         	str	r0, [sp, #0x8]
      20: f7ff fffe    	bl	0x20 <alloc::boxed::Box$LT$T$C$A$GT$::from_raw_in::hdf0b8a680646309a+0x20> @ imm = #-0x4
      24: 9000         	str	r0, [sp]
      26: e006         	b	0x36 <alloc::boxed::Box$LT$T$C$A$GT$::from_raw_in::hdf0b8a680646309a+0x36> @ imm = #0xc
      28: 9804         	ldr	r0, [sp, #0x10]
      2a: f7ff fffe    	bl	0x2a <alloc::boxed::Box$LT$T$C$A$GT$::from_raw_in::hdf0b8a680646309a+0x2a> @ imm = #-0x4
      2e: defe         	trap
      30: 9004         	str	r0, [sp, #0x10]
      32: 9105         	str	r1, [sp, #0x14]
      34: e7f8         	b	0x28 <alloc::boxed::Box$LT$T$C$A$GT$::from_raw_in::hdf0b8a680646309a+0x28> @ imm = #-0x10
      36: 9800         	ldr	r0, [sp]
      38: 9001         	str	r0, [sp, #0x4]
      3a: 9801         	ldr	r0, [sp, #0x4]
      3c: b006         	add	sp, #0x18
      3e: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN65_$LT$stm32f4xx_hal..serial..Error$u20$as$u20$core..fmt..Debug$GT$3fmt17h6754d526af57b2cfE:

00000000 <_$LT$stm32f4xx_hal..serial..Error$u20$as$u20$core..fmt..Debug$GT$::fmt::h6754d526af57b2cf>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f20    	.word	#0xf1bc0f20
      10: da02         	bge	0x18 <_$LT$stm32f4xx_hal..serial..Error$u20$as$u20$core..fmt..Debug$GT$::fmt::h6754d526af57b2cf+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0008         	movs	r0, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b086         	sub	sp, #0x18
      1e: 9100         	str	r1, [sp]
      20: 9004         	str	r0, [sp, #0x10]
      22: 9105         	str	r1, [sp, #0x14]
      24: 7800         	ldrb	r0, [r0]
      26: 9001         	str	r0, [sp, #0x4]
      28: 9901         	ldr	r1, [sp, #0x4]
      2a: e8df f001    	.word	#0xe8dff001

0000002e <$d.68>:
      2e: 04 0c 14 1c  	.word	0x1c140c04
      32: 24 00        	.short	0x0024

00000034 <$t.69>:
      34: defe         	trap
      36: f240 0000    	.word	#0xf2400000
      3a: f2c0 0000    	.word	#0xf2c00000
      3e: 9002         	str	r0, [sp, #0x8]
      40: 2007         	movs	r0, #0x7
      42: 9003         	str	r0, [sp, #0xc]
      44: e01f         	b	0x86 <_$LT$stm32f4xx_hal..serial..Error$u20$as$u20$core..fmt..Debug$GT$::fmt::h6754d526af57b2cf+0x86> @ imm = #0x3e
      46: f240 0000    	.word	#0xf2400000
      4a: f2c0 0000    	.word	#0xf2c00000
      4e: 9002         	str	r0, [sp, #0x8]
      50: 200b         	movs	r0, #0xb
      52: 9003         	str	r0, [sp, #0xc]
      54: e017         	b	0x86 <_$LT$stm32f4xx_hal..serial..Error$u20$as$u20$core..fmt..Debug$GT$::fmt::h6754d526af57b2cf+0x86> @ imm = #0x2e
      56: f240 0000    	.word	#0xf2400000
      5a: f2c0 0000    	.word	#0xf2c00000
      5e: 9002         	str	r0, [sp, #0x8]
      60: 2006         	movs	r0, #0x6
      62: 9003         	str	r0, [sp, #0xc]
      64: e00f         	b	0x86 <_$LT$stm32f4xx_hal..serial..Error$u20$as$u20$core..fmt..Debug$GT$::fmt::h6754d526af57b2cf+0x86> @ imm = #0x1e
      66: f240 0000    	.word	#0xf2400000
      6a: f2c0 0000    	.word	#0xf2c00000
      6e: 9002         	str	r0, [sp, #0x8]
      70: 2005         	movs	r0, #0x5
      72: 9003         	str	r0, [sp, #0xc]
      74: e007         	b	0x86 <_$LT$stm32f4xx_hal..serial..Error$u20$as$u20$core..fmt..Debug$GT$::fmt::h6754d526af57b2cf+0x86> @ imm = #0xe
      76: f240 0000    	.word	#0xf2400000
      7a: f2c0 0000    	.word	#0xf2c00000
      7e: 9002         	str	r0, [sp, #0x8]
      80: 2005         	movs	r0, #0x5
      82: 9003         	str	r0, [sp, #0xc]
      84: e7ff         	b	0x86 <_$LT$stm32f4xx_hal..serial..Error$u20$as$u20$core..fmt..Debug$GT$::fmt::h6754d526af57b2cf+0x86> @ imm = #-0x2
      86: 9800         	ldr	r0, [sp]
      88: 9902         	ldr	r1, [sp, #0x8]
      8a: 9a03         	ldr	r2, [sp, #0xc]
      8c: f7ff fffe    	bl	0x8c <_$LT$stm32f4xx_hal..serial..Error$u20$as$u20$core..fmt..Debug$GT$::fmt::h6754d526af57b2cf+0x8c> @ imm = #-0x4
      90: b006         	add	sp, #0x18
      92: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN77_$LT$cortex_m..register..primask..Primask$u20$as$u20$core..cmp..PartialEq$GT$2eq17hbb834c01e90f7027E:

00000000 <_$LT$cortex_m..register..primask..Primask$u20$as$u20$core..cmp..PartialEq$GT$::eq::hbb834c01e90f7027>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <_$LT$cortex_m..register..primask..Primask$u20$as$u20$core..cmp..PartialEq$GT$::eq::hbb834c01e90f7027+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b084         	sub	sp, #0x10
      1a: 9000         	str	r0, [sp]
      1c: 9101         	str	r1, [sp, #0x4]
      1e: 7800         	ldrb	r0, [r0]
      20: 9002         	str	r0, [sp, #0x8]
      22: 7809         	ldrb	r1, [r1]
      24: 9103         	str	r1, [sp, #0xc]
      26: 1a40         	subs	r0, r0, r1
      28: fab0 f080    	.word	#0xfab0f080
      2c: 0940         	lsrs	r0, r0, #0x5
      2e: b004         	add	sp, #0x10
      30: 4770         	bx	lr

Disassembly of section .text._ZN78_$LT$stm32f4xx_hal..serial..config..Parity$u20$as$u20$core..cmp..PartialEq$GT$2eq17h3755a2f23a58c5dfE:

00000000 <_$LT$stm32f4xx_hal..serial..config..Parity$u20$as$u20$core..cmp..PartialEq$GT$::eq::h3755a2f23a58c5df>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <_$LT$stm32f4xx_hal..serial..config..Parity$u20$as$u20$core..cmp..PartialEq$GT$::eq::h3755a2f23a58c5df+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b084         	sub	sp, #0x10
      1a: 9000         	str	r0, [sp]
      1c: 9101         	str	r1, [sp, #0x4]
      1e: 7800         	ldrb	r0, [r0]
      20: 9002         	str	r0, [sp, #0x8]
      22: 7809         	ldrb	r1, [r1]
      24: 9103         	str	r1, [sp, #0xc]
      26: 1a40         	subs	r0, r0, r1
      28: fab0 f080    	.word	#0xfab0f080
      2c: 0940         	lsrs	r0, r0, #0x5
      2e: b004         	add	sp, #0x10
      30: 4770         	bx	lr

Disassembly of section .text._ZN7stm32f49stm32f40511Peripherals5steal17h55ed0c33dc61e22fE:

00000000 <stm32f4::stm32f405::Peripherals::steal::h55ed0c33dc61e22f>:
       0: f240 0100    	.word	#0xf2400100
       4: f2c0 0100    	.word	#0xf2c00100
       8: 2001         	movs	r0, #0x1
       a: 7008         	strb	r0, [r1]
       c: 4770         	bx	lr

Disassembly of section .text._ZN81_$LT$stm32f4xx_hal..serial..config..InvalidConfig$u20$as$u20$core..fmt..Debug$GT$3fmt17haba3e324954e3057E:

00000000 <_$LT$stm32f4xx_hal..serial..config..InvalidConfig$u20$as$u20$core..fmt..Debug$GT$::fmt::haba3e324954e3057>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f18    	.word	#0xf1bc0f18
      10: da02         	bge	0x18 <_$LT$stm32f4xx_hal..serial..config..InvalidConfig$u20$as$u20$core..fmt..Debug$GT$::fmt::haba3e324954e3057+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0006         	movs	r6, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b084         	sub	sp, #0x10
      1e: 9101         	str	r1, [sp, #0x4]
      20: 4601         	mov	r1, r0
      22: 9801         	ldr	r0, [sp, #0x4]
      24: 9102         	str	r1, [sp, #0x8]
      26: 9003         	str	r0, [sp, #0xc]
      28: f240 0100    	.word	#0xf2400100
      2c: f2c0 0100    	.word	#0xf2c00100
      30: 220d         	movs	r2, #0xd
      32: f7ff fffe    	bl	0x32 <_$LT$stm32f4xx_hal..serial..config..InvalidConfig$u20$as$u20$core..fmt..Debug$GT$::fmt::haba3e324954e3057+0x32> @ imm = #-0x4
      36: b004         	add	sp, #0x10
      38: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN82_$LT$stm32f4xx_hal..serial..config..WordLength$u20$as$u20$core..cmp..PartialEq$GT$2eq17hd1afd2b15a1eea7fE:

00000000 <_$LT$stm32f4xx_hal..serial..config..WordLength$u20$as$u20$core..cmp..PartialEq$GT$::eq::hd1afd2b15a1eea7f>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <_$LT$stm32f4xx_hal..serial..config..WordLength$u20$as$u20$core..cmp..PartialEq$GT$::eq::hd1afd2b15a1eea7f+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b084         	sub	sp, #0x10
      1a: 9000         	str	r0, [sp]
      1c: 9101         	str	r1, [sp, #0x4]
      1e: 7800         	ldrb	r0, [r0]
      20: 9002         	str	r0, [sp, #0x8]
      22: 7809         	ldrb	r1, [r1]
      24: 9103         	str	r1, [sp, #0xc]
      26: 1a40         	subs	r0, r0, r1
      28: fab0 f080    	.word	#0xfab0f080
      2c: 0940         	lsrs	r0, r0, #0x5
      2e: b004         	add	sp, #0x10
      30: 4770         	bx	lr

Disassembly of section .text._ZN8cortex_m10peripheral4nvic44_$LT$impl$u20$cortex_m..peripheral..NVIC$GT$6unmask17hf7929b4d8b6ed008E:

00000000 <cortex_m::peripheral::nvic::_$LT$impl$u20$cortex_m..peripheral..NVIC$GT$::unmask::hf7929b4d8b6ed008>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f38    	.word	#0xf1bc0f38
      10: da02         	bge	0x18 <cortex_m::peripheral::nvic::_$LT$impl$u20$cortex_m..peripheral..NVIC$GT$::unmask::hf7929b4d8b6ed008+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 000e         	movs	r6, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b08c         	sub	sp, #0x30
      1e: f8ad 0010    	.word	#0xf8ad0010
      22: f827 0c02    	.word	#0xf8270c02
      26: f837 0c02    	.word	#0xf8370c02
      2a: 4601         	mov	r1, r0
      2c: 9102         	str	r1, [sp, #0x8]
      2e: f827 0c1e    	.word	#0xf8270c1e
      32: 0940         	lsrs	r0, r0, #0x5
      34: f827 0c12    	.word	#0xf8270c12
      38: 4601         	mov	r1, r0
      3a: 9103         	str	r1, [sp, #0xc]
      3c: 280f         	cmp	r0, #0xf
      3e: d810         	bhi	0x62 <cortex_m::peripheral::nvic::_$LT$impl$u20$cortex_m..peripheral..NVIC$GT$::unmask::hf7929b4d8b6ed008+0x62> @ imm = #0x20
      40: e7ff         	b	0x42 <cortex_m::peripheral::nvic::_$LT$impl$u20$cortex_m..peripheral..NVIC$GT$::unmask::hf7929b4d8b6ed008+0x42> @ imm = #-0x2
      42: 9802         	ldr	r0, [sp, #0x8]
      44: 9a03         	ldr	r2, [sp, #0xc]
      46: f24e 1100    	.word	#0xf24e1100
      4a: f2ce 0100    	.word	#0xf2ce0100
      4e: eb01 0182    	.word	#0xeb010182
      52: 9100         	str	r1, [sp]
      54: f000 001f    	.word	#0xf000001f
      58: 4601         	mov	r1, r0
      5a: 9101         	str	r1, [sp, #0x4]
      5c: 2820         	cmp	r0, #0x20
      5e: d309         	blo	0x74 <cortex_m::peripheral::nvic::_$LT$impl$u20$cortex_m..peripheral..NVIC$GT$::unmask::hf7929b4d8b6ed008+0x74> @ imm = #0x12
      60: e017         	b	0x92 <cortex_m::peripheral::nvic::_$LT$impl$u20$cortex_m..peripheral..NVIC$GT$::unmask::hf7929b4d8b6ed008+0x92> @ imm = #0x2e
      62: 9803         	ldr	r0, [sp, #0xc]
      64: f240 0200    	.word	#0xf2400200
      68: f2c0 0200    	.word	#0xf2c00200
      6c: 2110         	movs	r1, #0x10
      6e: f7ff fffe    	bl	0x6e <cortex_m::peripheral::nvic::_$LT$impl$u20$cortex_m..peripheral..NVIC$GT$::unmask::hf7929b4d8b6ed008+0x6e> @ imm = #-0x4
      72: defe         	trap
      74: 9800         	ldr	r0, [sp]
      76: 9901         	ldr	r1, [sp, #0x4]
      78: f001 021f    	.word	#0xf001021f
      7c: 2101         	movs	r1, #0x1
      7e: 4091         	lsls	r1, r2
      80: 9005         	str	r0, [sp, #0x14]
      82: 9106         	str	r1, [sp, #0x18]
      84: 9008         	str	r0, [sp, #0x20]
      86: 9109         	str	r1, [sp, #0x24]
      88: 900a         	str	r0, [sp, #0x28]
      8a: f7ff fffe    	bl	0x8a <cortex_m::peripheral::nvic::_$LT$impl$u20$cortex_m..peripheral..NVIC$GT$::unmask::hf7929b4d8b6ed008+0x8a> @ imm = #-0x4
      8e: b00c         	add	sp, #0x30
      90: bd80         	pop	{r7, pc}
      92: f240 0000    	.word	#0xf2400000
      96: f2c0 0000    	.word	#0xf2c00000
      9a: f240 0200    	.word	#0xf2400200
      9e: f2c0 0200    	.word	#0xf2c00200
      a2: 2123         	movs	r1, #0x23
      a4: f7ff fffe    	bl	0xa4 <cortex_m::peripheral::nvic::_$LT$impl$u20$cortex_m..peripheral..NVIC$GT$::unmask::hf7929b4d8b6ed008+0xa4> @ imm = #-0x4
      a8: defe         	trap

Disassembly of section .text._ZN8cortex_m3asm3dsb17h2e91ffe05f3b5612E:

00000000 <cortex_m::asm::dsb::h2e91ffe05f3b5612>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <cortex_m::asm::dsb::h2e91ffe05f3b5612+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 2004         	movs	r0, #0x4
      20: 9000         	str	r0, [sp]
      22: f807 0c02    	.word	#0xf8070c02
      26: f817 0c02    	.word	#0xf8170c02
      2a: f7ff fffe    	bl	0x2a <cortex_m::asm::dsb::h2e91ffe05f3b5612+0x2a> @ imm = #-0x4
      2e: 9800         	ldr	r0, [sp]
      30: f3bf 8f4f    	.word	#0xf3bf8f4f
      34: f807 0c01    	.word	#0xf8070c01
      38: f817 0c01    	.word	#0xf8170c01
      3c: f7ff fffe    	bl	0x3c <cortex_m::asm::dsb::h2e91ffe05f3b5612+0x3c> @ imm = #-0x4
      40: b002         	add	sp, #0x8
      42: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN8cortex_m8register7primask4read17h6f9c7a72aa23ab6aE:

00000000 <cortex_m::register::primask::read::h6f9c7a72aa23ab6a>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f0c    	.word	#0xf1bc0f0c
      10: da02         	bge	0x18 <cortex_m::register::primask::read::h6f9c7a72aa23ab6a+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0003         	movs	r3, r0
      16: 0000         	movs	r0, r0
      18: b083         	sub	sp, #0xc
      1a: f3ef 8010    	.word	#0xf3ef8010
      1e: 9002         	str	r0, [sp, #0x8]
      20: 9802         	ldr	r0, [sp, #0x8]
      22: 9001         	str	r0, [sp, #0x4]
      24: 07c0         	lsls	r0, r0, #0x1f
      26: b920         	cbnz	r0, 0x32 <cortex_m::register::primask::read::h6f9c7a72aa23ab6a+0x32> @ imm = #0x8
      28: e7ff         	b	0x2a <cortex_m::register::primask::read::h6f9c7a72aa23ab6a+0x2a> @ imm = #-0x2
      2a: 2000         	movs	r0, #0x0
      2c: f88d 0003    	.word	#0xf88d0003
      30: e003         	b	0x3a <cortex_m::register::primask::read::h6f9c7a72aa23ab6a+0x3a> @ imm = #0x6
      32: 2001         	movs	r0, #0x1
      34: f88d 0003    	.word	#0xf88d0003
      38: e7ff         	b	0x3a <cortex_m::register::primask::read::h6f9c7a72aa23ab6a+0x3a> @ imm = #-0x2
      3a: f89d 0003    	.word	#0xf89d0003
      3e: b003         	add	sp, #0xc
      40: 4770         	bx	lr

Disassembly of section .text._ZN8cortex_m8register7primask7Primask9is_active17hb06988f28840f480E:

00000000 <cortex_m::register::primask::Primask::is_active::hb06988f28840f480>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <cortex_m::register::primask::Primask::is_active::hb06988f28840f480+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: f807 0c01    	.word	#0xf8070c01
      22: f240 0100    	.word	#0xf2400100
      26: f2c0 0100    	.word	#0xf2c00100
      2a: 1e78         	subs	r0, r7, #0x1
      2c: f7ff fffe    	bl	0x2c <cortex_m::register::primask::Primask::is_active::hb06988f28840f480+0x2c> @ imm = #-0x4
      30: b002         	add	sp, #0x8
      32: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN8cortex_m9interrupt4free17hc74f9fdded939833E:

00000000 <cortex_m::interrupt::free::hc74f9fdded939833>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f28    	.word	#0xf1bc0f28
      10: da02         	bge	0x18 <cortex_m::interrupt::free::hc74f9fdded939833+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 000a         	movs	r2, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b088         	sub	sp, #0x20
      1e: 2000         	movs	r0, #0x0
      20: f807 0c0f    	.word	#0xf8070c0f
      24: f88d 0010    	.word	#0xf88d0010
      28: 2001         	movs	r0, #0x1
      2a: f807 0c0f    	.word	#0xf8070c0f
      2e: f7ff fffe    	bl	0x2e <cortex_m::interrupt::free::hc74f9fdded939833+0x2e> @ imm = #-0x4
      32: 9001         	str	r0, [sp, #0x4]
      34: e008         	b	0x48 <cortex_m::interrupt::free::hc74f9fdded939833+0x48> @ imm = #0x10
      36: f817 0c0f    	.word	#0xf8170c0f
      3a: 07c0         	lsls	r0, r0, #0x1f
      3c: 2800         	cmp	r0, #0x0
      3e: d143         	bne	0xc8 <cortex_m::interrupt::free::hc74f9fdded939833+0xc8> @ imm = #0x86
      40: e03e         	b	0xc0 <cortex_m::interrupt::free::hc74f9fdded939833+0xc0> @ imm = #0x7c
      42: 9005         	str	r0, [sp, #0x14]
      44: 9106         	str	r1, [sp, #0x18]
      46: e7f6         	b	0x36 <cortex_m::interrupt::free::hc74f9fdded939833+0x36> @ imm = #-0x14
      48: 9801         	ldr	r0, [sp, #0x4]
      4a: f000 0001    	.word	#0xf0000001
      4e: f807 0c01    	.word	#0xf8070c01
      52: f7ff fffe    	bl	0x52 <cortex_m::interrupt::free::hc74f9fdded939833+0x52> @ imm = #-0x4
      56: e7ff         	b	0x58 <cortex_m::interrupt::free::hc74f9fdded939833+0x58> @ imm = #-0x2
      58: 2000         	movs	r0, #0x0
      5a: f807 0c0f    	.word	#0xf8070c0f
      5e: 2001         	movs	r0, #0x1
      60: f88d 0010    	.word	#0xf88d0010
      64: f7ff fffe    	bl	0x64 <cortex_m::interrupt::free::hc74f9fdded939833+0x64> @ imm = #-0x4
      68: e007         	b	0x7a <cortex_m::interrupt::free::hc74f9fdded939833+0x7a> @ imm = #0xe
      6a: f89d 0010    	.word	#0xf89d0010
      6e: 07c0         	lsls	r0, r0, #0x1f
      70: bb28         	cbnz	r0, 0xbe <cortex_m::interrupt::free::hc74f9fdded939833+0xbe> @ imm = #0x4a
      72: e7e0         	b	0x36 <cortex_m::interrupt::free::hc74f9fdded939833+0x36> @ imm = #-0x40
      74: 9005         	str	r0, [sp, #0x14]
      76: 9106         	str	r1, [sp, #0x18]
      78: e7f7         	b	0x6a <cortex_m::interrupt::free::hc74f9fdded939833+0x6a> @ imm = #-0x12
      7a: f1a7 0011    	.word	#0xf1a70011
      7e: 9002         	str	r0, [sp, #0x8]
      80: 2000         	movs	r0, #0x0
      82: f88d 0010    	.word	#0xf88d0010
      86: 9802         	ldr	r0, [sp, #0x8]
      88: f7ff fffe    	bl	0x88 <cortex_m::interrupt::free::hc74f9fdded939833+0x88> @ imm = #-0x4
      8c: e7ff         	b	0x8e <cortex_m::interrupt::free::hc74f9fdded939833+0x8e> @ imm = #-0x2
      8e: 9801         	ldr	r0, [sp, #0x4]
      90: 2100         	movs	r1, #0x0
      92: f88d 1010    	.word	#0xf88d1010
      96: f000 0001    	.word	#0xf0000001
      9a: f7ff fffe    	bl	0x9a <cortex_m::interrupt::free::hc74f9fdded939833+0x9a> @ imm = #-0x4
      9e: 9000         	str	r0, [sp]
      a0: e003         	b	0xaa <cortex_m::interrupt::free::hc74f9fdded939833+0xaa> @ imm = #0x6
      a2: e7c8         	b	0x36 <cortex_m::interrupt::free::hc74f9fdded939833+0x36> @ imm = #-0x70
      a4: 9005         	str	r0, [sp, #0x14]
      a6: 9106         	str	r1, [sp, #0x18]
      a8: e7fb         	b	0xa2 <cortex_m::interrupt::free::hc74f9fdded939833+0xa2> @ imm = #-0xa
      aa: 9800         	ldr	r0, [sp]
      ac: 07c0         	lsls	r0, r0, #0x1f
      ae: b910         	cbnz	r0, 0xb6 <cortex_m::interrupt::free::hc74f9fdded939833+0xb6> @ imm = #0x4
      b0: e7ff         	b	0xb2 <cortex_m::interrupt::free::hc74f9fdded939833+0xb2> @ imm = #-0x2
      b2: b008         	add	sp, #0x20
      b4: bd80         	pop	{r7, pc}
      b6: f7ff fffe    	bl	0xb6 <cortex_m::interrupt::free::hc74f9fdded939833+0xb6> @ imm = #-0x4
      ba: e7ff         	b	0xbc <cortex_m::interrupt::free::hc74f9fdded939833+0xbc> @ imm = #-0x2
      bc: e7f9         	b	0xb2 <cortex_m::interrupt::free::hc74f9fdded939833+0xb2> @ imm = #-0xe
      be: e7ba         	b	0x36 <cortex_m::interrupt::free::hc74f9fdded939833+0x36> @ imm = #-0x8c
      c0: 9805         	ldr	r0, [sp, #0x14]
      c2: f7ff fffe    	bl	0xc2 <cortex_m::interrupt::free::hc74f9fdded939833+0xc2> @ imm = #-0x4
      c6: defe         	trap
      c8: e7fa         	b	0xc0 <cortex_m::interrupt::free::hc74f9fdded939833+0xc0> @ imm = #-0xc

Disassembly of section .text._ZN8cortex_m9interrupt6enable17h8d8f0ae1624628b5E:

00000000 <cortex_m::interrupt::enable::h8d8f0ae1624628b5>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <cortex_m::interrupt::enable::h8d8f0ae1624628b5+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 2004         	movs	r0, #0x4
      20: f807 0c01    	.word	#0xf8070c01
      24: f817 0c01    	.word	#0xf8170c01
      28: f7ff fffe    	bl	0x28 <cortex_m::interrupt::enable::h8d8f0ae1624628b5+0x28> @ imm = #-0x4
      2c: b662         	cpsie i
      2e: b002         	add	sp, #0x8
      30: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN8cortex_m9interrupt7disable17hc83defe8c7966595E:

00000000 <cortex_m::interrupt::disable::hc83defe8c7966595>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <cortex_m::interrupt::disable::hc83defe8c7966595+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: b672         	cpsid i
      20: 2004         	movs	r0, #0x4
      22: f807 0c01    	.word	#0xf8070c01
      26: f817 0c01    	.word	#0xf8170c01
      2a: f7ff fffe    	bl	0x2a <cortex_m::interrupt::disable::hc83defe8c7966595+0x2a> @ imm = #-0x4
      2e: b002         	add	sp, #0x8
      30: bd80         	pop	{r7, pc}

Disassembly of section .text.__main_trampoline:

00000000 <__main_trampoline>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f28    	.word	#0xf1bc0f28
      10: da02         	bge	0x18 <__main_trampoline+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 000a         	movs	r2, r1
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b088         	sub	sp, #0x20
      1e: 9002         	str	r0, [sp, #0x8]
      20: 9802         	ldr	r0, [sp, #0x8]
      22: 9001         	str	r0, [sp, #0x4]
      24: 2004         	movs	r0, #0x4
      26: f807 0c11    	.word	#0xf8070c11
      2a: f817 1c11    	.word	#0xf8171c11
      2e: a801         	add	r0, sp, #0x4
      30: f7ff fffe    	bl	0x30 <__main_trampoline+0x30> @ imm = #-0x4
      34: 9005         	str	r0, [sp, #0x14]
      36: f7ff fffe    	bl	0x36 <__main_trampoline+0x36> @ imm = #-0x4
      3a: 9004         	str	r0, [sp, #0x10]
      3c: 9804         	ldr	r0, [sp, #0x10]
      3e: 9000         	str	r0, [sp]
      40: 2000         	movs	r0, #0x0
      42: b918         	cbnz	r0, 0x4c <__main_trampoline+0x4c> @ imm = #0x6
      44: e7ff         	b	0x46 <__main_trampoline+0x46> @ imm = #-0x2
      46: f7ff fffe    	bl	0x46 <__main_trampoline+0x46> @ imm = #-0x4
      4a: e00f         	b	0x6c <__main_trampoline+0x6c> @ imm = #0x1e
      4c: 9900         	ldr	r1, [sp]
      4e: f240 0200    	.word	#0xf2400200
      52: f2c0 0200    	.word	#0xf2c00200
      56: 2001         	movs	r0, #0x1
      58: f7ff fffe    	bl	0x58 <__main_trampoline+0x58> @ imm = #-0x4
      5c: defe         	trap
      5e: a804         	add	r0, sp, #0x10
      60: f7ff fffe    	bl	0x60 <__main_trampoline+0x60> @ imm = #-0x4
      64: e00a         	b	0x7c <__main_trampoline+0x7c> @ imm = #0x14
      66: 9006         	str	r0, [sp, #0x18]
      68: 9107         	str	r1, [sp, #0x1c]
      6a: e7f8         	b	0x5e <__main_trampoline+0x5e> @ imm = #-0x10
      6c: a804         	add	r0, sp, #0x10
      6e: f7ff fffe    	bl	0x6e <__main_trampoline+0x6e> @ imm = #-0x4
      72: b008         	add	sp, #0x20
      74: bd80         	pop	{r7, pc}
      76: f7ff fffe    	bl	0x76 <__main_trampoline+0x76> @ imm = #-0x4
      7a: defe         	trap
      7c: 9806         	ldr	r0, [sp, #0x18]
      7e: f7ff fffe    	bl	0x7e <__main_trampoline+0x7e> @ imm = #-0x4
      82: defe         	trap

Disassembly of section .text._ZN7mailbox4main17h17fdd550b74349dfE:

00000000 <mailbox::main::h17fdd550b74349df>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f5bc 7fc0    	.word	#0xf5bc7fc0
      10: da02         	bge	0x18 <mailbox::main::h17fdd550b74349df+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0060         	lsls	r0, r4, #0x1
      16: 0000         	movs	r0, r0
      18: b5b0         	push	{r4, r5, r7, lr}
      1a: af02         	add	r7, sp, #0x8
      1c: b0dc         	sub	sp, #0x170
      1e: f7ff fffe    	bl	0x1e <mailbox::main::h17fdd550b74349df+0x1e> @ imm = #-0x4
      22: a821         	add	r0, sp, #0x84
      24: 9002         	str	r0, [sp, #0x8]
      26: f7ff fffe    	bl	0x26 <mailbox::main::h17fdd550b74349df+0x26> @ imm = #-0x4
      2a: 9a02         	ldr	r2, [sp, #0x8]
      2c: a912         	add	r1, sp, #0x48
      2e: 4608         	mov	r0, r1
      30: e8b2 5038    	.word	#0xe8b25038
      34: e8a0 5038    	.word	#0xe8a05038
      38: e8b2 5038    	.word	#0xe8b25038
      3c: e8a0 5038    	.word	#0xe8a05038
      40: e892 5038    	.word	#0xe8925038
      44: e880 5038    	.word	#0xe8805038
      48: a808         	add	r0, sp, #0x20
      4a: 9005         	str	r0, [sp, #0x14]
      4c: f7ff fffe    	bl	0x4c <mailbox::main::h17fdd550b74349df+0x4c> @ imm = #-0x4
      50: f7ff fffe    	bl	0x50 <mailbox::main::h17fdd550b74349df+0x50> @ imm = #-0x4
      54: f7ff fffe    	bl	0x54 <mailbox::main::h17fdd550b74349df+0x54> @ imm = #-0x4
      58: f7ff fffe    	bl	0x58 <mailbox::main::h17fdd550b74349df+0x58> @ imm = #-0x4
      5c: a833         	add	r0, sp, #0xcc
      5e: 9003         	str	r0, [sp, #0xc]
      60: f7ff fffe    	bl	0x60 <mailbox::main::h17fdd550b74349df+0x60> @ imm = #-0x4
      64: f44f 30e1    	.word	#0xf44f30e1
      68: f7ff fffe    	bl	0x68 <mailbox::main::h17fdd550b74349df+0x68> @ imm = #-0x4
      6c: 9903         	ldr	r1, [sp, #0xc]
      6e: 4602         	mov	r2, r0
      70: a831         	add	r0, sp, #0xc4
      72: 9004         	str	r0, [sp, #0x10]
      74: f7ff fffe    	bl	0x74 <mailbox::main::h17fdd550b74349df+0x74> @ imm = #-0x4
      78: 9804         	ldr	r0, [sp, #0x10]
      7a: 9905         	ldr	r1, [sp, #0x14]
      7c: f7ff fffe    	bl	0x7c <mailbox::main::h17fdd550b74349df+0x7c> @ imm = #-0x4
      80: f240 0200    	.word	#0xf2400200
      84: f2c0 0200    	.word	#0xf2c00200
      88: f7ff fffe    	bl	0x88 <mailbox::main::h17fdd550b74349df+0x88> @ imm = #-0x4
      8c: f7ff fffe    	bl	0x8c <mailbox::main::h17fdd550b74349df+0x8c> @ imm = #-0x4
      90: f807 0c29    	.word	#0xf8070c29
      94: f807 1cb5    	.word	#0xf8071cb5
      98: f1a7 00b5    	.word	#0xf1a700b5
      9c: f7ff fffe    	bl	0x9c <mailbox::main::h17fdd550b74349df+0x9c> @ imm = #-0x4
      a0: f817 0cb5    	.word	#0xf8170cb5
      a4: f807 0ca1    	.word	#0xf8070ca1
      a8: f817 0ca1    	.word	#0xf8170ca1
      ac: f240 0100    	.word	#0xf2400100
      b0: f2c0 0100    	.word	#0xf2c00100
      b4: 7008         	strb	r0, [r1]
      b6: a83d         	add	r0, sp, #0xf4
      b8: 9006         	str	r0, [sp, #0x18]
      ba: f7ff fffe    	bl	0xba <mailbox::main::h17fdd550b74349df+0xba> @ imm = #-0x4
      be: 9906         	ldr	r1, [sp, #0x18]
      c0: a836         	add	r0, sp, #0xd8
      c2: 3004         	adds	r0, #0x4
      c4: e891 503c    	.word	#0xe891503c
      c8: e880 503c    	.word	#0xe880503c
      cc: 2001         	movs	r0, #0x1
      ce: 9036         	str	r0, [sp, #0xd8]
      d0: f240 0000    	.word	#0xf2400000
      d4: f2c0 0000    	.word	#0xf2c00000
      d8: f7ff fffe    	bl	0xd8 <mailbox::main::h17fdd550b74349df+0xd8> @ imm = #-0x4
      dc: e013         	b	0x106 <mailbox::main::h17fdd550b74349df+0x106> @ imm = #0x26
      de: f240 0000    	.word	#0xf2400000
      e2: f2c0 0000    	.word	#0xf2c00000
      e6: a936         	add	r1, sp, #0xd8
      e8: e8b1 100c    	.word	#0xe8b1100c
      ec: e8a0 100c    	.word	#0xe8a0100c
      f0: e891 500c    	.word	#0xe891500c
      f4: e880 500c    	.word	#0xe880500c
      f8: 9854         	ldr	r0, [sp, #0x150]
      fa: f7ff fffe    	bl	0xfa <mailbox::main::h17fdd550b74349df+0xfa> @ imm = #-0x4
      fe: defe         	trap
     100: 9054         	str	r0, [sp, #0x150]
     102: 9155         	str	r1, [sp, #0x154]
     104: e7eb         	b	0xde <mailbox::main::h17fdd550b74349df+0xde> @ imm = #-0x2a
     106: f240 0000    	.word	#0xf2400000
     10a: f2c0 0000    	.word	#0xf2c00000
     10e: a936         	add	r1, sp, #0xd8
     110: e8b1 100c    	.word	#0xe8b1100c
     114: e8a0 100c    	.word	#0xe8a0100c
     118: e891 500c    	.word	#0xe891500c
     11c: e880 500c    	.word	#0xe880500c
     120: 2025         	movs	r0, #0x25
     122: f827 0c6a    	.word	#0xf8270c6a
     126: f837 0c6a    	.word	#0xf8370c6a
     12a: f7ff fffe    	bl	0x12a <mailbox::main::h17fdd550b74349df+0x12a> @ imm = #-0x4
     12e: 2000         	movs	r0, #0x0
     130: 9044         	str	r0, [sp, #0x110]
     132: 200a         	movs	r0, #0xa
     134: 9045         	str	r0, [sp, #0x114]
     136: 9844         	ldr	r0, [sp, #0x110]
     138: 9945         	ldr	r1, [sp, #0x114]
     13a: f7ff fffe    	bl	0x13a <mailbox::main::h17fdd550b74349df+0x13a> @ imm = #-0x4
     13e: 9046         	str	r0, [sp, #0x118]
     140: 9147         	str	r1, [sp, #0x11c]
     142: e7ff         	b	0x144 <mailbox::main::h17fdd550b74349df+0x144> @ imm = #-0x2
     144: a846         	add	r0, sp, #0x118
     146: f7ff fffe    	bl	0x146 <mailbox::main::h17fdd550b74349df+0x146> @ imm = #-0x4
     14a: 9149         	str	r1, [sp, #0x124]
     14c: 9048         	str	r0, [sp, #0x120]
     14e: 9848         	ldr	r0, [sp, #0x120]
     150: b920         	cbnz	r0, 0x15c <mailbox::main::h17fdd550b74349df+0x15c> @ imm = #0x8
     152: e7ff         	b	0x154 <mailbox::main::h17fdd550b74349df+0x154> @ imm = #-0x2
     154: 2001         	movs	r0, #0x1
     156: f7ff fffe    	bl	0x156 <mailbox::main::h17fdd550b74349df+0x156> @ imm = #-0x4
     15a: defe         	trap
     15c: f240 0000    	.word	#0xf2400000
     160: f2c0 0000    	.word	#0xf2c00000
     164: f7ff fffe    	bl	0x164 <mailbox::main::h17fdd550b74349df+0x164> @ imm = #-0x4
     168: f240 0100    	.word	#0xf2400100
     16c: f2c0 0100    	.word	#0xf2c00100
     170: f7ff fffe    	bl	0x170 <mailbox::main::h17fdd550b74349df+0x170> @ imm = #-0x4
     174: f640 31b8    	.word	#0xf64031b8
     178: f7ff fffe    	bl	0x178 <mailbox::main::h17fdd550b74349df+0x178> @ imm = #-0x4
     17c: f807 0c1d    	.word	#0xf8070c1d
     180: b940         	cbnz	r0, 0x194 <mailbox::main::h17fdd550b74349df+0x194> @ imm = #0x10
     182: e7ff         	b	0x184 <mailbox::main::h17fdd550b74349df+0x184> @ imm = #-0x2
     184: f240 0000    	.word	#0xf2400000
     188: f2c0 0000    	.word	#0xf2c00000
     18c: 2111         	movs	r1, #0x11
     18e: f7ff fffe    	bl	0x18e <mailbox::main::h17fdd550b74349df+0x18e> @ imm = #-0x4
     192: e7d7         	b	0x144 <mailbox::main::h17fdd550b74349df+0x144> @ imm = #-0x52
     194: f240 0000    	.word	#0xf2400000
     198: f2c0 0000    	.word	#0xf2c00000
     19c: 2117         	movs	r1, #0x17
     19e: f7ff fffe    	bl	0x19e <mailbox::main::h17fdd550b74349df+0x19e> @ imm = #-0x4
     1a2: f240 0000    	.word	#0xf2400000
     1a6: f2c0 0000    	.word	#0xf2c00000
     1aa: 7800         	ldrb	r0, [r0]
     1ac: f807 0c4d    	.word	#0xf8070c4d
     1b0: f1a7 014d    	.word	#0xf1a7014d
     1b4: 9157         	str	r1, [sp, #0x15c]
     1b6: 915a         	str	r1, [sp, #0x168]
     1b8: f240 0000    	.word	#0xf2400000
     1bc: f2c0 0000    	.word	#0xf2c00000
     1c0: 905b         	str	r0, [sp, #0x16c]
     1c2: 9158         	str	r1, [sp, #0x160]
     1c4: 9059         	str	r0, [sp, #0x164]
     1c6: 9958         	ldr	r1, [sp, #0x160]
     1c8: 9859         	ldr	r0, [sp, #0x164]
     1ca: 9151         	str	r1, [sp, #0x144]
     1cc: 9052         	str	r0, [sp, #0x148]
     1ce: 4669         	mov	r1, sp
     1d0: 2001         	movs	r0, #0x1
     1d2: 6008         	str	r0, [r1]
     1d4: f240 0100    	.word	#0xf2400100
     1d8: f2c0 0100    	.word	#0xf2c00100
     1dc: a84b         	add	r0, sp, #0x12c
     1de: 9001         	str	r0, [sp, #0x4]
     1e0: 2202         	movs	r2, #0x2
     1e2: ab51         	add	r3, sp, #0x144
     1e4: f7ff fffe    	bl	0x1e4 <mailbox::main::h17fdd550b74349df+0x1e4> @ imm = #-0x4
     1e8: 9801         	ldr	r0, [sp, #0x4]
     1ea: f7ff fffe    	bl	0x1ea <mailbox::main::h17fdd550b74349df+0x1ea> @ imm = #-0x4
     1ee: e7a9         	b	0x144 <mailbox::main::h17fdd550b74349df+0x144> @ imm = #-0xae

Disassembly of section .text.USART1:

00000000 <USART1>:
       0: 4801         	ldr	r0, [pc, #0x4]          @ 0x8 <USART1+0x8>
       2: f7ff bffe    	.word	#0xf7ffbffe
       6: defe         	trap

00000008 <$d.87>:
       8: 00 00 00 00  	.word	0x00000000

Disassembly of section .text._ZN7mailbox14usart1_handler17h65bf238da9223ea9E:

00000000 <mailbox::usart1_handler::h65bf238da9223ea9>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f08    	.word	#0xf1bc0f08
      10: da02         	bge	0x18 <mailbox::usart1_handler::h65bf238da9223ea9+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0002         	movs	r2, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: f7ff fffe    	bl	0x1c <mailbox::usart1_handler::h65bf238da9223ea9+0x1c> @ imm = #-0x4
      20: bd80         	pop	{r7, pc}

Disassembly of section .text._ZN7mailbox14usart1_handler28_$u7b$$u7b$closure$u7d$$u7d$17h7908c27d9960e9d1E:

00000000 <mailbox::usart1_handler::_$u7b$$u7b$closure$u7d$$u7d$::h7908c27d9960e9d1>:
       0: f04f 5c00    	.word	#0xf04f5c00
       4: f8dc c000    	.word	#0xf8dcc000
       8: ebbd 0c0c    	.word	#0xebbd0c0c
       c: f1bc 0f10    	.word	#0xf1bc0f10
      10: da02         	bge	0x18 <mailbox::usart1_handler::_$u7b$$u7b$closure$u7d$$u7d$::h7908c27d9960e9d1+0x18> @ imm = #0x4
      12: dfff         	svc	#0xff
      14: 0004         	movs	r4, r0
      16: 0000         	movs	r0, r0
      18: b580         	push	{r7, lr}
      1a: 466f         	mov	r7, sp
      1c: b082         	sub	sp, #0x8
      1e: 9001         	str	r0, [sp, #0x4]
      20: f240 0000    	.word	#0xf2400000
      24: f2c0 0000    	.word	#0xf2c00000
      28: f7ff fffe    	bl	0x28 <mailbox::usart1_handler::_$u7b$$u7b$closure$u7d$$u7d$::h7908c27d9960e9d1+0x28> @ imm = #-0x4
      2c: f240 0100    	.word	#0xf2400100
      30: f2c0 0100    	.word	#0xf2c00100
      34: f7ff fffe    	bl	0x34 <mailbox::usart1_handler::_$u7b$$u7b$closure$u7d$$u7d$::h7908c27d9960e9d1+0x34> @ imm = #-0x4
      38: f7ff fffe    	bl	0x38 <mailbox::usart1_handler::_$u7b$$u7b$closure$u7d$$u7d$::h7908c27d9960e9d1+0x38> @ imm = #-0x4
      3c: f000 0001    	.word	#0xf0000001
      40: f240 0200    	.word	#0xf2400200
      44: f2c0 0200    	.word	#0xf2c00200
      48: f7ff fffe    	bl	0x48 <mailbox::usart1_handler::_$u7b$$u7b$closure$u7d$$u7d$::h7908c27d9960e9d1+0x48> @ imm = #-0x4
      4c: f240 0100    	.word	#0xf2400100
      50: f2c0 0100    	.word	#0xf2c00100
      54: 7008         	strb	r0, [r1]
      56: f240 0000    	.word	#0xf2400000
      5a: f2c0 0000    	.word	#0xf2c00000
      5e: f7ff fffe    	bl	0x5e <mailbox::usart1_handler::_$u7b$$u7b$closure$u7d$$u7d$::h7908c27d9960e9d1+0x5e> @ imm = #-0x4
      62: f240 0100    	.word	#0xf2400100
      66: f2c0 0100    	.word	#0xf2c00100
      6a: f7ff fffe    	bl	0x6a <mailbox::usart1_handler::_$u7b$$u7b$closure$u7d$$u7d$::h7908c27d9960e9d1+0x6a> @ imm = #-0x4
      6e: f7ff fffe    	bl	0x6e <mailbox::usart1_handler::_$u7b$$u7b$closure$u7d$$u7d$::h7908c27d9960e9d1+0x6e> @ imm = #-0x4
      72: b002         	add	sp, #0x8
      74: bd80         	pop	{r7, pc}
