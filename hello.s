
a.out:	file format elf32-littlearm

Disassembly of section .text:

0f0001a8 <Reset>:
 f0001a8: 4814         	ldr	r0, [pc, #0x50]         @ 0xf0001fc <Reset+0x54>
 f0001aa: 4915         	ldr	r1, [pc, #0x54]         @ 0xf000200 <Reset+0x58>
 f0001ac: eba1 0100    	.word	#0xeba10100
 f0001b0: f000 fae4    	bl	0xf00077c <memclr>      @ imm = #0x5c8
 f0001b4: 4813         	ldr	r0, [pc, #0x4c]         @ 0xf000204 <Reset+0x5c>
 f0001b6: 4914         	ldr	r1, [pc, #0x50]         @ 0xf000208 <Reset+0x60>
 f0001b8: 4a14         	ldr	r2, [pc, #0x50]         @ 0xf00020c <Reset+0x64>
 f0001ba: eba2 0200    	.word	#0xeba20200
 f0001be: f000 fae2    	bl	0xf000786 <memcpy>      @ imm = #0x5c4
 f0001c2: f04f 5000    	.word	#0xf04f5000
 f0001c6: f04f 01aa    	.word	#0xf04f01aa
 f0001ca: f44f 5280    	.word	#0xf44f5280
 f0001ce: f000 fae1    	bl	0xf000794 <memset>      @ imm = #0x5c2
 f0001d2: 480f         	ldr	r0, [pc, #0x3c]         @ 0xf000210 <Reset+0x68>
 f0001d4: 490f         	ldr	r1, [pc, #0x3c]         @ 0xf000214 <Reset+0x6c>
 f0001d6: 6008         	str	r0, [r1]
 f0001d8: 480f         	ldr	r0, [pc, #0x3c]         @ 0xf000218 <Reset+0x70>
 f0001da: 4910         	ldr	r1, [pc, #0x40]         @ 0xf00021c <Reset+0x74>
 f0001dc: 6008         	str	r0, [r1]
 f0001de: 4810         	ldr	r0, [pc, #0x40]         @ 0xf000220 <Reset+0x78>
 f0001e0: 4910         	ldr	r1, [pc, #0x40]         @ 0xf000224 <Reset+0x7c>
 f0001e2: 6008         	str	r0, [r1]
 f0001e4: 4810         	ldr	r0, [pc, #0x40]         @ 0xf000228 <Reset+0x80>
 f0001e6: 4911         	ldr	r1, [pc, #0x44]         @ 0xf00022c <Reset+0x84>
 f0001e8: 6008         	str	r0, [r1]
 f0001ea: 4911         	ldr	r1, [pc, #0x44]         @ 0xf000230 <Reset+0x88>
 f0001ec: f04f 5000    	.word	#0xf04f5000
 f0001f0: 6001         	str	r1, [r0]
 f0001f2: f04f 0e00    	.word	#0xf04f0e00
 f0001f6: f000 bad5    	.word	#0xf000bad5
 f0001fa: defe         	trap

0f0001fc <$d.90>:
 f0001fc: 48 66 00 20  	.word	0x20006648
 f000200: 7c 67 00 20  	.word	0x2000677c
 f000204: 88 64 00 20  	.word	0x20006488
 f000208: 8c 60 00 0f  	.word	0x0f00608c
 f00020c: 44 66 00 20  	.word	0x20006644
 f000210: 00 59 00 0f  	.word	0x0f005900
 f000214: 3c 67 00 20  	.word	0x2000673c
 f000218: b8 5a 00 0f  	.word	0x0f005ab8
 f00021c: 40 67 00 20  	.word	0x20006740
 f000220: b8 5a 00 0f  	.word	0x0f005ab8
 f000224: 44 67 00 20  	.word	0x20006744
 f000228: 8c 60 00 0f  	.word	0x0f00608c
 f00022c: 48 67 00 20  	.word	0x20006748
 f000230: 10 00 00 20  	.word	0x20000010

0f000234 <__main_trampoline>:
 f000234: f04f 5c00    	.word	#0xf04f5c00
 f000238: f8dc c000    	.word	#0xf8dcc000
 f00023c: ebbd 0c0c    	.word	#0xebbd0c0c
 f000240: f1bc 0f28    	.word	#0xf1bc0f28
 f000244: da02         	bge	0xf00024c <__main_trampoline+0x18> @ imm = #0x4
 f000246: dfff         	svc	#0xff
 f000248: 000a         	movs	r2, r1
 f00024a: 0000         	movs	r0, r0
 f00024c: b5f0         	push	{r4, r5, r6, r7, lr}
 f00024e: af03         	add	r7, sp, #0xc
 f000250: f84d 8d04    	.word	#0xf84d8d04
 f000254: b084         	sub	sp, #0x10
 f000256: f246 7618    	.word	#0xf2467618
 f00025a: f2c2 0600    	.word	#0xf2c20600
 f00025e: f896 0058    	.word	#0xf8960058
 f000262: b100         	cbz	r0, 0xf000266 <__main_trampoline+0x32> @ imm = #0x0
 f000264: e7fe         	b	0xf000264 <__main_trampoline+0x30> @ imm = #-0x4
 f000266: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00026a: e856 0f0f    	.word	#0xe8560f0f
 f00026e: 3001         	adds	r0, #0x1
 f000270: e846 010f    	.word	#0xe846010f
 f000274: 2900         	cmp	r1, #0x0
 f000276: d1f8         	bne	0xf00026a <__main_trampoline+0x36> @ imm = #-0x10
 f000278: f64e 5804    	.word	#0xf64e5804
 f00027c: 2001         	movs	r0, #0x1
 f00027e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000282: 7070         	strb	r0, [r6, #0x1]
 f000284: f2ce 0800    	.word	#0xf2ce0800
 f000288: 2000         	movs	r0, #0x0
 f00028a: f888 001b    	.word	#0xf888001b
 f00028e: 2060         	movs	r0, #0x60
 f000290: f380 8811    	.word	#0xf3808811
 f000294: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000298: e856 0f10    	.word	#0xe8560f10
 f00029c: 3001         	adds	r0, #0x1
 f00029e: e846 0110    	.word	#0xe8460110
 f0002a2: 2900         	cmp	r1, #0x0
 f0002a4: d1f8         	bne	0xf000298 <__main_trampoline+0x64> @ imm = #-0x10
 f0002a6: 2800         	cmp	r0, #0x0
 f0002a8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0002ac: f000 80d4    	.word	#0xf00080d4
 f0002b0: f106 0058    	.word	#0xf1060058
 f0002b4: 2101         	movs	r1, #0x1
 f0002b6: e8d0 2f4f    	.word	#0xe8d02f4f
 f0002ba: b952         	cbnz	r2, 0xf0002d2 <__main_trampoline+0x9e> @ imm = #0x14
 f0002bc: e8c0 1f42    	.word	#0xe8c01f42
 f0002c0: 2a00         	cmp	r2, #0x0
 f0002c2: d1f8         	bne	0xf0002b6 <__main_trampoline+0x82> @ imm = #-0x10
 f0002c4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0002c8: 6df0         	ldr	r0, [r6, #0x5c]
 f0002ca: 2800         	cmp	r0, #0x0
 f0002cc: d044         	beq	0xf000358 <__main_trampoline+0x124> @ imm = #0x88
 f0002ce: 6e32         	ldr	r2, [r6, #0x60]
 f0002d0: e055         	b	0xf00037e <__main_trampoline+0x14a> @ imm = #0xaa
 f0002d2: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0002d6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0002da: e856 0f10    	.word	#0xe8560f10
 f0002de: 1e41         	subs	r1, r0, #0x1
 f0002e0: e846 1210    	.word	#0xe8461210
 f0002e4: 2a00         	cmp	r2, #0x0
 f0002e6: d1f8         	bne	0xf0002da <__main_trampoline+0xa6> @ imm = #-0x10
 f0002e8: 2801         	cmp	r0, #0x1
 f0002ea: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0002ee: d008         	beq	0xf000302 <__main_trampoline+0xce> @ imm = #0x10
 f0002f0: b978         	cbnz	r0, 0xf000312 <__main_trampoline+0xde> @ imm = #0x1e
 f0002f2: f245 60f6    	.word	#0xf24560f6
 f0002f6: 211e         	movs	r1, #0x1e
 f0002f8: f6c0 7000    	.word	#0xf6c07000
 f0002fc: f000 f9a5    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #0x34a
 f000300: e0d1         	b	0xf0004a6 <__main_trampoline+0x272> @ imm = #0x1a2
 f000302: 20e0         	movs	r0, #0xe0
 f000304: f380 8811    	.word	#0xf3808811
 f000308: 2001         	movs	r0, #0x1
 f00030a: 7070         	strb	r0, [r6, #0x1]
 f00030c: 20c0         	movs	r0, #0xc0
 f00030e: f888 001b    	.word	#0xf888001b
 f000312: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000316: e856 0f0f    	.word	#0xe8560f0f
 f00031a: 3801         	subs	r0, #0x1
 f00031c: e846 010f    	.word	#0xe846010f
 f000320: 2900         	cmp	r1, #0x0
 f000322: d1f8         	bne	0xf000316 <__main_trampoline+0xe2> @ imm = #-0x10
 f000324: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000328: 7970         	ldrb	r0, [r6, #0x5]
 f00032a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00032e: 2800         	cmp	r0, #0x0
 f000330: d098         	beq	0xf000264 <__main_trampoline+0x30> @ imm = #-0xd0
 f000332: 6bf0         	ldr	r0, [r6, #0x3c]
 f000334: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000338: 2800         	cmp	r0, #0x0
 f00033a: d193         	bne	0xf000264 <__main_trampoline+0x30> @ imm = #-0xda
 f00033c: f3ef 8005    	.word	#0xf3ef8005
 f000340: 2800         	cmp	r0, #0x0
 f000342: f000 807e    	.word	#0xf000807e
 f000346: f3ef 8005    	.word	#0xf3ef8005
 f00034a: 280e         	cmp	r0, #0xe
 f00034c: bf1c         	itt	ne
 f00034e: f04f 5080    	.word	#0xf04f5080
 f000352: f8c8 0000    	.word	#0xf8c80000
 f000356: e785         	b	0xf000264 <__main_trampoline+0x30> @ imm = #-0xf6
 f000358: 2003         	movs	r0, #0x3
 f00035a: a901         	add	r1, sp, #0x4
 f00035c: 9003         	str	r0, [sp, #0xc]
 f00035e: 2004         	movs	r0, #0x4
 f000360: 9002         	str	r0, [sp, #0x8]
 f000362: f245 6040    	.word	#0xf2456040
 f000366: f6c0 7000    	.word	#0xf6c07000
 f00036a: 2301         	movs	r3, #0x1
 f00036c: 9001         	str	r0, [sp, #0x4]
 f00036e: 2001         	movs	r0, #0x1
 f000370: beab         	bkpt	#0xab
 f000372: 4602         	mov	r2, r0
 f000374: 3001         	adds	r0, #0x1
 f000376: f000 8077    	.word	#0xf0008077
 f00037a: e9c6 3217    	.word	#0xe9c63217
 f00037e: 200d         	movs	r0, #0xd
 f000380: a901         	add	r1, sp, #0x4
 f000382: 9003         	str	r0, [sp, #0xc]
 f000384: f245 6030    	.word	#0xf2456030
 f000388: f6c0 7000    	.word	#0xf6c07000
 f00038c: e9cd 2001    	.word	#0xe9cd2001
 f000390: 2005         	movs	r0, #0x5
 f000392: beab         	bkpt	#0xab
 f000394: 1e41         	subs	r1, r0, #0x1
 f000396: 290c         	cmp	r1, #0xc
 f000398: d811         	bhi	0xf0003be <__main_trampoline+0x18a> @ imm = #0x22
 f00039a: f245 6330    	.word	#0xf2456330
 f00039e: a901         	add	r1, sp, #0x4
 f0003a0: f6c0 7300    	.word	#0xf6c07300
 f0003a4: 250d         	movs	r5, #0xd
 f0003a6: 4604         	mov	r4, r0
 f0003a8: 9003         	str	r0, [sp, #0xc]
 f0003aa: 1a28         	subs	r0, r5, r0
 f0003ac: 9201         	str	r2, [sp, #0x4]
 f0003ae: 4403         	add	r3, r0
 f0003b0: 9302         	str	r3, [sp, #0x8]
 f0003b2: 2005         	movs	r0, #0x5
 f0003b4: beab         	bkpt	#0xab
 f0003b6: 1e45         	subs	r5, r0, #0x1
 f0003b8: 42a5         	cmp	r5, r4
 f0003ba: 4625         	mov	r5, r4
 f0003bc: d3f3         	blo	0xf0003a6 <__main_trampoline+0x172> @ imm = #-0x1a
 f0003be: 2000         	movs	r0, #0x0
 f0003c0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0003c4: f886 0058    	.word	#0xf8860058
 f0003c8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0003cc: e856 0f10    	.word	#0xe8560f10
 f0003d0: 1e41         	subs	r1, r0, #0x1
 f0003d2: e846 1210    	.word	#0xe8461210
 f0003d6: 2a00         	cmp	r2, #0x0
 f0003d8: d1f8         	bne	0xf0003cc <__main_trampoline+0x198> @ imm = #-0x10
 f0003da: 2801         	cmp	r0, #0x1
 f0003dc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0003e0: d008         	beq	0xf0003f4 <__main_trampoline+0x1c0> @ imm = #0x10
 f0003e2: b978         	cbnz	r0, 0xf000404 <__main_trampoline+0x1d0> @ imm = #0x1e
 f0003e4: f245 60f6    	.word	#0xf24560f6
 f0003e8: 211e         	movs	r1, #0x1e
 f0003ea: f6c0 7000    	.word	#0xf6c07000
 f0003ee: f000 f92c    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #0x258
 f0003f2: e058         	b	0xf0004a6 <__main_trampoline+0x272> @ imm = #0xb0
 f0003f4: 20e0         	movs	r0, #0xe0
 f0003f6: f380 8811    	.word	#0xf3808811
 f0003fa: 2001         	movs	r0, #0x1
 f0003fc: 7070         	strb	r0, [r6, #0x1]
 f0003fe: 20c0         	movs	r0, #0xc0
 f000400: f888 001b    	.word	#0xf888001b
 f000404: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000408: e856 0f0f    	.word	#0xe8560f0f
 f00040c: 3801         	subs	r0, #0x1
 f00040e: e846 010f    	.word	#0xe846010f
 f000412: 2900         	cmp	r1, #0x0
 f000414: d1f8         	bne	0xf000408 <__main_trampoline+0x1d4> @ imm = #-0x10
 f000416: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00041a: 7970         	ldrb	r0, [r6, #0x5]
 f00041c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000420: b1a0         	cbz	r0, 0xf00044c <__main_trampoline+0x218> @ imm = #0x28
 f000422: 6bf0         	ldr	r0, [r6, #0x3c]
 f000424: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000428: b980         	cbnz	r0, 0xf00044c <__main_trampoline+0x218> @ imm = #0x20
 f00042a: f3ef 8005    	.word	#0xf3ef8005
 f00042e: b158         	cbz	r0, 0xf000448 <__main_trampoline+0x214> @ imm = #0x16
 f000430: f3ef 8005    	.word	#0xf3ef8005
 f000434: 280e         	cmp	r0, #0xe
 f000436: bf1c         	itt	ne
 f000438: f04f 5080    	.word	#0xf04f5080
 f00043c: f8c8 0000    	.word	#0xf8c80000
 f000440: e004         	b	0xf00044c <__main_trampoline+0x218> @ imm = #0x8
 f000442: f000 fdba    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #0xb74
 f000446: e70d         	b	0xf000264 <__main_trampoline+0x30> @ imm = #-0x1e6
 f000448: f000 fdb7    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #0xb6e
 f00044c: 2126         	movs	r1, #0x26
 f00044e: 2018         	movs	r0, #0x18
 f000450: f2c0 0102    	.word	#0xf2c00102
 f000454: beab         	bkpt	#0xab
 f000456: e7fe         	b	0xf000456 <__main_trampoline+0x222> @ imm = #-0x4
 f000458: f245 60cf    	.word	#0xf24560cf
 f00045c: 2127         	movs	r1, #0x27
 f00045e: f6c0 7000    	.word	#0xf6c07000
 f000462: f000 f8f2    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #0x1e4
 f000466: e01e         	b	0xf0004a6 <__main_trampoline+0x272> @ imm = #0x3c
 f000468: a801         	add	r0, sp, #0x4
 f00046a: f000 f910    	bl	0xf00068e <core::result::unwrap_failed::h8eb3fe0ea9f92dea> @ imm = #0x220
 f00046e: e01a         	b	0xf0004a6 <__main_trampoline+0x272> @ imm = #0x34
 f000470: 4604         	mov	r4, r0
 f000472: 2000         	movs	r0, #0x0
 f000474: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000478: f886 0058    	.word	#0xf8860058
 f00047c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000480: e856 0f10    	.word	#0xe8560f10
 f000484: 1e41         	subs	r1, r0, #0x1
 f000486: e846 1210    	.word	#0xe8461210
 f00048a: 2a00         	cmp	r2, #0x0
 f00048c: d1f8         	bne	0xf000480 <__main_trampoline+0x24c> @ imm = #-0x10
 f00048e: 2801         	cmp	r0, #0x1
 f000490: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000494: d008         	beq	0xf0004a8 <__main_trampoline+0x274> @ imm = #0x10
 f000496: b978         	cbnz	r0, 0xf0004b8 <__main_trampoline+0x284> @ imm = #0x1e
 f000498: f245 60f6    	.word	#0xf24560f6
 f00049c: 211e         	movs	r1, #0x1e
 f00049e: f6c0 7000    	.word	#0xf6c07000
 f0004a2: f000 f8d2    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #0x1a4
 f0004a6: defe         	trap
 f0004a8: 20e0         	movs	r0, #0xe0
 f0004aa: f380 8811    	.word	#0xf3808811
 f0004ae: 2001         	movs	r0, #0x1
 f0004b0: 7070         	strb	r0, [r6, #0x1]
 f0004b2: 20c0         	movs	r0, #0xc0
 f0004b4: f888 001b    	.word	#0xf888001b
 f0004b8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0004bc: e856 0f0f    	.word	#0xe8560f0f
 f0004c0: 3801         	subs	r0, #0x1
 f0004c2: e846 010f    	.word	#0xe846010f
 f0004c6: 2900         	cmp	r1, #0x0
 f0004c8: d1f8         	bne	0xf0004bc <__main_trampoline+0x288> @ imm = #-0x10
 f0004ca: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0004ce: 7970         	ldrb	r0, [r6, #0x5]
 f0004d0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0004d4: 2800         	cmp	r0, #0x0
 f0004d6: f000 80a0    	.word	#0xf00080a0
 f0004da: 6bf0         	ldr	r0, [r6, #0x3c]
 f0004dc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0004e0: 2800         	cmp	r0, #0x0
 f0004e2: f040 809a    	.word	#0xf040809a
 f0004e6: f3ef 8005    	.word	#0xf3ef8005
 f0004ea: b910         	cbnz	r0, 0xf0004f2 <__main_trampoline+0x2be> @ imm = #0x4
 f0004ec: f000 fd65    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #0xaca
 f0004f0: e093         	b	0xf00061a <__main_trampoline+0x3e6> @ imm = #0x126
 f0004f2: f3ef 8005    	.word	#0xf3ef8005
 f0004f6: e08a         	b	0xf00060e <__main_trampoline+0x3da> @ imm = #0x114
 f0004f8: f000 f923    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #0x246
 f0004fc: defe         	trap
 f0004fe: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000502: e856 0f0f    	.word	#0xe8560f0f
 f000506: 3801         	subs	r0, #0x1
 f000508: e846 010f    	.word	#0xe846010f
 f00050c: 2900         	cmp	r1, #0x0
 f00050e: d1f8         	bne	0xf000502 <__main_trampoline+0x2ce> @ imm = #-0x10
 f000510: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000514: 7970         	ldrb	r0, [r6, #0x5]
 f000516: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00051a: b168         	cbz	r0, 0xf000538 <__main_trampoline+0x304> @ imm = #0x1a
 f00051c: 6bf0         	ldr	r0, [r6, #0x3c]
 f00051e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000522: b948         	cbnz	r0, 0xf000538 <__main_trampoline+0x304> @ imm = #0x12
 f000524: f3ef 8005    	.word	#0xf3ef8005
 f000528: b910         	cbnz	r0, 0xf000530 <__main_trampoline+0x2fc> @ imm = #0x4
 f00052a: f000 fd46    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #0xa8c
 f00052e: e003         	b	0xf000538 <__main_trampoline+0x304> @ imm = #0x6
 f000530: f3ef 8005    	.word	#0xf3ef8005
 f000534: 280e         	cmp	r0, #0xe
 f000536: d102         	bne	0xf00053e <__main_trampoline+0x30a> @ imm = #0x4
 f000538: f000 f903    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #0x206
 f00053c: defe         	trap
 f00053e: f04f 5080    	.word	#0xf04f5080
 f000542: f8c8 0000    	.word	#0xf8c80000
 f000546: f000 f8fc    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #0x1f8
 f00054a: defe         	trap
 f00054c: f000 f8f9    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #0x1f2
 f000550: defe         	trap
 f000552: 4604         	mov	r4, r0
 f000554: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000558: e856 0f0f    	.word	#0xe8560f0f
 f00055c: 3801         	subs	r0, #0x1
 f00055e: e846 010f    	.word	#0xe846010f
 f000562: 2900         	cmp	r1, #0x0
 f000564: d1f8         	bne	0xf000558 <__main_trampoline+0x324> @ imm = #-0x10
 f000566: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00056a: 7970         	ldrb	r0, [r6, #0x5]
 f00056c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000570: 2800         	cmp	r0, #0x0
 f000572: d052         	beq	0xf00061a <__main_trampoline+0x3e6> @ imm = #0xa4
 f000574: 6bf0         	ldr	r0, [r6, #0x3c]
 f000576: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00057a: 2800         	cmp	r0, #0x0
 f00057c: d14d         	bne	0xf00061a <__main_trampoline+0x3e6> @ imm = #0x9a
 f00057e: f3ef 8005    	.word	#0xf3ef8005
 f000582: b910         	cbnz	r0, 0xf00058a <__main_trampoline+0x356> @ imm = #0x4
 f000584: f000 fd19    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #0xa32
 f000588: e047         	b	0xf00061a <__main_trampoline+0x3e6> @ imm = #0x8e
 f00058a: f3ef 8005    	.word	#0xf3ef8005
 f00058e: e03e         	b	0xf00060e <__main_trampoline+0x3da> @ imm = #0x7c
 f000590: f000 f8d7    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #0x1ae
 f000594: defe         	trap
 f000596: 4604         	mov	r4, r0
 f000598: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00059c: e856 0f0f    	.word	#0xe8560f0f
 f0005a0: 3801         	subs	r0, #0x1
 f0005a2: e846 010f    	.word	#0xe846010f
 f0005a6: 2900         	cmp	r1, #0x0
 f0005a8: d1f8         	bne	0xf00059c <__main_trampoline+0x368> @ imm = #-0x10
 f0005aa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0005ae: 7970         	ldrb	r0, [r6, #0x5]
 f0005b0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0005b4: b388         	cbz	r0, 0xf00061a <__main_trampoline+0x3e6> @ imm = #0x62
 f0005b6: 6bf0         	ldr	r0, [r6, #0x3c]
 f0005b8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0005bc: bb68         	cbnz	r0, 0xf00061a <__main_trampoline+0x3e6> @ imm = #0x5a
 f0005be: f3ef 8005    	.word	#0xf3ef8005
 f0005c2: b910         	cbnz	r0, 0xf0005ca <__main_trampoline+0x396> @ imm = #0x4
 f0005c4: f000 fcf9    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #0x9f2
 f0005c8: e027         	b	0xf00061a <__main_trampoline+0x3e6> @ imm = #0x4e
 f0005ca: f3ef 8005    	.word	#0xf3ef8005
 f0005ce: e01e         	b	0xf00060e <__main_trampoline+0x3da> @ imm = #0x3c
 f0005d0: f000 f8b7    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #0x16e
 f0005d4: defe         	trap
 f0005d6: 4604         	mov	r4, r0
 f0005d8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0005dc: e856 0f0f    	.word	#0xe8560f0f
 f0005e0: 3801         	subs	r0, #0x1
 f0005e2: e846 010f    	.word	#0xe846010f
 f0005e6: 2900         	cmp	r1, #0x0
 f0005e8: d1f8         	bne	0xf0005dc <__main_trampoline+0x3a8> @ imm = #-0x10
 f0005ea: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0005ee: 7970         	ldrb	r0, [r6, #0x5]
 f0005f0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0005f4: b188         	cbz	r0, 0xf00061a <__main_trampoline+0x3e6> @ imm = #0x22
 f0005f6: 6bf0         	ldr	r0, [r6, #0x3c]
 f0005f8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0005fc: b968         	cbnz	r0, 0xf00061a <__main_trampoline+0x3e6> @ imm = #0x1a
 f0005fe: f3ef 8005    	.word	#0xf3ef8005
 f000602: b910         	cbnz	r0, 0xf00060a <__main_trampoline+0x3d6> @ imm = #0x4
 f000604: f000 fcd9    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #0x9b2
 f000608: e007         	b	0xf00061a <__main_trampoline+0x3e6> @ imm = #0xe
 f00060a: f3ef 8005    	.word	#0xf3ef8005
 f00060e: 280e         	cmp	r0, #0xe
 f000610: bf1c         	itt	ne
 f000612: f04f 5080    	.word	#0xf04f5080
 f000616: f8c8 0000    	.word	#0xf8c80000
 f00061a: 4620         	mov	r0, r4
 f00061c: f004 ffda    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x4fb4
 f000620: defe         	trap
 f000622: f000 f88e    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #0x11c
 f000626: defe         	trap

0f000628 <core::panicking::panic_fmt::ha5901c099395c21f>:
 f000628: f04f 5c00    	.word	#0xf04f5c00
 f00062c: f8dc c000    	.word	#0xf8dcc000
 f000630: ebbd 0c0c    	.word	#0xebbd0c0c
 f000634: f1bc 0f08    	.word	#0xf1bc0f08
 f000638: da02         	bge	0xf000640 <core::panicking::panic_fmt::ha5901c099395c21f+0x18> @ imm = #0x4
 f00063a: dfff         	svc	#0xff
 f00063c: 0002         	movs	r2, r0
 f00063e: 0000         	movs	r0, r0
 f000640: b580         	push	{r7, lr}
 f000642: 466f         	mov	r7, sp
 f000644: f004 ffdf    	bl	0xf005606 <rust_begin_unwind> @ imm = #0x4fbe
 f000648: defe         	trap

0f00064a <core::panicking::panic::h8dd566bdcd44a399>:
 f00064a: f04f 5c00    	.word	#0xf04f5c00
 f00064e: f8dc c000    	.word	#0xf8dcc000
 f000652: ebbd 0c0c    	.word	#0xebbd0c0c
 f000656: f1bc 0f08    	.word	#0xf1bc0f08
 f00065a: da02         	bge	0xf000662 <core::panicking::panic::h8dd566bdcd44a399+0x18> @ imm = #0x4
 f00065c: dfff         	svc	#0xff
 f00065e: 0002         	movs	r2, r0
 f000660: 0000         	movs	r0, r0
 f000662: b580         	push	{r7, lr}
 f000664: 466f         	mov	r7, sp
 f000666: f7ff ffdf    	bl	0xf000628 <core::panicking::panic_fmt::ha5901c099395c21f> @ imm = #-0x42
 f00066a: defe         	trap

0f00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca>:
 f00066c: f04f 5c00    	.word	#0xf04f5c00
 f000670: f8dc c000    	.word	#0xf8dcc000
 f000674: ebbd 0c0c    	.word	#0xebbd0c0c
 f000678: f1bc 0f08    	.word	#0xf1bc0f08
 f00067c: da02         	bge	0xf000684 <core::slice::index::slice_index_order_fail::h189d1be8be941fca+0x18> @ imm = #0x4
 f00067e: dfff         	svc	#0xff
 f000680: 0002         	movs	r2, r0
 f000682: 0000         	movs	r0, r0
 f000684: b580         	push	{r7, lr}
 f000686: 466f         	mov	r7, sp
 f000688: f7ff ffce    	bl	0xf000628 <core::panicking::panic_fmt::ha5901c099395c21f> @ imm = #-0x64
 f00068c: defe         	trap

0f00068e <core::result::unwrap_failed::h8eb3fe0ea9f92dea>:
 f00068e: f04f 5c00    	.word	#0xf04f5c00
 f000692: f8dc c000    	.word	#0xf8dcc000
 f000696: ebbd 0c0c    	.word	#0xebbd0c0c
 f00069a: f1bc 0f08    	.word	#0xf1bc0f08
 f00069e: da02         	bge	0xf0006a6 <core::result::unwrap_failed::h8eb3fe0ea9f92dea+0x18> @ imm = #0x4
 f0006a0: dfff         	svc	#0xff
 f0006a2: 0002         	movs	r2, r0
 f0006a4: 0000         	movs	r0, r0
 f0006a6: b580         	push	{r7, lr}
 f0006a8: 466f         	mov	r7, sp
 f0006aa: f7ff ffbd    	bl	0xf000628 <core::panicking::panic_fmt::ha5901c099395c21f> @ imm = #-0x86
 f0006ae: defe         	trap

0f0006b0 <core::panicking::panic_nounwind_fmt::hc20988550c16eb8a>:
 f0006b0: f04f 5c00    	.word	#0xf04f5c00
 f0006b4: f8dc c000    	.word	#0xf8dcc000
 f0006b8: ebbd 0c0c    	.word	#0xebbd0c0c
 f0006bc: f1bc 0f08    	.word	#0xf1bc0f08
 f0006c0: da02         	bge	0xf0006c8 <core::panicking::panic_nounwind_fmt::hc20988550c16eb8a+0x18> @ imm = #0x4
 f0006c2: dfff         	svc	#0xff
 f0006c4: 0002         	movs	r2, r0
 f0006c6: 0000         	movs	r0, r0
 f0006c8: b580         	push	{r7, lr}
 f0006ca: 466f         	mov	r7, sp
 f0006cc: f004 ff9b    	bl	0xf005606 <rust_begin_unwind> @ imm = #0x4f36
 f0006d0: e001         	b	0xf0006d6 <core::panicking::panic_nounwind_fmt::hc20988550c16eb8a+0x26> @ imm = #0x2
 f0006d2: f000 f801    	bl	0xf0006d8 <core::panicking::panic_cannot_unwind::h4fe6a13633462c9f> @ imm = #0x2
 f0006d6: defe         	trap

0f0006d8 <core::panicking::panic_cannot_unwind::h4fe6a13633462c9f>:
 f0006d8: f04f 5c00    	.word	#0xf04f5c00
 f0006dc: f8dc c000    	.word	#0xf8dcc000
 f0006e0: ebbd 0c0c    	.word	#0xebbd0c0c
 f0006e4: f1bc 0f08    	.word	#0xf1bc0f08
 f0006e8: da02         	bge	0xf0006f0 <core::panicking::panic_cannot_unwind::h4fe6a13633462c9f+0x18> @ imm = #0x4
 f0006ea: dfff         	svc	#0xff
 f0006ec: 0002         	movs	r2, r0
 f0006ee: 0000         	movs	r0, r0
 f0006f0: b580         	push	{r7, lr}
 f0006f2: 466f         	mov	r7, sp
 f0006f4: f000 f801    	bl	0xf0006fa <core::panicking::panic_nounwind::hfbf77c74a46080a7> @ imm = #0x2
 f0006f8: defe         	trap

0f0006fa <core::panicking::panic_nounwind::hfbf77c74a46080a7>:
 f0006fa: f04f 5c00    	.word	#0xf04f5c00
 f0006fe: f8dc c000    	.word	#0xf8dcc000
 f000702: ebbd 0c0c    	.word	#0xebbd0c0c
 f000706: f1bc 0f08    	.word	#0xf1bc0f08
 f00070a: da02         	bge	0xf000712 <core::panicking::panic_nounwind::hfbf77c74a46080a7+0x18> @ imm = #0x4
 f00070c: dfff         	svc	#0xff
 f00070e: 0002         	movs	r2, r0
 f000710: 0000         	movs	r0, r0
 f000712: b580         	push	{r7, lr}
 f000714: 466f         	mov	r7, sp
 f000716: 2000         	movs	r0, #0x0
 f000718: f7ff ffca    	bl	0xf0006b0 <core::panicking::panic_nounwind_fmt::hc20988550c16eb8a> @ imm = #-0x6c
 f00071c: defe         	trap

0f00071e <core::panicking::panic_nounwind_nobacktrace::hd0dc27a7e972e884>:
 f00071e: f04f 5c00    	.word	#0xf04f5c00
 f000722: f8dc c000    	.word	#0xf8dcc000
 f000726: ebbd 0c0c    	.word	#0xebbd0c0c
 f00072a: f1bc 0f08    	.word	#0xf1bc0f08
 f00072e: da02         	bge	0xf000736 <core::panicking::panic_nounwind_nobacktrace::hd0dc27a7e972e884+0x18> @ imm = #0x4
 f000730: dfff         	svc	#0xff
 f000732: 0002         	movs	r2, r0
 f000734: 0000         	movs	r0, r0
 f000736: b580         	push	{r7, lr}
 f000738: 466f         	mov	r7, sp
 f00073a: 2001         	movs	r0, #0x1
 f00073c: f7ff ffb8    	bl	0xf0006b0 <core::panicking::panic_nounwind_fmt::hc20988550c16eb8a> @ imm = #-0x90
 f000740: defe         	trap

0f000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5>:
 f000742: f04f 5c00    	.word	#0xf04f5c00
 f000746: f8dc c000    	.word	#0xf8dcc000
 f00074a: ebbd 0c0c    	.word	#0xebbd0c0c
 f00074e: f1bc 0f08    	.word	#0xf1bc0f08
 f000752: da02         	bge	0xf00075a <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5+0x18> @ imm = #0x4
 f000754: dfff         	svc	#0xff
 f000756: 0002         	movs	r2, r0
 f000758: 0000         	movs	r0, r0
 f00075a: b580         	push	{r7, lr}
 f00075c: 466f         	mov	r7, sp
 f00075e: f7ff ffde    	bl	0xf00071e <core::panicking::panic_nounwind_nobacktrace::hd0dc27a7e972e884> @ imm = #-0x44
 f000762: defe         	trap

0f000764 <_critical_section_1_0_acquire>:
 f000764: f3ef 8010    	.word	#0xf3ef8010
 f000768: 2101         	movs	r1, #0x1
 f00076a: b672         	cpsid i
 f00076c: ea21 0000    	.word	#0xea210000
 f000770: 4770         	bx	lr

0f000772 <_critical_section_1_0_release>:
 f000772: 2800         	cmp	r0, #0x0
 f000774: bf08         	it	eq
 f000776: 4770         	bxeq	lr
 f000778: b662         	cpsie i
 f00077a: 4770         	bx	lr

0f00077c <memclr>:
 f00077c: 460a         	mov	r2, r1
 f00077e: 4049         	eors	r1, r1
 f000780: f000 b808    	.word	#0xf000b808
 f000784: defe         	trap

0f000786 <memcpy>:
 f000786: b11a         	cbz	r2, 0xf000790 <memcpy+0xa> @ imm = #0x6
 f000788: 3a01         	subs	r2, #0x1
 f00078a: 5c8b         	ldrb	r3, [r1, r2]
 f00078c: 5483         	strb	r3, [r0, r2]
 f00078e: d1fb         	bne	0xf000788 <memcpy+0x2>  @ imm = #-0xa
 f000790: 4770         	bx	lr
 f000792: defe         	trap

0f000794 <memset>:
 f000794: b122         	cbz	r2, 0xf0007a0 <memset+0xc> @ imm = #0x8
 f000796: 4603         	mov	r3, r0
 f000798: 3a01         	subs	r2, #0x1
 f00079a: f803 1b01    	.word	#0xf8031b01
 f00079e: d1fb         	bne	0xf000798 <memset+0x4>  @ imm = #-0xa
 f0007a0: 4770         	bx	lr
 f0007a2: defe         	trap

0f0007a4 <entry>:
 f0007a4: f04f 5c00    	.word	#0xf04f5c00
 f0007a8: f8dc c000    	.word	#0xf8dcc000
 f0007ac: ebbd 0c0c    	.word	#0xebbd0c0c
 f0007b0: f1bc 0f10    	.word	#0xf1bc0f10
 f0007b4: da02         	bge	0xf0007bc <entry+0x18>  @ imm = #0x4
 f0007b6: dfff         	svc	#0xff
 f0007b8: 0004         	movs	r4, r0
 f0007ba: 0000         	movs	r0, r0
 f0007bc: b5d0         	push	{r4, r6, r7, lr}
 f0007be: af02         	add	r7, sp, #0x8
 f0007c0: f246 7018    	.word	#0xf2467018
 f0007c4: f2c2 0000    	.word	#0xf2c20000
 f0007c8: 7a41         	ldrb	r1, [r0, #0x9]
 f0007ca: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0007ce: 2900         	cmp	r1, #0x0
 f0007d0: d16e         	bne	0xf0008b0 <entry+0x10c> @ imm = #0xdc
 f0007d2: 495c         	ldr	r1, [pc, #0x170]        @ 0xf000944 <entry+0x1a0>
 f0007d4: 1cca         	adds	r2, r1, #0x3
 f0007d6: d300         	blo	0xf0007da <entry+0x36>  @ imm = #0x0
 f0007d8: e7fe         	b	0xf0007d8 <entry+0x34>  @ imm = #-0x4
 f0007da: f022 0103    	.word	#0xf0220103
 f0007de: 0752         	lsls	r2, r2, #0x1d
 f0007e0: d402         	bmi	0xf0007e8 <entry+0x44>  @ imm = #0x4
 f0007e2: 3104         	adds	r1, #0x4
 f0007e4: d300         	blo	0xf0007e8 <entry+0x44>  @ imm = #0x0
 f0007e6: e7fe         	b	0xf0007e6 <entry+0x42>  @ imm = #-0x4
 f0007e8: f64f 73f4    	.word	#0xf64f73f4
 f0007ec: f2c2 0301    	.word	#0xf2c20301
 f0007f0: f103 020c    	.word	#0xf103020c
 f0007f4: 4291         	cmp	r1, r2
 f0007f6: d900         	bls	0xf0007fa <entry+0x56>  @ imm = #0x0
 f0007f8: e7fe         	b	0xf0007f8 <entry+0x54>  @ imm = #-0x4
 f0007fa: 4299         	cmp	r1, r3
 f0007fc: d900         	bls	0xf000800 <entry+0x5c>  @ imm = #0x0
 f0007fe: e7fe         	b	0xf0007fe <entry+0x5a>  @ imm = #-0x4
 f000800: f246 6e48    	.word	#0xf2466e48
 f000804: 60c1         	str	r1, [r0, #0xc]
 f000806: f2c2 0e00    	.word	#0xf2c20e00
 f00080a: f10e 0208    	.word	#0xf10e0208
 f00080e: ea4f 0c9e    	.word	#0xea4f0c9e
 f000812: f8ae c006    	.word	#0xf8aec006
 f000816: f8ae c004    	.word	#0xf8aec004
 f00081a: ea4f 0c92    	.word	#0xea4f0c92
 f00081e: f10e 0210    	.word	#0xf10e0210
 f000822: f8ae c00e    	.word	#0xf8aec00e
 f000826: f8ae c00c    	.word	#0xf8aec00c
 f00082a: 0894         	lsrs	r4, r2, #0x2
 f00082c: f10e 0218    	.word	#0xf10e0218
 f000830: f8ae 4016    	.word	#0xf8ae4016
 f000834: 0892         	lsrs	r2, r2, #0x2
 f000836: f8ae 4014    	.word	#0xf8ae4014
 f00083a: f8ae 201e    	.word	#0xf8ae201e
 f00083e: f10e 0420    	.word	#0xf10e0420
 f000842: f8ae 201c    	.word	#0xf8ae201c
 f000846: f10e 0228    	.word	#0xf10e0228
 f00084a: 08a4         	lsrs	r4, r4, #0x2
 f00084c: 0892         	lsrs	r2, r2, #0x2
 f00084e: f8ae 4026    	.word	#0xf8ae4026
 f000852: f8ae 202e    	.word	#0xf8ae202e
 f000856: f8ae 202c    	.word	#0xf8ae202c
 f00085a: 1a5a         	subs	r2, r3, r1
 f00085c: 3208         	adds	r2, #0x8
 f00085e: f8ae 4024    	.word	#0xf8ae4024
 f000862: f022 0303    	.word	#0xf0220303
 f000866: 600b         	str	r3, [r1]
 f000868: 440b         	add	r3, r1
 f00086a: f843 2c04    	.word	#0xf8432c04
 f00086e: fab2 f282    	.word	#0xfab2f282
 f000872: 680b         	ldr	r3, [r1]
 f000874: f023 0303    	.word	#0xf0230303
 f000878: 1c5c         	adds	r4, r3, #0x1
 f00087a: 600c         	str	r4, [r1]
 f00087c: 2402         	movs	r4, #0x2
 f00087e: 50cc         	str	r4, [r1, r3]
 f000880: f1c2 031b    	.word	#0xf1c2031b
 f000884: 241b         	movs	r4, #0x1b
 f000886: 4294         	cmp	r4, r2
 f000888: bf38         	it	lo
 f00088a: 2300         	movlo	r3, #0x0
 f00088c: 2b05         	cmp	r3, #0x5
 f00088e: bf28         	it	hs
 f000890: 2305         	movhs	r3, #0x5
 f000892: eb0e 02c3    	.word	#0xeb0e02c3
 f000896: 2404         	movs	r4, #0x4
 f000898: 088b         	lsrs	r3, r1, #0x2
 f00089a: f2c2 0400    	.word	#0xf2c20400
 f00089e: f8b2 c006    	.word	#0xf8b2c006
 f0008a2: 80d3         	strh	r3, [r2, #0x6]
 f0008a4: 0892         	lsrs	r2, r2, #0x2
 f0008a6: f824 302c    	.word	#0xf824302c
 f0008aa: 808a         	strh	r2, [r1, #0x4]
 f0008ac: f8a1 c006    	.word	#0xf8a1c006
 f0008b0: 2201         	movs	r2, #0x1
 f0008b2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0008b6: 7242         	strb	r2, [r0, #0x9]
 f0008b8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0008bc: f3ef 8310    	.word	#0xf3ef8310
 f0008c0: b672         	cpsid i
 f0008c2: 7841         	ldrb	r1, [r0, #0x1]
 f0008c4: 2900         	cmp	r1, #0x0
 f0008c6: bf08         	it	eq
 f0008c8: 7042         	strbeq	r2, [r0, #0x1]
 f0008ca: 07d8         	lsls	r0, r3, #0x1f
 f0008cc: d100         	bne	0xf0008d0 <entry+0x12c> @ imm = #0x0
 f0008ce: b662         	cpsie i
 f0008d0: b139         	cbz	r1, 0xf0008e2 <entry+0x13e> @ imm = #0xe
 f0008d2: f245 60a4    	.word	#0xf24560a4
 f0008d6: 212b         	movs	r1, #0x2b
 f0008d8: f6c0 7000    	.word	#0xf6c07000
 f0008dc: f7ff feb5    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x296
 f0008e0: defe         	trap
 f0008e2: f64e 5088    	.word	#0xf64e5088
 f0008e6: 2100         	movs	r1, #0x0
 f0008e8: f2ce 0000    	.word	#0xf2ce0000
 f0008ec: 22d0         	movs	r2, #0xd0
 f0008ee: f800 1c69    	.word	#0xf8001c69
 f0008f2: f800 2c66    	.word	#0xf8002c66
 f0008f6: 22a0         	movs	r2, #0xa0
 f0008f8: f800 2c65    	.word	#0xf8002c65
 f0008fc: f24e 0210    	.word	#0xf24e0210
 f000900: f2ce 0200    	.word	#0xf2ce0200
 f000904: 6813         	ldr	r3, [r2]
 f000906: f043 0304    	.word	#0xf0430304
 f00090a: 6013         	str	r3, [r2]
 f00090c: f249 0340    	.word	#0xf2490340
 f000910: f2c0 0302    	.word	#0xf2c00302
 f000914: 6053         	str	r3, [r2, #0x4]
 f000916: 6091         	str	r1, [r2, #0x8]
 f000918: 6811         	ldr	r1, [r2]
 f00091a: f041 0101    	.word	#0xf0410101
 f00091e: 6011         	str	r1, [r2]
 f000920: 6811         	ldr	r1, [r2]
 f000922: f041 0102    	.word	#0xf0410102
 f000926: 6011         	str	r1, [r2]
 f000928: 2160         	movs	r1, #0x60
 f00092a: f381 8811    	.word	#0xf3818811
 f00092e: 6801         	ldr	r1, [r0]
 f000930: f441 0170    	.word	#0xf4410170
 f000934: 6001         	str	r1, [r0]
 f000936: f000 f807    	bl	0xf000948 <hopter::schedule::start_task::start_task::h7c4f2101579afd4c> @ imm = #0xe
 f00093a: f000 f8a6    	bl	0xf000a8a <core::result::Result$LT$T$C$E$GT$::unwrap::h36b9bf0885a21f84> @ imm = #0x14c
 f00093e: f000 f8bb    	bl	0xf000ab8 <hopter::schedule::scheduler::start_scheduler::hf16ffe7ac65ad3ab> @ imm = #0x176
 f000942: defe         	trap

0f000944 <$d.91>:
 f000944: 7c 67 00 20  	.word	0x2000677c

0f000948 <hopter::schedule::start_task::start_task::h7c4f2101579afd4c>:
 f000948: f04f 5c00    	.word	#0xf04f5c00
 f00094c: f8dc c000    	.word	#0xf8dcc000
 f000950: ebbd 0c0c    	.word	#0xebbd0c0c
 f000954: f1bc 0f98    	.word	#0xf1bc0f98
 f000958: da02         	bge	0xf000960 <hopter::schedule::start_task::start_task::h7c4f2101579afd4c+0x18> @ imm = #0x4
 f00095a: dfff         	svc	#0xff
 f00095c: 0026         	movs	r6, r4
 f00095e: 0000         	movs	r0, r0
 f000960: b5f0         	push	{r4, r5, r6, r7, lr}
 f000962: af03         	add	r7, sp, #0xc
 f000964: e92d 0f00    	.word	#0xe92d0f00
 f000968: b09d         	sub	sp, #0x74
 f00096a: 2000         	movs	r0, #0x0
 f00096c: ac01         	add	r4, sp, #0x4
 f00096e: f88d 0010    	.word	#0xf88d0010
 f000972: 2128         	movs	r1, #0x28
 f000974: 9003         	str	r0, [sp, #0xc]
 f000976: e9cd 0001    	.word	#0xe9cd0001
 f00097a: f104 0010    	.word	#0xf1040010
 f00097e: f003 fa75    	bl	0xf003e6c <__aeabi_memclr8> @ imm = #0x34ea
 f000982: f246 7818    	.word	#0xf2467818
 f000986: f2c2 0800    	.word	#0xf2c20800
 f00098a: 4640         	mov	r0, r8
 f00098c: f810 1b09    	.word	#0xf8101b09
 f000990: 2104         	movs	r1, #0x4
 f000992: f000 fce1    	bl	0xf001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e> @ imm = #0x9c2
 f000996: 2800         	cmp	r0, #0x0
 f000998: d06f         	beq	0xf000a7a <hopter::schedule::start_task::start_task::h7c4f2101579afd4c+0x132> @ imm = #0xde
 f00099a: 4606         	mov	r6, r0
 f00099c: 2001         	movs	r0, #0x1
 f00099e: 6030         	str	r0, [r6]
 f0009a0: 4640         	mov	r0, r8
 f0009a2: f810 1b09    	.word	#0xf8101b09
 f0009a6: 217c         	movs	r1, #0x7c
 f0009a8: f000 fcd6    	bl	0xf001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e> @ imm = #0x9ac
 f0009ac: 2800         	cmp	r0, #0x0
 f0009ae: d063         	beq	0xf000a78 <hopter::schedule::start_task::start_task::h7c4f2101579afd4c+0x130> @ imm = #0xc6
 f0009b0: 4681         	mov	r9, r0
 f0009b2: 2000         	movs	r0, #0x0
 f0009b4: e9c9 0000    	.word	#0xe9c90000
 f0009b8: 2164         	movs	r1, #0x64
 f0009ba: f8c9 0008    	.word	#0xf8c90008
 f0009be: f109 0018    	.word	#0xf1090018
 f0009c2: f003 fa53    	bl	0xf003e6c <__aeabi_memclr8> @ imm = #0x34a6
 f0009c6: f241 50cf    	.word	#0xf24150cf
 f0009ca: 46ca         	mov	r10, r9
 f0009cc: f6c0 7000    	.word	#0xf6c07000
 f0009d0: f241 626b    	.word	#0xf241626b
 f0009d4: f84a 6f14    	.word	#0xf84a6f14
 f0009d8: f040 0001    	.word	#0xf0400001
 f0009dc: f6c0 7200    	.word	#0xf6c07200
 f0009e0: f04f 7180    	.word	#0xf04f7180
 f0009e4: f042 0201    	.word	#0xf0420201
 f0009e8: e9ca 2005    	.word	#0xe9ca2005
 f0009ec: f8ca 101c    	.word	#0xf8ca101c
 f0009f0: f10d 0b3c    	.word	#0xf10d0b3c
 f0009f4: cc4e         	ldm	r4!, {r1, r2, r3, r6}
 f0009f6: 4658         	mov	r0, r11
 f0009f8: c04e         	stm	r0!, {r1, r2, r3, r6}
 f0009fa: cc6e         	ldm	r4!, {r1, r2, r3, r5, r6}
 f0009fc: c06e         	stm	r0!, {r1, r2, r3, r5, r6}
 f0009fe: e894 006e    	.word	#0xe894006e
 f000a02: c06e         	stm	r0!, {r1, r2, r3, r5, r6}
 f000a04: 21d0         	movs	r1, #0xd0
 f000a06: f818 0b09    	.word	#0xf8180b09
 f000a0a: 4640         	mov	r0, r8
 f000a0c: f000 fca4    	bl	0xf001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e> @ imm = #0x948
 f000a10: b3b8         	cbz	r0, 0xf000a82 <hopter::schedule::start_task::start_task::h7c4f2101579afd4c+0x13a> @ imm = #0x6e
 f000a12: 4605         	mov	r5, r0
 f000a14: f109 007c    	.word	#0xf109007c
 f000a18: e9c5 0a07    	.word	#0xe9c50a07
 f000a1c: 2001         	movs	r0, #0x1
 f000a1e: e9c5 0004    	.word	#0xe9c50004
 f000a22: f04f 0800    	.word	#0xf04f0800
 f000a26: e9c5 0000    	.word	#0xe9c50000
 f000a2a: f105 0024    	.word	#0xf1050024
 f000a2e: 2160         	movs	r1, #0x60
 f000a30: f885 8018    	.word	#0xf8858018
 f000a34: f8c5 8008    	.word	#0xf8c58008
 f000a38: f003 fa18    	bl	0xf003e6c <__aeabi_memclr8> @ imm = #0x3430
 f000a3c: e9c5 9821    	.word	#0xe9c59821
 f000a40: f105 008c    	.word	#0xf105008c
 f000a44: e8bb 004e    	.word	#0xe8bb004e
 f000a48: c04e         	stm	r0!, {r1, r2, r3, r6}
 f000a4a: e8bb 005e    	.word	#0xe8bb005e
 f000a4e: c05e         	stm	r0!, {r1, r2, r3, r4, r6}
 f000a50: e89b 005e    	.word	#0xe89b005e
 f000a54: c05e         	stm	r0!, {r1, r2, r3, r4, r6}
 f000a56: f240 2001    	.word	#0xf2402001
 f000a5a: f04f 31ff    	.word	#0xf04f31ff
 f000a5e: e9c5 8131    	.word	#0xe9c58131
 f000a62: 4629         	mov	r1, r5
 f000a64: f8c5 00cc    	.word	#0xf8c500cc
 f000a68: 2001         	movs	r0, #0x1
 f000a6a: b01d         	add	sp, #0x74
 f000a6c: e8bd 0f00    	.word	#0xe8bd0f00
 f000a70: e8bd 40f0    	.word	#0xe8bd40f0
 f000a74: f000 bdfc    	.word	#0xf000bdfc
 f000a78: e7fe         	b	0xf000a78 <hopter::schedule::start_task::start_task::h7c4f2101579afd4c+0x130> @ imm = #-0x4
 f000a7a: f3ef 8010    	.word	#0xf3ef8010
 f000a7e: b672         	cpsid i
 f000a80: e7fe         	b	0xf000a80 <hopter::schedule::start_task::start_task::h7c4f2101579afd4c+0x138> @ imm = #-0x4
 f000a82: f3ef 8010    	.word	#0xf3ef8010
 f000a86: b672         	cpsid i
 f000a88: e7fe         	b	0xf000a88 <hopter::schedule::start_task::start_task::h7c4f2101579afd4c+0x140> @ imm = #-0x4

0f000a8a <core::result::Result$LT$T$C$E$GT$::unwrap::h36b9bf0885a21f84>:
 f000a8a: 2800         	cmp	r0, #0x0
 f000a8c: bf08         	it	eq
 f000a8e: 4770         	bxeq	lr
 f000a90: f04f 5c00    	.word	#0xf04f5c00
 f000a94: f8dc c000    	.word	#0xf8dcc000
 f000a98: ebbd 0c0c    	.word	#0xebbd0c0c
 f000a9c: f1bc 0f10    	.word	#0xf1bc0f10
 f000aa0: da02         	bge	0xf000aa8 <core::result::Result$LT$T$C$E$GT$::unwrap::h36b9bf0885a21f84+0x1e> @ imm = #0x4
 f000aa2: dfff         	svc	#0xff
 f000aa4: 0004         	movs	r4, r0
 f000aa6: 0000         	movs	r0, r0
 f000aa8: b580         	push	{r7, lr}
 f000aaa: 466f         	mov	r7, sp
 f000aac: b082         	sub	sp, #0x8
 f000aae: 1e78         	subs	r0, r7, #0x1
 f000ab0: f7ff fded    	bl	0xf00068e <core::result::unwrap_failed::h8eb3fe0ea9f92dea> @ imm = #-0x426
 f000ab4: defe         	trap
 f000ab6: d4d4         	bmi	0xf000a62 <hopter::schedule::start_task::start_task::h7c4f2101579afd4c+0x11a> @ imm = #-0x58

0f000ab8 <hopter::schedule::scheduler::start_scheduler::hf16ffe7ac65ad3ab>:
 f000ab8: f04f 5c00    	.word	#0xf04f5c00
 f000abc: f8dc c000    	.word	#0xf8dcc000
 f000ac0: ebbd 0c0c    	.word	#0xebbd0c0c
 f000ac4: f1bc 0fe0    	.word	#0xf1bc0fe0
 f000ac8: da02         	bge	0xf000ad0 <hopter::schedule::scheduler::start_scheduler::hf16ffe7ac65ad3ab+0x18> @ imm = #0x4
 f000aca: dfff         	svc	#0xff
 f000acc: 0038         	movs	r0, r7
 f000ace: 0000         	movs	r0, r0
 f000ad0: b5f0         	push	{r4, r5, r6, r7, lr}
 f000ad2: af03         	add	r7, sp, #0xc
 f000ad4: f84d bd04    	.word	#0xf84dbd04
 f000ad8: b0b2         	sub	sp, #0xc8
 f000ada: 466e         	mov	r6, sp
 f000adc: 4630         	mov	r0, r6
 f000ade: f000 f835    	bl	0xf000b4c <hopter::task::task_struct::Task::build_idle::h9fa8ec107f079fdf> @ imm = #0x6a
 f000ae2: 4630         	mov	r0, r6
 f000ae4: e9dd 4505    	.word	#0xe9dd4505
 f000ae8: f000 f899    	bl	0xf000c1e <alloc::sync::Arc$LT$T$GT$::new::hea10d4413d46917d> @ imm = #0x132
 f000aec: f000 f8c0    	bl	0xf000c70 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a> @ imm = #0x180
 f000af0: f000 f935    	bl	0xf000d5e <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714> @ imm = #0x26a
 f000af4: f246 7118    	.word	#0xf2467118
 f000af8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000afc: f2c2 0100    	.word	#0xf2c20100
 f000b00: 6388         	str	r0, [r1, #0x38]
 f000b02: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000b06: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000b0a: e851 0f0d    	.word	#0xe8510f0d
 f000b0e: 3001         	adds	r0, #0x1
 f000b10: e841 020d    	.word	#0xe841020d
 f000b14: 2a00         	cmp	r2, #0x0
 f000b16: d1f8         	bne	0xf000b0a <hopter::schedule::scheduler::start_scheduler::hf16ffe7ac65ad3ab+0x52> @ imm = #-0x10
 f000b18: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000b1c: 4628         	mov	r0, r5
 f000b1e: 4621         	mov	r1, r4
 f000b20: f380 8809    	.word	#0xf3808809
 f000b24: f04f 5000    	.word	#0xf04f5000
 f000b28: 6001         	str	r1, [r0]
 f000b2a: f3ef 8014    	.word	#0xf3ef8014
 f000b2e: f040 0002    	.word	#0xf0400002
 f000b32: f380 8814    	.word	#0xf3808814
 f000b36: 4804         	ldr	r0, [pc, #0x10]         @ 0xf000b48 <hopter::schedule::scheduler::start_scheduler::hf16ffe7ac65ad3ab+0x90>
 f000b38: f380 8808    	.word	#0xf3808808
 f000b3c: eeb0 0a40    	.word	#0xeeb00a40
 f000b40: f000 ba16    	.word	#0xf000ba16
 f000b44: defe         	trap
 f000b46: 0000         	movs	r0, r0

0f000b48 <$d.92>:
 f000b48: 00 10 00 20  	.word	0x20001000

0f000b4c <hopter::task::task_struct::Task::build_idle::h9fa8ec107f079fdf>:
 f000b4c: f04f 5c00    	.word	#0xf04f5c00
 f000b50: f8dc c000    	.word	#0xf8dcc000
 f000b54: ebbd 0c0c    	.word	#0xebbd0c0c
 f000b58: f1bc 0f58    	.word	#0xf1bc0f58
 f000b5c: da02         	bge	0xf000b64 <hopter::task::task_struct::Task::build_idle::h9fa8ec107f079fdf+0x18> @ imm = #0x4
 f000b5e: dfff         	svc	#0xff
 f000b60: 0016         	movs	r6, r2
 f000b62: 0000         	movs	r0, r0
 f000b64: b5f0         	push	{r4, r5, r6, r7, lr}
 f000b66: af03         	add	r7, sp, #0xc
 f000b68: e92d 0b00    	.word	#0xe92d0b00
 f000b6c: b08e         	sub	sp, #0x38
 f000b6e: f246 7518    	.word	#0xf2467518
 f000b72: 4604         	mov	r4, r0
 f000b74: f2c2 0500    	.word	#0xf2c20500
 f000b78: 1da8         	adds	r0, r5, #0x6
 f000b7a: 2201         	movs	r2, #0x1
 f000b7c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000b80: e8d0 1f4f    	.word	#0xe8d01f4f
 f000b84: e8c0 2f43    	.word	#0xe8c02f43
 f000b88: 2b00         	cmp	r3, #0x0
 f000b8a: d1f9         	bne	0xf000b80 <hopter::task::task_struct::Task::build_idle::h9fa8ec107f079fdf+0x34> @ imm = #-0xe
 f000b8c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000b90: b101         	cbz	r1, 0xf000b94 <hopter::task::task_struct::Task::build_idle::h9fa8ec107f079fdf+0x48> @ imm = #0x0
 f000b92: e7fe         	b	0xf000b92 <hopter::task::task_struct::Task::build_idle::h9fa8ec107f079fdf+0x46> @ imm = #-0x4
 f000b94: 46e9         	mov	r9, sp
 f000b96: f109 0010    	.word	#0xf1090010
 f000b9a: f04f 0800    	.word	#0xf04f0800
 f000b9e: 2128         	movs	r1, #0x28
 f000ba0: f88d 800c    	.word	#0xf88d800c
 f000ba4: f8cd 8008    	.word	#0xf8cd8008
 f000ba8: e9cd 8800    	.word	#0xe9cd8800
 f000bac: f003 f95e    	bl	0xf003e6c <__aeabi_memclr8> @ imm = #0x32bc
 f000bb0: f815 0b09    	.word	#0xf8150b09
 f000bb4: 217c         	movs	r1, #0x7c
 f000bb6: 4628         	mov	r0, r5
 f000bb8: f000 fbce    	bl	0xf001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e> @ imm = #0x79c
 f000bbc: b370         	cbz	r0, 0xf000c1c <hopter::task::task_struct::Task::build_idle::h9fa8ec107f079fdf+0xd0> @ imm = #0x5c
 f000bbe: 4605         	mov	r5, r0
 f000bc0: e9c0 8800    	.word	#0xe9c08800
 f000bc4: f8c0 8008    	.word	#0xf8c08008
 f000bc8: 307c         	adds	r0, #0x7c
 f000bca: 2160         	movs	r1, #0x60
 f000bcc: f884 8010    	.word	#0xf8848010
 f000bd0: e9c4 0005    	.word	#0xe9c40005
 f000bd4: 2001         	movs	r0, #0x1
 f000bd6: e9c4 0002    	.word	#0xe9c40002
 f000bda: f104 001c    	.word	#0xf104001c
 f000bde: f8c4 8000    	.word	#0xf8c48000
 f000be2: f003 f943    	bl	0xf003e6c <__aeabi_memclr8> @ imm = #0x3286
 f000be6: e9c4 581f    	.word	#0xe9c4581f
 f000bea: f104 0084    	.word	#0xf1040084
 f000bee: e8b9 002e    	.word	#0xe8b9002e
 f000bf2: c02e         	stm	r0!, {r1, r2, r3, r5}
 f000bf4: e8b9 006e    	.word	#0xe8b9006e
 f000bf8: c06e         	stm	r0!, {r1, r2, r3, r5, r6}
 f000bfa: e899 006e    	.word	#0xe899006e
 f000bfe: c06e         	stm	r0!, {r1, r2, r3, r5, r6}
 f000c00: f44f 7040    	.word	#0xf44f7040
 f000c04: f04f 31ff    	.word	#0xf04f31ff
 f000c08: f44f 6270    	.word	#0xf44f6270
 f000c0c: f8c4 00c4    	.word	#0xf8c400c4
 f000c10: e9c4 212f    	.word	#0xe9c4212f
 f000c14: b00e         	add	sp, #0x38
 f000c16: e8bd 0b00    	.word	#0xe8bd0b00
 f000c1a: bdf0         	pop	{r4, r5, r6, r7, pc}
 f000c1c: e7fe         	b	0xf000c1c <hopter::task::task_struct::Task::build_idle::h9fa8ec107f079fdf+0xd0> @ imm = #-0x4

0f000c1e <alloc::sync::Arc$LT$T$GT$::new::hea10d4413d46917d>:
 f000c1e: f04f 5c00    	.word	#0xf04f5c00
 f000c22: f8dc c000    	.word	#0xf8dcc000
 f000c26: ebbd 0c0c    	.word	#0xebbd0c0c
 f000c2a: f1bc 0f10    	.word	#0xf1bc0f10
 f000c2e: da02         	bge	0xf000c36 <alloc::sync::Arc$LT$T$GT$::new::hea10d4413d46917d+0x18> @ imm = #0x4
 f000c30: dfff         	svc	#0xff
 f000c32: 0004         	movs	r4, r0
 f000c34: 0000         	movs	r0, r0
 f000c36: b5b0         	push	{r4, r5, r7, lr}
 f000c38: af02         	add	r7, sp, #0x8
 f000c3a: 4604         	mov	r4, r0
 f000c3c: f246 7018    	.word	#0xf2467018
 f000c40: f2c2 0000    	.word	#0xf2c20000
 f000c44: f810 1b09    	.word	#0xf8101b09
 f000c48: 21d0         	movs	r1, #0xd0
 f000c4a: f000 fb85    	bl	0xf001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e> @ imm = #0x70a
 f000c4e: b158         	cbz	r0, 0xf000c68 <alloc::sync::Arc$LT$T$GT$::new::hea10d4413d46917d+0x4a> @ imm = #0x16
 f000c50: 4605         	mov	r5, r0
 f000c52: 2001         	movs	r0, #0x1
 f000c54: e9c5 0000    	.word	#0xe9c50000
 f000c58: f105 0008    	.word	#0xf1050008
 f000c5c: 4621         	mov	r1, r4
 f000c5e: 22c8         	movs	r2, #0xc8
 f000c60: f003 f901    	bl	0xf003e66 <__aeabi_memcpy8> @ imm = #0x3202
 f000c64: 4628         	mov	r0, r5
 f000c66: bdb0         	pop	{r4, r5, r7, pc}
 f000c68: f3ef 8010    	.word	#0xf3ef8010
 f000c6c: b672         	cpsid i
 f000c6e: e7fe         	b	0xf000c6e <alloc::sync::Arc$LT$T$GT$::new::hea10d4413d46917d+0x50> @ imm = #-0x4

0f000c70 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a>:
 f000c70: f04f 5c00    	.word	#0xf04f5c00
 f000c74: f8dc c000    	.word	#0xf8dcc000
 f000c78: ebbd 0c0c    	.word	#0xebbd0c0c
 f000c7c: f1bc 0f18    	.word	#0xf1bc0f18
 f000c80: da02         	bge	0xf000c88 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x18> @ imm = #0x4
 f000c82: dfff         	svc	#0xff
 f000c84: 0006         	movs	r6, r0
 f000c86: 0000         	movs	r0, r0
 f000c88: b5d0         	push	{r4, r6, r7, lr}
 f000c8a: af02         	add	r7, sp, #0x8
 f000c8c: b082         	sub	sp, #0x8
 f000c8e: f246 7418    	.word	#0xf2467418
 f000c92: f2c2 0400    	.word	#0xf2c20400
 f000c96: e854 1f14    	.word	#0xe8541f14
 f000c9a: b111         	cbz	r1, 0xf000ca2 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x32> @ imm = #0x4
 f000c9c: f3bf 8f2f    	.word	#0xf3bf8f2f
 f000ca0: e003         	b	0xf000caa <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x3a> @ imm = #0x6
 f000ca2: 2101         	movs	r1, #0x1
 f000ca4: e844 1214    	.word	#0xe8441214
 f000ca8: b352         	cbz	r2, 0xf000d00 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x90> @ imm = #0x54
 f000caa: 2101         	movs	r1, #0x1
 f000cac: e001         	b	0xf000cb2 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x42> @ imm = #0x2
 f000cae: f3bf 8f2f    	.word	#0xf3bf8f2f
 f000cb2: bf10         	yield
 f000cb4: e854 2f14    	.word	#0xe8542f14
 f000cb8: b112         	cbz	r2, 0xf000cc0 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x50> @ imm = #0x4
 f000cba: f3bf 8f2f    	.word	#0xf3bf8f2f
 f000cbe: e002         	b	0xf000cc6 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x56> @ imm = #0x4
 f000cc0: e844 1214    	.word	#0xe8441214
 f000cc4: b1e2         	cbz	r2, 0xf000d00 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x90> @ imm = #0x38
 f000cc6: bf10         	yield
 f000cc8: e854 2f14    	.word	#0xe8542f14
 f000ccc: b112         	cbz	r2, 0xf000cd4 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x64> @ imm = #0x4
 f000cce: f3bf 8f2f    	.word	#0xf3bf8f2f
 f000cd2: e002         	b	0xf000cda <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x6a> @ imm = #0x4
 f000cd4: e844 1214    	.word	#0xe8441214
 f000cd8: b192         	cbz	r2, 0xf000d00 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x90> @ imm = #0x24
 f000cda: bf10         	yield
 f000cdc: e854 2f14    	.word	#0xe8542f14
 f000ce0: b112         	cbz	r2, 0xf000ce8 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x78> @ imm = #0x4
 f000ce2: f3bf 8f2f    	.word	#0xf3bf8f2f
 f000ce6: e002         	b	0xf000cee <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x7e> @ imm = #0x4
 f000ce8: e844 1214    	.word	#0xe8441214
 f000cec: b142         	cbz	r2, 0xf000d00 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x90> @ imm = #0x10
 f000cee: bf10         	yield
 f000cf0: e854 2f14    	.word	#0xe8542f14
 f000cf4: 2a00         	cmp	r2, #0x0
 f000cf6: d1da         	bne	0xf000cae <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x3e> @ imm = #-0x4c
 f000cf8: e844 1214    	.word	#0xe8441214
 f000cfc: 2a00         	cmp	r2, #0x0
 f000cfe: d1d8         	bne	0xf000cb2 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0x42> @ imm = #-0x50
 f000d00: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000d04: 6d61         	ldr	r1, [r4, #0x54]
 f000d06: 6560         	str	r0, [r4, #0x54]
 f000d08: 9101         	str	r1, [sp, #0x4]
 f000d0a: b179         	cbz	r1, 0xf000d2c <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0xbc> @ imm = #0x1e
 f000d0c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000d10: e851 0f00    	.word	#0xe8510f00
 f000d14: 1e42         	subs	r2, r0, #0x1
 f000d16: e841 2300    	.word	#0xe8412300
 f000d1a: 2b00         	cmp	r3, #0x0
 f000d1c: d1f8         	bne	0xf000d10 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0xa0> @ imm = #-0x10
 f000d1e: 2801         	cmp	r0, #0x1
 f000d20: d104         	bne	0xf000d2c <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0xbc> @ imm = #0x8
 f000d22: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000d26: a801         	add	r0, sp, #0x4
 f000d28: f000 f94a    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #0x294
 f000d2c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000d30: e854 0f14    	.word	#0xe8540f14
 f000d34: f020 0003    	.word	#0xf0200003
 f000d38: e844 0114    	.word	#0xe8440114
 f000d3c: 2900         	cmp	r1, #0x0
 f000d3e: d1f7         	bne	0xf000d30 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0xc0> @ imm = #-0x12
 f000d40: b002         	add	sp, #0x8
 f000d42: bdd0         	pop	{r4, r6, r7, pc}
 f000d44: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000d48: e854 1f14    	.word	#0xe8541f14
 f000d4c: f021 0103    	.word	#0xf0210103
 f000d50: e844 1214    	.word	#0xe8441214
 f000d54: 2a00         	cmp	r2, #0x0
 f000d56: d1f7         	bne	0xf000d48 <hopter::schedule::current_task::set_cur_task::h10e3feb90c4b072a+0xd8> @ imm = #-0x12
 f000d58: f004 fc3c    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x4878
 f000d5c: defe         	trap

0f000d5e <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714>:
 f000d5e: f04f 5c00    	.word	#0xf04f5c00
 f000d62: f8dc c000    	.word	#0xf8dcc000
 f000d66: ebbd 0c0c    	.word	#0xebbd0c0c
 f000d6a: f1bc 0f10    	.word	#0xf1bc0f10
 f000d6e: da02         	bge	0xf000d76 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x18> @ imm = #0x4
 f000d70: dfff         	svc	#0xff
 f000d72: 0004         	movs	r4, r0
 f000d74: 0000         	movs	r0, r0
 f000d76: b5b0         	push	{r4, r5, r7, lr}
 f000d78: af02         	add	r7, sp, #0x8
 f000d7a: f246 7518    	.word	#0xf2467518
 f000d7e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000d82: f2c2 0500    	.word	#0xf2c20500
 f000d86: e855 0f0f    	.word	#0xe8550f0f
 f000d8a: 3001         	adds	r0, #0x1
 f000d8c: e845 010f    	.word	#0xe845010f
 f000d90: 2900         	cmp	r1, #0x0
 f000d92: d1f8         	bne	0xf000d86 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x28> @ imm = #-0x10
 f000d94: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000d98: e855 1f14    	.word	#0xe8551f14
 f000d9c: 1d08         	adds	r0, r1, #0x4
 f000d9e: e845 0214    	.word	#0xe8450214
 f000da2: 2a00         	cmp	r2, #0x0
 f000da4: d1f8         	bne	0xf000d98 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x3a> @ imm = #-0x10
 f000da6: f64f 70fc    	.word	#0xf64f70fc
 f000daa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000dae: f6c7 70ff    	.word	#0xf6c770ff
 f000db2: 4281         	cmp	r1, r0
 f000db4: d85b         	bhi	0xf000e6e <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x110> @ imm = #0xb6
 f000db6: 0789         	lsls	r1, r1, #0x1e
 f000db8: d068         	beq	0xf000e8c <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x12e> @ imm = #0xd0
 f000dba: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000dbe: e855 1f14    	.word	#0xe8551f14
 f000dc2: 3904         	subs	r1, #0x4
 f000dc4: e845 1214    	.word	#0xe8451214
 f000dc8: 2a00         	cmp	r2, #0x0
 f000dca: d1f8         	bne	0xf000dbe <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x60> @ imm = #-0x10
 f000dcc: bf10         	yield
 f000dce: e855 1f14    	.word	#0xe8551f14
 f000dd2: 1d0a         	adds	r2, r1, #0x4
 f000dd4: e845 2314    	.word	#0xe8452314
 f000dd8: 2b00         	cmp	r3, #0x0
 f000dda: d1f8         	bne	0xf000dce <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x70> @ imm = #-0x10
 f000ddc: 4281         	cmp	r1, r0
 f000dde: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000de2: d844         	bhi	0xf000e6e <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x110> @ imm = #0x88
 f000de4: 0789         	lsls	r1, r1, #0x1e
 f000de6: d051         	beq	0xf000e8c <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x12e> @ imm = #0xa2
 f000de8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000dec: e855 1f14    	.word	#0xe8551f14
 f000df0: 3904         	subs	r1, #0x4
 f000df2: e845 1214    	.word	#0xe8451214
 f000df6: 2a00         	cmp	r2, #0x0
 f000df8: d1f8         	bne	0xf000dec <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x8e> @ imm = #-0x10
 f000dfa: bf10         	yield
 f000dfc: e855 1f14    	.word	#0xe8551f14
 f000e00: 1d0a         	adds	r2, r1, #0x4
 f000e02: e845 2314    	.word	#0xe8452314
 f000e06: 2b00         	cmp	r3, #0x0
 f000e08: d1f8         	bne	0xf000dfc <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x9e> @ imm = #-0x10
 f000e0a: 4281         	cmp	r1, r0
 f000e0c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000e10: d82d         	bhi	0xf000e6e <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x110> @ imm = #0x5a
 f000e12: 0789         	lsls	r1, r1, #0x1e
 f000e14: d03a         	beq	0xf000e8c <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x12e> @ imm = #0x74
 f000e16: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000e1a: e855 1f14    	.word	#0xe8551f14
 f000e1e: 3904         	subs	r1, #0x4
 f000e20: e845 1214    	.word	#0xe8451214
 f000e24: 2a00         	cmp	r2, #0x0
 f000e26: d1f8         	bne	0xf000e1a <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0xbc> @ imm = #-0x10
 f000e28: bf10         	yield
 f000e2a: e855 1f14    	.word	#0xe8551f14
 f000e2e: 1d0a         	adds	r2, r1, #0x4
 f000e30: e845 2314    	.word	#0xe8452314
 f000e34: 2b00         	cmp	r3, #0x0
 f000e36: d1f8         	bne	0xf000e2a <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0xcc> @ imm = #-0x10
 f000e38: 4281         	cmp	r1, r0
 f000e3a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000e3e: d816         	bhi	0xf000e6e <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x110> @ imm = #0x2c
 f000e40: 0789         	lsls	r1, r1, #0x1e
 f000e42: d023         	beq	0xf000e8c <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x12e> @ imm = #0x46
 f000e44: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000e48: e855 1f14    	.word	#0xe8551f14
 f000e4c: 3904         	subs	r1, #0x4
 f000e4e: e845 1214    	.word	#0xe8451214
 f000e52: 2a00         	cmp	r2, #0x0
 f000e54: d1f8         	bne	0xf000e48 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0xea> @ imm = #-0x10
 f000e56: bf10         	yield
 f000e58: e855 1f14    	.word	#0xe8551f14
 f000e5c: 1d0a         	adds	r2, r1, #0x4
 f000e5e: e845 2314    	.word	#0xe8452314
 f000e62: 2b00         	cmp	r3, #0x0
 f000e64: d1f8         	bne	0xf000e58 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0xfa> @ imm = #-0x10
 f000e66: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000e6a: 4281         	cmp	r1, r0
 f000e6c: d9a3         	bls	0xf000db6 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x58> @ imm = #-0xba
 f000e6e: e855 0f14    	.word	#0xe8550f14
 f000e72: 3804         	subs	r0, #0x4
 f000e74: e845 0114    	.word	#0xe8450114
 f000e78: 2900         	cmp	r1, #0x0
 f000e7a: d1f8         	bne	0xf000e6e <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x110> @ imm = #-0x10
 f000e7c: f245 6078    	.word	#0xf2456078
 f000e80: 212c         	movs	r1, #0x2c
 f000e82: f6c0 7000    	.word	#0xf6c07000
 f000e86: f7ff fbe0    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x840
 f000e8a: defe         	trap
 f000e8c: 6d6c         	ldr	r4, [r5, #0x54]
 f000e8e: b3d4         	cbz	r4, 0xf000f06 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x1a8> @ imm = #0x74
 f000e90: 7e20         	ldrb	r0, [r4, #0x18]
 f000e92: bbd8         	cbnz	r0, 0xf000f0c <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x1ae> @ imm = #0x76
 f000e94: f104 0018    	.word	#0xf1040018
 f000e98: 2101         	movs	r1, #0x1
 f000e9a: e8d0 2f4f    	.word	#0xe8d02f4f
 f000e9e: bb9a         	cbnz	r2, 0xf000f08 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x1aa> @ imm = #0x66
 f000ea0: e8c0 1f42    	.word	#0xe8c01f42
 f000ea4: 2a00         	cmp	r2, #0x0
 f000ea6: d1f8         	bne	0xf000e9a <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x13c> @ imm = #-0x10
 f000ea8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000eac: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000eb0: e855 0f14    	.word	#0xe8550f14
 f000eb4: 3804         	subs	r0, #0x4
 f000eb6: e845 0114    	.word	#0xe8450114
 f000eba: 2900         	cmp	r1, #0x0
 f000ebc: d1f8         	bne	0xf000eb0 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x152> @ imm = #-0x10
 f000ebe: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000ec2: e855 0f0f    	.word	#0xe8550f0f
 f000ec6: 3801         	subs	r0, #0x1
 f000ec8: e845 010f    	.word	#0xe845010f
 f000ecc: 2900         	cmp	r1, #0x0
 f000ece: d1f8         	bne	0xf000ec2 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x164> @ imm = #-0x10
 f000ed0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000ed4: 7968         	ldrb	r0, [r5, #0x5]
 f000ed6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000eda: b188         	cbz	r0, 0xf000f00 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x1a2> @ imm = #0x22
 f000edc: 6be8         	ldr	r0, [r5, #0x3c]
 f000ede: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000ee2: b968         	cbnz	r0, 0xf000f00 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x1a2> @ imm = #0x1a
 f000ee4: f3ef 8005    	.word	#0xf3ef8005
 f000ee8: b188         	cbz	r0, 0xf000f0e <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x1b0> @ imm = #0x22
 f000eea: f3ef 8005    	.word	#0xf3ef8005
 f000eee: 280e         	cmp	r0, #0xe
 f000ef0: bf1f         	itttt	ne
 f000ef2: f64e 5004    	.word	#0xf64e5004
 f000ef6: f2ce 0000    	.word	#0xf2ce0000
 f000efa: f04f 5180    	.word	#0xf04f5180
 f000efe: 6001         	strne	r1, [r0]
 f000f00: f104 001c    	.word	#0xf104001c
 f000f04: bdb0         	pop	{r4, r5, r7, pc}
 f000f06: e7fe         	b	0xf000f06 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x1a8> @ imm = #-0x4
 f000f08: f3bf 8f2f    	.word	#0xf3bf8f2f
 f000f0c: e7fe         	b	0xf000f0c <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x1ae> @ imm = #-0x4
 f000f0e: f000 f854    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #0xa8
 f000f12: f104 001c    	.word	#0xf104001c
 f000f16: bdb0         	pop	{r4, r5, r7, pc}
 f000f18: 4604         	mov	r4, r0
 f000f1a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000f1e: e855 0f0f    	.word	#0xe8550f0f
 f000f22: 3801         	subs	r0, #0x1
 f000f24: e845 010f    	.word	#0xe845010f
 f000f28: 2900         	cmp	r1, #0x0
 f000f2a: d1f8         	bne	0xf000f1e <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x1c0> @ imm = #-0x10
 f000f2c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000f30: 7968         	ldrb	r0, [r5, #0x5]
 f000f32: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000f36: b1a0         	cbz	r0, 0xf000f62 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x204> @ imm = #0x28
 f000f38: 6be8         	ldr	r0, [r5, #0x3c]
 f000f3a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000f3e: b980         	cbnz	r0, 0xf000f62 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x204> @ imm = #0x20
 f000f40: f3ef 8005    	.word	#0xf3ef8005
 f000f44: b910         	cbnz	r0, 0xf000f4c <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x1ee> @ imm = #0x4
 f000f46: f000 f838    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #0x70
 f000f4a: e00a         	b	0xf000f62 <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714+0x204> @ imm = #0x14
 f000f4c: f3ef 8005    	.word	#0xf3ef8005
 f000f50: 280e         	cmp	r0, #0xe
 f000f52: bf1f         	itttt	ne
 f000f54: f64e 5004    	.word	#0xf64e5004
 f000f58: f2ce 0000    	.word	#0xf2ce0000
 f000f5c: f04f 5180    	.word	#0xf04f5180
 f000f60: 6001         	strne	r1, [r0]
 f000f62: 4620         	mov	r0, r4
 f000f64: f004 fb36    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x466c
 f000f68: defe         	trap
 f000f6a: f7ff fbea    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x82c
 f000f6e: defe         	trap

0f000f70 <hopter::schedule::idle::idle::h2ecdc11f94ee37c7>:
 f000f70: f04f 5c00    	.word	#0xf04f5c00
 f000f74: f8dc c000    	.word	#0xf8dcc000
 f000f78: ebbd 0c0c    	.word	#0xebbd0c0c
 f000f7c: f1bc 0f08    	.word	#0xf1bc0f08
 f000f80: da02         	bge	0xf000f88 <hopter::schedule::idle::idle::h2ecdc11f94ee37c7+0x18> @ imm = #0x4
 f000f82: dfff         	svc	#0xff
 f000f84: 0002         	movs	r2, r0
 f000f86: 0000         	movs	r0, r0
 f000f88: b580         	push	{r7, lr}
 f000f8a: 466f         	mov	r7, sp
 f000f8c: f246 7018    	.word	#0xf2467018
 f000f90: 2101         	movs	r1, #0x1
 f000f92: f2c2 0000    	.word	#0xf2c20000
 f000f96: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000f9a: 7101         	strb	r1, [r0, #0x4]
 f000f9c: 22e0         	movs	r2, #0xe0
 f000f9e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000fa2: f382 8811    	.word	#0xf3828811
 f000fa6: 7041         	strb	r1, [r0, #0x1]
 f000fa8: f64e 501f    	.word	#0xf64e501f
 f000fac: 21c0         	movs	r1, #0xc0
 f000fae: f2ce 0000    	.word	#0xf2ce0000
 f000fb2: 7001         	strb	r1, [r0]
 f000fb4: f000 f801    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #0x2
 f000fb8: e7fe         	b	0xf000fb8 <hopter::schedule::idle::idle::h2ecdc11f94ee37c7+0x48> @ imm = #-0x4

0f000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4>:
 f000fba: df01         	svc	#0x1
 f000fbc: 4770         	bx	lr
 f000fbe: defe         	trap

0f000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391>:
 f000fc0: f04f 5c00    	.word	#0xf04f5c00
 f000fc4: f8dc c000    	.word	#0xf8dcc000
 f000fc8: ebbd 0c0c    	.word	#0xebbd0c0c
 f000fcc: f1bc 0f10    	.word	#0xf1bc0f10
 f000fd0: da02         	bge	0xf000fd8 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0x18> @ imm = #0x4
 f000fd2: dfff         	svc	#0xff
 f000fd4: 0004         	movs	r4, r0
 f000fd6: 0000         	movs	r0, r0
 f000fd8: b5b0         	push	{r4, r5, r7, lr}
 f000fda: af02         	add	r7, sp, #0x8
 f000fdc: 6805         	ldr	r5, [r0]
 f000fde: 4604         	mov	r4, r0
 f000fe0: f8d5 1084    	.word	#0xf8d51084
 f000fe4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f000fe8: b131         	cbz	r1, 0xf000ff8 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0x38> @ imm = #0xc
 f000fea: f246 7018    	.word	#0xf2467018
 f000fee: f2c2 0000    	.word	#0xf2c20000
 f000ff2: 3009         	adds	r0, #0x9
 f000ff4: f000 f875    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #0xea
 f000ff8: 68a8         	ldr	r0, [r5, #0x8]
 f000ffa: b180         	cbz	r0, 0xf00101e <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0x5e> @ imm = #0x20
 f000ffc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001000: e850 1f00    	.word	#0xe8501f00
 f001004: 1e4a         	subs	r2, r1, #0x1
 f001006: e840 2300    	.word	#0xe8402300
 f00100a: 2b00         	cmp	r3, #0x0
 f00100c: d1f8         	bne	0xf001000 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0x40> @ imm = #-0x10
 f00100e: 2901         	cmp	r1, #0x1
 f001010: d105         	bne	0xf00101e <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0x5e> @ imm = #0xa
 f001012: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001016: e9d5 0102    	.word	#0xe9d50102
 f00101a: f000 f86c    	bl	0xf0010f6 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::ha658a7f69128d260> @ imm = #0xd8
 f00101e: f8d5 0090    	.word	#0xf8d50090
 f001022: 2800         	cmp	r0, #0x0
 f001024: bf18         	it	ne
 f001026: f110 0101    	.word	#0xf1100101
 f00102a: d11b         	bne	0xf001064 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0xa4> @ imm = #0x36
 f00102c: 6821         	ldr	r1, [r4]
 f00102e: 1c48         	adds	r0, r1, #0x1
 f001030: d017         	beq	0xf001062 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0xa2> @ imm = #0x2e
 f001032: 1d08         	adds	r0, r1, #0x4
 f001034: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001038: e850 2f00    	.word	#0xe8502f00
 f00103c: 1e53         	subs	r3, r2, #0x1
 f00103e: e840 3500    	.word	#0xe8403500
 f001042: 2d00         	cmp	r5, #0x0
 f001044: d1f8         	bne	0xf001038 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0x78> @ imm = #-0x10
 f001046: 2a01         	cmp	r2, #0x1
 f001048: bf18         	it	ne
 f00104a: bdb0         	popne	{r4, r5, r7, pc}
 f00104c: f246 7018    	.word	#0xf2467018
 f001050: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001054: f2c2 0000    	.word	#0xf2c20000
 f001058: 3009         	adds	r0, #0x9
 f00105a: e8bd 40b0    	.word	#0xe8bd40b0
 f00105e: f000 b840    	.word	#0xf000b840
 f001062: bdb0         	pop	{r4, r5, r7, pc}
 f001064: 3004         	adds	r0, #0x4
 f001066: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00106a: e850 1f00    	.word	#0xe8501f00
 f00106e: 1e4a         	subs	r2, r1, #0x1
 f001070: e840 2300    	.word	#0xe8402300
 f001074: 2b00         	cmp	r3, #0x0
 f001076: d1f8         	bne	0xf00106a <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0xaa> @ imm = #-0x10
 f001078: 2901         	cmp	r1, #0x1
 f00107a: d1d7         	bne	0xf00102c <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0x6c> @ imm = #-0x52
 f00107c: f246 7018    	.word	#0xf2467018
 f001080: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001084: f2c2 0000    	.word	#0xf2c20000
 f001088: f8d5 1090    	.word	#0xf8d51090
 f00108c: 3009         	adds	r0, #0x9
 f00108e: f000 f828    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #0x50
 f001092: e7cb         	b	0xf00102c <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0x6c> @ imm = #-0x6a
 f001094: 4604         	mov	r4, r0
 f001096: f8d5 0090    	.word	#0xf8d50090
 f00109a: 2800         	cmp	r0, #0x0
 f00109c: bf18         	it	ne
 f00109e: f110 0101    	.word	#0xf1100101
 f0010a2: d103         	bne	0xf0010ac <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0xec> @ imm = #0x6
 f0010a4: 4620         	mov	r0, r4
 f0010a6: f004 fa95    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x452a
 f0010aa: defe         	trap
 f0010ac: 3004         	adds	r0, #0x4
 f0010ae: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0010b2: e850 1f00    	.word	#0xe8501f00
 f0010b6: 1e4a         	subs	r2, r1, #0x1
 f0010b8: e840 2300    	.word	#0xe8402300
 f0010bc: 2b00         	cmp	r3, #0x0
 f0010be: d1f8         	bne	0xf0010b2 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0xf2> @ imm = #-0x10
 f0010c0: 2901         	cmp	r1, #0x1
 f0010c2: d1ef         	bne	0xf0010a4 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391+0xe4> @ imm = #-0x22
 f0010c4: f246 7018    	.word	#0xf2467018
 f0010c8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0010cc: f2c2 0000    	.word	#0xf2c20000
 f0010d0: f8d5 1090    	.word	#0xf8d51090
 f0010d4: 3009         	adds	r0, #0x9
 f0010d6: f000 f804    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #0x8
 f0010da: 4620         	mov	r0, r4
 f0010dc: f004 fa7a    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x44f4
 f0010e0: defe         	trap

0f0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1>:
 f0010e2: f3ef 8c14    	.word	#0xf3ef8c14
 f0010e6: f01c 0c02    	.word	#0xf01c0c02
 f0010ea: f000 8047    	.word	#0xf0008047
 f0010ee: 4608         	mov	r0, r1
 f0010f0: f000 b92f    	.word	#0xf000b92f
 f0010f4: defe         	trap

0f0010f6 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::ha658a7f69128d260>:
 f0010f6: f04f 5c00    	.word	#0xf04f5c00
 f0010fa: f8dc c000    	.word	#0xf8dcc000
 f0010fe: ebbd 0c0c    	.word	#0xebbd0c0c
 f001102: f1bc 0f18    	.word	#0xf1bc0f18
 f001106: da02         	bge	0xf00110e <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::ha658a7f69128d260+0x18> @ imm = #0x4
 f001108: dfff         	svc	#0xff
 f00110a: 0006         	movs	r6, r0
 f00110c: 0000         	movs	r0, r0
 f00110e: b5f0         	push	{r4, r5, r6, r7, lr}
 f001110: af03         	add	r7, sp, #0xc
 f001112: f84d bd04    	.word	#0xf84dbd04
 f001116: 460d         	mov	r5, r1
 f001118: 4604         	mov	r4, r0
 f00111a: 68ae         	ldr	r6, [r5, #0x8]
 f00111c: 6809         	ldr	r1, [r1]
 f00111e: 1e70         	subs	r0, r6, #0x1
 f001120: f020 0007    	.word	#0xf0200007
 f001124: 4420         	add	r0, r4
 f001126: 3008         	adds	r0, #0x8
 f001128: 4788         	blx	r1
 f00112a: 1c60         	adds	r0, r4, #0x1
 f00112c: d022         	beq	0xf001174 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::ha658a7f69128d260+0x7e> @ imm = #0x44
 f00112e: 1d20         	adds	r0, r4, #0x4
 f001130: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001134: e850 1f00    	.word	#0xe8501f00
 f001138: 1e4a         	subs	r2, r1, #0x1
 f00113a: e840 2300    	.word	#0xe8402300
 f00113e: 2b00         	cmp	r3, #0x0
 f001140: d1f8         	bne	0xf001134 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::ha658a7f69128d260+0x3e> @ imm = #-0x10
 f001142: 2901         	cmp	r1, #0x1
 f001144: d116         	bne	0xf001174 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::ha658a7f69128d260+0x7e> @ imm = #0x2c
 f001146: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00114a: 2e04         	cmp	r6, #0x4
 f00114c: 6868         	ldr	r0, [r5, #0x4]
 f00114e: bf98         	it	ls
 f001150: 2604         	movls	r6, #0x4
 f001152: 4271         	rsbs	r1, r6, #0
 f001154: 4430         	add	r0, r6
 f001156: 3007         	adds	r0, #0x7
 f001158: 4208         	tst	r0, r1
 f00115a: d00b         	beq	0xf001174 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::ha658a7f69128d260+0x7e> @ imm = #0x16
 f00115c: f246 7018    	.word	#0xf2467018
 f001160: 4621         	mov	r1, r4
 f001162: f2c2 0000    	.word	#0xf2c20000
 f001166: 3009         	adds	r0, #0x9
 f001168: f85d bb04    	.word	#0xf85dbb04
 f00116c: e8bd 40f0    	.word	#0xe8bd40f0
 f001170: f7ff bfb7    	.word	#0xf7ffbfb7
 f001174: f85d bb04    	.word	#0xf85dbb04
 f001178: bdf0         	pop	{r4, r5, r6, r7, pc}
 f00117a: d4d4         	bmi	0xf001126 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::ha658a7f69128d260+0x30> @ imm = #-0x58

0f00117c <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5>:
 f00117c: f04f 5c00    	.word	#0xf04f5c00
 f001180: f8dc c000    	.word	#0xf8dcc000
 f001184: ebbd 0c0c    	.word	#0xebbd0c0c
 f001188: f1bc 0f10    	.word	#0xf1bc0f10
 f00118c: da02         	bge	0xf001194 <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x18> @ imm = #0x4
 f00118e: dfff         	svc	#0xff
 f001190: 0004         	movs	r4, r0
 f001192: 0000         	movs	r0, r0
 f001194: b5b0         	push	{r4, r5, r7, lr}
 f001196: af02         	add	r7, sp, #0x8
 f001198: f246 7c18    	.word	#0xf2467c18
 f00119c: f2c2 0c00    	.word	#0xf2c20c00
 f0011a0: f89c 2004    	.word	#0xf89c2004
 f0011a4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0011a8: b12a         	cbz	r2, 0xf0011b6 <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x3a> @ imm = #0xa
 f0011aa: f3ef 8205    	.word	#0xf3ef8205
 f0011ae: 2a0b         	cmp	r2, #0xb
 f0011b0: bf18         	it	ne
 f0011b2: 2a0e         	cmpne	r2, #0xe
 f0011b4: d162         	bne	0xf00127c <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x100> @ imm = #0xc4
 f0011b6: 7802         	ldrb	r2, [r0]
 f0011b8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0011bc: b972         	cbnz	r2, 0xf0011dc <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x60> @ imm = #0x1c
 f0011be: 7802         	ldrb	r2, [r0]
 f0011c0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0011c4: 2a00         	cmp	r2, #0x0
 f0011c6: bf02         	ittt	eq
 f0011c8: 7802         	ldrbeq	r2, [r0]
 f0011ca: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0011ce: 2a00         	cmpeq	r2, #0x0
 f0011d0: d104         	bne	0xf0011dc <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x60> @ imm = #0x8
 f0011d2: 7802         	ldrb	r2, [r0]
 f0011d4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0011d8: 2a00         	cmp	r2, #0x0
 f0011da: d0ec         	beq	0xf0011b6 <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x3a> @ imm = #-0x28
 f0011dc: 7842         	ldrb	r2, [r0, #0x1]
 f0011de: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0011e2: b172         	cbz	r2, 0xf001202 <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x86> @ imm = #0x1c
 f0011e4: 7842         	ldrb	r2, [r0, #0x1]
 f0011e6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0011ea: 2a00         	cmp	r2, #0x0
 f0011ec: bf1e         	ittt	ne
 f0011ee: 7842         	ldrbne	r2, [r0, #0x1]
 f0011f0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0011f4: 2a00         	cmpne	r2, #0x0
 f0011f6: d004         	beq	0xf001202 <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x86> @ imm = #0x8
 f0011f8: 7842         	ldrb	r2, [r0, #0x1]
 f0011fa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0011fe: 2a00         	cmp	r2, #0x0
 f001200: d1ec         	bne	0xf0011dc <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x60> @ imm = #-0x28
 f001202: f04f 0e01    	.word	#0xf04f0e01
 f001206: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00120a: f880 e001    	.word	#0xf880e001
 f00120e: 3904         	subs	r1, #0x4
 f001210: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001214: f8dc 2010    	.word	#0xf8dc2010
 f001218: f8cc 1010    	.word	#0xf8cc1010
 f00121c: 2a00         	cmp	r2, #0x0
 f00121e: f000 8091    	.word	#0xf0008091
 f001222: 6811         	ldr	r1, [r2]
 f001224: f8dc 3018    	.word	#0xf8dc3018
 f001228: f021 0403    	.word	#0xf0210403
 f00122c: 1b1b         	subs	r3, r3, r4
 f00122e: f8cc 3018    	.word	#0xf8cc3018
 f001232: 5d13         	ldrb	r3, [r2, r4]
 f001234: ea2e 0c01    	.word	#0xea2e0c01
 f001238: eb02 0e04    	.word	#0xeb020e04
 f00123c: f003 0302    	.word	#0xf0030302
 f001240: 4463         	add	r3, r12
 f001242: f240 0c04    	.word	#0xf2400c04
 f001246: f083 0302    	.word	#0xf0830302
 f00124a: f2c2 0c00    	.word	#0xf2c20c00
 f00124e: e8df f003    	.word	#0xe8dff003

0f001252 <$d.30>:
 f001252: 4b 02 16 29  	.word	0x2916024b

0f001256 <$t.31>:
 f001256: f852 1c04    	.word	#0xf8521c04
 f00125a: 1a53         	subs	r3, r2, r1
 f00125c: 2106         	movs	r1, #0x6
 f00125e: f2c2 0100    	.word	#0xf2c20100
 f001262: f8b3 e004    	.word	#0xf8b3e004
 f001266: 88dc         	ldrh	r4, [r3, #0x6]
 f001268: f821 402e    	.word	#0xf821402e
 f00126c: f82c e024    	.word	#0xf82ce024
 f001270: 681c         	ldr	r4, [r3]
 f001272: 6811         	ldr	r1, [r2]
 f001274: f024 0203    	.word	#0xf0240203
 f001278: 4411         	add	r1, r2
 f00127a: e031         	b	0xf0012e0 <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x164> @ imm = #0x62
 f00127c: e7fe         	b	0xf00127c <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x100> @ imm = #-0x4
 f00127e: f8be 1004    	.word	#0xf8be1004
 f001282: 2406         	movs	r4, #0x6
 f001284: f8be 3006    	.word	#0xf8be3006
 f001288: f2c2 0400    	.word	#0xf2c20400
 f00128c: f824 3021    	.word	#0xf8243021
 f001290: f82c 1023    	.word	#0xf82c1023
 f001294: f8de 1000    	.word	#0xf8de1000
 f001298: 6813         	ldr	r3, [r2]
 f00129a: f021 0103    	.word	#0xf0210103
 f00129e: 4419         	add	r1, r3
 f0012a0: 6011         	str	r1, [r2]
 f0012a2: e021         	b	0xf0012e8 <hopter::allocator::Allocator::kernel_free::ha23cc858cc0964f5+0x16c> @ imm = #0x42
 f0012a4: f852 1c04    	.word	#0xf8521c04
 f0012a8: 2506         	movs	r5, #0x6
 f0012aa: f2c2 0500    	.word	#0xf2c20500
 f0012ae: 1a53         	subs	r3, r2, r1
 f0012b0: 8899         	ldrh	r1, [r3, #0x4]
 f0012b2: 88dc         	ldrh	r4, [r3, #0x6]
 f0012b4: f825 4021    	.word	#0xf8254021
 f0012b8: f82c 1024    	.word	#0xf82c1024
 f0012bc: f8be 1004    	.word	#0xf8be1004
 f0012c0: f8be 4006    	.word	#0xf8be4006
 f0012c4: f825 4021    	.word	#0xf8254021
 f0012c8: f82c 1024    	.word	#0xf82c1024
 f0012cc: 681c         	ldr	r4, [r3]
 f0012ce: 6811         	ldr	r1, [r2]
 f0012d0: f8de 2000    	.word	#0xf8de2000
 f0012d4: f024 0503    	.word	#0xf0240503
 f0012d8: 4429         	add	r1, r5
 f0012da: f022 0203    	.word	#0xf0220203
 f0012de: 4411         	add	r1, r2
 f0012e0: f364 0101    	.word	#0xf3640101
 f0012e4: 461a         	mov	r2, r3
 f0012e6: 6019         	str	r1, [r3]
 f0012e8: f021 0302    	.word	#0xf0210302
 f0012ec: f021 0103    	.word	#0xf0210103
 f0012f0: 6013         	str	r3, [r2]
 f0012f2: 1853         	adds	r3, r2, r1
 f0012f4: 251b         	movs	r5, #0x1b
 f0012f6: f843 1c04    	.word	#0xf8431c04
 f0012fa: 6811         	ldr	r1, [r2]
 f0012fc: f041 0301    	.word	#0xf0410301
 f001300: f021 0103    	.word	#0xf0210103
 f001304: 6013         	str	r3, [r2]
 f001306: 5853         	ldr	r3, [r2, r1]
 f001308: f023 0301    	.word	#0xf0230301
 f00130c: 5053         	str	r3, [r2, r1]
 f00130e: 6811         	ldr	r1, [r2]
 f001310: f021 0103    	.word	#0xf0210103
 f001314: fab1 f181    	.word	#0xfab1f181
 f001318: 428d         	cmp	r5, r1
 f00131a: f1c1 031b    	.word	#0xf1c1031b
 f00131e: f246 6148    	.word	#0xf2466148
 f001322: bf38         	it	lo
 f001324: 2300         	movlo	r3, #0x0
 f001326: f2c2 0100    	.word	#0xf2c20100
 f00132a: 2b05         	cmp	r3, #0x5
 f00132c: bf28         	it	hs
 f00132e: 2305         	movhs	r3, #0x5
 f001330: eb01 01c3    	.word	#0xeb0101c3
 f001334: 0895         	lsrs	r5, r2, #0x2
 f001336: 88cb         	ldrh	r3, [r1, #0x6]
 f001338: 80cd         	strh	r5, [r1, #0x6]
 f00133a: 0889         	lsrs	r1, r1, #0x2
 f00133c: f82c 5023    	.word	#0xf82c5023
 f001340: 8091         	strh	r1, [r2, #0x4]
 f001342: 80d3         	strh	r3, [r2, #0x6]
 f001344: 2100         	movs	r1, #0x0
 f001346: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00134a: 7041         	strb	r1, [r0, #0x1]
 f00134c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001350: bdb0         	pop	{r4, r5, r7, pc}

0f001352 <hopter::interrupt::svc::svc_free::h00e36469b2e6b06c>:
 f001352: df05         	svc	#0x5
 f001354: 4770         	bx	lr
 f001356: defe         	trap

0f001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e>:
 f001358: f3ef 8c14    	.word	#0xf3ef8c14
 f00135c: f01c 0c02    	.word	#0xf01c0c02
 f001360: f000 8004    	.word	#0xf0008004
 f001364: 4608         	mov	r0, r1
 f001366: f000 b92f    	.word	#0xf000b92f
 f00136a: defe         	trap

0f00136c <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7>:
 f00136c: f04f 5c00    	.word	#0xf04f5c00
 f001370: f8dc c000    	.word	#0xf8dcc000
 f001374: ebbd 0c0c    	.word	#0xebbd0c0c
 f001378: f1bc 0f20    	.word	#0xf1bc0f20
 f00137c: da02         	bge	0xf001384 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x18> @ imm = #0x4
 f00137e: dfff         	svc	#0xff
 f001380: 0008         	movs	r0, r1
 f001382: 0000         	movs	r0, r0
 f001384: b5f0         	push	{r4, r5, r6, r7, lr}
 f001386: af03         	add	r7, sp, #0xc
 f001388: e92d 0b00    	.word	#0xe92d0b00
 f00138c: f246 7c18    	.word	#0xf2467c18
 f001390: f2c2 0c00    	.word	#0xf2c20c00
 f001394: f89c 2004    	.word	#0xf89c2004
 f001398: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00139c: b11a         	cbz	r2, 0xf0013a6 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x3a> @ imm = #0x6
 f00139e: f3ef 8205    	.word	#0xf3ef8205
 f0013a2: 2a0b         	cmp	r2, #0xb
 f0013a4: d145         	bne	0xf001432 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0xc6> @ imm = #0x8a
 f0013a6: 7802         	ldrb	r2, [r0]
 f0013a8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0013ac: b972         	cbnz	r2, 0xf0013cc <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x60> @ imm = #0x1c
 f0013ae: 7802         	ldrb	r2, [r0]
 f0013b0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0013b4: 2a00         	cmp	r2, #0x0
 f0013b6: bf02         	ittt	eq
 f0013b8: 7802         	ldrbeq	r2, [r0]
 f0013ba: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0013be: 2a00         	cmpeq	r2, #0x0
 f0013c0: d104         	bne	0xf0013cc <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x60> @ imm = #0x8
 f0013c2: 7802         	ldrb	r2, [r0]
 f0013c4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0013c8: 2a00         	cmp	r2, #0x0
 f0013ca: d0ec         	beq	0xf0013a6 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x3a> @ imm = #-0x28
 f0013cc: 7842         	ldrb	r2, [r0, #0x1]
 f0013ce: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0013d2: b172         	cbz	r2, 0xf0013f2 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x86> @ imm = #0x1c
 f0013d4: 7842         	ldrb	r2, [r0, #0x1]
 f0013d6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0013da: 2a00         	cmp	r2, #0x0
 f0013dc: bf1e         	ittt	ne
 f0013de: 7842         	ldrbne	r2, [r0, #0x1]
 f0013e0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0013e4: 2a00         	cmpne	r2, #0x0
 f0013e6: d004         	beq	0xf0013f2 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x86> @ imm = #0x8
 f0013e8: 7842         	ldrb	r2, [r0, #0x1]
 f0013ea: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0013ee: 2a00         	cmp	r2, #0x0
 f0013f0: d1ec         	bne	0xf0013cc <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x60> @ imm = #-0x28
 f0013f2: 2201         	movs	r2, #0x1
 f0013f4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0013f8: 7042         	strb	r2, [r0, #0x1]
 f0013fa: 2900         	cmp	r1, #0x0
 f0013fc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001400: d061         	beq	0xf0014c6 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x15a> @ imm = #0xc2
 f001402: 1d0a         	adds	r2, r1, #0x4
 f001404: 2a10         	cmp	r2, #0x10
 f001406: bf98         	it	ls
 f001408: 2210         	movls	r2, #0x10
 f00140a: f8dc 1010    	.word	#0xf8dc1010
 f00140e: 3207         	adds	r2, #0x7
 f001410: f022 0307    	.word	#0xf0220307
 f001414: b171         	cbz	r1, 0xf001434 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0xc8> @ imm = #0x1c
 f001416: 680a         	ldr	r2, [r1]
 f001418: f022 0203    	.word	#0xf0220203
 f00141c: 1ad2         	subs	r2, r2, r3
 f00141e: d309         	blo	0xf001434 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0xc8> @ imm = #0x12
 f001420: f5b2 7f00    	.word	#0xf5b27f00
 f001424: d806         	bhi	0xf001434 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0xc8> @ imm = #0xc
 f001426: f101 0904    	.word	#0xf1010904
 f00142a: 2200         	movs	r2, #0x0
 f00142c: f8cc 2010    	.word	#0xf8cc2010
 f001430: e0a9         	b	0xf001586 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x21a> @ imm = #0x152
 f001432: e7fe         	b	0xf001432 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0xc6> @ imm = #-0x4
 f001434: fab3 f183    	.word	#0xfab3f183
 f001438: 261b         	movs	r6, #0x1b
 f00143a: f1c1 021b    	.word	#0xf1c1021b
 f00143e: 428e         	cmp	r6, r1
 f001440: bf38         	it	lo
 f001442: 2200         	movlo	r2, #0x0
 f001444: 2a04         	cmp	r2, #0x4
 f001446: bf28         	it	hs
 f001448: 2204         	movhs	r2, #0x4
 f00144a: f246 6e48    	.word	#0xf2466e48
 f00144e: 3201         	adds	r2, #0x1
 f001450: f2c2 0e00    	.word	#0xf2c20e00
 f001454: eb0e 05c2    	.word	#0xeb0e05c2
 f001458: 1c54         	adds	r4, r2, #0x1
 f00145a: 2a04         	cmp	r2, #0x4
 f00145c: 88e9         	ldrh	r1, [r5, #0x6]
 f00145e: bf88         	it	hi
 f001460: 2405         	movhi	r4, #0x5
 f001462: 0089         	lsls	r1, r1, #0x2
 f001464: f101 5100    	.word	#0xf1015100
 f001468: 428d         	cmp	r5, r1
 f00146a: d027         	beq	0xf0014bc <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x150> @ imm = #0x4e
 f00146c: 680e         	ldr	r6, [r1]
 f00146e: f026 0603    	.word	#0xf0260603
 f001472: 429e         	cmp	r6, r3
 f001474: d22e         	bhs	0xf0014d4 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x168> @ imm = #0x5c
 f001476: 88c9         	ldrh	r1, [r1, #0x6]
 f001478: 0089         	lsls	r1, r1, #0x2
 f00147a: f101 5100    	.word	#0xf1015100
 f00147e: 428d         	cmp	r5, r1
 f001480: d01c         	beq	0xf0014bc <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x150> @ imm = #0x38
 f001482: 680e         	ldr	r6, [r1]
 f001484: f026 0603    	.word	#0xf0260603
 f001488: 429e         	cmp	r6, r3
 f00148a: d223         	bhs	0xf0014d4 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x168> @ imm = #0x46
 f00148c: 88c9         	ldrh	r1, [r1, #0x6]
 f00148e: 0089         	lsls	r1, r1, #0x2
 f001490: f101 5100    	.word	#0xf1015100
 f001494: 428d         	cmp	r5, r1
 f001496: d011         	beq	0xf0014bc <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x150> @ imm = #0x22
 f001498: 680e         	ldr	r6, [r1]
 f00149a: f026 0603    	.word	#0xf0260603
 f00149e: 429e         	cmp	r6, r3
 f0014a0: d218         	bhs	0xf0014d4 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x168> @ imm = #0x30
 f0014a2: 88c9         	ldrh	r1, [r1, #0x6]
 f0014a4: 0089         	lsls	r1, r1, #0x2
 f0014a6: f101 5100    	.word	#0xf1015100
 f0014aa: 428d         	cmp	r5, r1
 f0014ac: d006         	beq	0xf0014bc <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x150> @ imm = #0xc
 f0014ae: 680e         	ldr	r6, [r1]
 f0014b0: f026 0603    	.word	#0xf0260603
 f0014b4: 429e         	cmp	r6, r3
 f0014b6: d20d         	bhs	0xf0014d4 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x168> @ imm = #0x1a
 f0014b8: 88c9         	ldrh	r1, [r1, #0x6]
 f0014ba: e7d2         	b	0xf001462 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0xf6> @ imm = #-0x5c
 f0014bc: 2a04         	cmp	r2, #0x4
 f0014be: d802         	bhi	0xf0014c6 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x15a> @ imm = #0x4
 f0014c0: 2c05         	cmp	r4, #0x5
 f0014c2: 4622         	mov	r2, r4
 f0014c4: d9c6         	bls	0xf001454 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0xe8> @ imm = #-0x74
 f0014c6: 2100         	movs	r1, #0x0
 f0014c8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0014cc: 7041         	strb	r1, [r0, #0x1]
 f0014ce: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0014d2: e075         	b	0xf0015c0 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x254> @ imm = #0xea
 f0014d4: 4689         	mov	r9, r1
 f0014d6: 88ce         	ldrh	r6, [r1, #0x6]
 f0014d8: f839 5f04    	.word	#0xf8395f04
 f0014dc: 2406         	movs	r4, #0x6
 f0014de: f240 0804    	.word	#0xf2400804
 f0014e2: f2c2 0400    	.word	#0xf2c20400
 f0014e6: f2c2 0800    	.word	#0xf2c20800
 f0014ea: f824 6025    	.word	#0xf8246025
 f0014ee: f103 040c    	.word	#0xf103040c
 f0014f2: f828 5026    	.word	#0xf8285026
 f0014f6: 680e         	ldr	r6, [r1]
 f0014f8: f026 0503    	.word	#0xf0260503
 f0014fc: 42a5         	cmp	r5, r4
 f0014fe: d325         	blo	0xf00154c <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x1e0> @ imm = #0x4a
 f001500: 1aec         	subs	r4, r5, r3
 f001502: 440d         	add	r5, r1
 f001504: 50cc         	str	r4, [r1, r3]
 f001506: 261b         	movs	r6, #0x1b
 f001508: f845 4c04    	.word	#0xf8454c04
 f00150c: fab4 f484    	.word	#0xfab4f484
 f001510: 58cd         	ldr	r5, [r1, r3]
 f001512: 42a6         	cmp	r6, r4
 f001514: f025 0502    	.word	#0xf0250502
 f001518: 50cd         	str	r5, [r1, r3]
 f00151a: f1c4 051b    	.word	#0xf1c4051b
 f00151e: bf38         	it	lo
 f001520: 2500         	movlo	r5, #0x0
 f001522: 2d05         	cmp	r5, #0x5
 f001524: bf28         	it	hs
 f001526: 2505         	movhs	r5, #0x5
 f001528: eb0e 06c5    	.word	#0xeb0e06c5
 f00152c: 18cd         	adds	r5, r1, r3
 f00152e: 88f2         	ldrh	r2, [r6, #0x6]
 f001530: 08ac         	lsrs	r4, r5, #0x2
 f001532: 80f4         	strh	r4, [r6, #0x6]
 f001534: 08b6         	lsrs	r6, r6, #0x2
 f001536: f828 4022    	.word	#0xf8284022
 f00153a: 80ae         	strh	r6, [r5, #0x4]
 f00153c: 80ea         	strh	r2, [r5, #0x6]
 f00153e: 461d         	mov	r5, r3
 f001540: 680a         	ldr	r2, [r1]
 f001542: f002 0203    	.word	#0xf0020203
 f001546: ea42 0603    	.word	#0xea420603
 f00154a: 600e         	str	r6, [r1]
 f00154c: f046 0203    	.word	#0xf0460203
 f001550: 600a         	str	r2, [r1]
 f001552: 594a         	ldr	r2, [r1, r5]
 f001554: 194b         	adds	r3, r1, r5
 f001556: f042 0201    	.word	#0xf0420201
 f00155a: 514a         	str	r2, [r1, r5]
 f00155c: f8dc 2014    	.word	#0xf8dc2014
 f001560: 429a         	cmp	r2, r3
 f001562: bf3e         	ittt	lo
 f001564: 2201         	movlo	r2, #0x1
 f001566: f88c 2002    	.word	#0xf88c2002
 f00156a: f8cc 3014    	.word	#0xf8cc3014
 f00156e: 6809         	ldr	r1, [r1]
 f001570: e9dc 2306    	.word	#0xe9dc2306
 f001574: f021 0103    	.word	#0xf0210103
 f001578: 4411         	add	r1, r2
 f00157a: f8cc 1018    	.word	#0xf8cc1018
 f00157e: 4299         	cmp	r1, r3
 f001580: bf28         	it	hs
 f001582: f8cc 101c    	.word	#0xf8cc101c
 f001586: 2100         	movs	r1, #0x0
 f001588: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00158c: 7041         	strb	r1, [r0, #0x1]
 f00158e: f1b9 0f00    	.word	#0xf1b90f00
 f001592: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001596: d013         	beq	0xf0015c0 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x254> @ imm = #0x26
 f001598: f89c 0002    	.word	#0xf89c0002
 f00159c: 2801         	cmp	r0, #0x1
 f00159e: d10b         	bne	0xf0015b8 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x24c> @ imm = #0x16
 f0015a0: f88c 1002    	.word	#0xf88c1002
 f0015a4: f06f 026b    	.word	#0xf06f026b
 f0015a8: f8dc 0014    	.word	#0xf8dc0014
 f0015ac: f8dc 1048    	.word	#0xf8dc1048
 f0015b0: fb01 0002    	.word	#0xfb010002
 f0015b4: f8cc 0020    	.word	#0xf8cc0020
 f0015b8: 4648         	mov	r0, r9
 f0015ba: e8bd 0b00    	.word	#0xe8bd0b00
 f0015be: bdf0         	pop	{r4, r5, r6, r7, pc}
 f0015c0: f3ef 8010    	.word	#0xf3ef8010
 f0015c4: b672         	cpsid i
 f0015c6: e7fe         	b	0xf0015c6 <hopter::allocator::Allocator::kernel_malloc::hfd88ebcabe199fb7+0x25a> @ imm = #-0x4

0f0015c8 <hopter::interrupt::svc::svc_malloc::h8b08df9f38d5dcc2>:
 f0015c8: df04         	svc	#0x4
 f0015ca: 4770         	bx	lr
 f0015cc: defe         	trap

0f0015ce <hopter::task::trampoline::task_entry::h3677dedef4cc6b46>:
 f0015ce: f04f 5c00    	.word	#0xf04f5c00
 f0015d2: f8dc c000    	.word	#0xf8dcc000
 f0015d6: ebbd 0c0c    	.word	#0xebbd0c0c
 f0015da: f1bc 0f18    	.word	#0xf1bc0f18
 f0015de: da02         	bge	0xf0015e6 <hopter::task::trampoline::task_entry::h3677dedef4cc6b46+0x18> @ imm = #0x4
 f0015e0: dfff         	svc	#0xff
 f0015e2: 0006         	movs	r6, r0
 f0015e4: 0000         	movs	r0, r0
 f0015e6: b5f0         	push	{r4, r5, r6, r7, lr}
 f0015e8: af03         	add	r7, sp, #0xc
 f0015ea: f84d bd04    	.word	#0xf84dbd04
 f0015ee: 4604         	mov	r4, r0
 f0015f0: 6800         	ldr	r0, [r0]
 f0015f2: f7fe fe1f    	bl	0xf000234 <__main_trampoline> @ imm = #-0x13c2
 f0015f6: defe         	trap
 f0015f8: f246 7618    	.word	#0xf2467618
 f0015fc: 4601         	mov	r1, r0
 f0015fe: f246 6078    	.word	#0xf2466078
 f001602: f2c2 0600    	.word	#0xf2c20600
 f001606: f2c2 0000    	.word	#0xf2c20000
 f00160a: 4281         	cmp	r1, r0
 f00160c: d00d         	beq	0xf00162a <hopter::task::trampoline::task_entry::h3677dedef4cc6b46+0x5c> @ imm = #0x1a
 f00160e: f106 0009    	.word	#0xf1060009
 f001612: f7ff fd66    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #-0x534
 f001616: f3ef 8005    	.word	#0xf3ef8005
 f00161a: b180         	cbz	r0, 0xf00163e <hopter::task::trampoline::task_entry::h3677dedef4cc6b46+0x70> @ imm = #0x20
 f00161c: 2000         	movs	r0, #0x0
 f00161e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001622: 7230         	strb	r0, [r6, #0x8]
 f001624: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001628: e00c         	b	0xf001644 <hopter::task::trampoline::task_entry::h3677dedef4cc6b46+0x76> @ imm = #0x18
 f00162a: 2000         	movs	r0, #0x0
 f00162c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001630: 71f0         	strb	r0, [r6, #0x7]
 f001632: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001636: f3ef 8005    	.word	#0xf3ef8005
 f00163a: 2800         	cmp	r0, #0x0
 f00163c: d1ee         	bne	0xf00161c <hopter::task::trampoline::task_entry::h3677dedef4cc6b46+0x4e> @ imm = #-0x24
 f00163e: 2000         	movs	r0, #0x0
 f001640: f000 fb63    	bl	0xf001d0a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b> @ imm = #0x6c6
 f001644: f106 0009    	.word	#0xf1060009
 f001648: 4621         	mov	r1, r4
 f00164a: f85d bb04    	.word	#0xf85dbb04
 f00164e: e8bd 40f0    	.word	#0xe8bd40f0
 f001652: f7ff bd46    	.word	#0xf7ffbd46
 f001656: 4605         	mov	r5, r0
 f001658: f106 0009    	.word	#0xf1060009
 f00165c: 4621         	mov	r1, r4
 f00165e: f7ff fd40    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #-0x580
 f001662: 4628         	mov	r0, r5
 f001664: f003 ffb6    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x3f6c
 f001668: defe         	trap

0f00166a <hopter::interrupt::svc::svc_destroy_current_task::hce3e75a8b63bc075>:
 f00166a: df08         	svc	#0x8
 f00166c: 4770         	bx	lr
 f00166e: defe         	trap

0f001670 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e>:
 f001670: f04f 5c00    	.word	#0xf04f5c00
 f001674: f8dc c000    	.word	#0xf8dcc000
 f001678: ebbd 0c0c    	.word	#0xebbd0c0c
 f00167c: f1bc 0f28    	.word	#0xf1bc0f28
 f001680: da02         	bge	0xf001688 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x18> @ imm = #0x4
 f001682: dfff         	svc	#0xff
 f001684: 000a         	movs	r2, r1
 f001686: 0000         	movs	r0, r0
 f001688: b5f0         	push	{r4, r5, r6, r7, lr}
 f00168a: af03         	add	r7, sp, #0xc
 f00168c: f84d 8d04    	.word	#0xf84d8d04
 f001690: b084         	sub	sp, #0x10
 f001692: 0600         	lsls	r0, r0, #0x18
 f001694: 9100         	str	r1, [sp]
 f001696: d009         	beq	0xf0016ac <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x3c> @ imm = #0x12
 f001698: f246 7018    	.word	#0xf2467018
 f00169c: f2c2 0000    	.word	#0xf2c20000
 f0016a0: 6b42         	ldr	r2, [r0, #0x34]
 f0016a2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0016a6: 9900         	ldr	r1, [sp]
 f0016a8: 2a0f         	cmp	r2, #0xf
 f0016aa: d914         	bls	0xf0016d6 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x66> @ imm = #0x28
 f0016ac: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0016b0: e851 0f00    	.word	#0xe8510f00
 f0016b4: 1e42         	subs	r2, r0, #0x1
 f0016b6: e841 2300    	.word	#0xe8412300
 f0016ba: 2b00         	cmp	r3, #0x0
 f0016bc: d1f8         	bne	0xf0016b0 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x40> @ imm = #-0x10
 f0016be: 2801         	cmp	r0, #0x1
 f0016c0: d104         	bne	0xf0016cc <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x5c> @ imm = #0x8
 f0016c2: 4668         	mov	r0, sp
 f0016c4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0016c8: f7ff fc7a    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x70c
 f0016cc: 2001         	movs	r0, #0x1
 f0016ce: b004         	add	sp, #0x10
 f0016d0: f85d 8b04    	.word	#0xf85d8b04
 f0016d4: bdf0         	pop	{r4, r5, r6, r7, pc}
 f0016d6: f246 4598    	.word	#0xf2464598
 f0016da: f2c2 0500    	.word	#0xf2c20500
 f0016de: f105 0291    	.word	#0xf1050291
 f0016e2: e8d2 3f4f    	.word	#0xe8d23f4f
 f0016e6: b94b         	cbnz	r3, 0xf0016fc <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x8c> @ imm = #0x12
 f0016e8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0016ec: 2301         	movs	r3, #0x1
 f0016ee: e8c2 3f46    	.word	#0xe8c23f46
 f0016f2: b136         	cbz	r6, 0xf001702 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x92> @ imm = #0xc
 f0016f4: e8d2 3f4f    	.word	#0xe8d23f4f
 f0016f8: 2b00         	cmp	r3, #0x0
 f0016fa: d0f7         	beq	0xf0016ec <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x7c> @ imm = #-0x12
 f0016fc: 2300         	movs	r3, #0x0
 f0016fe: f3bf 8f2f    	.word	#0xf3bf8f2f
 f001702: 2b00         	cmp	r3, #0x0
 f001704: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001708: 9501         	str	r5, [sp, #0x4]
 f00170a: f88d 3008    	.word	#0xf88d3008
 f00170e: d074         	beq	0xf0017fa <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x18a> @ imm = #0xe8
 f001710: f895 2084    	.word	#0xf8952084
 f001714: 2a00         	cmp	r2, #0x0
 f001716: d173         	bne	0xf001800 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x190> @ imm = #0xe6
 f001718: f105 0284    	.word	#0xf1050284
 f00171c: 2301         	movs	r3, #0x1
 f00171e: e8d2 6f4f    	.word	#0xe8d26f4f
 f001722: 2e00         	cmp	r6, #0x0
 f001724: d16a         	bne	0xf0017fc <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x18c> @ imm = #0xd4
 f001726: e8c2 3f46    	.word	#0xe8c23f46
 f00172a: 2e00         	cmp	r6, #0x0
 f00172c: d1f7         	bne	0xf00171e <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0xae> @ imm = #-0x12
 f00172e: f101 0210    	.word	#0xf1010210
 f001732: 2300         	movs	r3, #0x0
 f001734: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001738: e852 6f00    	.word	#0xe8526f00
 f00173c: 2e01         	cmp	r6, #0x1
 f00173e: d171         	bne	0xf001824 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x1b4> @ imm = #0xe2
 f001740: e842 3600    	.word	#0xe8423600
 f001744: 2e00         	cmp	r6, #0x0
 f001746: d1f7         	bne	0xf001738 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0xc8> @ imm = #-0x12
 f001748: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00174c: 2600         	movs	r6, #0x0
 f00174e: f8d5 308c    	.word	#0xf8d5308c
 f001752: 2b00         	cmp	r3, #0x0
 f001754: bf18         	it	ne
 f001756: 601a         	strne	r2, [r3]
 f001758: e9c1 6304    	.word	#0xe9c16304
 f00175c: f8d5 1088    	.word	#0xf8d51088
 f001760: f8c5 208c    	.word	#0xf8c5208c
 f001764: 2900         	cmp	r1, #0x0
 f001766: bf08         	it	eq
 f001768: f8c5 2088    	.word	#0xf8c52088
 f00176c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001770: e850 1f0d    	.word	#0xe8501f0d
 f001774: 3101         	adds	r1, #0x1
 f001776: e840 120d    	.word	#0xe840120d
 f00177a: 2a00         	cmp	r2, #0x0
 f00177c: d1f8         	bne	0xf001770 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x100> @ imm = #-0x10
 f00177e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001782: 2600         	movs	r6, #0x0
 f001784: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001788: f885 6084    	.word	#0xf8856084
 f00178c: f89d 0008    	.word	#0xf89d0008
 f001790: 9c01         	ldr	r4, [sp, #0x4]
 f001792: b3d8         	cbz	r0, 0xf00180c <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x19c> @ imm = #0x76
 f001794: f104 0884    	.word	#0xf1040884
 f001798: 2501         	movs	r5, #0x1
 f00179a: 9801         	ldr	r0, [sp, #0x4]
 f00179c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0017a0: 3090         	adds	r0, #0x90
 f0017a2: e8d0 1f4f    	.word	#0xe8d01f4f
 f0017a6: e8c0 6f42    	.word	#0xe8c06f42
 f0017aa: 2a00         	cmp	r2, #0x0
 f0017ac: d1f9         	bne	0xf0017a2 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x132> @ imm = #-0xe
 f0017ae: 2900         	cmp	r1, #0x0
 f0017b0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0017b4: bf1e         	ittt	ne
 f0017b6: 4620         	movne	r0, r4
 f0017b8: 4641         	movne	r1, r8
 f0017ba: f000 f8b3    	blne	0xf001924 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb> @ imm = #0x166
 f0017be: 9801         	ldr	r0, [sp, #0x4]
 f0017c0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0017c4: f880 6091    	.word	#0xf8806091
 f0017c8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0017cc: f890 0090    	.word	#0xf8900090
 f0017d0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0017d4: b308         	cbz	r0, 0xf00181a <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x1aa> @ imm = #0x42
 f0017d6: 9801         	ldr	r0, [sp, #0x4]
 f0017d8: 3091         	adds	r0, #0x91
 f0017da: e8d0 1f4f    	.word	#0xe8d01f4f
 f0017de: b981         	cbnz	r1, 0xf001802 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x192> @ imm = #0x20
 f0017e0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0017e4: e8c0 5f41    	.word	#0xe8c05f41
 f0017e8: b121         	cbz	r1, 0xf0017f4 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x184> @ imm = #0x8
 f0017ea: e8d0 1f4f    	.word	#0xe8d01f4f
 f0017ee: 2900         	cmp	r1, #0x0
 f0017f0: d0f8         	beq	0xf0017e4 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x174> @ imm = #-0x10
 f0017f2: e006         	b	0xf001802 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x192> @ imm = #0xc
 f0017f4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0017f8: e7cf         	b	0xf00179a <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x12a> @ imm = #-0x62
 f0017fa: e7fe         	b	0xf0017fa <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x18a> @ imm = #-0x4
 f0017fc: f3bf 8f2f    	.word	#0xf3bf8f2f
 f001800: e7fe         	b	0xf001800 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x190> @ imm = #-0x4
 f001802: f3bf 8f2f    	.word	#0xf3bf8f2f
 f001806: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00180a: e7fe         	b	0xf00180a <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x19a> @ imm = #-0x4
 f00180c: 2001         	movs	r0, #0x1
 f00180e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001812: f884 0090    	.word	#0xf8840090
 f001816: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00181a: 2000         	movs	r0, #0x0
 f00181c: b004         	add	sp, #0x10
 f00181e: f85d 8b04    	.word	#0xf85d8b04
 f001822: bdf0         	pop	{r4, r5, r6, r7, pc}
 f001824: f3bf 8f2f    	.word	#0xf3bf8f2f
 f001828: 9103         	str	r1, [sp, #0xc]
 f00182a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00182e: e851 0f00    	.word	#0xe8510f00
 f001832: 1e42         	subs	r2, r0, #0x1
 f001834: e841 2300    	.word	#0xe8412300
 f001838: 2b00         	cmp	r3, #0x0
 f00183a: d1f8         	bne	0xf00182e <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x1be> @ imm = #-0x10
 f00183c: 2801         	cmp	r0, #0x1
 f00183e: d104         	bne	0xf00184a <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e+0x1da> @ imm = #0x8
 f001840: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001844: a803         	add	r0, sp, #0xc
 f001846: f7ff fbbb    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x88a
 f00184a: f245 6044    	.word	#0xf2456044
 f00184e: 2134         	movs	r1, #0x34
 f001850: f6c0 7000    	.word	#0xf6c07000
 f001854: f7fe fef9    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x120e
 f001858: defe         	trap
 f00185a: 4604         	mov	r4, r0
 f00185c: 2000         	movs	r0, #0x0
 f00185e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001862: f885 0084    	.word	#0xf8850084
 f001866: a801         	add	r0, sp, #0x4
 f001868: f000 f807    	bl	0xf00187a <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7> @ imm = #0xe
 f00186c: 4620         	mov	r0, r4
 f00186e: f003 feb1    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x3d62
 f001872: defe         	trap
 f001874: f7fe ff65    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x1136
 f001878: defe         	trap

0f00187a <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7>:
 f00187a: f04f 5c00    	.word	#0xf04f5c00
 f00187e: f8dc c000    	.word	#0xf8dcc000
 f001882: ebbd 0c0c    	.word	#0xebbd0c0c
 f001886: f1bc 0f20    	.word	#0xf1bc0f20
 f00188a: da02         	bge	0xf001892 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7+0x18> @ imm = #0x4
 f00188c: dfff         	svc	#0xff
 f00188e: 0008         	movs	r0, r1
 f001890: 0000         	movs	r0, r0
 f001892: b5f0         	push	{r4, r5, r6, r7, lr}
 f001894: af03         	add	r7, sp, #0xc
 f001896: e92d 0700    	.word	#0xe92d0700
 f00189a: f8d0 9000    	.word	#0xf8d09000
 f00189e: 7900         	ldrb	r0, [r0, #0x4]
 f0018a0: b3b0         	cbz	r0, 0xf001910 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7+0x96> @ imm = #0x6c
 f0018a2: f109 0691    	.word	#0xf1090691
 f0018a6: f109 0590    	.word	#0xf1090590
 f0018aa: f109 0884    	.word	#0xf1090884
 f0018ae: 2400         	movs	r4, #0x0
 f0018b0: f04f 0a01    	.word	#0xf04f0a01
 f0018b4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0018b8: e8d5 0f4f    	.word	#0xe8d50f4f
 f0018bc: e8c5 4f41    	.word	#0xe8c54f41
 f0018c0: 2900         	cmp	r1, #0x0
 f0018c2: d1f9         	bne	0xf0018b8 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7+0x3e> @ imm = #-0xe
 f0018c4: 2800         	cmp	r0, #0x0
 f0018c6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0018ca: bf1e         	ittt	ne
 f0018cc: 4648         	movne	r0, r9
 f0018ce: 4641         	movne	r1, r8
 f0018d0: f000 f828    	blne	0xf001924 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb> @ imm = #0x50
 f0018d4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0018d8: 7034         	strb	r4, [r6]
 f0018da: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0018de: 7828         	ldrb	r0, [r5]
 f0018e0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0018e4: b1d8         	cbz	r0, 0xf00191e <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7+0xa4> @ imm = #0x36
 f0018e6: e8d6 0f4f    	.word	#0xe8d60f4f
 f0018ea: b960         	cbnz	r0, 0xf001906 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7+0x8c> @ imm = #0x18
 f0018ec: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0018f0: e8c6 af40    	.word	#0xe8c6af40
 f0018f4: b120         	cbz	r0, 0xf001900 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7+0x86> @ imm = #0x8
 f0018f6: e8d6 0f4f    	.word	#0xe8d60f4f
 f0018fa: 2800         	cmp	r0, #0x0
 f0018fc: d0f8         	beq	0xf0018f0 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7+0x76> @ imm = #-0x10
 f0018fe: e002         	b	0xf001906 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7+0x8c> @ imm = #0x4
 f001900: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001904: e7d6         	b	0xf0018b4 <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7+0x3a> @ imm = #-0x54
 f001906: f3bf 8f2f    	.word	#0xf3bf8f2f
 f00190a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00190e: e7fe         	b	0xf00190e <core::ptr::drop_in_place$LT$hopter..sync..interruptable..AccessGuard$LT$hopter..schedule..scheduler..Inner$GT$$GT$::hb3b5cf7abc9534c7+0x94> @ imm = #-0x4
 f001910: 2001         	movs	r0, #0x1
 f001912: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001916: f889 0090    	.word	#0xf8890090
 f00191a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00191e: e8bd 0700    	.word	#0xe8bd0700
 f001922: bdf0         	pop	{r4, r5, r6, r7, pc}

0f001924 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb>:
 f001924: f04f 5c00    	.word	#0xf04f5c00
 f001928: f8dc c000    	.word	#0xf8dcc000
 f00192c: ebbd 0c0c    	.word	#0xebbd0c0c
 f001930: f1bc 0f28    	.word	#0xf1bc0f28
 f001934: da02         	bge	0xf00193c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x18> @ imm = #0x4
 f001936: dfff         	svc	#0xff
 f001938: 000a         	movs	r2, r1
 f00193a: 0000         	movs	r0, r0
 f00193c: b5f0         	push	{r4, r5, r6, r7, lr}
 f00193e: af03         	add	r7, sp, #0xc
 f001940: e92d 0f00    	.word	#0xe92d0f00
 f001944: b081         	sub	sp, #0x4
 f001946: f246 7618    	.word	#0xf2467618
 f00194a: 4689         	mov	r9, r1
 f00194c: f2c2 0600    	.word	#0xf2c20600
 f001950: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001954: e856 1f0f    	.word	#0xe8561f0f
 f001958: 3101         	adds	r1, #0x1
 f00195a: e846 120f    	.word	#0xe846120f
 f00195e: 2a00         	cmp	r2, #0x0
 f001960: d1f8         	bne	0xf001954 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x30> @ imm = #-0x10
 f001962: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001966: e856 2f14    	.word	#0xe8562f14
 f00196a: 1d11         	adds	r1, r2, #0x4
 f00196c: e846 1314    	.word	#0xe8461314
 f001970: 2b00         	cmp	r3, #0x0
 f001972: d1f8         	bne	0xf001966 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x42> @ imm = #-0x10
 f001974: f64f 71fc    	.word	#0xf64f71fc
 f001978: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00197c: f6c7 71ff    	.word	#0xf6c771ff
 f001980: 428a         	cmp	r2, r1
 f001982: d85b         	bhi	0xf001a3c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x118> @ imm = #0xb6
 f001984: 0792         	lsls	r2, r2, #0x1e
 f001986: d068         	beq	0xf001a5a <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x136> @ imm = #0xd0
 f001988: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00198c: e856 2f14    	.word	#0xe8562f14
 f001990: 3a04         	subs	r2, #0x4
 f001992: e846 2314    	.word	#0xe8462314
 f001996: 2b00         	cmp	r3, #0x0
 f001998: d1f8         	bne	0xf00198c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x68> @ imm = #-0x10
 f00199a: bf10         	yield
 f00199c: e856 2f14    	.word	#0xe8562f14
 f0019a0: 1d13         	adds	r3, r2, #0x4
 f0019a2: e846 3514    	.word	#0xe8463514
 f0019a6: 2d00         	cmp	r5, #0x0
 f0019a8: d1f8         	bne	0xf00199c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x78> @ imm = #-0x10
 f0019aa: 428a         	cmp	r2, r1
 f0019ac: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0019b0: d844         	bhi	0xf001a3c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x118> @ imm = #0x88
 f0019b2: 0792         	lsls	r2, r2, #0x1e
 f0019b4: d051         	beq	0xf001a5a <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x136> @ imm = #0xa2
 f0019b6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0019ba: e856 2f14    	.word	#0xe8562f14
 f0019be: 3a04         	subs	r2, #0x4
 f0019c0: e846 2314    	.word	#0xe8462314
 f0019c4: 2b00         	cmp	r3, #0x0
 f0019c6: d1f8         	bne	0xf0019ba <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x96> @ imm = #-0x10
 f0019c8: bf10         	yield
 f0019ca: e856 2f14    	.word	#0xe8562f14
 f0019ce: 1d13         	adds	r3, r2, #0x4
 f0019d0: e846 3514    	.word	#0xe8463514
 f0019d4: 2d00         	cmp	r5, #0x0
 f0019d6: d1f8         	bne	0xf0019ca <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0xa6> @ imm = #-0x10
 f0019d8: 428a         	cmp	r2, r1
 f0019da: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0019de: d82d         	bhi	0xf001a3c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x118> @ imm = #0x5a
 f0019e0: 0792         	lsls	r2, r2, #0x1e
 f0019e2: d03a         	beq	0xf001a5a <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x136> @ imm = #0x74
 f0019e4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0019e8: e856 2f14    	.word	#0xe8562f14
 f0019ec: 3a04         	subs	r2, #0x4
 f0019ee: e846 2314    	.word	#0xe8462314
 f0019f2: 2b00         	cmp	r3, #0x0
 f0019f4: d1f8         	bne	0xf0019e8 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0xc4> @ imm = #-0x10
 f0019f6: bf10         	yield
 f0019f8: e856 2f14    	.word	#0xe8562f14
 f0019fc: 1d13         	adds	r3, r2, #0x4
 f0019fe: e846 3514    	.word	#0xe8463514
 f001a02: 2d00         	cmp	r5, #0x0
 f001a04: d1f8         	bne	0xf0019f8 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0xd4> @ imm = #-0x10
 f001a06: 428a         	cmp	r2, r1
 f001a08: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001a0c: d816         	bhi	0xf001a3c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x118> @ imm = #0x2c
 f001a0e: 0792         	lsls	r2, r2, #0x1e
 f001a10: d023         	beq	0xf001a5a <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x136> @ imm = #0x46
 f001a12: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001a16: e856 2f14    	.word	#0xe8562f14
 f001a1a: 3a04         	subs	r2, #0x4
 f001a1c: e846 2314    	.word	#0xe8462314
 f001a20: 2b00         	cmp	r3, #0x0
 f001a22: d1f8         	bne	0xf001a16 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0xf2> @ imm = #-0x10
 f001a24: bf10         	yield
 f001a26: e856 2f14    	.word	#0xe8562f14
 f001a2a: 1d13         	adds	r3, r2, #0x4
 f001a2c: e846 3514    	.word	#0xe8463514
 f001a30: 2d00         	cmp	r5, #0x0
 f001a32: d1f8         	bne	0xf001a26 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x102> @ imm = #-0x10
 f001a34: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001a38: 428a         	cmp	r2, r1
 f001a3a: d9a3         	bls	0xf001984 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x60> @ imm = #-0xba
 f001a3c: e856 0f14    	.word	#0xe8560f14
 f001a40: 3804         	subs	r0, #0x4
 f001a42: e846 0114    	.word	#0xe8460114
 f001a46: 2900         	cmp	r1, #0x0
 f001a48: d1f8         	bne	0xf001a3c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x118> @ imm = #-0x10
 f001a4a: f245 6078    	.word	#0xf2456078
 f001a4e: 212c         	movs	r1, #0x2c
 f001a50: f6c0 7000    	.word	#0xf6c07000
 f001a54: f7fe fdf9    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x140e
 f001a58: e11a         	b	0xf001c90 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x36c> @ imm = #0x234
 f001a5a: f8d6 8054    	.word	#0xf8d68054
 f001a5e: f1b8 0f00    	.word	#0xf1b80f00
 f001a62: d015         	beq	0xf001a90 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x16c> @ imm = #0x2a
 f001a64: f899 1000    	.word	#0xf8991000
 f001a68: 2900         	cmp	r1, #0x0
 f001a6a: f040 80bc    	.word	#0xf04080bc
 f001a6e: 2101         	movs	r1, #0x1
 f001a70: e8d9 2f4f    	.word	#0xe8d92f4f
 f001a74: 2a00         	cmp	r2, #0x0
 f001a76: f040 80b4    	.word	#0xf04080b4
 f001a7a: e8c9 1f42    	.word	#0xe8c91f42
 f001a7e: 2a00         	cmp	r2, #0x0
 f001a80: d1f6         	bne	0xf001a70 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x14c> @ imm = #-0x14
 f001a82: f100 0280    	.word	#0xf1000280
 f001a86: f04f 0b00    	.word	#0xf04f0b00
 f001a8a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001a8e: e006         	b	0xf001a9e <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x17a> @ imm = #0xc
 f001a90: e7fe         	b	0xf001a90 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x16c> @ imm = #-0x4
 f001a92: ebac 010e    	.word	#0xebac010e
 f001a96: b249         	sxtb	r1, r1
 f001a98: 2900         	cmp	r1, #0x0
 f001a9a: f100 80a5    	.word	#0xf10080a5
 f001a9e: f890 1080    	.word	#0xf8901080
 f001aa2: f001 0a0f    	.word	#0xf0010a0f
 f001aa6: f101 0e01    	.word	#0xf1010e01
 f001aaa: eb00 03ca    	.word	#0xeb0003ca
 f001aae: 1d1c         	adds	r4, r3, #0x4
 f001ab0: e001         	b	0xf001ab6 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x192> @ imm = #0x2
 f001ab2: f3bf 8f2f    	.word	#0xf3bf8f2f
 f001ab6: f894 c000    	.word	#0xf894c000
 f001aba: fa5f f38e    	.word	#0xfa5ff38e
 f001abe: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001ac2: 459c         	cmp	r12, r3
 f001ac4: d1e5         	bne	0xf001a92 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x16e> @ imm = #-0x36
 f001ac6: e8d2 5f4f    	.word	#0xe8d25f4f
 f001aca: 428d         	cmp	r5, r1
 f001acc: d10a         	bne	0xf001ae4 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x1c0> @ imm = #0x14
 f001ace: e8c2 ef45    	.word	#0xe8c2ef45
 f001ad2: 2d00         	cmp	r5, #0x0
 f001ad4: d042         	beq	0xf001b5c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x238> @ imm = #0x84
 f001ad6: f894 c000    	.word	#0xf894c000
 f001ada: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001ade: 459c         	cmp	r12, r3
 f001ae0: d008         	beq	0xf001af4 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x1d0> @ imm = #0x10
 f001ae2: e7d6         	b	0xf001a92 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x16e> @ imm = #-0x54
 f001ae4: f3bf 8f2f    	.word	#0xf3bf8f2f
 f001ae8: f894 c000    	.word	#0xf894c000
 f001aec: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001af0: 459c         	cmp	r12, r3
 f001af2: d1ce         	bne	0xf001a92 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x16e> @ imm = #-0x64
 f001af4: e8d2 5f4f    	.word	#0xe8d25f4f
 f001af8: 428d         	cmp	r5, r1
 f001afa: d109         	bne	0xf001b10 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x1ec> @ imm = #0x12
 f001afc: e8c2 ef45    	.word	#0xe8c2ef45
 f001b00: b365         	cbz	r5, 0xf001b5c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x238> @ imm = #0x58
 f001b02: f894 c000    	.word	#0xf894c000
 f001b06: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001b0a: 459c         	cmp	r12, r3
 f001b0c: d008         	beq	0xf001b20 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x1fc> @ imm = #0x10
 f001b0e: e7c0         	b	0xf001a92 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x16e> @ imm = #-0x80
 f001b10: f3bf 8f2f    	.word	#0xf3bf8f2f
 f001b14: f894 c000    	.word	#0xf894c000
 f001b18: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001b1c: 459c         	cmp	r12, r3
 f001b1e: d1b8         	bne	0xf001a92 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x16e> @ imm = #-0x90
 f001b20: e8d2 5f4f    	.word	#0xe8d25f4f
 f001b24: 428d         	cmp	r5, r1
 f001b26: d109         	bne	0xf001b3c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x218> @ imm = #0x12
 f001b28: e8c2 ef45    	.word	#0xe8c2ef45
 f001b2c: b1b5         	cbz	r5, 0xf001b5c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x238> @ imm = #0x2c
 f001b2e: f894 c000    	.word	#0xf894c000
 f001b32: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001b36: 459c         	cmp	r12, r3
 f001b38: d008         	beq	0xf001b4c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x228> @ imm = #0x10
 f001b3a: e7aa         	b	0xf001a92 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x16e> @ imm = #-0xac
 f001b3c: f3bf 8f2f    	.word	#0xf3bf8f2f
 f001b40: f894 c000    	.word	#0xf894c000
 f001b44: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001b48: 459c         	cmp	r12, r3
 f001b4a: d1a2         	bne	0xf001a92 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x16e> @ imm = #-0xbc
 f001b4c: e8d2 3f4f    	.word	#0xe8d23f4f
 f001b50: 428b         	cmp	r3, r1
 f001b52: d1ae         	bne	0xf001ab2 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x18e> @ imm = #-0xa4
 f001b54: e8c2 ef43    	.word	#0xe8c2ef43
 f001b58: 2b00         	cmp	r3, #0x0
 f001b5a: d1ac         	bne	0xf001ab6 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x192> @ imm = #-0xa8
 f001b5c: f850 503a    	.word	#0xf850503a
 f001b60: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001b64: 3110         	adds	r1, #0x10
 f001b66: 7021         	strb	r1, [r4]
 f001b68: f8d5 10c4    	.word	#0xf8d510c4
 f001b6c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001b70: f8d8 30c4    	.word	#0xf8d830c4
 f001b74: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001b78: f011 0ffe    	.word	#0xf0110ffe
 f001b7c: d12f         	bne	0xf001bde <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x2ba> @ imm = #0x5e
 f001b7e: f013 0ffe    	.word	#0xf0130ffe
 f001b82: d12d         	bne	0xf001be0 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x2bc> @ imm = #0x5a
 f001b84: f3c3 2307    	.word	#0xf3c32307
 f001b88: f3c1 2107    	.word	#0xf3c12107
 f001b8c: 4299         	cmp	r1, r3
 f001b8e: bf3f         	itttt	lo
 f001b90: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001b94: 2101         	movlo	r1, #0x1
 f001b96: 7171         	strblo	r1, [r6, #0x5]
 f001b98: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001b9c: 2102         	movs	r1, #0x2
 f001b9e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001ba2: f885 10cd    	.word	#0xf88510cd
 f001ba6: f105 0110    	.word	#0xf1050110
 f001baa: e851 3f00    	.word	#0xe8513f00
 f001bae: 2b01         	cmp	r3, #0x1
 f001bb0: d154         	bne	0xf001c5c <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x338> @ imm = #0xa8
 f001bb2: e841 b300    	.word	#0xe841b300
 f001bb6: 2b00         	cmp	r3, #0x0
 f001bb8: d1f7         	bne	0xf001baa <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x286> @ imm = #-0x12
 f001bba: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001bbe: f8d9 3008    	.word	#0xf8d93008
 f001bc2: 2b00         	cmp	r3, #0x0
 f001bc4: bf18         	it	ne
 f001bc6: 6019         	strne	r1, [r3]
 f001bc8: e9c5 b304    	.word	#0xe9c5b304
 f001bcc: f8d9 3004    	.word	#0xf8d93004
 f001bd0: f8c9 1008    	.word	#0xf8c91008
 f001bd4: 2b00         	cmp	r3, #0x0
 f001bd6: bf08         	it	eq
 f001bd8: f8c9 1004    	.word	#0xf8c91004
 f001bdc: e75f         	b	0xf001a9e <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x17a> @ imm = #-0x142
 f001bde: e7fe         	b	0xf001bde <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x2ba> @ imm = #-0x4
 f001be0: e7fe         	b	0xf001be0 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x2bc> @ imm = #-0x4
 f001be2: f3bf 8f2f    	.word	#0xf3bf8f2f
 f001be6: e7fe         	b	0xf001be6 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x2c2> @ imm = #-0x4
 f001be8: 2000         	movs	r0, #0x0
 f001bea: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001bee: f889 0000    	.word	#0xf8890000
 f001bf2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001bf6: e856 0f14    	.word	#0xe8560f14
 f001bfa: 3804         	subs	r0, #0x4
 f001bfc: e846 0114    	.word	#0xe8460114
 f001c00: 2900         	cmp	r1, #0x0
 f001c02: d1f8         	bne	0xf001bf6 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x2d2> @ imm = #-0x10
 f001c04: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001c08: e856 0f0f    	.word	#0xe8560f0f
 f001c0c: 3801         	subs	r0, #0x1
 f001c0e: e846 010f    	.word	#0xe846010f
 f001c12: 2900         	cmp	r1, #0x0
 f001c14: d1f8         	bne	0xf001c08 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x2e4> @ imm = #-0x10
 f001c16: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001c1a: 7970         	ldrb	r0, [r6, #0x5]
 f001c1c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001c20: b188         	cbz	r0, 0xf001c46 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x322> @ imm = #0x22
 f001c22: 6bf0         	ldr	r0, [r6, #0x3c]
 f001c24: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001c28: b968         	cbnz	r0, 0xf001c46 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x322> @ imm = #0x1a
 f001c2a: f3ef 8005    	.word	#0xf3ef8005
 f001c2e: b170         	cbz	r0, 0xf001c4e <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x32a> @ imm = #0x1c
 f001c30: f3ef 8005    	.word	#0xf3ef8005
 f001c34: 280e         	cmp	r0, #0xe
 f001c36: bf1f         	itttt	ne
 f001c38: f64e 5004    	.word	#0xf64e5004
 f001c3c: f2ce 0000    	.word	#0xf2ce0000
 f001c40: f04f 5180    	.word	#0xf04f5180
 f001c44: 6001         	strne	r1, [r0]
 f001c46: b001         	add	sp, #0x4
 f001c48: e8bd 0f00    	.word	#0xe8bd0f00
 f001c4c: bdf0         	pop	{r4, r5, r6, r7, pc}
 f001c4e: b001         	add	sp, #0x4
 f001c50: e8bd 0f00    	.word	#0xe8bd0f00
 f001c54: e8bd 40f0    	.word	#0xe8bd40f0
 f001c58: f7ff b9af    	.word	#0xf7ffb9af
 f001c5c: f3bf 8f2f    	.word	#0xf3bf8f2f
 f001c60: 9500         	str	r5, [sp]
 f001c62: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001c66: e855 0f00    	.word	#0xe8550f00
 f001c6a: 1e41         	subs	r1, r0, #0x1
 f001c6c: e845 1200    	.word	#0xe8451200
 f001c70: 2a00         	cmp	r2, #0x0
 f001c72: d1f8         	bne	0xf001c66 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x342> @ imm = #-0x10
 f001c74: 2801         	cmp	r0, #0x1
 f001c76: d104         	bne	0xf001c82 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x35e> @ imm = #0x8
 f001c78: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001c7c: 4668         	mov	r0, sp
 f001c7e: f7ff f99f    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0xcc2
 f001c82: f245 6044    	.word	#0xf2456044
 f001c86: 2134         	movs	r1, #0x34
 f001c88: f6c0 7000    	.word	#0xf6c07000
 f001c8c: f7fe fcdd    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x1646
 f001c90: defe         	trap
 f001c92: 4605         	mov	r5, r0
 f001c94: 2000         	movs	r0, #0x0
 f001c96: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001c9a: f889 0000    	.word	#0xf8890000
 f001c9e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001ca2: e856 0f14    	.word	#0xe8560f14
 f001ca6: 3804         	subs	r0, #0x4
 f001ca8: e846 0114    	.word	#0xe8460114
 f001cac: 2900         	cmp	r1, #0x0
 f001cae: d1f8         	bne	0xf001ca2 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x37e> @ imm = #-0x10
 f001cb0: e000         	b	0xf001cb4 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x390> @ imm = #0x0
 f001cb2: 4605         	mov	r5, r0
 f001cb4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001cb8: e856 0f0f    	.word	#0xe8560f0f
 f001cbc: 3801         	subs	r0, #0x1
 f001cbe: e846 010f    	.word	#0xe846010f
 f001cc2: 2900         	cmp	r1, #0x0
 f001cc4: d1f8         	bne	0xf001cb8 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x394> @ imm = #-0x10
 f001cc6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001cca: 7970         	ldrb	r0, [r6, #0x5]
 f001ccc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001cd0: b1a0         	cbz	r0, 0xf001cfc <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x3d8> @ imm = #0x28
 f001cd2: 6bf0         	ldr	r0, [r6, #0x3c]
 f001cd4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001cd8: b980         	cbnz	r0, 0xf001cfc <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x3d8> @ imm = #0x20
 f001cda: f3ef 8005    	.word	#0xf3ef8005
 f001cde: b910         	cbnz	r0, 0xf001ce6 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x3c2> @ imm = #0x4
 f001ce0: f7ff f96b    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0xd2a
 f001ce4: e00a         	b	0xf001cfc <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb+0x3d8> @ imm = #0x14
 f001ce6: f3ef 8005    	.word	#0xf3ef8005
 f001cea: 280e         	cmp	r0, #0xe
 f001cec: bf1f         	itttt	ne
 f001cee: f64e 5004    	.word	#0xf64e5004
 f001cf2: f2ce 0000    	.word	#0xf2ce0000
 f001cf6: f04f 5180    	.word	#0xf04f5180
 f001cfa: 6001         	strne	r1, [r0]
 f001cfc: 4628         	mov	r0, r5
 f001cfe: f003 fc69    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x38d2
 f001d02: defe         	trap
 f001d04: f7fe fd1d    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x15c6
 f001d08: defe         	trap

0f001d0a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b>:
 f001d0a: f04f 5c00    	.word	#0xf04f5c00
 f001d0e: f8dc c000    	.word	#0xf8dcc000
 f001d12: ebbd 0c0c    	.word	#0xebbd0c0c
 f001d16: f1bc 0f10    	.word	#0xf1bc0f10
 f001d1a: da02         	bge	0xf001d22 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x18> @ imm = #0x4
 f001d1c: dfff         	svc	#0xff
 f001d1e: 0004         	movs	r4, r0
 f001d20: 0000         	movs	r0, r0
 f001d22: b5b0         	push	{r4, r5, r7, lr}
 f001d24: af02         	add	r7, sp, #0x8
 f001d26: f246 7518    	.word	#0xf2467518
 f001d2a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001d2e: f2c2 0500    	.word	#0xf2c20500
 f001d32: e855 1f0f    	.word	#0xe8551f0f
 f001d36: 3101         	adds	r1, #0x1
 f001d38: e845 120f    	.word	#0xe845120f
 f001d3c: 2a00         	cmp	r2, #0x0
 f001d3e: d1f8         	bne	0xf001d32 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x28> @ imm = #-0x10
 f001d40: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001d44: e855 2f14    	.word	#0xe8552f14
 f001d48: 1d11         	adds	r1, r2, #0x4
 f001d4a: e845 1314    	.word	#0xe8451314
 f001d4e: 2b00         	cmp	r3, #0x0
 f001d50: d1f8         	bne	0xf001d44 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x3a> @ imm = #-0x10
 f001d52: f64f 71fc    	.word	#0xf64f71fc
 f001d56: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001d5a: f6c7 71ff    	.word	#0xf6c771ff
 f001d5e: 428a         	cmp	r2, r1
 f001d60: d85b         	bhi	0xf001e1a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x110> @ imm = #0xb6
 f001d62: 0792         	lsls	r2, r2, #0x1e
 f001d64: d068         	beq	0xf001e38 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x12e> @ imm = #0xd0
 f001d66: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001d6a: e855 2f14    	.word	#0xe8552f14
 f001d6e: 3a04         	subs	r2, #0x4
 f001d70: e845 2314    	.word	#0xe8452314
 f001d74: 2b00         	cmp	r3, #0x0
 f001d76: d1f8         	bne	0xf001d6a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x60> @ imm = #-0x10
 f001d78: bf10         	yield
 f001d7a: e855 2f14    	.word	#0xe8552f14
 f001d7e: 1d13         	adds	r3, r2, #0x4
 f001d80: e845 3414    	.word	#0xe8453414
 f001d84: 2c00         	cmp	r4, #0x0
 f001d86: d1f8         	bne	0xf001d7a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x70> @ imm = #-0x10
 f001d88: 428a         	cmp	r2, r1
 f001d8a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001d8e: d844         	bhi	0xf001e1a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x110> @ imm = #0x88
 f001d90: 0792         	lsls	r2, r2, #0x1e
 f001d92: d051         	beq	0xf001e38 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x12e> @ imm = #0xa2
 f001d94: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001d98: e855 2f14    	.word	#0xe8552f14
 f001d9c: 3a04         	subs	r2, #0x4
 f001d9e: e845 2314    	.word	#0xe8452314
 f001da2: 2b00         	cmp	r3, #0x0
 f001da4: d1f8         	bne	0xf001d98 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x8e> @ imm = #-0x10
 f001da6: bf10         	yield
 f001da8: e855 2f14    	.word	#0xe8552f14
 f001dac: 1d13         	adds	r3, r2, #0x4
 f001dae: e845 3414    	.word	#0xe8453414
 f001db2: 2c00         	cmp	r4, #0x0
 f001db4: d1f8         	bne	0xf001da8 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x9e> @ imm = #-0x10
 f001db6: 428a         	cmp	r2, r1
 f001db8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001dbc: d82d         	bhi	0xf001e1a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x110> @ imm = #0x5a
 f001dbe: 0792         	lsls	r2, r2, #0x1e
 f001dc0: d03a         	beq	0xf001e38 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x12e> @ imm = #0x74
 f001dc2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001dc6: e855 2f14    	.word	#0xe8552f14
 f001dca: 3a04         	subs	r2, #0x4
 f001dcc: e845 2314    	.word	#0xe8452314
 f001dd0: 2b00         	cmp	r3, #0x0
 f001dd2: d1f8         	bne	0xf001dc6 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0xbc> @ imm = #-0x10
 f001dd4: bf10         	yield
 f001dd6: e855 2f14    	.word	#0xe8552f14
 f001dda: 1d13         	adds	r3, r2, #0x4
 f001ddc: e845 3414    	.word	#0xe8453414
 f001de0: 2c00         	cmp	r4, #0x0
 f001de2: d1f8         	bne	0xf001dd6 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0xcc> @ imm = #-0x10
 f001de4: 428a         	cmp	r2, r1
 f001de6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001dea: d816         	bhi	0xf001e1a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x110> @ imm = #0x2c
 f001dec: 0792         	lsls	r2, r2, #0x1e
 f001dee: d023         	beq	0xf001e38 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x12e> @ imm = #0x46
 f001df0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001df4: e855 2f14    	.word	#0xe8552f14
 f001df8: 3a04         	subs	r2, #0x4
 f001dfa: e845 2314    	.word	#0xe8452314
 f001dfe: 2b00         	cmp	r3, #0x0
 f001e00: d1f8         	bne	0xf001df4 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0xea> @ imm = #-0x10
 f001e02: bf10         	yield
 f001e04: e855 2f14    	.word	#0xe8552f14
 f001e08: 1d13         	adds	r3, r2, #0x4
 f001e0a: e845 3414    	.word	#0xe8453414
 f001e0e: 2c00         	cmp	r4, #0x0
 f001e10: d1f8         	bne	0xf001e04 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0xfa> @ imm = #-0x10
 f001e12: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001e16: 428a         	cmp	r2, r1
 f001e18: d9a3         	bls	0xf001d62 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x58> @ imm = #-0xba
 f001e1a: e855 0f14    	.word	#0xe8550f14
 f001e1e: 3804         	subs	r0, #0x4
 f001e20: e845 0114    	.word	#0xe8450114
 f001e24: 2900         	cmp	r1, #0x0
 f001e26: d1f8         	bne	0xf001e1a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x110> @ imm = #-0x10
 f001e28: f245 6078    	.word	#0xf2456078
 f001e2c: 212c         	movs	r1, #0x2c
 f001e2e: f6c0 7000    	.word	#0xf6c07000
 f001e32: f7fe fc0a    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x17ec
 f001e36: defe         	trap
 f001e38: 6d69         	ldr	r1, [r5, #0x54]
 f001e3a: b391         	cbz	r1, 0xf001ea2 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x198> @ imm = #0x64
 f001e3c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001e40: f881 00ce    	.word	#0xf88100ce
 f001e44: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001e48: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001e4c: e855 0f14    	.word	#0xe8550f14
 f001e50: 3804         	subs	r0, #0x4
 f001e52: e845 0114    	.word	#0xe8450114
 f001e56: 2900         	cmp	r1, #0x0
 f001e58: d1f8         	bne	0xf001e4c <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x142> @ imm = #-0x10
 f001e5a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001e5e: e855 0f0f    	.word	#0xe8550f0f
 f001e62: 3801         	subs	r0, #0x1
 f001e64: e845 010f    	.word	#0xe845010f
 f001e68: 2900         	cmp	r1, #0x0
 f001e6a: d1f8         	bne	0xf001e5e <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x154> @ imm = #-0x10
 f001e6c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001e70: 7968         	ldrb	r0, [r5, #0x5]
 f001e72: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001e76: b198         	cbz	r0, 0xf001ea0 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x196> @ imm = #0x26
 f001e78: 6be8         	ldr	r0, [r5, #0x3c]
 f001e7a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001e7e: 2800         	cmp	r0, #0x0
 f001e80: bf18         	it	ne
 f001e82: bdb0         	popne	{r4, r5, r7, pc}
 f001e84: f3ef 8005    	.word	#0xf3ef8005
 f001e88: b160         	cbz	r0, 0xf001ea4 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x19a> @ imm = #0x18
 f001e8a: f3ef 8005    	.word	#0xf3ef8005
 f001e8e: 280e         	cmp	r0, #0xe
 f001e90: bf1f         	itttt	ne
 f001e92: f64e 5004    	.word	#0xf64e5004
 f001e96: f2ce 0000    	.word	#0xf2ce0000
 f001e9a: f04f 5180    	.word	#0xf04f5180
 f001e9e: 6001         	strne	r1, [r0]
 f001ea0: bdb0         	pop	{r4, r5, r7, pc}
 f001ea2: e7fe         	b	0xf001ea2 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x198> @ imm = #-0x4
 f001ea4: e8bd 40b0    	.word	#0xe8bd40b0
 f001ea8: f7ff b887    	.word	#0xf7ffb887
 f001eac: 4604         	mov	r4, r0
 f001eae: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001eb2: e855 0f0f    	.word	#0xe8550f0f
 f001eb6: 3801         	subs	r0, #0x1
 f001eb8: e845 010f    	.word	#0xe845010f
 f001ebc: 2900         	cmp	r1, #0x0
 f001ebe: d1f8         	bne	0xf001eb2 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x1a8> @ imm = #-0x10
 f001ec0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001ec4: 7968         	ldrb	r0, [r5, #0x5]
 f001ec6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001eca: b1a0         	cbz	r0, 0xf001ef6 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x1ec> @ imm = #0x28
 f001ecc: 6be8         	ldr	r0, [r5, #0x3c]
 f001ece: f3bf 8f5f    	.word	#0xf3bf8f5f
 f001ed2: b980         	cbnz	r0, 0xf001ef6 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x1ec> @ imm = #0x20
 f001ed4: f3ef 8005    	.word	#0xf3ef8005
 f001ed8: b910         	cbnz	r0, 0xf001ee0 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x1d6> @ imm = #0x4
 f001eda: f7ff f86e    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0xf24
 f001ede: e00a         	b	0xf001ef6 <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b+0x1ec> @ imm = #0x14
 f001ee0: f3ef 8005    	.word	#0xf3ef8005
 f001ee4: 280e         	cmp	r0, #0xe
 f001ee6: bf1f         	itttt	ne
 f001ee8: f64e 5004    	.word	#0xf64e5004
 f001eec: f2ce 0000    	.word	#0xf2ce0000
 f001ef0: f04f 5180    	.word	#0xf04f5180
 f001ef4: 6001         	strne	r1, [r0]
 f001ef6: 4620         	mov	r0, r4
 f001ef8: f003 fb6c    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x36d8
 f001efc: defe         	trap
 f001efe: f7fe fc20    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x17c0
 f001f02: defe         	trap

0f001f04 <HardFaultTrampoline>:
 f001f04: 4670         	mov	r0, lr
 f001f06: f04f 0104    	.word	#0xf04f0104
 f001f0a: 4208         	tst	r0, r1
 f001f0c: d103         	bne	0xf001f16 <HardFaultTrampoline+0x12> @ imm = #0x6
 f001f0e: f3ef 8008    	.word	#0xf3ef8008
 f001f12: f001 bf9d    	.word	#0xf001bf9d
 f001f16: f3ef 8009    	.word	#0xf3ef8009
 f001f1a: f001 bf99    	.word	#0xf001bf99
 f001f1e: defe         	trap

0f001f20 <SVCall>:
 f001f20: f11e 0f13    	.word	#0xf11e0f13
 f001f24: bf18         	it	ne
 f001f26: f003 fb7f    	blne	0xf005628 <rust_eh_personality> @ imm = #0x36fe
 f001f2a: eeb0 0a40    	.word	#0xeeb00a40
 f001f2e: f3ef 8009    	.word	#0xf3ef8009
 f001f32: f04f 5300    	.word	#0xf04f5300
 f001f36: 6819         	ldr	r1, [r3]
 f001f38: b503         	push	{r0, r1, lr}
 f001f3a: 4a07         	ldr	r2, [pc, #0x1c]         @ 0xf001f58 <SVCall+0x38>
 f001f3c: 601a         	str	r2, [r3]
 f001f3e: 4669         	mov	r1, sp
 f001f40: f001 faa6    	bl	0xf003490 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c> @ imm = #0x154c
 f001f44: e8bd 4003    	.word	#0xe8bd4003
 f001f48: f380 8809    	.word	#0xf3808809
 f001f4c: f04f 5000    	.word	#0xf04f5000
 f001f50: 6001         	str	r1, [r0]
 f001f52: 4770         	bx	lr
 f001f54: defe         	trap
 f001f56: 0000         	movs	r0, r0

0f001f58 <$d.93>:
 f001f58: 10 00 00 20  	.word	0x20000010

0f001f5c <PendSV>:
 f001f5c: f04f 5000    	.word	#0xf04f5000
 f001f60: 6800         	ldr	r0, [r0]
 f001f62: f246 7350    	.word	#0xf2467350
 f001f66: f2c2 0300    	.word	#0xf2c20300
 f001f6a: 681b         	ldr	r3, [r3]
 f001f6c: f3ef 8109    	.word	#0xf3ef8109
 f001f70: e8a3 0ff3    	.word	#0xe8a30ff3
 f001f74: eca3 8a10    	.word	#0xeca38a10
 f001f78: 4a0c         	ldr	r2, [pc, #0x30]         @ 0xf001fac <PendSV+0x50>
 f001f7a: f04f 5300    	.word	#0xf04f5300
 f001f7e: 601a         	str	r2, [r3]
 f001f80: 4670         	mov	r0, lr
 f001f82: f000 fd92    	bl	0xf002aaa <hopter::interrupt::context_switch::pendsv_handler::h2993e78676b45afd> @ imm = #0xb24
 f001f86: e8b0 0ff6    	.word	#0xe8b00ff6
 f001f8a: f382 8809    	.word	#0xf3828809
 f001f8e: f04f 5200    	.word	#0xf04f5200
 f001f92: 6011         	str	r1, [r2]
 f001f94: ecb0 8a10    	.word	#0xecb08a10
 f001f98: f3ef 8308    	.word	#0xf3ef8308
 f001f9c: 4a04         	ldr	r2, [pc, #0x10]         @ 0xf001fb0 <PendSV+0x54>
 f001f9e: 429a         	cmp	r2, r3
 f001fa0: d102         	bne	0xf001fa8 <PendSV+0x4c> @ imm = #0x4
 f001fa2: f06f 0e12    	.word	#0xf06f0e12
 f001fa6: 4770         	bx	lr
 f001fa8: e7fe         	b	0xf001fa8 <PendSV+0x4c> @ imm = #-0x4
 f001faa: defe         	trap

0f001fac <$d.94>:
 f001fac: 10 00 00 20  	.word	0x20000010
 f001fb0: 00 10 00 20  	.word	0x20001000

0f001fb4 <SysTick>:
 f001fb4: 4801         	ldr	r0, [pc, #0x4]          @ 0xf001fbc <SysTick+0x8>
 f001fb6: f000 b803    	.word	#0xf000b803
 f001fba: defe         	trap

0f001fbc <$d.95>:
 f001fbc: e1 1f 00 0f  	.word	0x0f001fe1

0f001fc0 <hopter::interrupt::default::fast_irq_entry::h9b037a0dea7899e5>:
 f001fc0: f04f 5300    	.word	#0xf04f5300
 f001fc4: 6819         	ldr	r1, [r3]
 f001fc6: b502         	push	{r1, lr}
 f001fc8: 4a03         	ldr	r2, [pc, #0xc]          @ 0xf001fd8 <hopter::interrupt::default::fast_irq_entry::h9b037a0dea7899e5+0x18>
 f001fca: 601a         	str	r2, [r3]
 f001fcc: f8df e00c    	.word	#0xf8dfe00c
 f001fd0: f000 bd22    	.word	#0xf000bd22
 f001fd4: defe         	trap
 f001fd6: 0000         	movs	r0, r0

0f001fd8 <$d.96>:
 f001fd8: 10 00 00 20  	.word	0x20000010
 f001fdc: 0b 2a 00 0f  	.word	0x0f002a0b

0f001fe0 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279>:
 f001fe0: f04f 5c00    	.word	#0xf04f5c00
 f001fe4: f8dc c000    	.word	#0xf8dcc000
 f001fe8: ebbd 0c0c    	.word	#0xebbd0c0c
 f001fec: f1bc 0f40    	.word	#0xf1bc0f40
 f001ff0: da02         	bge	0xf001ff8 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x18> @ imm = #0x4
 f001ff2: dfff         	svc	#0xff
 f001ff4: 0010         	movs	r0, r2
 f001ff6: 0000         	movs	r0, r0
 f001ff8: b5f0         	push	{r4, r5, r6, r7, lr}
 f001ffa: af03         	add	r7, sp, #0xc
 f001ffc: e92d 0f00    	.word	#0xe92d0f00
 f002000: b087         	sub	sp, #0x1c
 f002002: f246 7618    	.word	#0xf2467618
 f002006: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00200a: f2c2 0600    	.word	#0xf2c20600
 f00200e: e856 0f13    	.word	#0xe8560f13
 f002012: 3001         	adds	r0, #0x1
 f002014: e846 0113    	.word	#0xe8460113
 f002018: 2900         	cmp	r1, #0x0
 f00201a: d1f8         	bne	0xf00200e <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x2e> @ imm = #-0x10
 f00201c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002020: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002024: e856 0f0f    	.word	#0xe8560f0f
 f002028: 3001         	adds	r0, #0x1
 f00202a: e846 010f    	.word	#0xe846010f
 f00202e: 2900         	cmp	r1, #0x0
 f002030: d1f8         	bne	0xf002024 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x44> @ imm = #-0x10
 f002032: f246 5bac    	.word	#0xf2465bac
 f002036: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00203a: f2c2 0b00    	.word	#0xf2c20b00
 f00203e: f10b 0495    	.word	#0xf10b0495
 f002042: e8d4 0f4f    	.word	#0xe8d40f4f
 f002046: b948         	cbnz	r0, 0xf00205c <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x7c> @ imm = #0x12
 f002048: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00204c: 2001         	movs	r0, #0x1
 f00204e: e8c4 0f41    	.word	#0xe8c40f41
 f002052: b131         	cbz	r1, 0xf002062 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x82> @ imm = #0xc
 f002054: e8d4 0f4f    	.word	#0xe8d40f4f
 f002058: 2800         	cmp	r0, #0x0
 f00205a: d0f7         	beq	0xf00204c <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x6c> @ imm = #-0x12
 f00205c: 2000         	movs	r0, #0x0
 f00205e: f3bf 8f2f    	.word	#0xf3bf8f2f
 f002062: 2800         	cmp	r0, #0x0
 f002064: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002068: d049         	beq	0xf0020fe <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x11e> @ imm = #0x92
 f00206a: f10b 0590    	.word	#0xf10b0590
 f00206e: f10b 080c    	.word	#0xf10b080c
 f002072: f8cd b004    	.word	#0xf8cdb004
 f002076: 9503         	str	r5, [sp, #0xc]
 f002078: f8cd 8008    	.word	#0xf8cd8008
 f00207c: a801         	add	r0, sp, #0x4
 f00207e: f000 f8fd    	bl	0xf00227c <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd> @ imm = #0x1fa
 f002082: e9cd b804    	.word	#0xe9cdb804
 f002086: f10d 0810    	.word	#0xf10d0810
 f00208a: 9506         	str	r5, [sp, #0x18]
 f00208c: 2500         	movs	r5, #0x0
 f00208e: f04f 0901    	.word	#0xf04f0901
 f002092: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002096: f10b 0194    	.word	#0xf10b0194
 f00209a: e8d1 0f4f    	.word	#0xe8d10f4f
 f00209e: e8c1 5f42    	.word	#0xe8c15f42
 f0020a2: 2a00         	cmp	r2, #0x0
 f0020a4: d1f7         	bne	0xf002096 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0xb6> @ imm = #-0x12
 f0020a6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0020aa: b168         	cbz	r0, 0xf0020c8 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0xe8> @ imm = #0x1a
 f0020ac: 9806         	ldr	r0, [sp, #0x18]
 f0020ae: 7800         	ldrb	r0, [r0]
 f0020b0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0020b4: b140         	cbz	r0, 0xf0020c8 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0xe8> @ imm = #0x10
 f0020b6: 4640         	mov	r0, r8
 f0020b8: f000 f8e0    	bl	0xf00227c <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd> @ imm = #0x1c0
 f0020bc: 9806         	ldr	r0, [sp, #0x18]
 f0020be: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0020c2: 7005         	strb	r5, [r0]
 f0020c4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0020c8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0020cc: f88b 5095    	.word	#0xf88b5095
 f0020d0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0020d4: f89b 0094    	.word	#0xf89b0094
 f0020d8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0020dc: b320         	cbz	r0, 0xf002128 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x148> @ imm = #0x48
 f0020de: e8d4 0f4f    	.word	#0xe8d40f4f
 f0020e2: bbc0         	cbnz	r0, 0xf002156 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x176> @ imm = #0x70
 f0020e4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0020e8: e8c4 9f40    	.word	#0xe8c49f40
 f0020ec: b120         	cbz	r0, 0xf0020f8 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x118> @ imm = #0x8
 f0020ee: e8d4 0f4f    	.word	#0xe8d40f4f
 f0020f2: 2800         	cmp	r0, #0x0
 f0020f4: d0f8         	beq	0xf0020e8 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x108> @ imm = #-0x10
 f0020f6: e02e         	b	0xf002156 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x176> @ imm = #0x5c
 f0020f8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0020fc: e7c9         	b	0xf002092 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0xb2> @ imm = #-0x6e
 f0020fe: f10b 0090    	.word	#0xf10b0090
 f002102: 9003         	str	r0, [sp, #0xc]
 f002104: f10b 000c    	.word	#0xf10b000c
 f002108: 9002         	str	r0, [sp, #0x8]
 f00210a: 2000         	movs	r0, #0x0
 f00210c: 9001         	str	r0, [sp, #0x4]
 f00210e: 2001         	movs	r0, #0x1
 f002110: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002114: f88b 0090    	.word	#0xf88b0090
 f002118: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00211c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002120: f88b 0094    	.word	#0xf88b0094
 f002124: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002128: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00212c: e856 0f0f    	.word	#0xe8560f0f
 f002130: 3801         	subs	r0, #0x1
 f002132: e846 010f    	.word	#0xe846010f
 f002136: 2900         	cmp	r1, #0x0
 f002138: d1f8         	bne	0xf00212c <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x14c> @ imm = #-0x10
 f00213a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00213e: 7970         	ldrb	r0, [r6, #0x5]
 f002140: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002144: b118         	cbz	r0, 0xf00214e <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x16e> @ imm = #0x6
 f002146: 6bf0         	ldr	r0, [r6, #0x3c]
 f002148: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00214c: b140         	cbz	r0, 0xf002160 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x180> @ imm = #0x10
 f00214e: b007         	add	sp, #0x1c
 f002150: e8bd 0f00    	.word	#0xe8bd0f00
 f002154: bdf0         	pop	{r4, r5, r6, r7, pc}
 f002156: f3bf 8f2f    	.word	#0xf3bf8f2f
 f00215a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00215e: e7fe         	b	0xf00215e <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x17e> @ imm = #-0x4
 f002160: f3ef 8005    	.word	#0xf3ef8005
 f002164: b170         	cbz	r0, 0xf002184 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x1a4> @ imm = #0x1c
 f002166: f3ef 8005    	.word	#0xf3ef8005
 f00216a: 280e         	cmp	r0, #0xe
 f00216c: bf1f         	itttt	ne
 f00216e: f64e 5004    	.word	#0xf64e5004
 f002172: f2ce 0000    	.word	#0xf2ce0000
 f002176: f04f 5180    	.word	#0xf04f5180
 f00217a: 6001         	strne	r1, [r0]
 f00217c: b007         	add	sp, #0x1c
 f00217e: e8bd 0f00    	.word	#0xe8bd0f00
 f002182: bdf0         	pop	{r4, r5, r6, r7, pc}
 f002184: b007         	add	sp, #0x1c
 f002186: e8bd 0f00    	.word	#0xe8bd0f00
 f00218a: e8bd 40f0    	.word	#0xe8bd40f0
 f00218e: f7fe bf14    	.word	#0xf7febf14
 f002192: 4681         	mov	r9, r0
 f002194: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002198: e856 0f0f    	.word	#0xe8560f0f
 f00219c: 3801         	subs	r0, #0x1
 f00219e: e846 010f    	.word	#0xe846010f
 f0021a2: 2900         	cmp	r1, #0x0
 f0021a4: d1f8         	bne	0xf002198 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x1b8> @ imm = #-0x10
 f0021a6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0021aa: 7970         	ldrb	r0, [r6, #0x5]
 f0021ac: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0021b0: b1a0         	cbz	r0, 0xf0021dc <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x1fc> @ imm = #0x28
 f0021b2: 6bf0         	ldr	r0, [r6, #0x3c]
 f0021b4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0021b8: b980         	cbnz	r0, 0xf0021dc <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x1fc> @ imm = #0x20
 f0021ba: f3ef 8005    	.word	#0xf3ef8005
 f0021be: b910         	cbnz	r0, 0xf0021c6 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x1e6> @ imm = #0x4
 f0021c0: f7fe fefb    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x120a
 f0021c4: e00a         	b	0xf0021dc <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x1fc> @ imm = #0x14
 f0021c6: f3ef 8005    	.word	#0xf3ef8005
 f0021ca: 280e         	cmp	r0, #0xe
 f0021cc: bf1f         	itttt	ne
 f0021ce: f64e 5004    	.word	#0xf64e5004
 f0021d2: f2ce 0000    	.word	#0xf2ce0000
 f0021d6: f04f 5180    	.word	#0xf04f5180
 f0021da: 6001         	strne	r1, [r0]
 f0021dc: 4648         	mov	r0, r9
 f0021de: f003 f9f9    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x33f2
 f0021e2: defe         	trap
 f0021e4: f7fe faad    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x1aa6
 f0021e8: defe         	trap
 f0021ea: e9cd b804    	.word	#0xe9cdb804
 f0021ee: f10d 0810    	.word	#0xf10d0810
 f0021f2: 9506         	str	r5, [sp, #0x18]
 f0021f4: 4681         	mov	r9, r0
 f0021f6: f04f 0a00    	.word	#0xf04f0a00
 f0021fa: 2501         	movs	r5, #0x1
 f0021fc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002200: f10b 0194    	.word	#0xf10b0194
 f002204: e8d1 0f4f    	.word	#0xe8d10f4f
 f002208: e8c1 af42    	.word	#0xe8c1af42
 f00220c: 2a00         	cmp	r2, #0x0
 f00220e: d1f7         	bne	0xf002200 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x220> @ imm = #-0x12
 f002210: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002214: b170         	cbz	r0, 0xf002234 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x254> @ imm = #0x1c
 f002216: 9806         	ldr	r0, [sp, #0x18]
 f002218: 7800         	ldrb	r0, [r0]
 f00221a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00221e: b148         	cbz	r0, 0xf002234 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x254> @ imm = #0x12
 f002220: 4640         	mov	r0, r8
 f002222: f000 f82b    	bl	0xf00227c <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd> @ imm = #0x56
 f002226: 9806         	ldr	r0, [sp, #0x18]
 f002228: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00222c: f880 a000    	.word	#0xf880a000
 f002230: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002234: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002238: f88b a095    	.word	#0xf88ba095
 f00223c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002240: f89b 0094    	.word	#0xf89b0094
 f002244: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002248: 2800         	cmp	r0, #0x0
 f00224a: d0a3         	beq	0xf002194 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x1b4> @ imm = #-0xba
 f00224c: e8d4 0f4f    	.word	#0xe8d40f4f
 f002250: b960         	cbnz	r0, 0xf00226c <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x28c> @ imm = #0x18
 f002252: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002256: e8c4 5f40    	.word	#0xe8c45f40
 f00225a: b120         	cbz	r0, 0xf002266 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x286> @ imm = #0x8
 f00225c: e8d4 0f4f    	.word	#0xe8d40f4f
 f002260: 2800         	cmp	r0, #0x0
 f002262: d0f8         	beq	0xf002256 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x276> @ imm = #-0x10
 f002264: e002         	b	0xf00226c <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x28c> @ imm = #0x4
 f002266: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00226a: e7c7         	b	0xf0021fc <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x21c> @ imm = #-0x72
 f00226c: f3bf 8f2f    	.word	#0xf3bf8f2f
 f002270: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002274: e7fe         	b	0xf002274 <hopter::interrupt::systick::systick_handler::hf5f98bbe8ee52279+0x294> @ imm = #-0x4
 f002276: f7fe fa64    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x1b38
 f00227a: defe         	trap

0f00227c <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd>:
 f00227c: f04f 5c00    	.word	#0xf04f5c00
 f002280: f8dc c000    	.word	#0xf8dcc000
 f002284: ebbd 0c0c    	.word	#0xebbd0c0c
 f002288: f1bc 0f28    	.word	#0xf1bc0f28
 f00228c: da02         	bge	0xf002294 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x18> @ imm = #0x4
 f00228e: dfff         	svc	#0xff
 f002290: 000a         	movs	r2, r1
 f002292: 0000         	movs	r0, r0
 f002294: b5f0         	push	{r4, r5, r6, r7, lr}
 f002296: af03         	add	r7, sp, #0xc
 f002298: e92d 0f00    	.word	#0xe92d0f00
 f00229c: b081         	sub	sp, #0x4
 f00229e: 4604         	mov	r4, r0
 f0022a0: f246 7018    	.word	#0xf2467018
 f0022a4: f2c2 0000    	.word	#0xf2c20000
 f0022a8: 6cc5         	ldr	r5, [r0, #0x4c]
 f0022aa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0022ae: f8d4 a000    	.word	#0xf8d4a000
 f0022b2: f89a 0000    	.word	#0xf89a0000
 f0022b6: bba8         	cbnz	r0, 0xf002324 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xa8> @ imm = #0x6a
 f0022b8: 2001         	movs	r0, #0x1
 f0022ba: e8da 1f4f    	.word	#0xe8da1f4f
 f0022be: bb79         	cbnz	r1, 0xf002320 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xa4> @ imm = #0x5e
 f0022c0: e8ca 0f41    	.word	#0xe8ca0f41
 f0022c4: 2900         	cmp	r1, #0x0
 f0022c6: d1f8         	bne	0xf0022ba <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x3e> @ imm = #-0x10
 f0022c8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0022cc: f04f 0801    	.word	#0xf04f0801
 f0022d0: f8da 0004    	.word	#0xf8da0004
 f0022d4: b338         	cbz	r0, 0xf002326 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xaa> @ imm = #0x4e
 f0022d6: f8d0 10b8    	.word	#0xf8d010b8
 f0022da: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0022de: 42a9         	cmp	r1, r5
 f0022e0: d821         	bhi	0xf002326 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xaa> @ imm = #0x42
 f0022e2: f8da 1004    	.word	#0xf8da1004
 f0022e6: 4281         	cmp	r1, r0
 f0022e8: bf04         	itt	eq
 f0022ea: 6801         	ldreq	r1, [r0]
 f0022ec: f8ca 1004    	.word	#0xf8ca1004
 f0022f0: f8da 1008    	.word	#0xf8da1008
 f0022f4: 4281         	cmp	r1, r0
 f0022f6: bf04         	itt	eq
 f0022f8: 6841         	ldreq	r1, [r0, #0x4]
 f0022fa: f8ca 1008    	.word	#0xf8ca1008
 f0022fe: e9d0 6100    	.word	#0xe9d06100
 f002302: 2e00         	cmp	r6, #0x0
 f002304: bf18         	it	ne
 f002306: 6071         	strne	r1, [r6, #0x4]
 f002308: 2900         	cmp	r1, #0x0
 f00230a: bf18         	it	ne
 f00230c: 600e         	strne	r6, [r1]
 f00230e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002312: f8c0 8000    	.word	#0xf8c08000
 f002316: 3810         	subs	r0, #0x10
 f002318: f000 f8e4    	bl	0xf0024e4 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e> @ imm = #0x1c8
 f00231c: 4630         	mov	r0, r6
 f00231e: e7d9         	b	0xf0022d4 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x58> @ imm = #-0x4e
 f002320: f3bf 8f2f    	.word	#0xf3bf8f2f
 f002324: e7fe         	b	0xf002324 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xa8> @ imm = #-0x4
 f002326: f8d4 b004    	.word	#0xf8d4b004
 f00232a: 46e8         	mov	r8, sp
 f00232c: f04f 0901    	.word	#0xf04f0901
 f002330: f10b 0480    	.word	#0xf10b0480
 f002334: e004         	b	0xf002340 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xc4> @ imm = #0x8
 f002336: 1a30         	subs	r0, r6, r0
 f002338: b240         	sxtb	r0, r0
 f00233a: 2800         	cmp	r0, #0x0
 f00233c: f100 80a9    	.word	#0xf10080a9
 f002340: f89b 1080    	.word	#0xf89b1080
 f002344: f001 030f    	.word	#0xf001030f
 f002348: eb0b 00c3    	.word	#0xeb0b00c3
 f00234c: 1d02         	adds	r2, r0, #0x4
 f00234e: 1c48         	adds	r0, r1, #0x1
 f002350: e001         	b	0xf002356 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xda> @ imm = #0x2
 f002352: f3bf 8f2f    	.word	#0xf3bf8f2f
 f002356: 7816         	ldrb	r6, [r2]
 f002358: b2c5         	uxtb	r5, r0
 f00235a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00235e: 42ae         	cmp	r6, r5
 f002360: d1e9         	bne	0xf002336 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xba> @ imm = #-0x2e
 f002362: e8d4 6f4f    	.word	#0xe8d46f4f
 f002366: 428e         	cmp	r6, r1
 f002368: d108         	bne	0xf00237c <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x100> @ imm = #0x10
 f00236a: e8c4 0f46    	.word	#0xe8c40f46
 f00236e: b3e6         	cbz	r6, 0xf0023ea <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x16e> @ imm = #0x78
 f002370: 7816         	ldrb	r6, [r2]
 f002372: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002376: 42ae         	cmp	r6, r5
 f002378: d007         	beq	0xf00238a <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x10e> @ imm = #0xe
 f00237a: e7dc         	b	0xf002336 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xba> @ imm = #-0x48
 f00237c: f3bf 8f2f    	.word	#0xf3bf8f2f
 f002380: 7816         	ldrb	r6, [r2]
 f002382: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002386: 42ae         	cmp	r6, r5
 f002388: d1d5         	bne	0xf002336 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xba> @ imm = #-0x56
 f00238a: e8d4 6f4f    	.word	#0xe8d46f4f
 f00238e: 428e         	cmp	r6, r1
 f002390: d108         	bne	0xf0023a4 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x128> @ imm = #0x10
 f002392: e8c4 0f46    	.word	#0xe8c40f46
 f002396: b346         	cbz	r6, 0xf0023ea <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x16e> @ imm = #0x50
 f002398: 7816         	ldrb	r6, [r2]
 f00239a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00239e: 42ae         	cmp	r6, r5
 f0023a0: d007         	beq	0xf0023b2 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x136> @ imm = #0xe
 f0023a2: e7c8         	b	0xf002336 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xba> @ imm = #-0x70
 f0023a4: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0023a8: 7816         	ldrb	r6, [r2]
 f0023aa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0023ae: 42ae         	cmp	r6, r5
 f0023b0: d1c1         	bne	0xf002336 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xba> @ imm = #-0x7e
 f0023b2: e8d4 6f4f    	.word	#0xe8d46f4f
 f0023b6: 428e         	cmp	r6, r1
 f0023b8: d108         	bne	0xf0023cc <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x150> @ imm = #0x10
 f0023ba: e8c4 0f46    	.word	#0xe8c40f46
 f0023be: b1a6         	cbz	r6, 0xf0023ea <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x16e> @ imm = #0x28
 f0023c0: 7816         	ldrb	r6, [r2]
 f0023c2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0023c6: 42ae         	cmp	r6, r5
 f0023c8: d007         	beq	0xf0023da <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x15e> @ imm = #0xe
 f0023ca: e7b4         	b	0xf002336 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xba> @ imm = #-0x98
 f0023cc: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0023d0: 7816         	ldrb	r6, [r2]
 f0023d2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0023d6: 42ae         	cmp	r6, r5
 f0023d8: d1ad         	bne	0xf002336 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xba> @ imm = #-0xa6
 f0023da: e8d4 6f4f    	.word	#0xe8d46f4f
 f0023de: 428e         	cmp	r6, r1
 f0023e0: d1b7         	bne	0xf002352 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xd6> @ imm = #-0x92
 f0023e2: e8c4 0f46    	.word	#0xe8c40f46
 f0023e6: 2e00         	cmp	r6, #0x0
 f0023e8: d1b5         	bne	0xf002356 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xda> @ imm = #-0x96
 f0023ea: f85b 5033    	.word	#0xf85b5033
 f0023ee: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0023f2: f101 0010    	.word	#0xf1010010
 f0023f6: 7010         	strb	r0, [r2]
 f0023f8: f8da 1004    	.word	#0xf8da1004
 f0023fc: 9500         	str	r5, [sp]
 f0023fe: b3b1         	cbz	r1, 0xf00246e <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x1f2> @ imm = #0x6c
 f002400: f105 0208    	.word	#0xf1050208
 f002404: 4608         	mov	r0, r1
 f002406: f1a0 0308    	.word	#0xf1a00308
 f00240a: 4293         	cmp	r3, r2
 f00240c: d015         	beq	0xf00243a <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x1be> @ imm = #0x2a
 f00240e: 6800         	ldr	r0, [r0]
 f002410: b368         	cbz	r0, 0xf00246e <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x1f2> @ imm = #0x5a
 f002412: f1a0 0308    	.word	#0xf1a00308
 f002416: 4293         	cmp	r3, r2
 f002418: d00f         	beq	0xf00243a <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x1be> @ imm = #0x1e
 f00241a: 6800         	ldr	r0, [r0]
 f00241c: b338         	cbz	r0, 0xf00246e <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x1f2> @ imm = #0x4e
 f00241e: f1a0 0308    	.word	#0xf1a00308
 f002422: 4293         	cmp	r3, r2
 f002424: d009         	beq	0xf00243a <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x1be> @ imm = #0x12
 f002426: 6800         	ldr	r0, [r0]
 f002428: b308         	cbz	r0, 0xf00246e <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x1f2> @ imm = #0x42
 f00242a: f1a0 0308    	.word	#0xf1a00308
 f00242e: 4293         	cmp	r3, r2
 f002430: d003         	beq	0xf00243a <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x1be> @ imm = #0x6
 f002432: 6800         	ldr	r0, [r0]
 f002434: 2800         	cmp	r0, #0x0
 f002436: d1e6         	bne	0xf002406 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x18a> @ imm = #-0x34
 f002438: e019         	b	0xf00246e <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x1f2> @ imm = #0x32
 f00243a: 4281         	cmp	r1, r0
 f00243c: bf04         	itt	eq
 f00243e: 6809         	ldreq	r1, [r1]
 f002440: f8ca 1004    	.word	#0xf8ca1004
 f002444: f8da 2008    	.word	#0xf8da2008
 f002448: 6841         	ldr	r1, [r0, #0x4]
 f00244a: 4282         	cmp	r2, r0
 f00244c: bf08         	it	eq
 f00244e: f8ca 1008    	.word	#0xf8ca1008
 f002452: 6802         	ldr	r2, [r0]
 f002454: 2a00         	cmp	r2, #0x0
 f002456: bf18         	it	ne
 f002458: 6051         	strne	r1, [r2, #0x4]
 f00245a: 2900         	cmp	r1, #0x0
 f00245c: bf18         	it	ne
 f00245e: 600a         	strne	r2, [r1]
 f002460: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002464: f8c0 9000    	.word	#0xf8c09000
 f002468: 3810         	subs	r0, #0x10
 f00246a: f000 f83b    	bl	0xf0024e4 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e> @ imm = #0x76
 f00246e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002472: e855 0f00    	.word	#0xe8550f00
 f002476: 1e41         	subs	r1, r0, #0x1
 f002478: e845 1200    	.word	#0xe8451200
 f00247c: 2a00         	cmp	r2, #0x0
 f00247e: d1f8         	bne	0xf002472 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x1f6> @ imm = #-0x10
 f002480: 2801         	cmp	r0, #0x1
 f002482: f47f af5d    	.word	#0xf47faf5d
 f002486: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00248a: 4640         	mov	r0, r8
 f00248c: f7fe fd98    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x14d0
 f002490: e756         	b	0xf002340 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0xc4> @ imm = #-0x154
 f002492: 2000         	movs	r0, #0x0
 f002494: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002498: f88a 0000    	.word	#0xf88a0000
 f00249c: b001         	add	sp, #0x4
 f00249e: e8bd 0f00    	.word	#0xe8bd0f00
 f0024a2: bdf0         	pop	{r4, r5, r6, r7, pc}
 f0024a4: 4604         	mov	r4, r0
 f0024a6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0024aa: e855 0f00    	.word	#0xe8550f00
 f0024ae: 1e41         	subs	r1, r0, #0x1
 f0024b0: e845 1200    	.word	#0xe8451200
 f0024b4: 2a00         	cmp	r2, #0x0
 f0024b6: d1f8         	bne	0xf0024aa <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x22e> @ imm = #-0x10
 f0024b8: 2801         	cmp	r0, #0x1
 f0024ba: d10a         	bne	0xf0024d2 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x256> @ imm = #0x14
 f0024bc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0024c0: 4668         	mov	r0, sp
 f0024c2: f7fe fd7d    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x1506
 f0024c6: e004         	b	0xf0024d2 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x256> @ imm = #0x8
 f0024c8: f7fe f93b    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x1d8a
 f0024cc: defe         	trap
 f0024ce: e7ff         	b	0xf0024d0 <hopter::time::InnerFullAccessor::wake_expired_tasks::h71ec4be1023ad6dd+0x254> @ imm = #-0x2
 f0024d0: 4604         	mov	r4, r0
 f0024d2: 2000         	movs	r0, #0x0
 f0024d4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0024d8: f88a 0000    	.word	#0xf88a0000
 f0024dc: 4620         	mov	r0, r4
 f0024de: f003 f879    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x30f2
 f0024e2: defe         	trap

0f0024e4 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e>:
 f0024e4: f04f 5c00    	.word	#0xf04f5c00
 f0024e8: f8dc c000    	.word	#0xf8dcc000
 f0024ec: ebbd 0c0c    	.word	#0xebbd0c0c
 f0024f0: f1bc 0f30    	.word	#0xf1bc0f30
 f0024f4: da02         	bge	0xf0024fc <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x18> @ imm = #0x4
 f0024f6: dfff         	svc	#0xff
 f0024f8: 000c         	movs	r4, r1
 f0024fa: 0000         	movs	r0, r0
 f0024fc: b5f0         	push	{r4, r5, r6, r7, lr}
 f0024fe: af03         	add	r7, sp, #0xc
 f002500: e92d 0f00    	.word	#0xe92d0f00
 f002504: b083         	sub	sp, #0xc
 f002506: f246 4a98    	.word	#0xf2464a98
 f00250a: f2c2 0a00    	.word	#0xf2c20a00
 f00250e: f10a 0891    	.word	#0xf10a0891
 f002512: e8d8 1f4f    	.word	#0xe8d81f4f
 f002516: b949         	cbnz	r1, 0xf00252c <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x48> @ imm = #0x12
 f002518: 2501         	movs	r5, #0x1
 f00251a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00251e: e8c8 5f41    	.word	#0xe8c85f41
 f002522: b131         	cbz	r1, 0xf002532 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x4e> @ imm = #0xc
 f002524: e8d8 1f4f    	.word	#0xe8d81f4f
 f002528: 2900         	cmp	r1, #0x0
 f00252a: d0f8         	beq	0xf00251e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x3a> @ imm = #-0x10
 f00252c: 2500         	movs	r5, #0x0
 f00252e: f3bf 8f2f    	.word	#0xf3bf8f2f
 f002532: 2d00         	cmp	r5, #0x0
 f002534: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002538: f000 8097    	.word	#0xf0008097
 f00253c: f10a 0984    	.word	#0xf10a0984
 f002540: f246 7418    	.word	#0xf2467418
 f002544: f2c2 0400    	.word	#0xf2c20400
 f002548: e9cd 0900    	.word	#0xe9cd0900
 f00254c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002550: e854 0f0f    	.word	#0xe8540f0f
 f002554: 3001         	adds	r0, #0x1
 f002556: e844 010f    	.word	#0xe844010f
 f00255a: 2900         	cmp	r1, #0x0
 f00255c: d1f8         	bne	0xf002550 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x6c> @ imm = #-0x10
 f00255e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002562: e854 1f14    	.word	#0xe8541f14
 f002566: 1d08         	adds	r0, r1, #0x4
 f002568: e844 0214    	.word	#0xe8440214
 f00256c: 2a00         	cmp	r2, #0x0
 f00256e: d1f8         	bne	0xf002562 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x7e> @ imm = #-0x10
 f002570: f64f 70fc    	.word	#0xf64f70fc
 f002574: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002578: f6c7 70ff    	.word	#0xf6c770ff
 f00257c: 4281         	cmp	r1, r0
 f00257e: d85f         	bhi	0xf002640 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x15c> @ imm = #0xbe
 f002580: 0789         	lsls	r1, r1, #0x1e
 f002582: f000 8100    	.word	#0xf0008100
 f002586: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00258a: e854 1f14    	.word	#0xe8541f14
 f00258e: 3904         	subs	r1, #0x4
 f002590: e844 1214    	.word	#0xe8441214
 f002594: 2a00         	cmp	r2, #0x0
 f002596: d1f8         	bne	0xf00258a <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0xa6> @ imm = #-0x10
 f002598: bf10         	yield
 f00259a: e854 1f14    	.word	#0xe8541f14
 f00259e: 1d0a         	adds	r2, r1, #0x4
 f0025a0: e844 2314    	.word	#0xe8442314
 f0025a4: 2b00         	cmp	r3, #0x0
 f0025a6: d1f8         	bne	0xf00259a <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0xb6> @ imm = #-0x10
 f0025a8: 4281         	cmp	r1, r0
 f0025aa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0025ae: d847         	bhi	0xf002640 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x15c> @ imm = #0x8e
 f0025b0: 0789         	lsls	r1, r1, #0x1e
 f0025b2: f000 80e8    	.word	#0xf00080e8
 f0025b6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0025ba: e854 1f14    	.word	#0xe8541f14
 f0025be: 3904         	subs	r1, #0x4
 f0025c0: e844 1214    	.word	#0xe8441214
 f0025c4: 2a00         	cmp	r2, #0x0
 f0025c6: d1f8         	bne	0xf0025ba <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0xd6> @ imm = #-0x10
 f0025c8: bf10         	yield
 f0025ca: e854 1f14    	.word	#0xe8541f14
 f0025ce: 1d0a         	adds	r2, r1, #0x4
 f0025d0: e844 2314    	.word	#0xe8442314
 f0025d4: 2b00         	cmp	r3, #0x0
 f0025d6: d1f8         	bne	0xf0025ca <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0xe6> @ imm = #-0x10
 f0025d8: 4281         	cmp	r1, r0
 f0025da: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0025de: d82f         	bhi	0xf002640 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x15c> @ imm = #0x5e
 f0025e0: 0789         	lsls	r1, r1, #0x1e
 f0025e2: f000 80d0    	.word	#0xf00080d0
 f0025e6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0025ea: e854 1f14    	.word	#0xe8541f14
 f0025ee: 3904         	subs	r1, #0x4
 f0025f0: e844 1214    	.word	#0xe8441214
 f0025f4: 2a00         	cmp	r2, #0x0
 f0025f6: d1f8         	bne	0xf0025ea <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x106> @ imm = #-0x10
 f0025f8: bf10         	yield
 f0025fa: e854 1f14    	.word	#0xe8541f14
 f0025fe: 1d0a         	adds	r2, r1, #0x4
 f002600: e844 2314    	.word	#0xe8442314
 f002604: 2b00         	cmp	r3, #0x0
 f002606: d1f8         	bne	0xf0025fa <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x116> @ imm = #-0x10
 f002608: 4281         	cmp	r1, r0
 f00260a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00260e: d817         	bhi	0xf002640 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x15c> @ imm = #0x2e
 f002610: 0789         	lsls	r1, r1, #0x1e
 f002612: f000 80b8    	.word	#0xf00080b8
 f002616: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00261a: e854 1f14    	.word	#0xe8541f14
 f00261e: 3904         	subs	r1, #0x4
 f002620: e844 1214    	.word	#0xe8441214
 f002624: 2a00         	cmp	r2, #0x0
 f002626: d1f8         	bne	0xf00261a <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x136> @ imm = #-0x10
 f002628: bf10         	yield
 f00262a: e854 1f14    	.word	#0xe8541f14
 f00262e: 1d0a         	adds	r2, r1, #0x4
 f002630: e844 2314    	.word	#0xe8442314
 f002634: 2b00         	cmp	r3, #0x0
 f002636: d1f8         	bne	0xf00262a <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x146> @ imm = #-0x10
 f002638: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00263c: 4281         	cmp	r1, r0
 f00263e: d99f         	bls	0xf002580 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x9c> @ imm = #-0xc2
 f002640: e854 0f14    	.word	#0xe8540f14
 f002644: 3804         	subs	r0, #0x4
 f002646: e844 0114    	.word	#0xe8440114
 f00264a: 2900         	cmp	r1, #0x0
 f00264c: d1f8         	bne	0xf002640 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x15c> @ imm = #-0x10
 f00264e: f245 6078    	.word	#0xf2456078
 f002652: 212c         	movs	r1, #0x2c
 f002654: f6c0 7000    	.word	#0xf6c07000
 f002658: f7fd fff7    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x2012
 f00265c: e149         	b	0xf0028f2 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x40e> @ imm = #0x292
 f00265e: 1a71         	subs	r1, r6, r1
 f002660: b249         	sxtb	r1, r1
 f002662: f1b1 3fff    	.word	#0xf1b13fff
 f002666: f340 808d    	.word	#0xf340808d
 f00266a: f89a 1081    	.word	#0xf89a1081
 f00266e: f001 0c0f    	.word	#0xf0010c0f
 f002672: 1c4c         	adds	r4, r1, #0x1
 f002674: eb0a 02cc    	.word	#0xeb0a02cc
 f002678: 1d13         	adds	r3, r2, #0x4
 f00267a: e001         	b	0xf002680 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x19c> @ imm = #0x2
 f00267c: f3bf 8f2f    	.word	#0xf3bf8f2f
 f002680: 781e         	ldrb	r6, [r3]
 f002682: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002686: 428e         	cmp	r6, r1
 f002688: d1e9         	bne	0xf00265e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x17a> @ imm = #-0x2e
 f00268a: f10a 0281    	.word	#0xf10a0281
 f00268e: e8d2 6f4f    	.word	#0xe8d26f4f
 f002692: 428e         	cmp	r6, r1
 f002694: d108         	bne	0xf0026a8 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x1c4> @ imm = #0x10
 f002696: e8c2 4f46    	.word	#0xe8c24f46
 f00269a: b3e6         	cbz	r6, 0xf002716 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x232> @ imm = #0x78
 f00269c: 781e         	ldrb	r6, [r3]
 f00269e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0026a2: 428e         	cmp	r6, r1
 f0026a4: d007         	beq	0xf0026b6 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x1d2> @ imm = #0xe
 f0026a6: e7da         	b	0xf00265e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x17a> @ imm = #-0x4c
 f0026a8: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0026ac: 781e         	ldrb	r6, [r3]
 f0026ae: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0026b2: 428e         	cmp	r6, r1
 f0026b4: d1d3         	bne	0xf00265e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x17a> @ imm = #-0x5a
 f0026b6: e8d2 6f4f    	.word	#0xe8d26f4f
 f0026ba: 428e         	cmp	r6, r1
 f0026bc: d108         	bne	0xf0026d0 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x1ec> @ imm = #0x10
 f0026be: e8c2 4f46    	.word	#0xe8c24f46
 f0026c2: b346         	cbz	r6, 0xf002716 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x232> @ imm = #0x50
 f0026c4: 781e         	ldrb	r6, [r3]
 f0026c6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0026ca: 428e         	cmp	r6, r1
 f0026cc: d007         	beq	0xf0026de <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x1fa> @ imm = #0xe
 f0026ce: e7c6         	b	0xf00265e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x17a> @ imm = #-0x74
 f0026d0: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0026d4: 781e         	ldrb	r6, [r3]
 f0026d6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0026da: 428e         	cmp	r6, r1
 f0026dc: d1bf         	bne	0xf00265e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x17a> @ imm = #-0x82
 f0026de: e8d2 6f4f    	.word	#0xe8d26f4f
 f0026e2: 428e         	cmp	r6, r1
 f0026e4: d108         	bne	0xf0026f8 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x214> @ imm = #0x10
 f0026e6: e8c2 4f46    	.word	#0xe8c24f46
 f0026ea: b1a6         	cbz	r6, 0xf002716 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x232> @ imm = #0x28
 f0026ec: 781e         	ldrb	r6, [r3]
 f0026ee: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0026f2: 428e         	cmp	r6, r1
 f0026f4: d007         	beq	0xf002706 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x222> @ imm = #0xe
 f0026f6: e7b2         	b	0xf00265e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x17a> @ imm = #-0x9c
 f0026f8: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0026fc: 781e         	ldrb	r6, [r3]
 f0026fe: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002702: 428e         	cmp	r6, r1
 f002704: d1ab         	bne	0xf00265e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x17a> @ imm = #-0xaa
 f002706: e8d2 6f4f    	.word	#0xe8d26f4f
 f00270a: 428e         	cmp	r6, r1
 f00270c: d1b6         	bne	0xf00267c <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x198> @ imm = #-0x94
 f00270e: e8c2 4f46    	.word	#0xe8c24f46
 f002712: 2e00         	cmp	r6, #0x0
 f002714: d1b4         	bne	0xf002680 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x19c> @ imm = #-0x98
 f002716: f84a 003c    	.word	#0xf84a003c
 f00271a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00271e: 701c         	strb	r4, [r3]
 f002720: 2d00         	cmp	r5, #0x0
 f002722: d041         	beq	0xf0027a8 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2c4> @ imm = #0x82
 f002724: f10a 0490    	.word	#0xf10a0490
 f002728: 2500         	movs	r5, #0x0
 f00272a: 2601         	movs	r6, #0x1
 f00272c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002730: e8d4 0f4f    	.word	#0xe8d40f4f
 f002734: e8c4 5f41    	.word	#0xe8c45f41
 f002738: 2900         	cmp	r1, #0x0
 f00273a: d1f9         	bne	0xf002730 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x24c> @ imm = #-0xe
 f00273c: 2800         	cmp	r0, #0x0
 f00273e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002742: bf1e         	ittt	ne
 f002744: f10a 0184    	.word	#0xf10a0184
 f002748: 4650         	movne	r0, r10
 f00274a: f7ff f8eb    	blne	0xf001924 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb> @ imm = #-0xe2a
 f00274e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002752: f88a 5091    	.word	#0xf88a5091
 f002756: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00275a: f89a 0090    	.word	#0xf89a0090
 f00275e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002762: b340         	cbz	r0, 0xf0027b6 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2d2> @ imm = #0x50
 f002764: e8d8 0f4f    	.word	#0xe8d80f4f
 f002768: bb48         	cbnz	r0, 0xf0027be <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2da> @ imm = #0x52
 f00276a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00276e: e8c8 6f40    	.word	#0xe8c86f40
 f002772: b120         	cbz	r0, 0xf00277e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x29a> @ imm = #0x8
 f002774: e8d8 0f4f    	.word	#0xe8d80f4f
 f002778: 2800         	cmp	r0, #0x0
 f00277a: d0f8         	beq	0xf00276e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x28a> @ imm = #-0x10
 f00277c: e01f         	b	0xf0027be <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2da> @ imm = #0x3e
 f00277e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002782: e7d3         	b	0xf00272c <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x248> @ imm = #-0x5a
 f002784: e7fe         	b	0xf002784 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2a0> @ imm = #-0x4
 f002786: 6d62         	ldr	r2, [r4, #0x54]
 f002788: b16a         	cbz	r2, 0xf0027a6 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2c2> @ imm = #0x1a
 f00278a: e9dd 0b00    	.word	#0xe9dd0b00
 f00278e: f8d0 10c4    	.word	#0xf8d010c4
 f002792: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002796: f8d2 20c4    	.word	#0xf8d220c4
 f00279a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00279e: f011 0ffe    	.word	#0xf0110ffe
 f0027a2: d011         	beq	0xf0027c8 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2e4> @ imm = #0x22
 f0027a4: e7fe         	b	0xf0027a4 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2c0> @ imm = #-0x4
 f0027a6: e7fe         	b	0xf0027a6 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2c2> @ imm = #-0x4
 f0027a8: 2001         	movs	r0, #0x1
 f0027aa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0027ae: f88a 0090    	.word	#0xf88a0090
 f0027b2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0027b6: b003         	add	sp, #0xc
 f0027b8: e8bd 0f00    	.word	#0xe8bd0f00
 f0027bc: bdf0         	pop	{r4, r5, r6, r7, pc}
 f0027be: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0027c2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0027c6: e7fe         	b	0xf0027c6 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2e2> @ imm = #-0x4
 f0027c8: f012 0ffe    	.word	#0xf0120ffe
 f0027cc: d000         	beq	0xf0027d0 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2ec> @ imm = #0x0
 f0027ce: e7fe         	b	0xf0027ce <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x2ea> @ imm = #-0x4
 f0027d0: f3c2 2207    	.word	#0xf3c22207
 f0027d4: f3c1 2107    	.word	#0xf3c12107
 f0027d8: 4291         	cmp	r1, r2
 f0027da: bf3f         	itttt	lo
 f0027dc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0027e0: 2101         	movlo	r1, #0x1
 f0027e2: 7161         	strblo	r1, [r4, #0x5]
 f0027e4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0027e8: 2102         	movs	r1, #0x2
 f0027ea: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0027ee: f880 10cd    	.word	#0xf88010cd
 f0027f2: f89b 1000    	.word	#0xf89b1000
 f0027f6: 2900         	cmp	r1, #0x0
 f0027f8: d15d         	bne	0xf0028b6 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x3d2> @ imm = #0xba
 f0027fa: 2101         	movs	r1, #0x1
 f0027fc: e8db 2f4f    	.word	#0xe8db2f4f
 f002800: 2a00         	cmp	r2, #0x0
 f002802: d156         	bne	0xf0028b2 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x3ce> @ imm = #0xac
 f002804: e8cb 1f42    	.word	#0xe8cb1f42
 f002808: 2a00         	cmp	r2, #0x0
 f00280a: d1f7         	bne	0xf0027fc <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x318> @ imm = #-0x12
 f00280c: f100 0110    	.word	#0xf1000110
 f002810: 2200         	movs	r2, #0x0
 f002812: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002816: e851 3f00    	.word	#0xe8513f00
 f00281a: 2b01         	cmp	r3, #0x1
 f00281c: d14f         	bne	0xf0028be <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x3da> @ imm = #0x9e
 f00281e: e841 2300    	.word	#0xe8412300
 f002822: 2b00         	cmp	r3, #0x0
 f002824: d1f7         	bne	0xf002816 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x332> @ imm = #-0x12
 f002826: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00282a: 2200         	movs	r2, #0x0
 f00282c: f8db 3008    	.word	#0xf8db3008
 f002830: 2b00         	cmp	r3, #0x0
 f002832: bf18         	it	ne
 f002834: 6019         	strne	r1, [r3]
 f002836: e9c0 2304    	.word	#0xe9c02304
 f00283a: f8db 0004    	.word	#0xf8db0004
 f00283e: f8cb 1008    	.word	#0xf8cb1008
 f002842: 2800         	cmp	r0, #0x0
 f002844: bf08         	it	eq
 f002846: f8cb 1004    	.word	#0xf8cb1004
 f00284a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00284e: f88b 2000    	.word	#0xf88b2000
 f002852: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002856: e854 0f14    	.word	#0xe8540f14
 f00285a: 3804         	subs	r0, #0x4
 f00285c: e844 0114    	.word	#0xe8440114
 f002860: 2900         	cmp	r1, #0x0
 f002862: d1f8         	bne	0xf002856 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x372> @ imm = #-0x10
 f002864: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002868: e854 0f0f    	.word	#0xe8540f0f
 f00286c: 3801         	subs	r0, #0x1
 f00286e: e844 010f    	.word	#0xe844010f
 f002872: 2900         	cmp	r1, #0x0
 f002874: d1f8         	bne	0xf002868 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x384> @ imm = #-0x10
 f002876: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00287a: 7960         	ldrb	r0, [r4, #0x5]
 f00287c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002880: 2800         	cmp	r0, #0x0
 f002882: f43f af4d    	.word	#0xf43faf4d
 f002886: 6be0         	ldr	r0, [r4, #0x3c]
 f002888: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00288c: 2800         	cmp	r0, #0x0
 f00288e: f47f af47    	.word	#0xf47faf47
 f002892: f3ef 8005    	.word	#0xf3ef8005
 f002896: b178         	cbz	r0, 0xf0028b8 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x3d4> @ imm = #0x1e
 f002898: f3ef 8005    	.word	#0xf3ef8005
 f00289c: 280e         	cmp	r0, #0xe
 f00289e: f43f af3f    	.word	#0xf43faf3f
 f0028a2: f64e 5004    	.word	#0xf64e5004
 f0028a6: f04f 5180    	.word	#0xf04f5180
 f0028aa: f2ce 0000    	.word	#0xf2ce0000
 f0028ae: 6001         	str	r1, [r0]
 f0028b0: e736         	b	0xf002720 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x23c> @ imm = #-0x194
 f0028b2: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0028b6: e7fe         	b	0xf0028b6 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x3d2> @ imm = #-0x4
 f0028b8: f7fe fb7f    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x1902
 f0028bc: e730         	b	0xf002720 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x23c> @ imm = #-0x1a0
 f0028be: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0028c2: 9002         	str	r0, [sp, #0x8]
 f0028c4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0028c8: e850 1f00    	.word	#0xe8501f00
 f0028cc: 1e4a         	subs	r2, r1, #0x1
 f0028ce: e840 2300    	.word	#0xe8402300
 f0028d2: 2b00         	cmp	r3, #0x0
 f0028d4: d1f8         	bne	0xf0028c8 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x3e4> @ imm = #-0x10
 f0028d6: 2901         	cmp	r1, #0x1
 f0028d8: d104         	bne	0xf0028e4 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x400> @ imm = #0x8
 f0028da: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0028de: a802         	add	r0, sp, #0x8
 f0028e0: f7fe fb6e    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x1924
 f0028e4: f245 6044    	.word	#0xf2456044
 f0028e8: 2134         	movs	r1, #0x34
 f0028ea: f6c0 7000    	.word	#0xf6c07000
 f0028ee: f7fd feac    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x22a8
 f0028f2: defe         	trap
 f0028f4: 4606         	mov	r6, r0
 f0028f6: e038         	b	0xf00296a <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x486> @ imm = #0x70
 f0028f8: 4606         	mov	r6, r0
 f0028fa: 2000         	movs	r0, #0x0
 f0028fc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002900: f88b 0000    	.word	#0xf88b0000
 f002904: 2501         	movs	r5, #0x1
 f002906: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00290a: e854 0f14    	.word	#0xe8540f14
 f00290e: 3804         	subs	r0, #0x4
 f002910: e844 0114    	.word	#0xe8440114
 f002914: 2900         	cmp	r1, #0x0
 f002916: d1f8         	bne	0xf00290a <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x426> @ imm = #-0x10
 f002918: e001         	b	0xf00291e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x43a> @ imm = #0x2
 f00291a: 4606         	mov	r6, r0
 f00291c: 2500         	movs	r5, #0x0
 f00291e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002922: e854 0f0f    	.word	#0xe8540f0f
 f002926: 3801         	subs	r0, #0x1
 f002928: e844 010f    	.word	#0xe844010f
 f00292c: 2900         	cmp	r1, #0x0
 f00292e: d1f8         	bne	0xf002922 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x43e> @ imm = #-0x10
 f002930: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002934: 7960         	ldrb	r0, [r4, #0x5]
 f002936: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00293a: b120         	cbz	r0, 0xf002946 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x462> @ imm = #0x8
 f00293c: 6be0         	ldr	r0, [r4, #0x3c]
 f00293e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002942: 2800         	cmp	r0, #0x0
 f002944: d045         	beq	0xf0029d2 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x4ee> @ imm = #0x8a
 f002946: b985         	cbnz	r5, 0xf00296a <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x486> @ imm = #0x20
 f002948: 9800         	ldr	r0, [sp]
 f00294a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00294e: e850 1f00    	.word	#0xe8501f00
 f002952: 1e4a         	subs	r2, r1, #0x1
 f002954: e840 2300    	.word	#0xe8402300
 f002958: 2b00         	cmp	r3, #0x0
 f00295a: d1f8         	bne	0xf00294e <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x46a> @ imm = #-0x10
 f00295c: 2901         	cmp	r1, #0x1
 f00295e: d104         	bne	0xf00296a <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x486> @ imm = #0x8
 f002960: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002964: 4668         	mov	r0, sp
 f002966: f7fe fb2b    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x19aa
 f00296a: f10a 0490    	.word	#0xf10a0490
 f00296e: 2500         	movs	r5, #0x0
 f002970: f04f 0b01    	.word	#0xf04f0b01
 f002974: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002978: e8d4 0f4f    	.word	#0xe8d40f4f
 f00297c: e8c4 5f41    	.word	#0xe8c45f41
 f002980: 2900         	cmp	r1, #0x0
 f002982: d1f9         	bne	0xf002978 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x494> @ imm = #-0xe
 f002984: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002988: b118         	cbz	r0, 0xf002992 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x4ae> @ imm = #0x6
 f00298a: 4650         	mov	r0, r10
 f00298c: 4649         	mov	r1, r9
 f00298e: f7fe ffc9    	bl	0xf001924 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb> @ imm = #-0x106e
 f002992: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002996: f88a 5091    	.word	#0xf88a5091
 f00299a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00299e: f89a 0090    	.word	#0xf89a0090
 f0029a2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0029a6: b330         	cbz	r0, 0xf0029f6 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x512> @ imm = #0x4c
 f0029a8: e8d8 0f4f    	.word	#0xe8d80f4f
 f0029ac: b960         	cbnz	r0, 0xf0029c8 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x4e4> @ imm = #0x18
 f0029ae: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0029b2: e8c8 bf40    	.word	#0xe8c8bf40
 f0029b6: b120         	cbz	r0, 0xf0029c2 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x4de> @ imm = #0x8
 f0029b8: e8d8 0f4f    	.word	#0xe8d80f4f
 f0029bc: 2800         	cmp	r0, #0x0
 f0029be: d0f8         	beq	0xf0029b2 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x4ce> @ imm = #-0x10
 f0029c0: e002         	b	0xf0029c8 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x4e4> @ imm = #0x4
 f0029c2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0029c6: e7d5         	b	0xf002974 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x490> @ imm = #-0x56
 f0029c8: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0029cc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0029d0: e7fe         	b	0xf0029d0 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x4ec> @ imm = #-0x4
 f0029d2: f3ef 8005    	.word	#0xf3ef8005
 f0029d6: b158         	cbz	r0, 0xf0029f0 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x50c> @ imm = #0x16
 f0029d8: f3ef 8005    	.word	#0xf3ef8005
 f0029dc: 280e         	cmp	r0, #0xe
 f0029de: d0b2         	beq	0xf002946 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x462> @ imm = #-0x9c
 f0029e0: f64e 5004    	.word	#0xf64e5004
 f0029e4: f04f 5180    	.word	#0xf04f5180
 f0029e8: f2ce 0000    	.word	#0xf2ce0000
 f0029ec: 6001         	str	r1, [r0]
 f0029ee: e7aa         	b	0xf002946 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x462> @ imm = #-0xac
 f0029f0: f7fe fae3    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x1a3a
 f0029f4: e7a7         	b	0xf002946 <hopter::schedule::scheduler::make_task_ready_and_enqueue::h972c4b6f9b60e56e+0x462> @ imm = #-0xb2
 f0029f6: 4630         	mov	r0, r6
 f0029f8: f002 fdec    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x2bd8
 f0029fc: defe         	trap
 f0029fe: f7fd fea0    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x22c0
 f002a02: defe         	trap
 f002a04: f7fd fe9d    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x22c6
 f002a08: defe         	trap

0f002a0a <hopter::interrupt::default::fast_irq_exit::hed25f1382e90d6f6>:
 f002a0a: e8bd 4002    	.word	#0xe8bd4002
 f002a0e: f04f 5200    	.word	#0xf04f5200
 f002a12: 6011         	str	r1, [r2]
 f002a14: 4770         	bx	lr
 f002a16: defe         	trap

0f002a18 <hopter::interrupt::default::irq_handler_trampoline::h6154bac8fc74b3c1>:
 f002a18: f04f 5c00    	.word	#0xf04f5c00
 f002a1c: f8dc c000    	.word	#0xf8dcc000
 f002a20: ebbd 0c0c    	.word	#0xebbd0c0c
 f002a24: f1bc 0f10    	.word	#0xf1bc0f10
 f002a28: da02         	bge	0xf002a30 <hopter::interrupt::default::irq_handler_trampoline::h6154bac8fc74b3c1+0x18> @ imm = #0x4
 f002a2a: dfff         	svc	#0xff
 f002a2c: 0004         	movs	r4, r0
 f002a2e: 0000         	movs	r0, r0
 f002a30: b5b0         	push	{r4, r5, r7, lr}
 f002a32: af02         	add	r7, sp, #0x8
 f002a34: f246 7418    	.word	#0xf2467418
 f002a38: 2200         	movs	r2, #0x0
 f002a3a: f2c2 0400    	.word	#0xf2c20400
 f002a3e: f104 0108    	.word	#0xf1040108
 f002a42: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002a46: e8d1 5f4f    	.word	#0xe8d15f4f
 f002a4a: e8c1 2f43    	.word	#0xe8c12f43
 f002a4e: 2b00         	cmp	r3, #0x0
 f002a50: d1f9         	bne	0xf002a46 <hopter::interrupt::default::irq_handler_trampoline::h6154bac8fc74b3c1+0x2e> @ imm = #-0xe
 f002a52: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002a56: 4780         	blx	r0
 f002a58: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002a5c: 2d00         	cmp	r5, #0x0
 f002a5e: bf18         	it	ne
 f002a60: 2501         	movne	r5, #0x1
 f002a62: 7225         	strb	r5, [r4, #0x8]
 f002a64: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002a68: bdb0         	pop	{r4, r5, r7, pc}
 f002a6a: 4601         	mov	r1, r0
 f002a6c: f246 6078    	.word	#0xf2466078
 f002a70: f2c2 0000    	.word	#0xf2c20000
 f002a74: 4281         	cmp	r1, r0
 f002a76: d004         	beq	0xf002a82 <hopter::interrupt::default::irq_handler_trampoline::h6154bac8fc74b3c1+0x6a> @ imm = #0x8
 f002a78: f104 0009    	.word	#0xf1040009
 f002a7c: f7fe fb31    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #-0x199e
 f002a80: e005         	b	0xf002a8e <hopter::interrupt::default::irq_handler_trampoline::h6154bac8fc74b3c1+0x76> @ imm = #0xa
 f002a82: 2000         	movs	r0, #0x0
 f002a84: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002a88: 71e0         	strb	r0, [r4, #0x7]
 f002a8a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002a8e: f3ef 8005    	.word	#0xf3ef8005
 f002a92: b130         	cbz	r0, 0xf002aa2 <hopter::interrupt::default::irq_handler_trampoline::h6154bac8fc74b3c1+0x8a> @ imm = #0xc
 f002a94: 2000         	movs	r0, #0x0
 f002a96: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002a9a: 7220         	strb	r0, [r4, #0x8]
 f002a9c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002aa0: e7da         	b	0xf002a58 <hopter::interrupt::default::irq_handler_trampoline::h6154bac8fc74b3c1+0x40> @ imm = #-0x4c
 f002aa2: 2000         	movs	r0, #0x0
 f002aa4: f7ff f931    	bl	0xf001d0a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b> @ imm = #-0xd9e
 f002aa8: e7d6         	b	0xf002a58 <hopter::interrupt::default::irq_handler_trampoline::h6154bac8fc74b3c1+0x40> @ imm = #-0x54

0f002aaa <hopter::interrupt::context_switch::pendsv_handler::h2993e78676b45afd>:
 f002aaa: 3013         	adds	r0, #0x13
 f002aac: bf08         	it	eq
 f002aae: f000 b801    	.word	#0xf000b801
 f002ab2: e7fe         	b	0xf002ab2 <hopter::interrupt::context_switch::pendsv_handler::h2993e78676b45afd+0x8> @ imm = #-0x4

0f002ab4 <schedule>:
 f002ab4: f04f 5c00    	.word	#0xf04f5c00
 f002ab8: f8dc c000    	.word	#0xf8dcc000
 f002abc: ebbd 0c0c    	.word	#0xebbd0c0c
 f002ac0: f1bc 0f30    	.word	#0xf1bc0f30
 f002ac4: da02         	bge	0xf002acc <schedule+0x18> @ imm = #0x4
 f002ac6: dfff         	svc	#0xff
 f002ac8: 000c         	movs	r4, r1
 f002aca: 0000         	movs	r0, r0
 f002acc: b5f0         	push	{r4, r5, r6, r7, lr}
 f002ace: af03         	add	r7, sp, #0xc
 f002ad0: e92d 0f00    	.word	#0xe92d0f00
 f002ad4: b083         	sub	sp, #0xc
 f002ad6: f246 7418    	.word	#0xf2467418
 f002ada: f2c2 0400    	.word	#0xf2c20400
 f002ade: 6be0         	ldr	r0, [r4, #0x3c]
 f002ae0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002ae4: b100         	cbz	r0, 0xf002ae8 <schedule+0x34> @ imm = #0x0
 f002ae6: e7fe         	b	0xf002ae6 <schedule+0x32> @ imm = #-0x4
 f002ae8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002aec: e854 0f0f    	.word	#0xe8540f0f
 f002af0: 3001         	adds	r0, #0x1
 f002af2: e844 010f    	.word	#0xe844010f
 f002af6: 2900         	cmp	r1, #0x0
 f002af8: d1f8         	bne	0xf002aec <schedule+0x38> @ imm = #-0x10
 f002afa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002afe: e854 0f14    	.word	#0xe8540f14
 f002b02: 1d01         	adds	r1, r0, #0x4
 f002b04: e844 1214    	.word	#0xe8441214
 f002b08: 2a00         	cmp	r2, #0x0
 f002b0a: d1f8         	bne	0xf002afe <schedule+0x4a> @ imm = #-0x10
 f002b0c: f64f 75fc    	.word	#0xf64f75fc
 f002b10: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002b14: f6c7 75ff    	.word	#0xf6c775ff
 f002b18: 42a8         	cmp	r0, r5
 f002b1a: d85b         	bhi	0xf002bd4 <schedule+0x120> @ imm = #0xb6
 f002b1c: 0780         	lsls	r0, r0, #0x1e
 f002b1e: d068         	beq	0xf002bf2 <schedule+0x13e> @ imm = #0xd0
 f002b20: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002b24: e854 0f14    	.word	#0xe8540f14
 f002b28: 3804         	subs	r0, #0x4
 f002b2a: e844 0114    	.word	#0xe8440114
 f002b2e: 2900         	cmp	r1, #0x0
 f002b30: d1f8         	bne	0xf002b24 <schedule+0x70> @ imm = #-0x10
 f002b32: bf10         	yield
 f002b34: e854 0f14    	.word	#0xe8540f14
 f002b38: 1d01         	adds	r1, r0, #0x4
 f002b3a: e844 1214    	.word	#0xe8441214
 f002b3e: 2a00         	cmp	r2, #0x0
 f002b40: d1f8         	bne	0xf002b34 <schedule+0x80> @ imm = #-0x10
 f002b42: 42a8         	cmp	r0, r5
 f002b44: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002b48: d844         	bhi	0xf002bd4 <schedule+0x120> @ imm = #0x88
 f002b4a: 0780         	lsls	r0, r0, #0x1e
 f002b4c: d051         	beq	0xf002bf2 <schedule+0x13e> @ imm = #0xa2
 f002b4e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002b52: e854 0f14    	.word	#0xe8540f14
 f002b56: 3804         	subs	r0, #0x4
 f002b58: e844 0114    	.word	#0xe8440114
 f002b5c: 2900         	cmp	r1, #0x0
 f002b5e: d1f8         	bne	0xf002b52 <schedule+0x9e> @ imm = #-0x10
 f002b60: bf10         	yield
 f002b62: e854 0f14    	.word	#0xe8540f14
 f002b66: 1d01         	adds	r1, r0, #0x4
 f002b68: e844 1214    	.word	#0xe8441214
 f002b6c: 2a00         	cmp	r2, #0x0
 f002b6e: d1f8         	bne	0xf002b62 <schedule+0xae> @ imm = #-0x10
 f002b70: 42a8         	cmp	r0, r5
 f002b72: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002b76: d82d         	bhi	0xf002bd4 <schedule+0x120> @ imm = #0x5a
 f002b78: 0780         	lsls	r0, r0, #0x1e
 f002b7a: d03a         	beq	0xf002bf2 <schedule+0x13e> @ imm = #0x74
 f002b7c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002b80: e854 0f14    	.word	#0xe8540f14
 f002b84: 3804         	subs	r0, #0x4
 f002b86: e844 0114    	.word	#0xe8440114
 f002b8a: 2900         	cmp	r1, #0x0
 f002b8c: d1f8         	bne	0xf002b80 <schedule+0xcc> @ imm = #-0x10
 f002b8e: bf10         	yield
 f002b90: e854 0f14    	.word	#0xe8540f14
 f002b94: 1d01         	adds	r1, r0, #0x4
 f002b96: e844 1214    	.word	#0xe8441214
 f002b9a: 2a00         	cmp	r2, #0x0
 f002b9c: d1f8         	bne	0xf002b90 <schedule+0xdc> @ imm = #-0x10
 f002b9e: 42a8         	cmp	r0, r5
 f002ba0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002ba4: d816         	bhi	0xf002bd4 <schedule+0x120> @ imm = #0x2c
 f002ba6: 0780         	lsls	r0, r0, #0x1e
 f002ba8: d023         	beq	0xf002bf2 <schedule+0x13e> @ imm = #0x46
 f002baa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002bae: e854 0f14    	.word	#0xe8540f14
 f002bb2: 3804         	subs	r0, #0x4
 f002bb4: e844 0114    	.word	#0xe8440114
 f002bb8: 2900         	cmp	r1, #0x0
 f002bba: d1f8         	bne	0xf002bae <schedule+0xfa> @ imm = #-0x10
 f002bbc: bf10         	yield
 f002bbe: e854 0f14    	.word	#0xe8540f14
 f002bc2: 1d01         	adds	r1, r0, #0x4
 f002bc4: e844 1214    	.word	#0xe8441214
 f002bc8: 2a00         	cmp	r2, #0x0
 f002bca: d1f8         	bne	0xf002bbe <schedule+0x10a> @ imm = #-0x10
 f002bcc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002bd0: 42a8         	cmp	r0, r5
 f002bd2: d9a3         	bls	0xf002b1c <schedule+0x68> @ imm = #-0xba
 f002bd4: e854 0f14    	.word	#0xe8540f14
 f002bd8: 3804         	subs	r0, #0x4
 f002bda: e844 0114    	.word	#0xe8440114
 f002bde: 2900         	cmp	r1, #0x0
 f002be0: d1f8         	bne	0xf002bd4 <schedule+0x120> @ imm = #-0x10
 f002be2: f245 6078    	.word	#0xf2456078
 f002be6: 212c         	movs	r1, #0x2c
 f002be8: f6c0 7000    	.word	#0xf6c07000
 f002bec: f7fd fd2d    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x25a6
 f002bf0: e35a         	b	0xf0032a8 <schedule+0x7f4> @ imm = #0x6b4
 f002bf2: 6d60         	ldr	r0, [r4, #0x54]
 f002bf4: b370         	cbz	r0, 0xf002c54 <schedule+0x1a0> @ imm = #0x5c
 f002bf6: 2100         	movs	r1, #0x0
 f002bf8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002bfc: 7601         	strb	r1, [r0, #0x18]
 f002bfe: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002c02: e854 0f14    	.word	#0xe8540f14
 f002c06: 3804         	subs	r0, #0x4
 f002c08: e844 0114    	.word	#0xe8440114
 f002c0c: 2900         	cmp	r1, #0x0
 f002c0e: d1f8         	bne	0xf002c02 <schedule+0x14e> @ imm = #-0x10
 f002c10: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002c14: e854 0f0f    	.word	#0xe8540f0f
 f002c18: 3801         	subs	r0, #0x1
 f002c1a: e844 010f    	.word	#0xe844010f
 f002c1e: 2900         	cmp	r1, #0x0
 f002c20: d1f8         	bne	0xf002c14 <schedule+0x160> @ imm = #-0x10
 f002c22: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002c26: 7960         	ldrb	r0, [r4, #0x5]
 f002c28: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002c2c: b1a8         	cbz	r0, 0xf002c5a <schedule+0x1a6> @ imm = #0x2a
 f002c2e: 6be0         	ldr	r0, [r4, #0x3c]
 f002c30: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002c34: b988         	cbnz	r0, 0xf002c5a <schedule+0x1a6> @ imm = #0x22
 f002c36: f3ef 8005    	.word	#0xf3ef8005
 f002c3a: b160         	cbz	r0, 0xf002c56 <schedule+0x1a2> @ imm = #0x18
 f002c3c: f3ef 8005    	.word	#0xf3ef8005
 f002c40: 280e         	cmp	r0, #0xe
 f002c42: bf1f         	itttt	ne
 f002c44: f64e 5004    	.word	#0xf64e5004
 f002c48: f2ce 0000    	.word	#0xf2ce0000
 f002c4c: f04f 5180    	.word	#0xf04f5180
 f002c50: 6001         	strne	r1, [r0]
 f002c52: e002         	b	0xf002c5a <schedule+0x1a6> @ imm = #0x4
 f002c54: e7fe         	b	0xf002c54 <schedule+0x1a0> @ imm = #-0x4
 f002c56: f7fe f9b0    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x1ca0
 f002c5a: f246 4998    	.word	#0xf2464998
 f002c5e: f2c2 0900    	.word	#0xf2c20900
 f002c62: f109 0691    	.word	#0xf1090691
 f002c66: e8d6 0f4f    	.word	#0xe8d60f4f
 f002c6a: b948         	cbnz	r0, 0xf002c80 <schedule+0x1cc> @ imm = #0x12
 f002c6c: 2001         	movs	r0, #0x1
 f002c6e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002c72: e8c6 0f41    	.word	#0xe8c60f41
 f002c76: b141         	cbz	r1, 0xf002c8a <schedule+0x1d6> @ imm = #0x10
 f002c78: e8d6 1f4f    	.word	#0xe8d61f4f
 f002c7c: 2900         	cmp	r1, #0x0
 f002c7e: d0f8         	beq	0xf002c72 <schedule+0x1be> @ imm = #-0x10
 f002c80: f3bf 8f2f    	.word	#0xf3bf8f2f
 f002c84: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002c88: e7fe         	b	0xf002c88 <schedule+0x1d4> @ imm = #-0x4
 f002c8a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002c8e: f899 0084    	.word	#0xf8990084
 f002c92: 2800         	cmp	r0, #0x0
 f002c94: f040 80c9    	.word	#0xf04080c9
 f002c98: f109 0a84    	.word	#0xf1090a84
 f002c9c: 2001         	movs	r0, #0x1
 f002c9e: e8da 1f4f    	.word	#0xe8da1f4f
 f002ca2: 2900         	cmp	r1, #0x0
 f002ca4: f040 80bf    	.word	#0xf04080bf
 f002ca8: e8ca 0f41    	.word	#0xe8ca0f41
 f002cac: 2900         	cmp	r1, #0x0
 f002cae: d1f6         	bne	0xf002c9e <schedule+0x1ea> @ imm = #-0x14
 f002cb0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002cb4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002cb8: e854 0f0f    	.word	#0xe8540f0f
 f002cbc: 3001         	adds	r0, #0x1
 f002cbe: e844 010f    	.word	#0xe844010f
 f002cc2: 2900         	cmp	r1, #0x0
 f002cc4: d1f8         	bne	0xf002cb8 <schedule+0x204> @ imm = #-0x10
 f002cc6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002cca: e854 0f14    	.word	#0xe8540f14
 f002cce: 1d01         	adds	r1, r0, #0x4
 f002cd0: e844 1214    	.word	#0xe8441214
 f002cd4: 2a00         	cmp	r2, #0x0
 f002cd6: d1f8         	bne	0xf002cca <schedule+0x216> @ imm = #-0x10
 f002cd8: e010         	b	0xf002cfc <schedule+0x248> @ imm = #0x20
 f002cda: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002cde: e854 0f14    	.word	#0xe8540f14
 f002ce2: 3804         	subs	r0, #0x4
 f002ce4: e844 0114    	.word	#0xe8440114
 f002ce8: 2900         	cmp	r1, #0x0
 f002cea: d1f8         	bne	0xf002cde <schedule+0x22a> @ imm = #-0x10
 f002cec: bf10         	yield
 f002cee: e854 0f14    	.word	#0xe8540f14
 f002cf2: 1d01         	adds	r1, r0, #0x4
 f002cf4: e844 1214    	.word	#0xe8441214
 f002cf8: 2a00         	cmp	r2, #0x0
 f002cfa: d1f8         	bne	0xf002cee <schedule+0x23a> @ imm = #-0x10
 f002cfc: 42a8         	cmp	r0, r5
 f002cfe: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002d02: f200 8081    	.word	#0xf2008081
 f002d06: 0780         	lsls	r0, r0, #0x1e
 f002d08: d044         	beq	0xf002d94 <schedule+0x2e0> @ imm = #0x88
 f002d0a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002d0e: e854 0f14    	.word	#0xe8540f14
 f002d12: 3804         	subs	r0, #0x4
 f002d14: e844 0114    	.word	#0xe8440114
 f002d18: 2900         	cmp	r1, #0x0
 f002d1a: d1f8         	bne	0xf002d0e <schedule+0x25a> @ imm = #-0x10
 f002d1c: bf10         	yield
 f002d1e: e854 0f14    	.word	#0xe8540f14
 f002d22: 1d01         	adds	r1, r0, #0x4
 f002d24: e844 1214    	.word	#0xe8441214
 f002d28: 2a00         	cmp	r2, #0x0
 f002d2a: d1f8         	bne	0xf002d1e <schedule+0x26a> @ imm = #-0x10
 f002d2c: 42a8         	cmp	r0, r5
 f002d2e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002d32: d869         	bhi	0xf002e08 <schedule+0x354> @ imm = #0xd2
 f002d34: 0780         	lsls	r0, r0, #0x1e
 f002d36: d02d         	beq	0xf002d94 <schedule+0x2e0> @ imm = #0x5a
 f002d38: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002d3c: e854 0f14    	.word	#0xe8540f14
 f002d40: 3804         	subs	r0, #0x4
 f002d42: e844 0114    	.word	#0xe8440114
 f002d46: 2900         	cmp	r1, #0x0
 f002d48: d1f8         	bne	0xf002d3c <schedule+0x288> @ imm = #-0x10
 f002d4a: bf10         	yield
 f002d4c: e854 0f14    	.word	#0xe8540f14
 f002d50: 1d01         	adds	r1, r0, #0x4
 f002d52: e844 1214    	.word	#0xe8441214
 f002d56: 2a00         	cmp	r2, #0x0
 f002d58: d1f8         	bne	0xf002d4c <schedule+0x298> @ imm = #-0x10
 f002d5a: 42a8         	cmp	r0, r5
 f002d5c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002d60: d852         	bhi	0xf002e08 <schedule+0x354> @ imm = #0xa4
 f002d62: 0780         	lsls	r0, r0, #0x1e
 f002d64: d016         	beq	0xf002d94 <schedule+0x2e0> @ imm = #0x2c
 f002d66: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002d6a: e854 0f14    	.word	#0xe8540f14
 f002d6e: 3804         	subs	r0, #0x4
 f002d70: e844 0114    	.word	#0xe8440114
 f002d74: 2900         	cmp	r1, #0x0
 f002d76: d1f8         	bne	0xf002d6a <schedule+0x2b6> @ imm = #-0x10
 f002d78: bf10         	yield
 f002d7a: e854 0f14    	.word	#0xe8540f14
 f002d7e: 1d01         	adds	r1, r0, #0x4
 f002d80: e844 1214    	.word	#0xe8441214
 f002d84: 2a00         	cmp	r2, #0x0
 f002d86: d1f8         	bne	0xf002d7a <schedule+0x2c6> @ imm = #-0x10
 f002d88: 42a8         	cmp	r0, r5
 f002d8a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002d8e: d83b         	bhi	0xf002e08 <schedule+0x354> @ imm = #0x76
 f002d90: 0780         	lsls	r0, r0, #0x1e
 f002d92: d1a2         	bne	0xf002cda <schedule+0x226> @ imm = #-0xbc
 f002d94: 6d60         	ldr	r0, [r4, #0x54]
 f002d96: b3b0         	cbz	r0, 0xf002e06 <schedule+0x352> @ imm = #0x6c
 f002d98: e850 1f00    	.word	#0xe8501f00
 f002d9c: 1c4a         	adds	r2, r1, #0x1
 f002d9e: e840 2300    	.word	#0xe8402300
 f002da2: 2b00         	cmp	r3, #0x0
 f002da4: d1f8         	bne	0xf002d98 <schedule+0x2e4> @ imm = #-0x10
 f002da6: f1b1 3fff    	.word	#0xf1b13fff
 f002daa: f340 827e    	.word	#0xf340827e
 f002dae: 9001         	str	r0, [sp, #0x4]
 f002db0: f890 00cd    	.word	#0xf89000cd
 f002db4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002db8: 2803         	cmp	r0, #0x3
 f002dba: d137         	bne	0xf002e2c <schedule+0x378> @ imm = #0x6e
 f002dbc: 9801         	ldr	r0, [sp, #0x4]
 f002dbe: 2102         	movs	r1, #0x2
 f002dc0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002dc4: 2200         	movs	r2, #0x0
 f002dc6: f880 10cd    	.word	#0xf88010cd
 f002dca: f100 0110    	.word	#0xf1000110
 f002dce: e851 3f00    	.word	#0xe8513f00
 f002dd2: 2b01         	cmp	r3, #0x1
 f002dd4: f040 824e    	.word	#0xf040824e
 f002dd8: e841 2300    	.word	#0xe8412300
 f002ddc: 2b00         	cmp	r3, #0x0
 f002dde: d1f6         	bne	0xf002dce <schedule+0x31a> @ imm = #-0x14
 f002de0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002de4: 2300         	movs	r3, #0x0
 f002de6: f8d9 208c    	.word	#0xf8d9208c
 f002dea: 2a00         	cmp	r2, #0x0
 f002dec: bf18         	it	ne
 f002dee: 6011         	strne	r1, [r2]
 f002df0: e9c0 3204    	.word	#0xe9c03204
 f002df4: f8d9 0088    	.word	#0xf8d90088
 f002df8: f8c9 108c    	.word	#0xf8c9108c
 f002dfc: 2800         	cmp	r0, #0x0
 f002dfe: bf08         	it	eq
 f002e00: f8c9 1088    	.word	#0xf8c91088
 f002e04: e023         	b	0xf002e4e <schedule+0x39a> @ imm = #0x46
 f002e06: e7fe         	b	0xf002e06 <schedule+0x352> @ imm = #-0x4
 f002e08: e854 0f14    	.word	#0xe8540f14
 f002e0c: 3804         	subs	r0, #0x4
 f002e0e: e844 0114    	.word	#0xe8440114
 f002e12: 2900         	cmp	r1, #0x0
 f002e14: d1f8         	bne	0xf002e08 <schedule+0x354> @ imm = #-0x10
 f002e16: f245 6078    	.word	#0xf2456078
 f002e1a: 212c         	movs	r1, #0x2c
 f002e1c: f6c0 7000    	.word	#0xf6c07000
 f002e20: f7fd fc13    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x27da
 f002e24: e240         	b	0xf0032a8 <schedule+0x7f4> @ imm = #0x480
 f002e26: f3bf 8f2f    	.word	#0xf3bf8f2f
 f002e2a: e7fe         	b	0xf002e2a <schedule+0x376> @ imm = #-0x4
 f002e2c: 9801         	ldr	r0, [sp, #0x4]
 f002e2e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002e32: e850 1f00    	.word	#0xe8501f00
 f002e36: 1e4a         	subs	r2, r1, #0x1
 f002e38: e840 2300    	.word	#0xe8402300
 f002e3c: 2b00         	cmp	r3, #0x0
 f002e3e: d1f8         	bne	0xf002e32 <schedule+0x37e> @ imm = #-0x10
 f002e40: 2901         	cmp	r1, #0x1
 f002e42: d104         	bne	0xf002e4e <schedule+0x39a> @ imm = #0x8
 f002e44: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002e48: a801         	add	r0, sp, #0x4
 f002e4a: f7fe f8b9    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x1e8e
 f002e4e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002e52: e854 0f14    	.word	#0xe8540f14
 f002e56: 3804         	subs	r0, #0x4
 f002e58: e844 0114    	.word	#0xe8440114
 f002e5c: 2900         	cmp	r1, #0x0
 f002e5e: d1f8         	bne	0xf002e52 <schedule+0x39e> @ imm = #-0x10
 f002e60: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002e64: e854 0f0f    	.word	#0xe8540f0f
 f002e68: 3801         	subs	r0, #0x1
 f002e6a: e844 010f    	.word	#0xe844010f
 f002e6e: 2900         	cmp	r1, #0x0
 f002e70: d1f8         	bne	0xf002e64 <schedule+0x3b0> @ imm = #-0x10
 f002e72: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002e76: 7960         	ldrb	r0, [r4, #0x5]
 f002e78: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002e7c: b1a0         	cbz	r0, 0xf002ea8 <schedule+0x3f4> @ imm = #0x28
 f002e7e: 6be0         	ldr	r0, [r4, #0x3c]
 f002e80: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002e84: b980         	cbnz	r0, 0xf002ea8 <schedule+0x3f4> @ imm = #0x20
 f002e86: f3ef 8005    	.word	#0xf3ef8005
 f002e8a: b158         	cbz	r0, 0xf002ea4 <schedule+0x3f0> @ imm = #0x16
 f002e8c: f3ef 8005    	.word	#0xf3ef8005
 f002e90: 280e         	cmp	r0, #0xe
 f002e92: bf1f         	itttt	ne
 f002e94: f64e 5004    	.word	#0xf64e5004
 f002e98: f2ce 0000    	.word	#0xf2ce0000
 f002e9c: f04f 5180    	.word	#0xf04f5180
 f002ea0: 6001         	strne	r1, [r0]
 f002ea2: e001         	b	0xf002ea8 <schedule+0x3f4> @ imm = #0x2
 f002ea4: f7fe f889    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x1eee
 f002ea8: f8d9 1088    	.word	#0xf8d91088
 f002eac: 2900         	cmp	r1, #0x0
 f002eae: f000 80e8    	.word	#0xf00080e8
 f002eb2: f8d1 80b4    	.word	#0xf8d180b4
 f002eb6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002eba: 6809         	ldr	r1, [r1]
 f002ebc: 2900         	cmp	r1, #0x0
 f002ebe: d059         	beq	0xf002f74 <schedule+0x4c0> @ imm = #0xb2
 f002ec0: ea4f 2c18    	.word	#0xea4f2c18
 f002ec4: 2301         	movs	r3, #0x1
 f002ec6: f04f 0e00    	.word	#0xf04f0e00
 f002eca: f8d1 50b4    	.word	#0xf8d150b4
 f002ece: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002ed2: f015 0ffe    	.word	#0xf0150ffe
 f002ed6: d14b         	bne	0xf002f70 <schedule+0x4bc> @ imm = #0x96
 f002ed8: fa5f f288    	.word	#0xfa5ff288
 f002edc: 2a02         	cmp	r2, #0x2
 f002ede: d248         	bhs	0xf002f72 <schedule+0x4be> @ imm = #0x90
 f002ee0: 0a2a         	lsrs	r2, r5, #0x8
 f002ee2: fa5f f08c    	.word	#0xfa5ff08c
 f002ee6: b2d2         	uxtb	r2, r2
 f002ee8: 4290         	cmp	r0, r2
 f002eea: bf84         	itt	hi
 f002eec: 469e         	movhi	lr, r3
 f002eee: 46a8         	movhi	r8, r5
 f002ef0: 6809         	ldr	r1, [r1]
 f002ef2: f103 0301    	.word	#0xf1030301
 f002ef6: bf38         	it	lo
 f002ef8: 4602         	movlo	r2, r0
 f002efa: 2900         	cmp	r1, #0x0
 f002efc: 4694         	mov	r12, r2
 f002efe: d1e4         	bne	0xf002eca <schedule+0x416> @ imm = #-0x38
 f002f00: f8d9 1088    	.word	#0xf8d91088
 f002f04: f1be 0f00    	.word	#0xf1be0f00
 f002f08: f000 80b7    	.word	#0xf00080b7
 f002f0c: f00e 0303    	.word	#0xf00e0303
 f002f10: f1be 0f04    	.word	#0xf1be0f04
 f002f14: 4608         	mov	r0, r1
 f002f16: d316         	blo	0xf002f46 <schedule+0x492> @ imm = #0x2c
 f002f18: f02e 0203    	.word	#0xf02e0203
 f002f1c: f109 0588    	.word	#0xf1090588
 f002f20: 4608         	mov	r0, r1
 f002f22: 2800         	cmp	r0, #0x0
 f002f24: bf08         	it	eq
 f002f26: 4628         	moveq	r0, r5
 f002f28: 6800         	ldr	r0, [r0]
 f002f2a: 2800         	cmp	r0, #0x0
 f002f2c: bf08         	it	eq
 f002f2e: 4628         	moveq	r0, r5
 f002f30: 6800         	ldr	r0, [r0]
 f002f32: 2800         	cmp	r0, #0x0
 f002f34: bf08         	it	eq
 f002f36: 4628         	moveq	r0, r5
 f002f38: 6800         	ldr	r0, [r0]
 f002f3a: 2800         	cmp	r0, #0x0
 f002f3c: bf08         	it	eq
 f002f3e: 4628         	moveq	r0, r5
 f002f40: 6800         	ldr	r0, [r0]
 f002f42: 3a04         	subs	r2, #0x4
 f002f44: d1ed         	bne	0xf002f22 <schedule+0x46e> @ imm = #-0x26
 f002f46: b1c3         	cbz	r3, 0xf002f7a <schedule+0x4c6> @ imm = #0x30
 f002f48: f109 0288    	.word	#0xf1090288
 f002f4c: 2800         	cmp	r0, #0x0
 f002f4e: bf08         	it	eq
 f002f50: 4610         	moveq	r0, r2
 f002f52: 2b01         	cmp	r3, #0x1
 f002f54: 6800         	ldr	r0, [r0]
 f002f56: d010         	beq	0xf002f7a <schedule+0x4c6> @ imm = #0x20
 f002f58: 2800         	cmp	r0, #0x0
 f002f5a: bf08         	it	eq
 f002f5c: 4610         	moveq	r0, r2
 f002f5e: 6800         	ldr	r0, [r0]
 f002f60: 2b02         	cmp	r3, #0x2
 f002f62: d00a         	beq	0xf002f7a <schedule+0x4c6> @ imm = #0x14
 f002f64: 2800         	cmp	r0, #0x0
 f002f66: bf18         	it	ne
 f002f68: 4602         	movne	r2, r0
 f002f6a: 6810         	ldr	r0, [r2]
 f002f6c: b940         	cbnz	r0, 0xf002f80 <schedule+0x4cc> @ imm = #0x10
 f002f6e: e088         	b	0xf003082 <schedule+0x5ce> @ imm = #0x110
 f002f70: e7fe         	b	0xf002f70 <schedule+0x4bc> @ imm = #-0x4
 f002f72: e7fe         	b	0xf002f72 <schedule+0x4be> @ imm = #-0x4
 f002f74: f8d9 1088    	.word	#0xf8d91088
 f002f78: 4608         	mov	r0, r1
 f002f7a: 2800         	cmp	r0, #0x0
 f002f7c: f000 8081    	.word	#0xf0008081
 f002f80: 4281         	cmp	r1, r0
 f002f82: bf04         	itt	eq
 f002f84: 6809         	ldreq	r1, [r1]
 f002f86: f8c9 1088    	.word	#0xf8c91088
 f002f8a: f8d9 208c    	.word	#0xf8d9208c
 f002f8e: 6841         	ldr	r1, [r0, #0x4]
 f002f90: 4282         	cmp	r2, r0
 f002f92: bf08         	it	eq
 f002f94: f8c9 108c    	.word	#0xf8c9108c
 f002f98: 6802         	ldr	r2, [r0]
 f002f9a: 2a00         	cmp	r2, #0x0
 f002f9c: bf18         	it	ne
 f002f9e: 6051         	strne	r1, [r2, #0x4]
 f002fa0: 2900         	cmp	r1, #0x0
 f002fa2: bf18         	it	ne
 f002fa4: 600a         	strne	r2, [r1]
 f002fa6: 2101         	movs	r1, #0x1
 f002fa8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002fac: 6001         	str	r1, [r0]
 f002fae: f1a0 0110    	.word	#0xf1a00110
 f002fb2: 9101         	str	r1, [sp, #0x4]
 f002fb4: 2103         	movs	r1, #0x3
 f002fb6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002fba: f880 10bd    	.word	#0xf88010bd
 f002fbe: f890 50bc    	.word	#0xf89050bc
 f002fc2: 1ce1         	adds	r1, r4, #0x3
 f002fc4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002fc8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002fcc: e8d1 0f4f    	.word	#0xe8d10f4f
 f002fd0: e8c1 5f42    	.word	#0xe8c15f42
 f002fd4: 2a00         	cmp	r2, #0x0
 f002fd6: d1f9         	bne	0xf002fcc <schedule+0x518> @ imm = #-0xe
 f002fd8: f246 4388    	.word	#0xf2464388
 f002fdc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002fe0: f2c2 0300    	.word	#0xf2c20300
 f002fe4: 7819         	ldrb	r1, [r3]
 f002fe6: b101         	cbz	r1, 0xf002fea <schedule+0x536> @ imm = #0x0
 f002fe8: e7fe         	b	0xf002fe8 <schedule+0x534> @ imm = #-0x4
 f002fea: f3bf 8f5f    	.word	#0xf3bf8f5f
 f002fee: e854 1f0f    	.word	#0xe8541f0f
 f002ff2: 3101         	adds	r1, #0x1
 f002ff4: e844 120f    	.word	#0xe844120f
 f002ff8: 2a00         	cmp	r2, #0x0
 f002ffa: d1f8         	bne	0xf002fee <schedule+0x53a> @ imm = #-0x10
 f002ffc: 2101         	movs	r1, #0x1
 f002ffe: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003002: e8d3 2f4f    	.word	#0xe8d32f4f
 f003006: 2a00         	cmp	r2, #0x0
 f003008: d13c         	bne	0xf003084 <schedule+0x5d0> @ imm = #0x78
 f00300a: e8c3 1f42    	.word	#0xe8c31f42
 f00300e: 2a00         	cmp	r2, #0x0
 f003010: d1f7         	bne	0xf003002 <schedule+0x54e> @ imm = #-0x12
 f003012: 2800         	cmp	r0, #0x0
 f003014: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003018: d05a         	beq	0xf0030d0 <schedule+0x61c> @ imm = #0xb4
 f00301a: f246 4b88    	.word	#0xf2464b88
 f00301e: 2d00         	cmp	r5, #0x0
 f003020: f2c2 0b00    	.word	#0xf2c20b00
 f003024: d06d         	beq	0xf003102 <schedule+0x64e> @ imm = #0xda
 f003026: 2000         	movs	r0, #0x0
 f003028: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00302c: f88b 0000    	.word	#0xf88b0000
 f003030: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003034: e854 0f0f    	.word	#0xe8540f0f
 f003038: 3801         	subs	r0, #0x1
 f00303a: e844 010f    	.word	#0xe844010f
 f00303e: 2900         	cmp	r1, #0x0
 f003040: d1f8         	bne	0xf003034 <schedule+0x580> @ imm = #-0x10
 f003042: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003046: 7960         	ldrb	r0, [r4, #0x5]
 f003048: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00304c: 2800         	cmp	r0, #0x0
 f00304e: d071         	beq	0xf003134 <schedule+0x680> @ imm = #0xe2
 f003050: 6be0         	ldr	r0, [r4, #0x3c]
 f003052: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003056: 2800         	cmp	r0, #0x0
 f003058: d16c         	bne	0xf003134 <schedule+0x680> @ imm = #0xd8
 f00305a: f3ef 8005    	.word	#0xf3ef8005
 f00305e: 2800         	cmp	r0, #0x0
 f003060: d066         	beq	0xf003130 <schedule+0x67c> @ imm = #0xcc
 f003062: f3ef 8005    	.word	#0xf3ef8005
 f003066: 280e         	cmp	r0, #0xe
 f003068: bf1f         	itttt	ne
 f00306a: f64e 5004    	.word	#0xf64e5004
 f00306e: f2ce 0000    	.word	#0xf2ce0000
 f003072: f04f 5180    	.word	#0xf04f5180
 f003076: 6001         	strne	r1, [r0]
 f003078: e05c         	b	0xf003134 <schedule+0x680> @ imm = #0xb8
 f00307a: 4608         	mov	r0, r1
 f00307c: 2800         	cmp	r0, #0x0
 f00307e: f47f af7f    	.word	#0xf47faf7f
 f003082: e7fe         	b	0xf003082 <schedule+0x5ce> @ imm = #-0x4
 f003084: f3bf 8f2f    	.word	#0xf3bf8f2f
 f003088: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00308c: e854 0f0f    	.word	#0xe8540f0f
 f003090: 3801         	subs	r0, #0x1
 f003092: e844 010f    	.word	#0xe844010f
 f003096: 2900         	cmp	r1, #0x0
 f003098: d1f8         	bne	0xf00308c <schedule+0x5d8> @ imm = #-0x10
 f00309a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00309e: 7960         	ldrb	r0, [r4, #0x5]
 f0030a0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0030a4: 2800         	cmp	r0, #0x0
 f0030a6: d09f         	beq	0xf002fe8 <schedule+0x534> @ imm = #-0xc2
 f0030a8: 6be0         	ldr	r0, [r4, #0x3c]
 f0030aa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0030ae: 2800         	cmp	r0, #0x0
 f0030b0: d19a         	bne	0xf002fe8 <schedule+0x534> @ imm = #-0xcc
 f0030b2: f3ef 8005    	.word	#0xf3ef8005
 f0030b6: b3c0         	cbz	r0, 0xf00312a <schedule+0x676> @ imm = #0x70
 f0030b8: f3ef 8005    	.word	#0xf3ef8005
 f0030bc: 280e         	cmp	r0, #0xe
 f0030be: bf1f         	itttt	ne
 f0030c0: f64e 5004    	.word	#0xf64e5004
 f0030c4: f2ce 0000    	.word	#0xf2ce0000
 f0030c8: f04f 5180    	.word	#0xf04f5180
 f0030cc: 6001         	strne	r1, [r0]
 f0030ce: e78b         	b	0xf002fe8 <schedule+0x534> @ imm = #-0xea
 f0030d0: f246 4088    	.word	#0xf2464088
 f0030d4: f2c2 0000    	.word	#0xf2c20000
 f0030d8: f8d0 8004    	.word	#0xf8d08004
 f0030dc: 68c0         	ldr	r0, [r0, #0xc]
 f0030de: ea4f 0bc0    	.word	#0xea4f0bc0
 f0030e2: f1bb 0f00    	.word	#0xf1bb0f00
 f0030e6: d098         	beq	0xf00301a <schedule+0x566> @ imm = #-0xd0
 f0030e8: e8f8 0102    	.word	#0xe8f80102
 f0030ec: f1ab 0b08    	.word	#0xf1ab0b08
 f0030f0: 688a         	ldr	r2, [r1, #0x8]
 f0030f2: 6909         	ldr	r1, [r1, #0x10]
 f0030f4: 3a01         	subs	r2, #0x1
 f0030f6: f022 0207    	.word	#0xf0220207
 f0030fa: 4410         	add	r0, r2
 f0030fc: 3008         	adds	r0, #0x8
 f0030fe: 4788         	blx	r1
 f003100: e7ef         	b	0xf0030e2 <schedule+0x62e> @ imm = #-0x22
 f003102: f8db 000c    	.word	#0xf8db000c
 f003106: f8db 8004    	.word	#0xf8db8004
 f00310a: 00c5         	lsls	r5, r0, #0x3
 f00310c: 2d00         	cmp	r5, #0x0
 f00310e: f43f af8a    	.word	#0xf43faf8a
 f003112: e8f8 0102    	.word	#0xe8f80102
 f003116: 3d08         	subs	r5, #0x8
 f003118: e9d1 1202    	.word	#0xe9d11202
 f00311c: 3901         	subs	r1, #0x1
 f00311e: f021 0107    	.word	#0xf0210107
 f003122: 4408         	add	r0, r1
 f003124: 3008         	adds	r0, #0x8
 f003126: 4790         	blx	r2
 f003128: e7f0         	b	0xf00310c <schedule+0x658> @ imm = #-0x20
 f00312a: f7fd ff46    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x2174
 f00312e: e75b         	b	0xf002fe8 <schedule+0x534> @ imm = #-0x14a
 f003130: f7fd ff43    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x217a
 f003134: 9801         	ldr	r0, [sp, #0x4]
 f003136: e854 1f14    	.word	#0xe8541f14
 f00313a: b111         	cbz	r1, 0xf003142 <schedule+0x68e> @ imm = #0x4
 f00313c: f3bf 8f2f    	.word	#0xf3bf8f2f
 f003140: e003         	b	0xf00314a <schedule+0x696> @ imm = #0x6
 f003142: 2101         	movs	r1, #0x1
 f003144: e844 1214    	.word	#0xe8441214
 f003148: b352         	cbz	r2, 0xf0031a0 <schedule+0x6ec> @ imm = #0x54
 f00314a: 2101         	movs	r1, #0x1
 f00314c: e001         	b	0xf003152 <schedule+0x69e> @ imm = #0x2
 f00314e: f3bf 8f2f    	.word	#0xf3bf8f2f
 f003152: bf10         	yield
 f003154: e854 2f14    	.word	#0xe8542f14
 f003158: b112         	cbz	r2, 0xf003160 <schedule+0x6ac> @ imm = #0x4
 f00315a: f3bf 8f2f    	.word	#0xf3bf8f2f
 f00315e: e002         	b	0xf003166 <schedule+0x6b2> @ imm = #0x4
 f003160: e844 1214    	.word	#0xe8441214
 f003164: b1e2         	cbz	r2, 0xf0031a0 <schedule+0x6ec> @ imm = #0x38
 f003166: bf10         	yield
 f003168: e854 2f14    	.word	#0xe8542f14
 f00316c: b112         	cbz	r2, 0xf003174 <schedule+0x6c0> @ imm = #0x4
 f00316e: f3bf 8f2f    	.word	#0xf3bf8f2f
 f003172: e002         	b	0xf00317a <schedule+0x6c6> @ imm = #0x4
 f003174: e844 1214    	.word	#0xe8441214
 f003178: b192         	cbz	r2, 0xf0031a0 <schedule+0x6ec> @ imm = #0x24
 f00317a: bf10         	yield
 f00317c: e854 2f14    	.word	#0xe8542f14
 f003180: b112         	cbz	r2, 0xf003188 <schedule+0x6d4> @ imm = #0x4
 f003182: f3bf 8f2f    	.word	#0xf3bf8f2f
 f003186: e002         	b	0xf00318e <schedule+0x6da> @ imm = #0x4
 f003188: e844 1214    	.word	#0xe8441214
 f00318c: b142         	cbz	r2, 0xf0031a0 <schedule+0x6ec> @ imm = #0x10
 f00318e: bf10         	yield
 f003190: e854 2f14    	.word	#0xe8542f14
 f003194: 2a00         	cmp	r2, #0x0
 f003196: d1da         	bne	0xf00314e <schedule+0x69a> @ imm = #-0x4c
 f003198: e844 1214    	.word	#0xe8441214
 f00319c: 2a00         	cmp	r2, #0x0
 f00319e: d1d8         	bne	0xf003152 <schedule+0x69e> @ imm = #-0x50
 f0031a0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0031a4: 6d61         	ldr	r1, [r4, #0x54]
 f0031a6: 6560         	str	r0, [r4, #0x54]
 f0031a8: 9102         	str	r1, [sp, #0x8]
 f0031aa: b179         	cbz	r1, 0xf0031cc <schedule+0x718> @ imm = #0x1e
 f0031ac: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0031b0: e851 0f00    	.word	#0xe8510f00
 f0031b4: 1e42         	subs	r2, r0, #0x1
 f0031b6: e841 2300    	.word	#0xe8412300
 f0031ba: 2b00         	cmp	r3, #0x0
 f0031bc: d1f8         	bne	0xf0031b0 <schedule+0x6fc> @ imm = #-0x10
 f0031be: 2801         	cmp	r0, #0x1
 f0031c0: d104         	bne	0xf0031cc <schedule+0x718> @ imm = #0x8
 f0031c2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0031c6: a802         	add	r0, sp, #0x8
 f0031c8: f7fd fefa    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x220c
 f0031cc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0031d0: e854 0f14    	.word	#0xe8540f14
 f0031d4: f020 0003    	.word	#0xf0200003
 f0031d8: e844 0114    	.word	#0xe8440114
 f0031dc: 2900         	cmp	r1, #0x0
 f0031de: d1f7         	bne	0xf0031d0 <schedule+0x71c> @ imm = #-0x12
 f0031e0: f7fd fdbd    	bl	0xf000d5e <hopter::schedule::current_task::lock_cur_task_regs::h0975465bf3cff714> @ imm = #-0x2486
 f0031e4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0031e8: 63a0         	str	r0, [r4, #0x38]
 f0031ea: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0031ee: 2500         	movs	r5, #0x0
 f0031f0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0031f4: 7165         	strb	r5, [r4, #0x5]
 f0031f6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0031fa: 4680         	mov	r8, r0
 f0031fc: 2401         	movs	r4, #0x1
 f0031fe: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003202: f889 5084    	.word	#0xf8895084
 f003206: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00320a: f109 0190    	.word	#0xf1090190
 f00320e: e8d1 0f4f    	.word	#0xe8d10f4f
 f003212: e8c1 5f42    	.word	#0xe8c15f42
 f003216: 2a00         	cmp	r2, #0x0
 f003218: d1f7         	bne	0xf00320a <schedule+0x756> @ imm = #-0x12
 f00321a: 2800         	cmp	r0, #0x0
 f00321c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003220: bf1e         	ittt	ne
 f003222: 4648         	movne	r0, r9
 f003224: 4651         	movne	r1, r10
 f003226: f7fe fb7d    	blne	0xf001924 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb> @ imm = #-0x1906
 f00322a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00322e: f889 5091    	.word	#0xf8895091
 f003232: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003236: f899 0090    	.word	#0xf8990090
 f00323a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00323e: b1a0         	cbz	r0, 0xf00326a <schedule+0x7b6> @ imm = #0x28
 f003240: e8d6 0f4f    	.word	#0xe8d60f4f
 f003244: b960         	cbnz	r0, 0xf003260 <schedule+0x7ac> @ imm = #0x18
 f003246: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00324a: e8c6 4f40    	.word	#0xe8c64f40
 f00324e: b120         	cbz	r0, 0xf00325a <schedule+0x7a6> @ imm = #0x8
 f003250: e8d6 0f4f    	.word	#0xe8d60f4f
 f003254: 2800         	cmp	r0, #0x0
 f003256: d0f8         	beq	0xf00324a <schedule+0x796> @ imm = #-0x10
 f003258: e002         	b	0xf003260 <schedule+0x7ac> @ imm = #0x4
 f00325a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00325e: e7d2         	b	0xf003206 <schedule+0x752> @ imm = #-0x5c
 f003260: f3bf 8f2f    	.word	#0xf3bf8f2f
 f003264: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003268: e7fe         	b	0xf003268 <schedule+0x7b4> @ imm = #-0x4
 f00326a: 4640         	mov	r0, r8
 f00326c: b003         	add	sp, #0xc
 f00326e: e8bd 0f00    	.word	#0xe8bd0f00
 f003272: bdf0         	pop	{r4, r5, r6, r7, pc}
 f003274: f3bf 8f2f    	.word	#0xf3bf8f2f
 f003278: 9002         	str	r0, [sp, #0x8]
 f00327a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00327e: e850 1f00    	.word	#0xe8501f00
 f003282: 1e4a         	subs	r2, r1, #0x1
 f003284: e840 2300    	.word	#0xe8402300
 f003288: 2b00         	cmp	r3, #0x0
 f00328a: d1f8         	bne	0xf00327e <schedule+0x7ca> @ imm = #-0x10
 f00328c: 2901         	cmp	r1, #0x1
 f00328e: d104         	bne	0xf00329a <schedule+0x7e6> @ imm = #0x8
 f003290: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003294: a802         	add	r0, sp, #0x8
 f003296: f7fd fe93    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x22da
 f00329a: f245 6044    	.word	#0xf2456044
 f00329e: 2134         	movs	r1, #0x34
 f0032a0: f6c0 7000    	.word	#0xf6c07000
 f0032a4: f7fd f9d1    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x2c5e
 f0032a8: defe         	trap
 f0032aa: defe         	trap
 f0032ac: defe         	trap
 f0032ae: 4680         	mov	r8, r0
 f0032b0: e02c         	b	0xf00330c <schedule+0x858> @ imm = #0x58
 f0032b2: 4680         	mov	r8, r0
 f0032b4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0032b8: e854 0f14    	.word	#0xe8540f14
 f0032bc: f020 0003    	.word	#0xf0200003
 f0032c0: e844 0114    	.word	#0xe8440114
 f0032c4: 2900         	cmp	r1, #0x0
 f0032c6: d1f7         	bne	0xf0032b8 <schedule+0x804> @ imm = #-0x12
 f0032c8: e066         	b	0xf003398 <schedule+0x8e4> @ imm = #0xcc
 f0032ca: 4680         	mov	r8, r0
 f0032cc: e064         	b	0xf003398 <schedule+0x8e4> @ imm = #0xc8
 f0032ce: 4680         	mov	r8, r0
 f0032d0: e062         	b	0xf003398 <schedule+0x8e4> @ imm = #0xc4
 f0032d2: e7ff         	b	0xf0032d4 <schedule+0x820> @ imm = #-0x2
 f0032d4: f246 4188    	.word	#0xf2464188
 f0032d8: 4680         	mov	r8, r0
 f0032da: 2000         	movs	r0, #0x0
 f0032dc: f2c2 0100    	.word	#0xf2c20100
 f0032e0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0032e4: 7008         	strb	r0, [r1]
 f0032e6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0032ea: e854 0f0f    	.word	#0xe8540f0f
 f0032ee: 3801         	subs	r0, #0x1
 f0032f0: e844 010f    	.word	#0xe844010f
 f0032f4: 2900         	cmp	r1, #0x0
 f0032f6: d1f8         	bne	0xf0032ea <schedule+0x836> @ imm = #-0x10
 f0032f8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0032fc: 7960         	ldrb	r0, [r4, #0x5]
 f0032fe: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003302: b118         	cbz	r0, 0xf00330c <schedule+0x858> @ imm = #0x6
 f003304: 6be0         	ldr	r0, [r4, #0x3c]
 f003306: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00330a: b188         	cbz	r0, 0xf003330 <schedule+0x87c> @ imm = #0x22
 f00330c: 9801         	ldr	r0, [sp, #0x4]
 f00330e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003312: e850 1f00    	.word	#0xe8501f00
 f003316: 1e4a         	subs	r2, r1, #0x1
 f003318: e840 2300    	.word	#0xe8402300
 f00331c: 2b00         	cmp	r3, #0x0
 f00331e: d1f8         	bne	0xf003312 <schedule+0x85e> @ imm = #-0x10
 f003320: 2901         	cmp	r1, #0x1
 f003322: d139         	bne	0xf003398 <schedule+0x8e4> @ imm = #0x72
 f003324: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003328: a801         	add	r0, sp, #0x4
 f00332a: f7fd fe49    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x236e
 f00332e: e033         	b	0xf003398 <schedule+0x8e4> @ imm = #0x66
 f003330: f3ef 8005    	.word	#0xf3ef8005
 f003334: b158         	cbz	r0, 0xf00334e <schedule+0x89a> @ imm = #0x16
 f003336: f3ef 8005    	.word	#0xf3ef8005
 f00333a: 280e         	cmp	r0, #0xe
 f00333c: d0e6         	beq	0xf00330c <schedule+0x858> @ imm = #-0x34
 f00333e: f64e 5004    	.word	#0xf64e5004
 f003342: f04f 5180    	.word	#0xf04f5180
 f003346: f2ce 0000    	.word	#0xf2ce0000
 f00334a: 6001         	str	r1, [r0]
 f00334c: e7de         	b	0xf00330c <schedule+0x858> @ imm = #-0x44
 f00334e: f7fd fe34    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x2398
 f003352: e7db         	b	0xf00330c <schedule+0x858> @ imm = #-0x4a
 f003354: f7fd f9f5    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x2c16
 f003358: defe         	trap
 f00335a: 4680         	mov	r8, r0
 f00335c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003360: e854 0f14    	.word	#0xe8540f14
 f003364: 3804         	subs	r0, #0x4
 f003366: e844 0114    	.word	#0xe8440114
 f00336a: 2900         	cmp	r1, #0x0
 f00336c: d1f8         	bne	0xf003360 <schedule+0x8ac> @ imm = #-0x10
 f00336e: e000         	b	0xf003372 <schedule+0x8be> @ imm = #0x0
 f003370: 4680         	mov	r8, r0
 f003372: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003376: e854 0f0f    	.word	#0xe8540f0f
 f00337a: 3801         	subs	r0, #0x1
 f00337c: e844 010f    	.word	#0xe844010f
 f003380: 2900         	cmp	r1, #0x0
 f003382: d1f8         	bne	0xf003376 <schedule+0x8c2> @ imm = #-0x10
 f003384: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003388: 7960         	ldrb	r0, [r4, #0x5]
 f00338a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00338e: b118         	cbz	r0, 0xf003398 <schedule+0x8e4> @ imm = #0x6
 f003390: 6be0         	ldr	r0, [r4, #0x3c]
 f003392: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003396: b3b8         	cbz	r0, 0xf003408 <schedule+0x954> @ imm = #0x6e
 f003398: 2400         	movs	r4, #0x0
 f00339a: 2501         	movs	r5, #0x1
 f00339c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0033a0: f889 4084    	.word	#0xf8894084
 f0033a4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0033a8: f109 0190    	.word	#0xf1090190
 f0033ac: e8d1 0f4f    	.word	#0xe8d10f4f
 f0033b0: e8c1 4f42    	.word	#0xe8c14f42
 f0033b4: 2a00         	cmp	r2, #0x0
 f0033b6: d1f7         	bne	0xf0033a8 <schedule+0x8f4> @ imm = #-0x12
 f0033b8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0033bc: b118         	cbz	r0, 0xf0033c6 <schedule+0x912> @ imm = #0x6
 f0033be: 4648         	mov	r0, r9
 f0033c0: 4651         	mov	r1, r10
 f0033c2: f7fe faaf    	bl	0xf001924 <_$LT$hopter..schedule..scheduler..InnerFullAccessor$u20$as$u20$hopter..sync..interruptable..RunPendedOp$GT$::run_pended_op::hc7eb08b5839ac9cb> @ imm = #-0x1aa2
 f0033c6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0033ca: f889 4091    	.word	#0xf8894091
 f0033ce: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0033d2: f899 0090    	.word	#0xf8990090
 f0033d6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0033da: 2800         	cmp	r0, #0x0
 f0033dc: d051         	beq	0xf003482 <schedule+0x9ce> @ imm = #0xa2
 f0033de: e8d6 0f4f    	.word	#0xe8d60f4f
 f0033e2: b960         	cbnz	r0, 0xf0033fe <schedule+0x94a> @ imm = #0x18
 f0033e4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0033e8: e8c6 5f40    	.word	#0xe8c65f40
 f0033ec: b120         	cbz	r0, 0xf0033f8 <schedule+0x944> @ imm = #0x8
 f0033ee: e8d6 0f4f    	.word	#0xe8d60f4f
 f0033f2: 2800         	cmp	r0, #0x0
 f0033f4: d0f8         	beq	0xf0033e8 <schedule+0x934> @ imm = #-0x10
 f0033f6: e002         	b	0xf0033fe <schedule+0x94a> @ imm = #0x4
 f0033f8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0033fc: e7d2         	b	0xf0033a4 <schedule+0x8f0> @ imm = #-0x5c
 f0033fe: f3bf 8f2f    	.word	#0xf3bf8f2f
 f003402: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003406: e7fe         	b	0xf003406 <schedule+0x952> @ imm = #-0x4
 f003408: f3ef 8005    	.word	#0xf3ef8005
 f00340c: b158         	cbz	r0, 0xf003426 <schedule+0x972> @ imm = #0x16
 f00340e: f3ef 8005    	.word	#0xf3ef8005
 f003412: 280e         	cmp	r0, #0xe
 f003414: d0c0         	beq	0xf003398 <schedule+0x8e4> @ imm = #-0x80
 f003416: f64e 5004    	.word	#0xf64e5004
 f00341a: f04f 5180    	.word	#0xf04f5180
 f00341e: f2ce 0000    	.word	#0xf2ce0000
 f003422: 6001         	str	r1, [r0]
 f003424: e7b8         	b	0xf003398 <schedule+0x8e4> @ imm = #-0x90
 f003426: f7fd fdc8    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x2470
 f00342a: e7b5         	b	0xf003398 <schedule+0x8e4> @ imm = #-0x96
 f00342c: f7fd f989    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x2cee
 f003430: defe         	trap
 f003432: f7fd f986    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x2cf4
 f003436: defe         	trap
 f003438: 4680         	mov	r8, r0
 f00343a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00343e: e854 0f0f    	.word	#0xe8540f0f
 f003442: 3801         	subs	r0, #0x1
 f003444: e844 010f    	.word	#0xe844010f
 f003448: 2900         	cmp	r1, #0x0
 f00344a: d1f8         	bne	0xf00343e <schedule+0x98a> @ imm = #-0x10
 f00344c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003450: 7960         	ldrb	r0, [r4, #0x5]
 f003452: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003456: b1a0         	cbz	r0, 0xf003482 <schedule+0x9ce> @ imm = #0x28
 f003458: 6be0         	ldr	r0, [r4, #0x3c]
 f00345a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00345e: b980         	cbnz	r0, 0xf003482 <schedule+0x9ce> @ imm = #0x20
 f003460: f3ef 8005    	.word	#0xf3ef8005
 f003464: b910         	cbnz	r0, 0xf00346c <schedule+0x9b8> @ imm = #0x4
 f003466: f7fd fda8    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x24b0
 f00346a: e00a         	b	0xf003482 <schedule+0x9ce> @ imm = #0x14
 f00346c: f3ef 8005    	.word	#0xf3ef8005
 f003470: 280e         	cmp	r0, #0xe
 f003472: bf1f         	itttt	ne
 f003474: f64e 5004    	.word	#0xf64e5004
 f003478: f2ce 0000    	.word	#0xf2ce0000
 f00347c: f04f 5180    	.word	#0xf04f5180
 f003480: 6001         	strne	r1, [r0]
 f003482: 4640         	mov	r0, r8
 f003484: f002 f8a6    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x214c
 f003488: defe         	trap
 f00348a: f7fd f95a    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x2d4c
 f00348e: defe         	trap

0f003490 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c>:
 f003490: f04f 5c00    	.word	#0xf04f5c00
 f003494: f8dc c000    	.word	#0xf8dcc000
 f003498: ebbd 0c0c    	.word	#0xebbd0c0c
 f00349c: f1bc 0f10    	.word	#0xf1bc0f10
 f0034a0: da02         	bge	0xf0034a8 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x18> @ imm = #0x4
 f0034a2: dfff         	svc	#0xff
 f0034a4: 0004         	movs	r4, r0
 f0034a6: 0000         	movs	r0, r0
 f0034a8: b5b0         	push	{r4, r5, r7, lr}
 f0034aa: af02         	add	r7, sp, #0x8
 f0034ac: 4604         	mov	r4, r0
 f0034ae: 6980         	ldr	r0, [r0, #0x18]
 f0034b0: f810 0c02    	.word	#0xf8100c02
 f0034b4: 28fc         	cmp	r0, #0xfc
 f0034b6: dc10         	bgt	0xf0034da <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x4a> @ imm = #0x20
 f0034b8: 3801         	subs	r0, #0x1
 f0034ba: 2807         	cmp	r0, #0x7
 f0034bc: d819         	bhi	0xf0034f2 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x62> @ imm = #0x32
 f0034be: e8df f000    	.word	#0xe8dff000

0f0034c2 <$d.55>:
 f0034c2: 04 04 23 c6  	.word	0xc6230404
 f0034c6: 19 18 18 cf  	.word	0xcf181819

0f0034ca <$t.56>:
 f0034ca: f64e 5004    	.word	#0xf64e5004
 f0034ce: f04f 5180    	.word	#0xf04f5180
 f0034d2: f2ce 0000    	.word	#0xf2ce0000
 f0034d6: 6001         	str	r1, [r0]
 f0034d8: bdb0         	pop	{r4, r5, r7, pc}
 f0034da: 28fd         	cmp	r0, #0xfd
 f0034dc: d004         	beq	0xf0034e8 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x58> @ imm = #0x8
 f0034de: 28fe         	cmp	r0, #0xfe
 f0034e0: f000 81e2    	.word	#0xf00081e2
 f0034e4: 28ff         	cmp	r0, #0xff
 f0034e6: d104         	bne	0xf0034f2 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x62> @ imm = #0x8
 f0034e8: 4620         	mov	r0, r4
 f0034ea: e8bd 40b0    	.word	#0xe8bd40b0
 f0034ee: f000 ba68    	.word	#0xf000ba68
 f0034f2: e7fe         	b	0xf0034f2 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x62> @ imm = #-0x4
 f0034f4: f246 7018    	.word	#0xf2467018
 f0034f8: 6821         	ldr	r1, [r4]
 f0034fa: f2c2 0000    	.word	#0xf2c20000
 f0034fe: 3009         	adds	r0, #0x9
 f003500: e8bd 40b0    	.word	#0xe8bd40b0
 f003504: f7fd bded    	.word	#0xf7fdbded
 f003508: 684a         	ldr	r2, [r1, #0x4]
 f00350a: e9d4 3500    	.word	#0xe9d43500
 f00350e: e9d4 0402    	.word	#0xe9d40402
 f003512: f852 cc78    	.word	#0xf852cc78
 f003516: f8dc e014    	.word	#0xf8dce014
 f00351a: e9cc 3500    	.word	#0xe9cc3500
 f00351e: f246 7518    	.word	#0xf2467518
 f003522: e9cc 0402    	.word	#0xe9cc0402
 f003526: 4614         	mov	r4, r2
 f003528: f8cc e018    	.word	#0xf8cce018
 f00352c: f2c2 0500    	.word	#0xf2c20500
 f003530: f854 0d7c    	.word	#0xf8540d7c
 f003534: f852 2c78    	.word	#0xf8522c78
 f003538: e9c1 2000    	.word	#0xe9c12000
 f00353c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003540: e855 0f0f    	.word	#0xe8550f0f
 f003544: 3001         	adds	r0, #0x1
 f003546: e845 010f    	.word	#0xe845010f
 f00354a: 2900         	cmp	r1, #0x0
 f00354c: d1f8         	bne	0xf003540 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0xb0> @ imm = #-0x10
 f00354e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003552: e855 2f14    	.word	#0xe8552f14
 f003556: 1d10         	adds	r0, r2, #0x4
 f003558: e845 0114    	.word	#0xe8450114
 f00355c: 2900         	cmp	r1, #0x0
 f00355e: d1f8         	bne	0xf003552 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0xc2> @ imm = #-0x10
 f003560: f64f 71fc    	.word	#0xf64f71fc
 f003564: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003568: f6c7 71ff    	.word	#0xf6c771ff
 f00356c: 428a         	cmp	r2, r1
 f00356e: d85f         	bhi	0xf003630 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x1a0> @ imm = #0xbe
 f003570: 0790         	lsls	r0, r2, #0x1e
 f003572: f000 810c    	.word	#0xf000810c
 f003576: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00357a: e855 0f14    	.word	#0xe8550f14
 f00357e: 3804         	subs	r0, #0x4
 f003580: e845 0214    	.word	#0xe8450214
 f003584: 2a00         	cmp	r2, #0x0
 f003586: d1f8         	bne	0xf00357a <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0xea> @ imm = #-0x10
 f003588: bf10         	yield
 f00358a: e855 2f14    	.word	#0xe8552f14
 f00358e: 1d10         	adds	r0, r2, #0x4
 f003590: e845 0314    	.word	#0xe8450314
 f003594: 2b00         	cmp	r3, #0x0
 f003596: d1f8         	bne	0xf00358a <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0xfa> @ imm = #-0x10
 f003598: 428a         	cmp	r2, r1
 f00359a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00359e: d847         	bhi	0xf003630 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x1a0> @ imm = #0x8e
 f0035a0: 0790         	lsls	r0, r2, #0x1e
 f0035a2: f000 80f4    	.word	#0xf00080f4
 f0035a6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0035aa: e855 0f14    	.word	#0xe8550f14
 f0035ae: 3804         	subs	r0, #0x4
 f0035b0: e845 0214    	.word	#0xe8450214
 f0035b4: 2a00         	cmp	r2, #0x0
 f0035b6: d1f8         	bne	0xf0035aa <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x11a> @ imm = #-0x10
 f0035b8: bf10         	yield
 f0035ba: e855 2f14    	.word	#0xe8552f14
 f0035be: 1d10         	adds	r0, r2, #0x4
 f0035c0: e845 0314    	.word	#0xe8450314
 f0035c4: 2b00         	cmp	r3, #0x0
 f0035c6: d1f8         	bne	0xf0035ba <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x12a> @ imm = #-0x10
 f0035c8: 428a         	cmp	r2, r1
 f0035ca: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0035ce: d82f         	bhi	0xf003630 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x1a0> @ imm = #0x5e
 f0035d0: 0790         	lsls	r0, r2, #0x1e
 f0035d2: f000 80dc    	.word	#0xf00080dc
 f0035d6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0035da: e855 0f14    	.word	#0xe8550f14
 f0035de: 3804         	subs	r0, #0x4
 f0035e0: e845 0214    	.word	#0xe8450214
 f0035e4: 2a00         	cmp	r2, #0x0
 f0035e6: d1f8         	bne	0xf0035da <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x14a> @ imm = #-0x10
 f0035e8: bf10         	yield
 f0035ea: e855 2f14    	.word	#0xe8552f14
 f0035ee: 1d10         	adds	r0, r2, #0x4
 f0035f0: e845 0314    	.word	#0xe8450314
 f0035f4: 2b00         	cmp	r3, #0x0
 f0035f6: d1f8         	bne	0xf0035ea <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x15a> @ imm = #-0x10
 f0035f8: 428a         	cmp	r2, r1
 f0035fa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0035fe: d817         	bhi	0xf003630 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x1a0> @ imm = #0x2e
 f003600: 0790         	lsls	r0, r2, #0x1e
 f003602: f000 80c4    	.word	#0xf00080c4
 f003606: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00360a: e855 0f14    	.word	#0xe8550f14
 f00360e: 3804         	subs	r0, #0x4
 f003610: e845 0214    	.word	#0xe8450214
 f003614: 2a00         	cmp	r2, #0x0
 f003616: d1f8         	bne	0xf00360a <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x17a> @ imm = #-0x10
 f003618: bf10         	yield
 f00361a: e855 2f14    	.word	#0xe8552f14
 f00361e: 1d10         	adds	r0, r2, #0x4
 f003620: e845 0314    	.word	#0xe8450314
 f003624: 2b00         	cmp	r3, #0x0
 f003626: d1f8         	bne	0xf00361a <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x18a> @ imm = #-0x10
 f003628: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00362c: 428a         	cmp	r2, r1
 f00362e: d99f         	bls	0xf003570 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0xe0> @ imm = #-0xc2
 f003630: e855 0f14    	.word	#0xe8550f14
 f003634: 3804         	subs	r0, #0x4
 f003636: e845 0114    	.word	#0xe8450114
 f00363a: 2900         	cmp	r1, #0x0
 f00363c: d1f8         	bne	0xf003630 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x1a0> @ imm = #-0x10
 f00363e: f245 6078    	.word	#0xf2456078
 f003642: 212c         	movs	r1, #0x2c
 f003644: f6c0 7000    	.word	#0xf6c07000
 f003648: f7fc ffff    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x3002
 f00364c: e09e         	b	0xf00378c <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x2fc> @ imm = #0x13c
 f00364e: 6821         	ldr	r1, [r4]
 f003650: f64f 70fc    	.word	#0xf64f70fc
 f003654: f6c7 70ff    	.word	#0xf6c770ff
 f003658: 4281         	cmp	r1, r0
 f00365a: f240 8141    	.word	#0xf2408141
 f00365e: e7fe         	b	0xf00365e <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x1ce> @ imm = #-0x4
 f003660: f246 7518    	.word	#0xf2467518
 f003664: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003668: f2c2 0500    	.word	#0xf2c20500
 f00366c: e855 0f0d    	.word	#0xe8550f0d
 f003670: 3801         	subs	r0, #0x1
 f003672: e845 010d    	.word	#0xe845010d
 f003676: 2900         	cmp	r1, #0x0
 f003678: d1f8         	bne	0xf00366c <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x1dc> @ imm = #-0x10
 f00367a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00367e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003682: e855 0f0f    	.word	#0xe8550f0f
 f003686: 3001         	adds	r0, #0x1
 f003688: e845 010f    	.word	#0xe845010f
 f00368c: 2900         	cmp	r1, #0x0
 f00368e: d1f8         	bne	0xf003682 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x1f2> @ imm = #-0x10
 f003690: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003694: e855 1f14    	.word	#0xe8551f14
 f003698: 1d08         	adds	r0, r1, #0x4
 f00369a: e845 0214    	.word	#0xe8450214
 f00369e: 2a00         	cmp	r2, #0x0
 f0036a0: d1f8         	bne	0xf003694 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x204> @ imm = #-0x10
 f0036a2: f64f 70fc    	.word	#0xf64f70fc
 f0036a6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0036aa: f6c7 70ff    	.word	#0xf6c770ff
 f0036ae: 4281         	cmp	r1, r0
 f0036b0: d85e         	bhi	0xf003770 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x2e0> @ imm = #0xbc
 f0036b2: 0789         	lsls	r1, r1, #0x1e
 f0036b4: f000 80c0    	.word	#0xf00080c0
 f0036b8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0036bc: e855 1f14    	.word	#0xe8551f14
 f0036c0: 3904         	subs	r1, #0x4
 f0036c2: e845 1214    	.word	#0xe8451214
 f0036c6: 2a00         	cmp	r2, #0x0
 f0036c8: d1f8         	bne	0xf0036bc <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x22c> @ imm = #-0x10
 f0036ca: bf10         	yield
 f0036cc: e855 1f14    	.word	#0xe8551f14
 f0036d0: 1d0a         	adds	r2, r1, #0x4
 f0036d2: e845 2314    	.word	#0xe8452314
 f0036d6: 2b00         	cmp	r3, #0x0
 f0036d8: d1f8         	bne	0xf0036cc <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x23c> @ imm = #-0x10
 f0036da: 4281         	cmp	r1, r0
 f0036dc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0036e0: d846         	bhi	0xf003770 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x2e0> @ imm = #0x8c
 f0036e2: 0789         	lsls	r1, r1, #0x1e
 f0036e4: f000 80a8    	.word	#0xf00080a8
 f0036e8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0036ec: e855 1f14    	.word	#0xe8551f14
 f0036f0: 3904         	subs	r1, #0x4
 f0036f2: e845 1214    	.word	#0xe8451214
 f0036f6: 2a00         	cmp	r2, #0x0
 f0036f8: d1f8         	bne	0xf0036ec <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x25c> @ imm = #-0x10
 f0036fa: bf10         	yield
 f0036fc: e855 1f14    	.word	#0xe8551f14
 f003700: 1d0a         	adds	r2, r1, #0x4
 f003702: e845 2314    	.word	#0xe8452314
 f003706: 2b00         	cmp	r3, #0x0
 f003708: d1f8         	bne	0xf0036fc <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x26c> @ imm = #-0x10
 f00370a: 4281         	cmp	r1, r0
 f00370c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003710: d82e         	bhi	0xf003770 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x2e0> @ imm = #0x5c
 f003712: 0789         	lsls	r1, r1, #0x1e
 f003714: f000 8090    	.word	#0xf0008090
 f003718: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00371c: e855 1f14    	.word	#0xe8551f14
 f003720: 3904         	subs	r1, #0x4
 f003722: e845 1214    	.word	#0xe8451214
 f003726: 2a00         	cmp	r2, #0x0
 f003728: d1f8         	bne	0xf00371c <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x28c> @ imm = #-0x10
 f00372a: bf10         	yield
 f00372c: e855 1f14    	.word	#0xe8551f14
 f003730: 1d0a         	adds	r2, r1, #0x4
 f003732: e845 2314    	.word	#0xe8452314
 f003736: 2b00         	cmp	r3, #0x0
 f003738: d1f8         	bne	0xf00372c <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x29c> @ imm = #-0x10
 f00373a: 4281         	cmp	r1, r0
 f00373c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003740: d816         	bhi	0xf003770 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x2e0> @ imm = #0x2c
 f003742: 0789         	lsls	r1, r1, #0x1e
 f003744: d078         	beq	0xf003838 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x3a8> @ imm = #0xf0
 f003746: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00374a: e855 1f14    	.word	#0xe8551f14
 f00374e: 3904         	subs	r1, #0x4
 f003750: e845 1214    	.word	#0xe8451214
 f003754: 2a00         	cmp	r2, #0x0
 f003756: d1f8         	bne	0xf00374a <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x2ba> @ imm = #-0x10
 f003758: bf10         	yield
 f00375a: e855 1f14    	.word	#0xe8551f14
 f00375e: 1d0a         	adds	r2, r1, #0x4
 f003760: e845 2314    	.word	#0xe8452314
 f003764: 2b00         	cmp	r3, #0x0
 f003766: d1f8         	bne	0xf00375a <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x2ca> @ imm = #-0x10
 f003768: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00376c: 4281         	cmp	r1, r0
 f00376e: d9a0         	bls	0xf0036b2 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x222> @ imm = #-0xc0
 f003770: e855 0f14    	.word	#0xe8550f14
 f003774: 3804         	subs	r0, #0x4
 f003776: e845 0114    	.word	#0xe8450114
 f00377a: 2900         	cmp	r1, #0x0
 f00377c: d1f8         	bne	0xf003770 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x2e0> @ imm = #-0x10
 f00377e: f245 6078    	.word	#0xf2456078
 f003782: 212c         	movs	r1, #0x2c
 f003784: f6c0 7000    	.word	#0xf6c07000
 f003788: f7fc ff5f    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x3142
 f00378c: defe         	trap
 f00378e: 6d69         	ldr	r1, [r5, #0x54]
 f003790: 2900         	cmp	r1, #0x0
 f003792: d050         	beq	0xf003836 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x3a6> @ imm = #0xa0
 f003794: f891 0098    	.word	#0xf8910098
 f003798: 2800         	cmp	r0, #0x0
 f00379a: f040 80b0    	.word	#0xf04080b0
 f00379e: f101 0298    	.word	#0xf1010298
 f0037a2: 2301         	movs	r3, #0x1
 f0037a4: e8d2 0f4f    	.word	#0xe8d20f4f
 f0037a8: 2800         	cmp	r0, #0x0
 f0037aa: f040 80a6    	.word	#0xf04080a6
 f0037ae: e8c2 3f40    	.word	#0xe8c23f40
 f0037b2: 2800         	cmp	r0, #0x0
 f0037b4: d1f6         	bne	0xf0037a4 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x314> @ imm = #-0x14
 f0037b6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0037ba: f8dc 0014    	.word	#0xf8dc0014
 f0037be: f8d1 20bc    	.word	#0xf8d120bc
 f0037c2: 4050         	eors	r0, r2
 f0037c4: ea4f 70f0    	.word	#0xea4f70f0
 f0037c8: f8c1 00bc    	.word	#0xf8c100bc
 f0037cc: 2000         	movs	r0, #0x0
 f0037ce: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0037d2: f881 0098    	.word	#0xf8810098
 f0037d6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0037da: e855 0f14    	.word	#0xe8550f14
 f0037de: 3804         	subs	r0, #0x4
 f0037e0: e845 0114    	.word	#0xe8450114
 f0037e4: 2900         	cmp	r1, #0x0
 f0037e6: d1f8         	bne	0xf0037da <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x34a> @ imm = #-0x10
 f0037e8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0037ec: e855 0f0f    	.word	#0xe8550f0f
 f0037f0: 3801         	subs	r0, #0x1
 f0037f2: e845 010f    	.word	#0xe845010f
 f0037f6: 2900         	cmp	r1, #0x0
 f0037f8: d1f8         	bne	0xf0037ec <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x35c> @ imm = #-0x10
 f0037fa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0037fe: 7968         	ldrb	r0, [r5, #0x5]
 f003800: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003804: 2800         	cmp	r0, #0x0
 f003806: f000 8083    	.word	#0xf0008083
 f00380a: 6be8         	ldr	r0, [r5, #0x3c]
 f00380c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003810: 2800         	cmp	r0, #0x0
 f003812: f040 807d    	.word	#0xf040807d
 f003816: f3ef 8005    	.word	#0xf3ef8005
 f00381a: 2800         	cmp	r0, #0x0
 f00381c: d076         	beq	0xf00390c <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x47c> @ imm = #0xec
 f00381e: f3ef 8005    	.word	#0xf3ef8005
 f003822: 280e         	cmp	r0, #0xe
 f003824: bf1f         	itttt	ne
 f003826: f64e 5004    	.word	#0xf64e5004
 f00382a: f2ce 0000    	.word	#0xf2ce0000
 f00382e: f04f 5180    	.word	#0xf04f5180
 f003832: 6001         	strne	r1, [r0]
 f003834: e06c         	b	0xf003910 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x480> @ imm = #0xd8
 f003836: e7fe         	b	0xf003836 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x3a6> @ imm = #-0x4
 f003838: 6d68         	ldr	r0, [r5, #0x54]
 f00383a: b3a0         	cbz	r0, 0xf0038a6 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x416> @ imm = #0x68
 f00383c: 2100         	movs	r1, #0x0
 f00383e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003842: f880 10cd    	.word	#0xf88010cd
 f003846: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00384a: e855 0f14    	.word	#0xe8550f14
 f00384e: 3804         	subs	r0, #0x4
 f003850: e845 0114    	.word	#0xe8450114
 f003854: 2900         	cmp	r1, #0x0
 f003856: d1f8         	bne	0xf00384a <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x3ba> @ imm = #-0x10
 f003858: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00385c: e855 0f0f    	.word	#0xe8550f0f
 f003860: 3801         	subs	r0, #0x1
 f003862: e845 010f    	.word	#0xe845010f
 f003866: 2900         	cmp	r1, #0x0
 f003868: d1f8         	bne	0xf00385c <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x3cc> @ imm = #-0x10
 f00386a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00386e: f64e 5404    	.word	#0xf64e5404
 f003872: 7968         	ldrb	r0, [r5, #0x5]
 f003874: f2ce 0400    	.word	#0xf2ce0400
 f003878: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00387c: 2800         	cmp	r0, #0x0
 f00387e: d041         	beq	0xf003904 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x474> @ imm = #0x82
 f003880: 6be8         	ldr	r0, [r5, #0x3c]
 f003882: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003886: 2800         	cmp	r0, #0x0
 f003888: d13c         	bne	0xf003904 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x474> @ imm = #0x78
 f00388a: f3ef 8005    	.word	#0xf3ef8005
 f00388e: b3b8         	cbz	r0, 0xf003900 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x470> @ imm = #0x6e
 f003890: f3ef 8005    	.word	#0xf3ef8005
 f003894: 280e         	cmp	r0, #0xe
 f003896: bf1c         	itt	ne
 f003898: f04f 5080    	.word	#0xf04f5080
 f00389c: 6020         	strne	r0, [r4]
 f00389e: f04f 5080    	.word	#0xf04f5080
 f0038a2: 6020         	str	r0, [r4]
 f0038a4: bdb0         	pop	{r4, r5, r7, pc}
 f0038a6: e7fe         	b	0xf0038a6 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x416> @ imm = #-0x4
 f0038a8: e9d4 0200    	.word	#0xe9d40200
 f0038ac: 69e3         	ldr	r3, [r4, #0x1c]
 f0038ae: 684c         	ldr	r4, [r1, #0x4]
 f0038b0: 6a45         	ldr	r5, [r0, #0x24]
 f0038b2: f423 7300    	.word	#0xf4237300
 f0038b6: f845 3c4c    	.word	#0xf8453c4c
 f0038ba: 6803         	ldr	r3, [r0]
 f0038bc: f845 3d68    	.word	#0xf8453d68
 f0038c0: 61aa         	str	r2, [r5, #0x18]
 f0038c2: f8d0 0094    	.word	#0xf8d00094
 f0038c6: e9c1 5000    	.word	#0xe9c15000
 f0038ca: f246 7018    	.word	#0xf2467018
 f0038ce: f2c2 0000    	.word	#0xf2c20000
 f0038d2: f1a4 017c    	.word	#0xf1a4017c
 f0038d6: 3009         	adds	r0, #0x9
 f0038d8: e8bd 40b0    	.word	#0xe8bd40b0
 f0038dc: f7fd bc01    	.word	#0xf7fdbc01
 f0038e0: f246 7018    	.word	#0xf2467018
 f0038e4: f2c2 0000    	.word	#0xf2c20000
 f0038e8: f810 2b09    	.word	#0xf8102b09
 f0038ec: f7fd fd34    	bl	0xf001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e> @ imm = #-0x2598
 f0038f0: 2800         	cmp	r0, #0x0
 f0038f2: bf1c         	itt	ne
 f0038f4: 6020         	strne	r0, [r4]
 f0038f6: bdb0         	popne	{r4, r5, r7, pc}
 f0038f8: e7fe         	b	0xf0038f8 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x468> @ imm = #-0x4
 f0038fa: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0038fe: e7fe         	b	0xf0038fe <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x46e> @ imm = #-0x4
 f003900: f7fd fb5b    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x294a
 f003904: f04f 5080    	.word	#0xf04f5080
 f003908: 6020         	str	r0, [r4]
 f00390a: bdb0         	pop	{r4, r5, r7, pc}
 f00390c: f7fd fb55    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x2956
 f003910: f105 0009    	.word	#0xf1050009
 f003914: 4621         	mov	r1, r4
 f003916: f7fd fbe4    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #-0x2838
 f00391a: e855 0f12    	.word	#0xe8550f12
 f00391e: 3801         	subs	r0, #0x1
 f003920: e845 0112    	.word	#0xe8450112
 f003924: 2900         	cmp	r1, #0x0
 f003926: d1f8         	bne	0xf00391a <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x48a> @ imm = #-0x10
 f003928: e5d6         	b	0xf0034d8 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x48> @ imm = #-0x454
 f00392a: 4604         	mov	r4, r0
 f00392c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003930: e855 0f0f    	.word	#0xe8550f0f
 f003934: 3801         	subs	r0, #0x1
 f003936: e845 010f    	.word	#0xe845010f
 f00393a: 2900         	cmp	r1, #0x0
 f00393c: d1f8         	bne	0xf003930 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x4a0> @ imm = #-0x10
 f00393e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003942: 7968         	ldrb	r0, [r5, #0x5]
 f003944: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003948: b3a0         	cbz	r0, 0xf0039b4 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x524> @ imm = #0x68
 f00394a: 6be8         	ldr	r0, [r5, #0x3c]
 f00394c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003950: bb80         	cbnz	r0, 0xf0039b4 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x524> @ imm = #0x60
 f003952: f3ef 8005    	.word	#0xf3ef8005
 f003956: b910         	cbnz	r0, 0xf00395e <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x4ce> @ imm = #0x4
 f003958: f7fd fb2f    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x29a2
 f00395c: e02a         	b	0xf0039b4 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x524> @ imm = #0x54
 f00395e: f3ef 8005    	.word	#0xf3ef8005
 f003962: e01e         	b	0xf0039a2 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x512> @ imm = #0x3c
 f003964: f7fc feed    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x3226
 f003968: defe         	trap
 f00396a: 4604         	mov	r4, r0
 f00396c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003970: e855 0f0f    	.word	#0xe8550f0f
 f003974: 3801         	subs	r0, #0x1
 f003976: e845 010f    	.word	#0xe845010f
 f00397a: 2900         	cmp	r1, #0x0
 f00397c: d1f8         	bne	0xf003970 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x4e0> @ imm = #-0x10
 f00397e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003982: 7968         	ldrb	r0, [r5, #0x5]
 f003984: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003988: b1a0         	cbz	r0, 0xf0039b4 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x524> @ imm = #0x28
 f00398a: 6be8         	ldr	r0, [r5, #0x3c]
 f00398c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003990: b980         	cbnz	r0, 0xf0039b4 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x524> @ imm = #0x20
 f003992: f3ef 8005    	.word	#0xf3ef8005
 f003996: b910         	cbnz	r0, 0xf00399e <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x50e> @ imm = #0x4
 f003998: f7fd fb0f    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x29e2
 f00399c: e00a         	b	0xf0039b4 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x524> @ imm = #0x14
 f00399e: f3ef 8005    	.word	#0xf3ef8005
 f0039a2: 280e         	cmp	r0, #0xe
 f0039a4: d006         	beq	0xf0039b4 <hopter::interrupt::svc_handler::svc_handler::h64e9ae74034e8e0c+0x524> @ imm = #0xc
 f0039a6: f64e 5004    	.word	#0xf64e5004
 f0039aa: f04f 5180    	.word	#0xf04f5180
 f0039ae: f2ce 0000    	.word	#0xf2ce0000
 f0039b2: 6001         	str	r1, [r0]
 f0039b4: 4620         	mov	r0, r4
 f0039b6: f001 fe0d    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x1c1a
 f0039ba: defe         	trap
 f0039bc: f7fc fec1    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x327e
 f0039c0: defe         	trap

0f0039c2 <hopter::task::segmented_stack::more_stack::hba837af733e59a63>:
 f0039c2: f04f 5c00    	.word	#0xf04f5c00
 f0039c6: f8dc c000    	.word	#0xf8dcc000
 f0039ca: ebbd 0c0c    	.word	#0xebbd0c0c
 f0039ce: f1bc 0f68    	.word	#0xf1bc0f68
 f0039d2: da02         	bge	0xf0039da <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x18> @ imm = #0x4
 f0039d4: dfff         	svc	#0xff
 f0039d6: 001a         	movs	r2, r3
 f0039d8: 0000         	movs	r0, r0
 f0039da: b5f0         	push	{r4, r5, r6, r7, lr}
 f0039dc: af03         	add	r7, sp, #0xc
 f0039de: e92d 0f00    	.word	#0xe92d0f00
 f0039e2: b091         	sub	sp, #0x44
 f0039e4: f246 7418    	.word	#0xf2467418
 f0039e8: 468a         	mov	r10, r1
 f0039ea: 4680         	mov	r8, r0
 f0039ec: f2c2 0400    	.word	#0xf2c20400
 f0039f0: e854 0f11    	.word	#0xe8540f11
 f0039f4: 3001         	adds	r0, #0x1
 f0039f6: e844 0111    	.word	#0xe8440111
 f0039fa: 2900         	cmp	r1, #0x0
 f0039fc: d1f8         	bne	0xf0039f0 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x2e> @ imm = #-0x10
 f0039fe: f8d8 0018    	.word	#0xf8d80018
 f003a02: 8801         	ldrh	r1, [r0]
 f003a04: 8842         	ldrh	r2, [r0, #0x2]
 f003a06: f8da e004    	.word	#0xf8dae004
 f003a0a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003a0e: ea4f 0981    	.word	#0xea4f0981
 f003a12: ea4f 0c82    	.word	#0xea4f0c82
 f003a16: e854 1f0f    	.word	#0xe8541f0f
 f003a1a: 3101         	adds	r1, #0x1
 f003a1c: e844 120f    	.word	#0xe844120f
 f003a20: 2a00         	cmp	r2, #0x0
 f003a22: d1f8         	bne	0xf003a16 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x54> @ imm = #-0x10
 f003a24: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003a28: e854 1f14    	.word	#0xe8541f14
 f003a2c: 1d0a         	adds	r2, r1, #0x4
 f003a2e: e844 2314    	.word	#0xe8442314
 f003a32: 2b00         	cmp	r3, #0x0
 f003a34: d1f8         	bne	0xf003a28 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x66> @ imm = #-0x10
 f003a36: f64f 76fc    	.word	#0xf64f76fc
 f003a3a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003a3e: f6c7 76ff    	.word	#0xf6c776ff
 f003a42: 42b1         	cmp	r1, r6
 f003a44: d85b         	bhi	0xf003afe <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x13c> @ imm = #0xb6
 f003a46: 0789         	lsls	r1, r1, #0x1e
 f003a48: d068         	beq	0xf003b1c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x15a> @ imm = #0xd0
 f003a4a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003a4e: e854 1f14    	.word	#0xe8541f14
 f003a52: 3904         	subs	r1, #0x4
 f003a54: e844 1214    	.word	#0xe8441214
 f003a58: 2a00         	cmp	r2, #0x0
 f003a5a: d1f8         	bne	0xf003a4e <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x8c> @ imm = #-0x10
 f003a5c: bf10         	yield
 f003a5e: e854 1f14    	.word	#0xe8541f14
 f003a62: 1d0a         	adds	r2, r1, #0x4
 f003a64: e844 2314    	.word	#0xe8442314
 f003a68: 2b00         	cmp	r3, #0x0
 f003a6a: d1f8         	bne	0xf003a5e <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x9c> @ imm = #-0x10
 f003a6c: 42b1         	cmp	r1, r6
 f003a6e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003a72: d844         	bhi	0xf003afe <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x13c> @ imm = #0x88
 f003a74: 0789         	lsls	r1, r1, #0x1e
 f003a76: d051         	beq	0xf003b1c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x15a> @ imm = #0xa2
 f003a78: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003a7c: e854 1f14    	.word	#0xe8541f14
 f003a80: 3904         	subs	r1, #0x4
 f003a82: e844 1214    	.word	#0xe8441214
 f003a86: 2a00         	cmp	r2, #0x0
 f003a88: d1f8         	bne	0xf003a7c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0xba> @ imm = #-0x10
 f003a8a: bf10         	yield
 f003a8c: e854 1f14    	.word	#0xe8541f14
 f003a90: 1d0a         	adds	r2, r1, #0x4
 f003a92: e844 2314    	.word	#0xe8442314
 f003a96: 2b00         	cmp	r3, #0x0
 f003a98: d1f8         	bne	0xf003a8c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0xca> @ imm = #-0x10
 f003a9a: 42b1         	cmp	r1, r6
 f003a9c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003aa0: d82d         	bhi	0xf003afe <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x13c> @ imm = #0x5a
 f003aa2: 0789         	lsls	r1, r1, #0x1e
 f003aa4: d03a         	beq	0xf003b1c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x15a> @ imm = #0x74
 f003aa6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003aaa: e854 1f14    	.word	#0xe8541f14
 f003aae: 3904         	subs	r1, #0x4
 f003ab0: e844 1214    	.word	#0xe8441214
 f003ab4: 2a00         	cmp	r2, #0x0
 f003ab6: d1f8         	bne	0xf003aaa <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0xe8> @ imm = #-0x10
 f003ab8: bf10         	yield
 f003aba: e854 1f14    	.word	#0xe8541f14
 f003abe: 1d0a         	adds	r2, r1, #0x4
 f003ac0: e844 2314    	.word	#0xe8442314
 f003ac4: 2b00         	cmp	r3, #0x0
 f003ac6: d1f8         	bne	0xf003aba <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0xf8> @ imm = #-0x10
 f003ac8: 42b1         	cmp	r1, r6
 f003aca: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003ace: d816         	bhi	0xf003afe <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x13c> @ imm = #0x2c
 f003ad0: 0789         	lsls	r1, r1, #0x1e
 f003ad2: d023         	beq	0xf003b1c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x15a> @ imm = #0x46
 f003ad4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003ad8: e854 1f14    	.word	#0xe8541f14
 f003adc: 3904         	subs	r1, #0x4
 f003ade: e844 1214    	.word	#0xe8441214
 f003ae2: 2a00         	cmp	r2, #0x0
 f003ae4: d1f8         	bne	0xf003ad8 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x116> @ imm = #-0x10
 f003ae6: bf10         	yield
 f003ae8: e854 1f14    	.word	#0xe8541f14
 f003aec: 1d0a         	adds	r2, r1, #0x4
 f003aee: e844 2314    	.word	#0xe8442314
 f003af2: 2b00         	cmp	r3, #0x0
 f003af4: d1f8         	bne	0xf003ae8 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x126> @ imm = #-0x10
 f003af6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003afa: 42b1         	cmp	r1, r6
 f003afc: d9a3         	bls	0xf003a46 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x84> @ imm = #-0xba
 f003afe: e854 0f14    	.word	#0xe8540f14
 f003b02: 3804         	subs	r0, #0x4
 f003b04: e844 0114    	.word	#0xe8440114
 f003b08: 2900         	cmp	r1, #0x0
 f003b0a: d1f8         	bne	0xf003afe <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x13c> @ imm = #-0x10
 f003b0c: f245 6078    	.word	#0xf2456078
 f003b10: 212c         	movs	r1, #0x2c
 f003b12: f6c0 7000    	.word	#0xf6c07000
 f003b16: f7fc fd98    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x34d0
 f003b1a: e15a         	b	0xf003dd2 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x410> @ imm = #0x2b4
 f003b1c: 6d61         	ldr	r1, [r4, #0x54]
 f003b1e: b1f9         	cbz	r1, 0xf003b60 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x19e> @ imm = #0x3e
 f003b20: f891 2098    	.word	#0xf8912098
 f003b24: b9fa         	cbnz	r2, 0xf003b66 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1a4> @ imm = #0x3e
 f003b26: f101 0598    	.word	#0xf1010598
 f003b2a: 2201         	movs	r2, #0x1
 f003b2c: e8d5 3f4f    	.word	#0xe8d53f4f
 f003b30: b9bb         	cbnz	r3, 0xf003b62 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1a0> @ imm = #0x2e
 f003b32: e8c5 2f43    	.word	#0xe8c52f43
 f003b36: 2b00         	cmp	r3, #0x0
 f003b38: d1f8         	bne	0xf003b2c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x16a> @ imm = #-0x10
 f003b3a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003b3e: 460b         	mov	r3, r1
 f003b40: f853 bf9c    	.word	#0xf853bf9c
 f003b44: f8d8 2014    	.word	#0xf8d82014
 f003b48: 6a18         	ldr	r0, [r3, #0x20]
 f003b4a: 900f         	str	r0, [sp, #0x3c]
 f003b4c: ea82 0270    	.word	#0xea820270
 f003b50: f103 0010    	.word	#0xf1030010
 f003b54: 455a         	cmp	r2, r11
 f003b56: 621a         	str	r2, [r3, #0x20]
 f003b58: 9010         	str	r0, [sp, #0x40]
 f003b5a: d105         	bne	0xf003b68 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1a6> @ imm = #0xa
 f003b5c: 2200         	movs	r2, #0x0
 f003b5e: e01b         	b	0xf003b98 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1d6> @ imm = #0x36
 f003b60: e7fe         	b	0xf003b60 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x19e> @ imm = #-0x4
 f003b62: f3bf 8f2f    	.word	#0xf3bf8f2f
 f003b66: e7fe         	b	0xf003b66 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1a4> @ imm = #-0x4
 f003b68: f8cd c038    	.word	#0xf8cdc038
 f003b6c: f8d1 c0a0    	.word	#0xf8d1c0a0
 f003b70: 4562         	cmp	r2, r12
 f003b72: d103         	bne	0xf003b7c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1ba> @ imm = #0x6
 f003b74: 2201         	movs	r2, #0x1
 f003b76: f8dd c038    	.word	#0xf8ddc038
 f003b7a: e00d         	b	0xf003b98 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1d6> @ imm = #0x1a
 f003b7c: f8d1 00a4    	.word	#0xf8d100a4
 f003b80: f8dd c038    	.word	#0xf8ddc038
 f003b84: 4282         	cmp	r2, r0
 f003b86: d101         	bne	0xf003b8c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1ca> @ imm = #0x2
 f003b88: 2202         	movs	r2, #0x2
 f003b8a: e004         	b	0xf003b96 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1d4> @ imm = #0x8
 f003b8c: f8d1 00a8    	.word	#0xf8d100a8
 f003b90: 4282         	cmp	r2, r0
 f003b92: d105         	bne	0xf003ba0 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1de> @ imm = #0xa
 f003b94: 2203         	movs	r2, #0x3
 f003b96: 9810         	ldr	r0, [sp, #0x40]
 f003b98: f850 0022    	.word	#0xf8500022
 f003b9c: fb09 f900    	.word	#0xfb09f900
 f003ba0: f85e 2c74    	.word	#0xf85e2c74
 f003ba4: 3201         	adds	r2, #0x1
 f003ba6: f84e 2c74    	.word	#0xf84e2c74
 f003baa: 2a0a         	cmp	r2, #0xa
 f003bac: d11c         	bne	0xf003be8 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x226> @ imm = #0x38
 f003bae: 9a0f         	ldr	r2, [sp, #0x3c]
 f003bb0: 4593         	cmp	r11, r2
 f003bb2: d101         	bne	0xf003bb8 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x1f6> @ imm = #0x2
 f003bb4: 2000         	movs	r0, #0x0
 f003bb6: e011         	b	0xf003bdc <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x21a> @ imm = #0x22
 f003bb8: f8d1 00a0    	.word	#0xf8d100a0
 f003bbc: 4290         	cmp	r0, r2
 f003bbe: d101         	bne	0xf003bc4 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x202> @ imm = #0x2
 f003bc0: 2001         	movs	r0, #0x1
 f003bc2: e00b         	b	0xf003bdc <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x21a> @ imm = #0x16
 f003bc4: f8d1 00a4    	.word	#0xf8d100a4
 f003bc8: 4290         	cmp	r0, r2
 f003bca: d101         	bne	0xf003bd0 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x20e> @ imm = #0x2
 f003bcc: 2002         	movs	r0, #0x2
 f003bce: e005         	b	0xf003bdc <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x21a> @ imm = #0xa
 f003bd0: f8d1 00a8    	.word	#0xf8d100a8
 f003bd4: 4290         	cmp	r0, r2
 f003bd6: f040 80e1    	.word	#0xf04080e1
 f003bda: 2003         	movs	r0, #0x3
 f003bdc: 9a10         	ldr	r2, [sp, #0x40]
 f003bde: f852 1020    	.word	#0xf8521020
 f003be2: 3101         	adds	r1, #0x1
 f003be4: f842 1020    	.word	#0xf8421020
 f003be8: 2000         	movs	r0, #0x0
 f003bea: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003bee: 7028         	strb	r0, [r5]
 f003bf0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003bf4: e854 0f14    	.word	#0xe8540f14
 f003bf8: 3804         	subs	r0, #0x4
 f003bfa: e844 0114    	.word	#0xe8440114
 f003bfe: 2900         	cmp	r1, #0x0
 f003c00: d1f8         	bne	0xf003bf4 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x232> @ imm = #-0x10
 f003c02: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003c06: e854 0f0f    	.word	#0xe8540f0f
 f003c0a: 3801         	subs	r0, #0x1
 f003c0c: e844 010f    	.word	#0xe844010f
 f003c10: 2900         	cmp	r1, #0x0
 f003c12: d1f8         	bne	0xf003c06 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x244> @ imm = #-0x10
 f003c14: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003c18: 7960         	ldrb	r0, [r4, #0x5]
 f003c1a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003c1e: b1b0         	cbz	r0, 0xf003c4e <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x28c> @ imm = #0x2c
 f003c20: 6be0         	ldr	r0, [r4, #0x3c]
 f003c22: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003c26: b990         	cbnz	r0, 0xf003c4e <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x28c> @ imm = #0x24
 f003c28: f3ef 8005    	.word	#0xf3ef8005
 f003c2c: b158         	cbz	r0, 0xf003c46 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x284> @ imm = #0x16
 f003c2e: f3ef 8005    	.word	#0xf3ef8005
 f003c32: 280e         	cmp	r0, #0xe
 f003c34: bf1f         	itttt	ne
 f003c36: f64e 5004    	.word	#0xf64e5004
 f003c3a: f2ce 0000    	.word	#0xf2ce0000
 f003c3e: f04f 5180    	.word	#0xf04f5180
 f003c42: 6001         	strne	r1, [r0]
 f003c44: e003         	b	0xf003c4e <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x28c> @ imm = #0x6
 f003c46: 4665         	mov	r5, r12
 f003c48: f7fd f9b7    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x2c92
 f003c4c: 46ac         	mov	r12, r5
 f003c4e: eb0c 0009    	.word	#0xeb0c0009
 f003c52: f100 0bbc    	.word	#0xf1000bbc
 f003c56: 45b3         	cmp	r11, r6
 f003c58: d900         	bls	0xf003c5c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x29a> @ imm = #0x0
 f003c5a: e7fe         	b	0xf003c5a <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x298> @ imm = #-0x4
 f003c5c: 4620         	mov	r0, r4
 f003c5e: 4665         	mov	r5, r12
 f003c60: f810 1b09    	.word	#0xf8101b09
 f003c64: 4659         	mov	r1, r11
 f003c66: f7fd fb77    	bl	0xf001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e> @ imm = #-0x2912
 f003c6a: 2800         	cmp	r0, #0x0
 f003c6c: f000 8095    	.word	#0xf0008095
 f003c70: f8d8 301c    	.word	#0xf8d8301c
 f003c74: 4681         	mov	r9, r0
 f003c76: 2000         	movs	r0, #0x0
 f003c78: e9da 1200    	.word	#0xe9da1200
 f003c7c: f8c9 0008    	.word	#0xf8c90008
 f003c80: ebab 0005    	.word	#0xebab0005
 f003c84: eb09 0600    	.word	#0xeb090600
 f003c88: 0598         	lsls	r0, r3, #0x16
 f003c8a: f04f 006c    	.word	#0xf04f006c
 f003c8e: e9c9 2100    	.word	#0xe9c92100
 f003c92: 9310         	str	r3, [sp, #0x40]
 f003c94: bf58         	it	pl
 f003c96: 2068         	movpl	r0, #0x68
 f003c98: 4401         	add	r1, r0
 f003c9a: 462a         	mov	r2, r5
 f003c9c: 4630         	mov	r0, r6
 f003c9e: f000 f8e2    	bl	0xf003e66 <__aeabi_memcpy8> @ imm = #0x1c4
 f003ca2: f8d8 0018    	.word	#0xf8d80018
 f003ca6: f108 0e50    	.word	#0xf1080e50
 f003caa: 900d         	str	r0, [sp, #0x34]
 f003cac: f8d8 0010    	.word	#0xf8d80010
 f003cb0: 900e         	str	r0, [sp, #0x38]
 f003cb2: f8d8 0020    	.word	#0xf8d80020
 f003cb6: 900f         	str	r0, [sp, #0x3c]
 f003cb8: f8d8 0024    	.word	#0xf8d80024
 f003cbc: 900c         	str	r0, [sp, #0x30]
 f003cbe: f8d8 0028    	.word	#0xf8d80028
 f003cc2: 900b         	str	r0, [sp, #0x2c]
 f003cc4: f8d8 002c    	.word	#0xf8d8002c
 f003cc8: 900a         	str	r0, [sp, #0x28]
 f003cca: f8d8 0030    	.word	#0xf8d80030
 f003cce: 9009         	str	r0, [sp, #0x24]
 f003cd0: f8d8 0034    	.word	#0xf8d80034
 f003cd4: 9008         	str	r0, [sp, #0x20]
 f003cd6: f8d8 0038    	.word	#0xf8d80038
 f003cda: 9007         	str	r0, [sp, #0x1c]
 f003cdc: f8d8 003c    	.word	#0xf8d8003c
 f003ce0: 9006         	str	r0, [sp, #0x18]
 f003ce2: f8d8 0040    	.word	#0xf8d80040
 f003ce6: 9005         	str	r0, [sp, #0x14]
 f003ce8: f8d8 0044    	.word	#0xf8d80044
 f003cec: 9002         	str	r0, [sp, #0x8]
 f003cee: f8d8 0048    	.word	#0xf8d80048
 f003cf2: 9001         	str	r0, [sp, #0x4]
 f003cf4: f8d8 004c    	.word	#0xf8d8004c
 f003cf8: 9000         	str	r0, [sp]
 f003cfa: e9d8 0200    	.word	#0xe9d80200
 f003cfe: f846 0d68    	.word	#0xf8460d68
 f003d02: 9802         	ldr	r0, [sp, #0x8]
 f003d04: e9d8 b118    	.word	#0xe9d8b118
 f003d08: 6470         	str	r0, [r6, #0x44]
 f003d0a: 9801         	ldr	r0, [sp, #0x4]
 f003d0c: 64b0         	str	r0, [r6, #0x48]
 f003d0e: 9800         	ldr	r0, [sp]
 f003d10: 6671         	str	r1, [r6, #0x64]
 f003d12: f106 014c    	.word	#0xf106014c
 f003d16: e89e 5008    	.word	#0xe89e5008
 f003d1a: e881 5009    	.word	#0xe8815009
 f003d1e: 980c         	ldr	r0, [sp, #0x30]
 f003d20: 6270         	str	r0, [r6, #0x24]
 f003d22: 980b         	ldr	r0, [sp, #0x2c]
 f003d24: 62b0         	str	r0, [r6, #0x28]
 f003d26: 980a         	ldr	r0, [sp, #0x28]
 f003d28: 62f0         	str	r0, [r6, #0x2c]
 f003d2a: 9809         	ldr	r0, [sp, #0x24]
 f003d2c: 6330         	str	r0, [r6, #0x30]
 f003d2e: 9808         	ldr	r0, [sp, #0x20]
 f003d30: 6370         	str	r0, [r6, #0x34]
 f003d32: 9807         	ldr	r0, [sp, #0x1c]
 f003d34: 63b0         	str	r0, [r6, #0x38]
 f003d36: 9806         	ldr	r0, [sp, #0x18]
 f003d38: 63f0         	str	r0, [r6, #0x3c]
 f003d3a: 9805         	ldr	r0, [sp, #0x14]
 f003d3c: 6430         	str	r0, [r6, #0x40]
 f003d3e: f109 007c    	.word	#0xf109007c
 f003d42: 9910         	ldr	r1, [sp, #0x40]
 f003d44: 9204         	str	r2, [sp, #0x10]
 f003d46: f8d8 505c    	.word	#0xf8d8505c
 f003d4a: f421 7100    	.word	#0xf4217100
 f003d4e: f8d8 2008    	.word	#0xf8d82008
 f003d52: e9ca 6000    	.word	#0xe9ca6000
 f003d56: 980d         	ldr	r0, [sp, #0x34]
 f003d58: f8d8 800c    	.word	#0xf8d8800c
 f003d5c: 9203         	str	r2, [sp, #0xc]
 f003d5e: f643 624b    	.word	#0xf643624b
 f003d62: 9b04         	ldr	r3, [sp, #0x10]
 f003d64: 3004         	adds	r0, #0x4
 f003d66: 6073         	str	r3, [r6, #0x4]
 f003d68: f6c0 7200    	.word	#0xf6c07200
 f003d6c: 9b03         	ldr	r3, [sp, #0xc]
 f003d6e: e9c6 3802    	.word	#0xe9c63802
 f003d72: 9b0e         	ldr	r3, [sp, #0x38]
 f003d74: e9c6 0106    	.word	#0xe9c60106
 f003d78: 980f         	ldr	r0, [sp, #0x3c]
 f003d7a: e9c6 5b17    	.word	#0xe9c65b17
 f003d7e: e9c6 3204    	.word	#0xe9c63204
 f003d82: 6230         	str	r0, [r6, #0x20]
 f003d84: e854 0f12    	.word	#0xe8540f12
 f003d88: 3001         	adds	r0, #0x1
 f003d8a: e844 0112    	.word	#0xe8440112
 f003d8e: 2900         	cmp	r1, #0x0
 f003d90: d1f8         	bne	0xf003d84 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x3c2> @ imm = #-0x10
 f003d92: b011         	add	sp, #0x44
 f003d94: e8bd 0f00    	.word	#0xe8bd0f00
 f003d98: bdf0         	pop	{r4, r5, r6, r7, pc}
 f003d9a: e7fe         	b	0xf003d9a <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x3d8> @ imm = #-0x4
 f003d9c: f8d1 00c0    	.word	#0xf8d100c0
 f003da0: 2804         	cmp	r0, #0x4
 f003da2: bf3e         	ittt	lo
 f003da4: f843 2020    	.word	#0xf8432020
 f003da8: f8d1 00c0    	.word	#0xf8d100c0
 f003dac: 2804         	cmplo	r0, #0x4
 f003dae: d20d         	bhs	0xf003dcc <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x40a> @ imm = #0x1a
 f003db0: eb03 0080    	.word	#0xeb030080
 f003db4: 2202         	movs	r2, #0x2
 f003db6: 6102         	str	r2, [r0, #0x10]
 f003db8: f8d1 00c0    	.word	#0xf8d100c0
 f003dbc: 3001         	adds	r0, #0x1
 f003dbe: f010 0203    	.word	#0xf0100203
 f003dc2: bf18         	it	ne
 f003dc4: 4602         	movne	r2, r0
 f003dc6: f8c1 20c0    	.word	#0xf8c120c0
 f003dca: e70d         	b	0xf003be8 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x226> @ imm = #-0x1e6
 f003dcc: 2104         	movs	r1, #0x4
 f003dce: f7fc fc4d    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x3766
 f003dd2: defe         	trap
 f003dd4: 4606         	mov	r6, r0
 f003dd6: 2000         	movs	r0, #0x0
 f003dd8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003ddc: 7028         	strb	r0, [r5]
 f003dde: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003de2: e854 0f14    	.word	#0xe8540f14
 f003de6: 3804         	subs	r0, #0x4
 f003de8: e844 0114    	.word	#0xe8440114
 f003dec: 2900         	cmp	r1, #0x0
 f003dee: d1f8         	bne	0xf003de2 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x420> @ imm = #-0x10
 f003df0: e000         	b	0xf003df4 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x432> @ imm = #0x0
 f003df2: 4606         	mov	r6, r0
 f003df4: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003df8: e854 0f0f    	.word	#0xe8540f0f
 f003dfc: 3801         	subs	r0, #0x1
 f003dfe: e844 010f    	.word	#0xe844010f
 f003e02: 2900         	cmp	r1, #0x0
 f003e04: d1f8         	bne	0xf003df8 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x436> @ imm = #-0x10
 f003e06: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003e0a: 7960         	ldrb	r0, [r4, #0x5]
 f003e0c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003e10: b1a0         	cbz	r0, 0xf003e3c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x47a> @ imm = #0x28
 f003e12: 6be0         	ldr	r0, [r4, #0x3c]
 f003e14: f3bf 8f5f    	.word	#0xf3bf8f5f
 f003e18: b980         	cbnz	r0, 0xf003e3c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x47a> @ imm = #0x20
 f003e1a: f3ef 8005    	.word	#0xf3ef8005
 f003e1e: b910         	cbnz	r0, 0xf003e26 <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x464> @ imm = #0x4
 f003e20: f7fd f8cb    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x2e6a
 f003e24: e00a         	b	0xf003e3c <hopter::task::segmented_stack::more_stack::hba837af733e59a63+0x47a> @ imm = #0x14
 f003e26: f3ef 8005    	.word	#0xf3ef8005
 f003e2a: 280e         	cmp	r0, #0xe
 f003e2c: bf1f         	itttt	ne
 f003e2e: f64e 5004    	.word	#0xf64e5004
 f003e32: f2ce 0000    	.word	#0xf2ce0000
 f003e36: f04f 5180    	.word	#0xf04f5180
 f003e3a: 6001         	strne	r1, [r0]
 f003e3c: 4630         	mov	r0, r6
 f003e3e: f001 fbc9    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x1792
 f003e42: defe         	trap
 f003e44: f7fc fc7d    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x3706
 f003e48: defe         	trap

0f003e4a <hopter::interrupt::svc::svc_less_stack::h09019249c83c4e55>:
 f003e4a: df03         	svc	#0x3
 f003e4c: 4770         	bx	lr
 f003e4e: defe         	trap

0f003e50 <HardFault>:
 f003e50: e7fe         	b	0xf003e50 <HardFault>   @ imm = #-0x4
 f003e52: defe         	trap

0f003e54 <__aeabi_memset>:
 f003e54: 4613         	mov	r3, r2
 f003e56: 460a         	mov	r2, r1
 f003e58: 4619         	mov	r1, r3
 f003e5a: f7fc bc9b    	.word	#0xf7fcbc9b
 f003e5e: defe         	trap

0f003e60 <__aeabi_memset8>:
 f003e60: f7ff bff8    	.word	#0xf7ffbff8
 f003e64: defe         	trap

0f003e66 <__aeabi_memcpy8>:
 f003e66: f7fc bc8e    	.word	#0xf7fcbc8e
 f003e6a: defe         	trap

0f003e6c <__aeabi_memclr8>:
 f003e6c: 460a         	mov	r2, r1
 f003e6e: 4049         	eors	r1, r1
 f003e70: f7fc bc90    	.word	#0xf7fcbc90
 f003e74: defe         	trap

0f003e76 <__aeabi_memmove8>:
 f003e76: f000 b801    	.word	#0xf000b801
 f003e7a: defe         	trap

0f003e7c <memmove>:
 f003e7c: 4288         	cmp	r0, r1
 f003e7e: dd01         	ble	0xf003e84 <memmove+0x8> @ imm = #0x2
 f003e80: f7fc bc81    	.word	#0xf7fcbc81
 f003e84: f000 b801    	.word	#0xf000b801
 f003e88: defe         	trap

0f003e8a <memcpy_fwd>:
 f003e8a: b142         	cbz	r2, 0xf003e9e <memcpy_fwd+0x14> @ imm = #0x10
 f003e8c: 4684         	mov	r12, r0
 f003e8e: 1812         	adds	r2, r2, r0
 f003e90: f811 3b01    	.word	#0xf8113b01
 f003e94: f800 3b01    	.word	#0xf8003b01
 f003e98: 4282         	cmp	r2, r0
 f003e9a: d1f9         	bne	0xf003e90 <memcpy_fwd+0x6> @ imm = #-0xe
 f003e9c: 4660         	mov	r0, r12
 f003e9e: 4770         	bx	lr
 f003ea0: defe         	trap

0f003ea2 <WWDG>:
 f003ea2: e7fe         	b	0xf003ea2 <WWDG>        @ imm = #-0x4
 f003ea4: defe         	trap

0f003ea6 <__morestack_non_split>:
 f003ea6: deff         	udf	#0xff
 f003ea8: defe         	trap

0f003eaa <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101>:
 f003eaa: f04f 5c00    	.word	#0xf04f5c00
 f003eae: f8dc c000    	.word	#0xf8dcc000
 f003eb2: ebbd 0c0c    	.word	#0xebbd0c0c
 f003eb6: f1bc 0f48    	.word	#0xf1bc0f48
 f003eba: da02         	bge	0xf003ec2 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x18> @ imm = #0x4
 f003ebc: dfff         	svc	#0xff
 f003ebe: 0012         	movs	r2, r2
 f003ec0: 0002         	movs	r2, r0
 f003ec2: b5f0         	push	{r4, r5, r6, r7, lr}
 f003ec4: af03         	add	r7, sp, #0xc
 f003ec6: e92d 0700    	.word	#0xe92d0700
 f003eca: b08a         	sub	sp, #0x28
 f003ecc: 4680         	mov	r8, r0
 f003ece: 0758         	lsls	r0, r3, #0x1d
 f003ed0: d007         	beq	0xf003ee2 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x38> @ imm = #0xe
 f003ed2: f645 0041    	.word	#0xf6450041
 f003ed6: f6c0 7000    	.word	#0xf6c07000
 f003eda: b00a         	add	sp, #0x28
 f003edc: e8bd 0700    	.word	#0xe8bd0700
 f003ee0: bdf0         	pop	{r4, r5, r6, r7, pc}
 f003ee2: b183         	cbz	r3, 0xf003f06 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x5c> @ imm = #0x20
 f003ee4: 2b03         	cmp	r3, #0x3
 f003ee6: f240 8084    	.word	#0xf2408084
 f003eea: 6810         	ldr	r0, [r2]
 f003eec: 0040         	lsls	r0, r0, #0x1
 f003eee: eb02 0060    	.word	#0xeb020060
 f003ef2: 4288         	cmp	r0, r1
 f003ef4: d90f         	bls	0xf003f16 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x6c> @ imm = #0x1e
 f003ef6: f645 0012    	.word	#0xf6450012
 f003efa: f6c0 7000    	.word	#0xf6c07000
 f003efe: b00a         	add	sp, #0x28
 f003f00: e8bd 0700    	.word	#0xe8bd0700
 f003f04: bdf0         	pop	{r4, r5, r6, r7, pc}
 f003f06: f245 70e9    	.word	#0xf24570e9
 f003f0a: f6c0 7000    	.word	#0xf6c07000
 f003f0e: b00a         	add	sp, #0x28
 f003f10: e8bd 0700    	.word	#0xe8bd0700
 f003f14: bdf0         	pop	{r4, r5, r6, r7, pc}
 f003f16: f1a3 0008    	.word	#0xf1a30008
 f003f1a: 1f1e         	subs	r6, r3, #0x4
 f003f1c: 42b0         	cmp	r0, r6
 f003f1e: d86d         	bhi	0xf003ffc <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x152> @ imm = #0xda
 f003f20: 5815         	ldr	r5, [r2, r0]
 f003f22: 1814         	adds	r4, r2, r0
 f003f24: e9d7 ec02    	.word	#0xe9d7ec02
 f003f28: 006d         	lsls	r5, r5, #0x1
 f003f2a: eb04 0565    	.word	#0xeb040565
 f003f2e: 428d         	cmp	r5, r1
 f003f30: d904         	bls	0xf003f3c <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x92> @ imm = #0x8
 f003f32: 2500         	movs	r5, #0x0
 f003f34: 2b10         	cmp	r3, #0x10
 f003f36: d113         	bne	0xf003f60 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0xb6> @ imm = #0x26
 f003f38: 2108         	movs	r1, #0x8
 f003f3a: e032         	b	0xf003fa2 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0xf8> @ imm = #0x64
 f003f3c: 2b07         	cmp	r3, #0x7
 f003f3e: d962         	bls	0xf004006 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x15c> @ imm = #0xc4
 f003f40: ad01         	add	r5, sp, #0x4
 f003f42: 4621         	mov	r1, r4
 f003f44: 4672         	mov	r2, lr
 f003f46: 4663         	mov	r3, r12
 f003f48: 4628         	mov	r0, r5
 f003f4a: f000 f864    	bl	0xf004016 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33> @ imm = #0xc8
 f003f4e: f89d 0004    	.word	#0xf89d0004
 f003f52: 2803         	cmp	r0, #0x3
 f003f54: d137         	bne	0xf003fc6 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x11c> @ imm = #0x6e
 f003f56: 9802         	ldr	r0, [sp, #0x8]
 f003f58: b00a         	add	sp, #0x28
 f003f5a: e8bd 0700    	.word	#0xe8bd0700
 f003f5e: bdf0         	pop	{r4, r5, r6, r7, pc}
 f003f60: f04f 0904    	.word	#0xf04f0904
 f003f64: 1b44         	subs	r4, r0, r5
 f003f66: eb09 0454    	.word	#0xeb090454
 f003f6a: f024 0407    	.word	#0xf0240407
 f003f6e: 1966         	adds	r6, r4, r5
 f003f70: 1d34         	adds	r4, r6, #0x4
 f003f72: f116 0f05    	.word	#0xf1160f05
 f003f76: d832         	bhi	0xf003fde <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x134> @ imm = #0x64
 f003f78: 429c         	cmp	r4, r3
 f003f7a: d835         	bhi	0xf003fe8 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x13e> @ imm = #0x6a
 f003f7c: 5994         	ldr	r4, [r2, r6]
 f003f7e: eb02 0a06    	.word	#0xeb020a06
 f003f82: 0064         	lsls	r4, r4, #0x1
 f003f84: eb0a 0464    	.word	#0xeb0a0464
 f003f88: 428c         	cmp	r4, r1
 f003f8a: bf94         	ite	ls
 f003f8c: 4635         	movls	r5, r6
 f003f8e: 4630         	movhi	r0, r6
 f003f90: f1a0 0408    	.word	#0xf1a00408
 f003f94: 42a5         	cmp	r5, r4
 f003f96: d3e5         	blo	0xf003f64 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0xba> @ imm = #-0x36
 f003f98: f105 0108    	.word	#0xf1050108
 f003f9c: f115 0f09    	.word	#0xf1150f09
 f003fa0: d835         	bhi	0xf00400e <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x164> @ imm = #0x6a
 f003fa2: 4299         	cmp	r1, r3
 f003fa4: d82e         	bhi	0xf004004 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x15a> @ imm = #0x5c
 f003fa6: 1951         	adds	r1, r2, r5
 f003fa8: ad01         	add	r5, sp, #0x4
 f003faa: 4672         	mov	r2, lr
 f003fac: 4663         	mov	r3, r12
 f003fae: 4628         	mov	r0, r5
 f003fb0: f000 f831    	bl	0xf004016 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33> @ imm = #0x62
 f003fb4: f89d 0004    	.word	#0xf89d0004
 f003fb8: 2803         	cmp	r0, #0x3
 f003fba: d104         	bne	0xf003fc6 <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101+0x11c> @ imm = #0x8
 f003fbc: 9802         	ldr	r0, [sp, #0x8]
 f003fbe: b00a         	add	sp, #0x28
 f003fc0: e8bd 0700    	.word	#0xe8bd0700
 f003fc4: bdf0         	pop	{r4, r5, r6, r7, pc}
 f003fc6: cd0f         	ldm	r5!, {r0, r1, r2, r3}
 f003fc8: e8a8 000f    	.word	#0xe8a8000f
 f003fcc: e895 004f    	.word	#0xe895004f
 f003fd0: e888 004f    	.word	#0xe888004f
 f003fd4: 2000         	movs	r0, #0x0
 f003fd6: b00a         	add	sp, #0x28
 f003fd8: e8bd 0700    	.word	#0xe8bd0700
 f003fdc: bdf0         	pop	{r4, r5, r6, r7, pc}
 f003fde: 4630         	mov	r0, r6
 f003fe0: 4621         	mov	r1, r4
 f003fe2: f7fc fb43    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x397a
 f003fe6: defe         	trap
 f003fe8: 4620         	mov	r0, r4
 f003fea: 4619         	mov	r1, r3
 f003fec: f7fc fb3e    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x3984
 f003ff0: defe         	trap
 f003ff2: 2004         	movs	r0, #0x4
 f003ff4: 4619         	mov	r1, r3
 f003ff6: f7fc fb39    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x398e
 f003ffa: defe         	trap
 f003ffc: 4631         	mov	r1, r6
 f003ffe: f7fc fb35    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x3996
 f004002: defe         	trap
 f004004: 4608         	mov	r0, r1
 f004006: 4619         	mov	r1, r3
 f004008: f7fc fb30    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x39a0
 f00400c: defe         	trap
 f00400e: 4628         	mov	r0, r5
 f004010: f7fc fb2c    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x39a8
 f004014: defe         	trap

0f004016 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33>:
 f004016: f04f 5c00    	.word	#0xf04f5c00
 f00401a: f8dc c000    	.word	#0xf8dcc000
 f00401e: ebbd 0c0c    	.word	#0xebbd0c0c
 f004022: f1bc 0f28    	.word	#0xf1bc0f28
 f004026: da02         	bge	0xf00402e <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x18> @ imm = #0x4
 f004028: dfff         	svc	#0xff
 f00402a: 000a         	movs	r2, r1
 f00402c: 0000         	movs	r0, r0
 f00402e: b5f0         	push	{r4, r5, r6, r7, lr}
 f004030: af03         	add	r7, sp, #0xc
 f004032: e92d 0f00    	.word	#0xe92d0f00
 f004036: b081         	sub	sp, #0x4
 f004038: 460e         	mov	r6, r1
 f00403a: f856 5b04    	.word	#0xf8565b04
 f00403e: 2d00         	cmp	r5, #0x0
 f004040: d408         	bmi	0xf004054 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x3e> @ imm = #0x10
 f004042: 684c         	ldr	r4, [r1, #0x4]
 f004044: 2c01         	cmp	r4, #0x1
 f004046: d10b         	bne	0xf004060 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x4a> @ imm = #0x16
 f004048: 2102         	movs	r1, #0x2
 f00404a: 7001         	strb	r1, [r0]
 f00404c: b001         	add	sp, #0x4
 f00404e: e8bd 0f00    	.word	#0xe8bd0f00
 f004052: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004054: f245 7252    	.word	#0xf2457252
 f004058: 2128         	movs	r1, #0x28
 f00405a: f6c0 7200    	.word	#0xf6c07200
 f00405e: e082         	b	0xf004166 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x150> @ imm = #0x104
 f004060: 006d         	lsls	r5, r5, #0x1
 f004062: f1b4 3fff    	.word	#0xf1b43fff
 f004066: eb01 0565    	.word	#0xeb010565
 f00406a: dd10         	ble	0xf00408e <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x78> @ imm = #0x20
 f00406c: 2b00         	cmp	r3, #0x0
 f00406e: f000 80b4    	.word	#0xf00080b4
 f004072: 0061         	lsls	r1, r4, #0x1
 f004074: eb06 0161    	.word	#0xeb060161
 f004078: eba1 0e02    	.word	#0xeba10e02
 f00407c: ea5f 718e    	.word	#0xea5f718e
 f004080: d015         	beq	0xf0040ae <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x98> @ imm = #0x2a
 f004082: f245 72b8    	.word	#0xf24572b8
 f004086: 2131         	movs	r1, #0x31
 f004088: f6c0 7200    	.word	#0xf6c07200
 f00408c: e06b         	b	0xf004166 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x150> @ imm = #0xd6
 f00408e: 2100         	movs	r1, #0x0
 f004090: 2201         	movs	r2, #0x1
 f004092: 2304         	movs	r3, #0x4
 f004094: e9c0 2504    	.word	#0xe9c02504
 f004098: f3c4 6203    	.word	#0xf3c46203
 f00409c: e9c0 6302    	.word	#0xe9c06302
 f0040a0: 6181         	str	r1, [r0, #0x18]
 f0040a2: 7042         	strb	r2, [r0, #0x1]
 f0040a4: 7001         	strb	r1, [r0]
 f0040a6: b001         	add	sp, #0x4
 f0040a8: e8bd 0f00    	.word	#0xe8bd0f00
 f0040ac: bdf0         	pop	{r4, r5, r6, r7, pc}
 f0040ae: f10e 0103    	.word	#0xf10e0103
 f0040b2: 4299         	cmp	r1, r3
 f0040b4: f080 8096    	.word	#0xf0808096
 f0040b8: f812 b001    	.word	#0xf812b001
 f0040bc: f1bb 0ff0    	.word	#0xf1bb0ff0
 f0040c0: d226         	bhs	0xf004110 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0xfa> @ imm = #0x4c
 f0040c2: f10e 0107    	.word	#0xf10e0107
 f0040c6: 4299         	cmp	r1, r3
 f0040c8: f080 808c    	.word	#0xf080808c
 f0040cc: 5c51         	ldrb	r1, [r2, r1]
 f0040ce: f10e 0404    	.word	#0xf10e0404
 f0040d2: eb0e 0181    	.word	#0xeb0e0181
 f0040d6: f101 0c08    	.word	#0xf1010c08
 f0040da: 45a4         	cmp	r12, r4
 f0040dc: f0c0 8094    	.word	#0xf0c08094
 f0040e0: 459c         	cmp	r12, r3
 f0040e2: f200 808c    	.word	#0xf200808c
 f0040e6: ebac 0104    	.word	#0xebac0104
 f0040ea: 078e         	lsls	r6, r1, #0x1e
 f0040ec: d125         	bne	0xf00413a <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x124> @ imm = #0x4a
 f0040ee: f852 600e    	.word	#0xf852600e
 f0040f2: 4496         	add	lr, r2
 f0040f4: 2900         	cmp	r1, #0x0
 f0040f6: ea4f 0646    	.word	#0xea4f0646
 f0040fa: eb0e 0a66    	.word	#0xeb0e0a66
 f0040fe: d040         	beq	0xf004182 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x16c> @ imm = #0x80
 f004100: 2903         	cmp	r1, #0x3
 f004102: d974         	bls	0xf0041ee <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x1d8> @ imm = #0xe8
 f004104: f04f 0800    	.word	#0xf04f0800
 f004108: f04f 0901    	.word	#0xf04f0901
 f00410c: 46a6         	mov	lr, r4
 f00410e: e049         	b	0xf0041a4 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x18e> @ imm = #0x92
 f004110: f00b 080f    	.word	#0xf00b080f
 f004114: f1a8 0101    	.word	#0xf1a80101
 f004118: 2902         	cmp	r1, #0x2
 f00411a: d214         	bhs	0xf004146 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x130> @ imm = #0x28
 f00411c: eb0e 0102    	.word	#0xeb0e0102
 f004120: 7889         	ldrb	r1, [r1, #0x2]
 f004122: eb0e 0181    	.word	#0xeb0e0181
 f004126: f101 0c04    	.word	#0xf1010c04
 f00412a: 45f4         	cmp	r12, lr
 f00412c: d371         	blo	0xf004212 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x1fc> @ imm = #0xe2
 f00412e: 459c         	cmp	r12, r3
 f004130: d865         	bhi	0xf0041fe <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x1e8> @ imm = #0xca
 f004132: ebac 010e    	.word	#0xebac010e
 f004136: 078c         	lsls	r4, r1, #0x1e
 f004138: d01d         	beq	0xf004176 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x160> @ imm = #0x3a
 f00413a: f245 7214    	.word	#0xf2457214
 f00413e: 213e         	movs	r1, #0x3e
 f004140: f6c0 7200    	.word	#0xf6c07200
 f004144: e00f         	b	0xf004166 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x150> @ imm = #0x1e
 f004146: f1b8 0f00    	.word	#0xf1b80f00
 f00414a: d107         	bne	0xf00415c <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x146> @ imm = #0xe
 f00414c: f10e 0c04    	.word	#0xf10e0c04
 f004150: f04f 0800    	.word	#0xf04f0800
 f004154: 2104         	movs	r1, #0x4
 f004156: f04f 0901    	.word	#0xf04f0901
 f00415a: e023         	b	0xf0041a4 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x18e> @ imm = #0x46
 f00415c: f245 727a    	.word	#0xf245727a
 f004160: 213e         	movs	r1, #0x3e
 f004162: f6c0 7200    	.word	#0xf6c07200
 f004166: e9c0 2101    	.word	#0xe9c02101
 f00416a: 2103         	movs	r1, #0x3
 f00416c: 7001         	strb	r1, [r0]
 f00416e: b001         	add	sp, #0x4
 f004170: e8bd 0f00    	.word	#0xe8bd0f00
 f004174: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004176: b159         	cbz	r1, 0xf004190 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x17a> @ imm = #0x16
 f004178: 2903         	cmp	r1, #0x3
 f00417a: d938         	bls	0xf0041ee <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x1d8> @ imm = #0x70
 f00417c: f04f 0901    	.word	#0xf04f0901
 f004180: e008         	b	0xf004194 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x17e> @ imm = #0x10
 f004182: f04f 0900    	.word	#0xf04f0900
 f004186: 2100         	movs	r1, #0x0
 f004188: 46a6         	mov	lr, r4
 f00418a: f04f 0800    	.word	#0xf04f0800
 f00418e: e009         	b	0xf0041a4 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x18e> @ imm = #0x12
 f004190: f04f 0900    	.word	#0xf04f0900
 f004194: 4589         	cmp	r9, r1
 f004196: d205         	bhs	0xf0041a4 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x18e> @ imm = #0xa
 f004198: f089 0403    	.word	#0xf0890403
 f00419c: 428c         	cmp	r4, r1
 f00419e: d22a         	bhs	0xf0041f6 <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x1e0> @ imm = #0x54
 f0041a0: f109 0901    	.word	#0xf1090901
 f0041a4: 4563         	cmp	r3, r12
 f0041a6: d32a         	blo	0xf0041fe <hopter::unwind::unwind::UnwindAbility::from_bytes::h220871d566875d33+0x1e8> @ imm = #0x54
 f0041a8: eb02 060c    	.word	#0xeb02060c
 f0041ac: 4472         	add	r2, lr
 f0041ae: e9c0 1903    	.word	#0xe9c01903
 f0041b2: 2100         	movs	r1, #0x0
 f0041b4: eba3 030c    	.word	#0xeba3030c
 f0041b8: e9c0 a201    	.word	#0xe9c0a201
 f0041bc: e9c0 5605    	.word	#0xe9c05605
 f0041c0: f1bb 0ff0    	.word	#0xf1bb0ff0
 f0041c4: e9c0 3507    	.word	#0xe9c03507
 f0041c8: f880 8001    	.word	#0xf8808001
 f0041cc: bf38         	it	lo
 f0041ce: 2101         	movlo	r1, #0x1
 f0041d0: 7001         	strb	r1, [r0]
 f0041d2: b001         	add	sp, #0x4
 f0041d4: e8bd 0f00    	.word	#0xe8bd0f00
 f0041d8: bdf0         	pop	{r4, r5, r6, r7, pc}
 f0041da: 2000         	movs	r0, #0x0
 f0041dc: 2100         	movs	r1, #0x0
 f0041de: f7fc fa45    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x3b76
 f0041e2: defe         	trap
 f0041e4: 4608         	mov	r0, r1
 f0041e6: 4619         	mov	r1, r3
 f0041e8: f7fc fa40    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x3b80
 f0041ec: defe         	trap
 f0041ee: 2003         	movs	r0, #0x3
 f0041f0: f7fc fa3c    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x3b88
 f0041f4: defe         	trap
 f0041f6: 4620         	mov	r0, r4
 f0041f8: f7fc fa38    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x3b90
 f0041fc: defe         	trap
 f0041fe: 4660         	mov	r0, r12
 f004200: 4619         	mov	r1, r3
 f004202: f7fc fa33    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x3b9a
 f004206: defe         	trap
 f004208: 4620         	mov	r0, r4
 f00420a: 4661         	mov	r1, r12
 f00420c: f7fc fa2e    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x3ba4
 f004210: defe         	trap
 f004212: 4670         	mov	r0, lr
 f004214: 4661         	mov	r1, r12
 f004216: f7fc fa29    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x3bae
 f00421a: defe         	trap

0f00421c <hopter::unwind::unwind::start_unwind_entry::hab72bc47e885ba0f>:
 f00421c: 4670         	mov	r0, lr
 f00421e: 4669         	mov	r1, sp
 f004220: f04f 5200    	.word	#0xf04f5200
 f004224: 6812         	ldr	r2, [r2]
 f004226: f3ef 8305    	.word	#0xf3ef8305
 f00422a: b913         	cbnz	r3, 0xf004232 <hopter::unwind::unwind::start_unwind_entry::hab72bc47e885ba0f+0x16> @ imm = #0x4
 f00422c: dffd         	svc	#0xfd

0f00422e <$d.72>:
 f00422e: 00 02 00 00  	.word	0x00000200

0f004232 <$t.73>:
 f004232: f04f 5300    	.word	#0xf04f5300
 f004236: 681b         	ldr	r3, [r3]
 f004238: ed2d 8b10    	.word	#0xed2d8b10
 f00423c: b40f         	push	{r0, r1, r2, r3}
 f00423e: e92d 0ff0    	.word	#0xe92d0ff0
 f004242: 4668         	mov	r0, sp
 f004244: f000 f813    	bl	0xf00426e <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477> @ imm = #0x26
 f004248: b018         	add	sp, #0x60
 f00424a: 4669         	mov	r1, sp
 f00424c: f000 f9c2    	bl	0xf0045d4 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21> @ imm = #0x384
 f004250: bc0f         	pop	{r0, r1, r2, r3}
 f004252: f102 0204    	.word	#0xf1020204
 f004256: e892 0ff0    	.word	#0xe8920ff0
 f00425a: ec93 8b10    	.word	#0xec938b10
 f00425e: f3ef 8305    	.word	#0xf3ef8305
 f004262: b903         	cbnz	r3, 0xf004266 <hopter::unwind::unwind::start_unwind_entry::hab72bc47e885ba0f+0x4a> @ imm = #0x0
 f004264: dffe         	svc	#0xfe
 f004266: f8d2 d020    	.word	#0xf8d2d020
 f00426a: 4708         	bx	r1
 f00426c: defe         	trap

0f00426e <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477>:
 f00426e: f04f 5c00    	.word	#0xf04f5c00
 f004272: f8dc c000    	.word	#0xf8dcc000
 f004276: ebbd 0c0c    	.word	#0xebbd0c0c
 f00427a: f1bc 0f48    	.word	#0xf1bc0f48
 f00427e: da02         	bge	0xf004286 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x18> @ imm = #0x4
 f004280: dfff         	svc	#0xff
 f004282: 0012         	movs	r2, r2
 f004284: 0000         	movs	r0, r0
 f004286: b5f0         	push	{r4, r5, r6, r7, lr}
 f004288: af03         	add	r7, sp, #0xc
 f00428a: e92d 0f00    	.word	#0xe92d0f00
 f00428e: b089         	sub	sp, #0x24
 f004290: f246 7618    	.word	#0xf2467618
 f004294: 4604         	mov	r4, r0
 f004296: f3ef 8005    	.word	#0xf3ef8005
 f00429a: f2c2 0600    	.word	#0xf2c20600
 f00429e: b130         	cbz	r0, 0xf0042ae <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x40> @ imm = #0xc
 f0042a0: 7a30         	ldrb	r0, [r6, #0x8]
 f0042a2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0042a6: 2800         	cmp	r0, #0x0
 f0042a8: f000 80bc    	.word	#0xf00080bc
 f0042ac: e7fe         	b	0xf0042ac <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x3e> @ imm = #-0x4
 f0042ae: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0042b2: e856 0f0f    	.word	#0xe8560f0f
 f0042b6: 3001         	adds	r0, #0x1
 f0042b8: e846 010f    	.word	#0xe846010f
 f0042bc: 2900         	cmp	r1, #0x0
 f0042be: d1f8         	bne	0xf0042b2 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x44> @ imm = #-0x10
 f0042c0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0042c4: e856 1f14    	.word	#0xe8561f14
 f0042c8: 1d08         	adds	r0, r1, #0x4
 f0042ca: e846 0214    	.word	#0xe8460214
 f0042ce: 2a00         	cmp	r2, #0x0
 f0042d0: d1f8         	bne	0xf0042c4 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x56> @ imm = #-0x10
 f0042d2: f64f 70fc    	.word	#0xf64f70fc
 f0042d6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0042da: f6c7 70ff    	.word	#0xf6c770ff
 f0042de: 4281         	cmp	r1, r0
 f0042e0: d85b         	bhi	0xf00439a <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x12c> @ imm = #0xb6
 f0042e2: 0789         	lsls	r1, r1, #0x1e
 f0042e4: d068         	beq	0xf0043b8 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x14a> @ imm = #0xd0
 f0042e6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0042ea: e856 1f14    	.word	#0xe8561f14
 f0042ee: 3904         	subs	r1, #0x4
 f0042f0: e846 1214    	.word	#0xe8461214
 f0042f4: 2a00         	cmp	r2, #0x0
 f0042f6: d1f8         	bne	0xf0042ea <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x7c> @ imm = #-0x10
 f0042f8: bf10         	yield
 f0042fa: e856 1f14    	.word	#0xe8561f14
 f0042fe: 1d0a         	adds	r2, r1, #0x4
 f004300: e846 2314    	.word	#0xe8462314
 f004304: 2b00         	cmp	r3, #0x0
 f004306: d1f8         	bne	0xf0042fa <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x8c> @ imm = #-0x10
 f004308: 4281         	cmp	r1, r0
 f00430a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00430e: d844         	bhi	0xf00439a <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x12c> @ imm = #0x88
 f004310: 0789         	lsls	r1, r1, #0x1e
 f004312: d051         	beq	0xf0043b8 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x14a> @ imm = #0xa2
 f004314: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004318: e856 1f14    	.word	#0xe8561f14
 f00431c: 3904         	subs	r1, #0x4
 f00431e: e846 1214    	.word	#0xe8461214
 f004322: 2a00         	cmp	r2, #0x0
 f004324: d1f8         	bne	0xf004318 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0xaa> @ imm = #-0x10
 f004326: bf10         	yield
 f004328: e856 1f14    	.word	#0xe8561f14
 f00432c: 1d0a         	adds	r2, r1, #0x4
 f00432e: e846 2314    	.word	#0xe8462314
 f004332: 2b00         	cmp	r3, #0x0
 f004334: d1f8         	bne	0xf004328 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0xba> @ imm = #-0x10
 f004336: 4281         	cmp	r1, r0
 f004338: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00433c: d82d         	bhi	0xf00439a <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x12c> @ imm = #0x5a
 f00433e: 0789         	lsls	r1, r1, #0x1e
 f004340: d03a         	beq	0xf0043b8 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x14a> @ imm = #0x74
 f004342: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004346: e856 1f14    	.word	#0xe8561f14
 f00434a: 3904         	subs	r1, #0x4
 f00434c: e846 1214    	.word	#0xe8461214
 f004350: 2a00         	cmp	r2, #0x0
 f004352: d1f8         	bne	0xf004346 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0xd8> @ imm = #-0x10
 f004354: bf10         	yield
 f004356: e856 1f14    	.word	#0xe8561f14
 f00435a: 1d0a         	adds	r2, r1, #0x4
 f00435c: e846 2314    	.word	#0xe8462314
 f004360: 2b00         	cmp	r3, #0x0
 f004362: d1f8         	bne	0xf004356 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0xe8> @ imm = #-0x10
 f004364: 4281         	cmp	r1, r0
 f004366: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00436a: d816         	bhi	0xf00439a <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x12c> @ imm = #0x2c
 f00436c: 0789         	lsls	r1, r1, #0x1e
 f00436e: d023         	beq	0xf0043b8 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x14a> @ imm = #0x46
 f004370: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004374: e856 1f14    	.word	#0xe8561f14
 f004378: 3904         	subs	r1, #0x4
 f00437a: e846 1214    	.word	#0xe8461214
 f00437e: 2a00         	cmp	r2, #0x0
 f004380: d1f8         	bne	0xf004374 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x106> @ imm = #-0x10
 f004382: bf10         	yield
 f004384: e856 1f14    	.word	#0xe8561f14
 f004388: 1d0a         	adds	r2, r1, #0x4
 f00438a: e846 2314    	.word	#0xe8462314
 f00438e: 2b00         	cmp	r3, #0x0
 f004390: d1f8         	bne	0xf004384 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x116> @ imm = #-0x10
 f004392: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004396: 4281         	cmp	r1, r0
 f004398: d9a3         	bls	0xf0042e2 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x74> @ imm = #-0xba
 f00439a: e856 0f14    	.word	#0xe8560f14
 f00439e: 3804         	subs	r0, #0x4
 f0043a0: e846 0114    	.word	#0xe8460114
 f0043a4: 2900         	cmp	r1, #0x0
 f0043a6: d1f8         	bne	0xf00439a <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x12c> @ imm = #-0x10
 f0043a8: f245 6078    	.word	#0xf2456078
 f0043ac: 212c         	movs	r1, #0x2c
 f0043ae: f6c0 7000    	.word	#0xf6c07000
 f0043b2: f7fc f94a    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x3d6c
 f0043b6: defe         	trap
 f0043b8: 6d70         	ldr	r0, [r6, #0x54]
 f0043ba: 2800         	cmp	r0, #0x0
 f0043bc: d051         	beq	0xf004462 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x1f4> @ imm = #0xa2
 f0043be: f890 50ce    	.word	#0xf89050ce
 f0043c2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0043c6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0043ca: e856 0f14    	.word	#0xe8560f14
 f0043ce: 3804         	subs	r0, #0x4
 f0043d0: e846 0114    	.word	#0xe8460114
 f0043d4: 2900         	cmp	r1, #0x0
 f0043d6: d1f8         	bne	0xf0043ca <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x15c> @ imm = #-0x10
 f0043d8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0043dc: e856 0f0f    	.word	#0xe8560f0f
 f0043e0: 3801         	subs	r0, #0x1
 f0043e2: e846 010f    	.word	#0xe846010f
 f0043e6: 2900         	cmp	r1, #0x0
 f0043e8: d1f8         	bne	0xf0043dc <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x16e> @ imm = #-0x10
 f0043ea: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0043ee: 7970         	ldrb	r0, [r6, #0x5]
 f0043f0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0043f4: b198         	cbz	r0, 0xf00441e <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x1b0> @ imm = #0x26
 f0043f6: 6bf0         	ldr	r0, [r6, #0x3c]
 f0043f8: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0043fc: b978         	cbnz	r0, 0xf00441e <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x1b0> @ imm = #0x1e
 f0043fe: f3ef 8005    	.word	#0xf3ef8005
 f004402: 2800         	cmp	r0, #0x0
 f004404: f000 80b3    	.word	#0xf00080b3
 f004408: f3ef 8005    	.word	#0xf3ef8005
 f00440c: 280e         	cmp	r0, #0xe
 f00440e: bf1f         	itttt	ne
 f004410: f64e 5004    	.word	#0xf64e5004
 f004414: f2ce 0000    	.word	#0xf2ce0000
 f004418: f04f 5180    	.word	#0xf04f5180
 f00441c: 6001         	strne	r1, [r0]
 f00441e: 2d00         	cmp	r5, #0x0
 f004420: f47f af44    	.word	#0xf47faf44
 f004424: f3ef 8005    	.word	#0xf3ef8005
 f004428: b1e0         	cbz	r0, 0xf004464 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x1f6> @ imm = #0x38
 f00442a: 2001         	movs	r0, #0x1
 f00442c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004430: 7230         	strb	r0, [r6, #0x8]
 f004432: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004436: f3ef 8005    	.word	#0xf3ef8005
 f00443a: b1d0         	cbz	r0, 0xf004472 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x204> @ imm = #0x34
 f00443c: 1df0         	adds	r0, r6, #0x7
 f00443e: e8d0 1f4f    	.word	#0xe8d01f4f
 f004442: b949         	cbnz	r1, 0xf004458 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x1ea> @ imm = #0x12
 f004444: 2101         	movs	r1, #0x1
 f004446: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00444a: e8c0 1f42    	.word	#0xe8c01f42
 f00444e: b1e2         	cbz	r2, 0xf00448a <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x21c> @ imm = #0x38
 f004450: e8d0 2f4f    	.word	#0xe8d02f4f
 f004454: 2a00         	cmp	r2, #0x0
 f004456: d0f8         	beq	0xf00444a <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x1dc> @ imm = #-0x10
 f004458: f3bf 8f2f    	.word	#0xf3bf8f2f
 f00445c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004460: e7fe         	b	0xf004460 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x1f2> @ imm = #-0x4
 f004462: e7fe         	b	0xf004462 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x1f4> @ imm = #-0x4
 f004464: 2001         	movs	r0, #0x1
 f004466: f7fd fc50    	bl	0xf001d0a <hopter::unwind::unwind::set_cur_task_unwinding::hef670f5e1ada8d5b> @ imm = #-0x2760
 f00446a: f3ef 8005    	.word	#0xf3ef8005
 f00446e: 2800         	cmp	r0, #0x0
 f004470: d1e4         	bne	0xf00443c <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x1ce> @ imm = #-0x38
 f004472: 4630         	mov	r0, r6
 f004474: f810 1b09    	.word	#0xf8101b09
 f004478: 21a0         	movs	r1, #0xa0
 f00447a: f7fc ff6d    	bl	0xf001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e> @ imm = #-0x3126
 f00447e: 4605         	mov	r5, r0
 f004480: b948         	cbnz	r0, 0xf004496 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x228> @ imm = #0x12
 f004482: f3ef 8010    	.word	#0xf3ef8010
 f004486: b672         	cpsid i
 f004488: e7fe         	b	0xf004488 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x21a> @ imm = #-0x4
 f00448a: f246 6578    	.word	#0xf2466578
 f00448e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004492: f2c2 0500    	.word	#0xf2c20500
 f004496: 2000         	movs	r0, #0x0
 f004498: 4629         	mov	r1, r5
 f00449a: f8c5 0094    	.word	#0xf8c50094
 f00449e: 2002         	movs	r0, #0x2
 f0044a0: f801 0f70    	.word	#0xf8010f70
 f0044a4: 4628         	mov	r0, r5
 f0044a6: 9108         	str	r1, [sp, #0x20]
 f0044a8: 2170         	movs	r1, #0x70
 f0044aa: f7ff fcdf    	bl	0xf003e6c <__aeabi_memclr8> @ imm = #-0x642
 f0044ae: 2001         	movs	r0, #0x1
 f0044b0: f885 0098    	.word	#0xf8850098
 f0044b4: f3ef 8005    	.word	#0xf3ef8005
 f0044b8: 2800         	cmp	r0, #0x0
 f0044ba: bf08         	it	eq
 f0044bc: f000 fce2    	bleq	0xf004e84 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818> @ imm = #0x9c4
 f0044c0: e894 500f    	.word	#0xe894500f
 f0044c4: f8c5 e018    	.word	#0xf8c5e018
 f0044c8: f104 0e30    	.word	#0xf1040e30
 f0044cc: 60a9         	str	r1, [r5, #0x8]
 f0044ce: 6c61         	ldr	r1, [r4, #0x44]
 f0044d0: 6068         	str	r0, [r5, #0x4]
 f0044d2: 60ea         	str	r2, [r5, #0xc]
 f0044d4: 612b         	str	r3, [r5, #0x10]
 f0044d6: f8c5 c014    	.word	#0xf8c5c014
 f0044da: e89e 500d    	.word	#0xe89e500d
 f0044de: e9d4 8b08    	.word	#0xe9d48b08
 f0044e2: 9106         	str	r1, [sp, #0x18]
 f0044e4: 6ca1         	ldr	r1, [r4, #0x48]
 f0044e6: 9104         	str	r1, [sp, #0x10]
 f0044e8: 6ce1         	ldr	r1, [r4, #0x4c]
 f0044ea: e9d4 9a06    	.word	#0xe9d49a06
 f0044ee: 9105         	str	r1, [sp, #0x14]
 f0044f0: f1a8 0102    	.word	#0xf1a80102
 f0044f4: e9c5 100b    	.word	#0xe9c5100b
 f0044f8: f105 0034    	.word	#0xf1050034
 f0044fc: e880 500c    	.word	#0xe880500c
 f004500: e9c5 9a07    	.word	#0xe9c59a07
 f004504: e9c5 b809    	.word	#0xe9c5b809
 f004508: 9107         	str	r1, [sp, #0x1c]
 f00450a: 6ea0         	ldr	r0, [r4, #0x68]
 f00450c: 9906         	ldr	r1, [sp, #0x18]
 f00450e: e9d4 a314    	.word	#0xe9d4a314
 f004512: 9002         	str	r0, [sp, #0x8]
 f004514: e9d6 2009    	.word	#0xe9d62009
 f004518: 6469         	str	r1, [r5, #0x44]
 f00451a: 9904         	ldr	r1, [sp, #0x10]
 f00451c: 64a9         	str	r1, [r5, #0x48]
 f00451e: 9905         	ldr	r1, [sp, #0x14]
 f004520: f8d4 906c    	.word	#0xf8d4906c
 f004524: 9003         	str	r0, [sp, #0xc]
 f004526: e9c5 1a13    	.word	#0xe9c51a13
 f00452a: f105 0154    	.word	#0xf1050154
 f00452e: e9d6 060b    	.word	#0xe9d6060b
 f004532: e9d4 ce16    	.word	#0xe9d4ce16
 f004536: e881 5008    	.word	#0xe8815008
 f00453a: 9902         	ldr	r1, [sp, #0x8]
 f00453c: e9c5 191a    	.word	#0xe9c5191a
 f004540: 1a31         	subs	r1, r6, r0
 f004542: e9d4 8b18    	.word	#0xe9d48b18
 f004546: e9c5 8b18    	.word	#0xe9c58b18
 f00454a: e9cd 0100    	.word	#0xe9cd0100
 f00454e: 9803         	ldr	r0, [sp, #0xc]
 f004550: 1a83         	subs	r3, r0, r2
 f004552: e9dd 1007    	.word	#0xe9dd1007
 f004556: f7ff fca8    	bl	0xf003eaa <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101> @ imm = #-0x6b0
 f00455a: b100         	cbz	r0, 0xf00455e <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x2f0> @ imm = #0x0
 f00455c: e7fe         	b	0xf00455c <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x2ee> @ imm = #-0x4
 f00455e: 6aa0         	ldr	r0, [r4, #0x28]
 f004560: f8c5 0094    	.word	#0xf8c50094
 f004564: 4628         	mov	r0, r5
 f004566: b009         	add	sp, #0x24
 f004568: e8bd 0f00    	.word	#0xe8bd0f00
 f00456c: bdf0         	pop	{r4, r5, r6, r7, pc}
 f00456e: f7fc fd24    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x35b8
 f004572: 2d00         	cmp	r5, #0x0
 f004574: f47f ae9a    	.word	#0xf47fae9a
 f004578: e754         	b	0xf004424 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x1b6> @ imm = #-0x158
 f00457a: 4604         	mov	r4, r0
 f00457c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004580: e856 0f0f    	.word	#0xe8560f0f
 f004584: 3801         	subs	r0, #0x1
 f004586: e846 010f    	.word	#0xe846010f
 f00458a: 2900         	cmp	r1, #0x0
 f00458c: d1f8         	bne	0xf004580 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x312> @ imm = #-0x10
 f00458e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004592: 7970         	ldrb	r0, [r6, #0x5]
 f004594: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004598: b1a0         	cbz	r0, 0xf0045c4 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x356> @ imm = #0x28
 f00459a: 6bf0         	ldr	r0, [r6, #0x3c]
 f00459c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0045a0: b980         	cbnz	r0, 0xf0045c4 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x356> @ imm = #0x20
 f0045a2: f3ef 8005    	.word	#0xf3ef8005
 f0045a6: b910         	cbnz	r0, 0xf0045ae <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x340> @ imm = #0x4
 f0045a8: f7fc fd07    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x35f2
 f0045ac: e00a         	b	0xf0045c4 <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x356> @ imm = #0x14
 f0045ae: f3ef 8005    	.word	#0xf3ef8005
 f0045b2: 280e         	cmp	r0, #0xe
 f0045b4: bf1f         	itttt	ne
 f0045b6: f64e 5004    	.word	#0xf64e5004
 f0045ba: f2ce 0000    	.word	#0xf2ce0000
 f0045be: f04f 5180    	.word	#0xf04f5180
 f0045c2: 6001         	strne	r1, [r0]
 f0045c4: 4620         	mov	r0, r4
 f0045c6: f001 f805    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x100a
 f0045ca: defe         	trap
 f0045cc: f7fc f8b9    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x3e8e
 f0045d0: defe         	trap
 f0045d2: d4d4         	bmi	0xf00457e <hopter::unwind::unwind::UnwindState::create_unwind_state::he8e766db31a9a477+0x310> @ imm = #-0x58

0f0045d4 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21>:
 f0045d4: f04f 5c00    	.word	#0xf04f5c00
 f0045d8: f8dc c000    	.word	#0xf8dcc000
 f0045dc: ebbd 0c0c    	.word	#0xebbd0c0c
 f0045e0: f1bc 0f88    	.word	#0xf1bc0f88
 f0045e4: da02         	bge	0xf0045ec <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x18> @ imm = #0x4
 f0045e6: dfff         	svc	#0xff
 f0045e8: 0022         	movs	r2, r4
 f0045ea: 0000         	movs	r0, r0
 f0045ec: b5f0         	push	{r4, r5, r6, r7, lr}
 f0045ee: af03         	add	r7, sp, #0xc
 f0045f0: e92d 0f00    	.word	#0xe92d0f00
 f0045f4: b099         	sub	sp, #0x64
 f0045f6: 4680         	mov	r8, r0
 f0045f8: 3810         	subs	r0, #0x10
 f0045fa: 900a         	str	r0, [sp, #0x28]
 f0045fc: f108 0030    	.word	#0xf1080030
 f004600: 9007         	str	r0, [sp, #0x1c]
 f004602: f246 7018    	.word	#0xf2467018
 f004606: f108 0a70    	.word	#0xf1080a70
 f00460a: f2c2 0000    	.word	#0xf2c20000
 f00460e: f64e 79f1    	.word	#0xf64e79f1
 f004612: 3009         	adds	r0, #0x9
 f004614: 9108         	str	r1, [sp, #0x20]
 f004616: 9009         	str	r0, [sp, #0x24]
 f004618: f898 0098    	.word	#0xf8980098
 f00461c: 2800         	cmp	r0, #0x0
 f00461e: d044         	beq	0xf0046aa <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0xd6> @ imm = #0x88
 f004620: 2000         	movs	r0, #0x0
 f004622: f888 0098    	.word	#0xf8880098
 f004626: f89a 0000    	.word	#0xf89a0000
 f00462a: 2802         	cmp	r0, #0x2
 f00462c: f000 8297    	.word	#0xf0008297
 f004630: f8d8 b088    	.word	#0xf8d8b088
 f004634: f1bb 0f00    	.word	#0xf1bb0f00
 f004638: bf1c         	itt	ne
 f00463a: f8d8 108c    	.word	#0xf8d8108c
 f00463e: 2900         	cmpne	r1, #0x0
 f004640: d0ea         	beq	0xf004618 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x44> @ imm = #-0x2c
 f004642: f81b 2b01    	.word	#0xf81b2b01
 f004646: 1e4b         	subs	r3, r1, #0x1
 f004648: f8d8 402c    	.word	#0xf8d8402c
 f00464c: f8d8 0090    	.word	#0xf8d80090
 f004650: 2aff         	cmp	r2, #0xff
 f004652: e9cd b310    	.word	#0xe9cdb310
 f004656: d00a         	beq	0xf00466e <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x9a> @ imm = #0x14
 f004658: a814         	add	r0, sp, #0x50
 f00465a: a910         	add	r1, sp, #0x40
 f00465c: f000 fa96    	bl	0xf004b8c <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6> @ imm = #0x52c
 f004660: f89d 0050    	.word	#0xf89d0050
 f004664: 284b         	cmp	r0, #0x4b
 f004666: d1d7         	bne	0xf004618 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x44> @ imm = #-0x52
 f004668: e9dd b310    	.word	#0xe9ddb310
 f00466c: 9816         	ldr	r0, [sp, #0x58]
 f00466e: 2b00         	cmp	r3, #0x0
 f004670: e9cd 4005    	.word	#0xe9cd4005
 f004674: d0d0         	beq	0xf004618 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x44> @ imm = #-0x60
 f004676: f81b 1b01    	.word	#0xf81b1b01
 f00467a: 1e5a         	subs	r2, r3, #0x1
 f00467c: 29ff         	cmp	r1, #0xff
 f00467e: e9cd b210    	.word	#0xe9cdb210
 f004682: f000 81b8    	.word	#0xf00081b8
 f004686: 2a00         	cmp	r2, #0x0
 f004688: d0c6         	beq	0xf004618 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x44> @ imm = #-0x74
 f00468a: 1e9a         	subs	r2, r3, #0x2
 f00468c: 233f         	movs	r3, #0x3f
 f00468e: f81b 1b01    	.word	#0xf81b1b01
 f004692: b90b         	cbnz	r3, 0xf004698 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0xc4> @ imm = #0x2
 f004694: 2901         	cmp	r1, #0x1
 f004696: d8bf         	bhi	0xf004618 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x44> @ imm = #-0x82
 f004698: b249         	sxtb	r1, r1
 f00469a: 2900         	cmp	r1, #0x0
 f00469c: f140 81a9    	.word	#0xf14081a9
 f0046a0: 3a01         	subs	r2, #0x1
 f0046a2: 3b07         	subs	r3, #0x7
 f0046a4: 1c51         	adds	r1, r2, #0x1
 f0046a6: d1f2         	bne	0xf00468e <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0xba> @ imm = #-0x1c
 f0046a8: e7b6         	b	0xf004618 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x44> @ imm = #-0x94
 f0046aa: f8d8 002c    	.word	#0xf8d8002c
 f0046ae: 2800         	cmp	r0, #0x0
 f0046b0: bf1c         	itt	ne
 f0046b2: f89a 0000    	.word	#0xf89a0000
 f0046b6: 2802         	cmpne	r0, #0x2
 f0046b8: f000 824f    	.word	#0xf000824f
 f0046bc: e9d8 1e1f    	.word	#0xe9d81e1f
 f0046c0: f04f 30ff    	.word	#0xf04f30ff
 f0046c4: f8c8 002c    	.word	#0xf8c8002c
 f0046c8: 458e         	cmp	lr, r1
 f0046ca: f080 8157    	.word	#0xf0808157
 f0046ce: 4672         	mov	r2, lr
 f0046d0: f10e 0e01    	.word	#0xf10e0e01
 f0046d4: f082 0003    	.word	#0xf0820003
 f0046d8: f8c8 e080    	.word	#0xf8c8e080
 f0046dc: 4288         	cmp	r0, r1
 f0046de: f080 8241    	.word	#0xf0808241
 f0046e2: f8d8 c078    	.word	#0xf8d8c078
 f0046e6: f81c 6000    	.word	#0xf81c6000
 f0046ea: f006 00c0    	.word	#0xf00600c0
 f0046ee: 2840         	cmp	r0, #0x40
 f0046f0: d005         	beq	0xf0046fe <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x12a> @ imm = #0xa
 f0046f2: b948         	cbnz	r0, 0xf004708 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x134> @ imm = #0x12
 f0046f4: 00b0         	lsls	r0, r6, #0x2
 f0046f6: 2204         	movs	r2, #0x4
 f0046f8: fa52 f080    	.word	#0xfa52f080
 f0046fc: e0e0         	b	0xf0048c0 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x2ec> @ imm = #0x1c0
 f0046fe: 00b0         	lsls	r0, r6, #0x2
 f004700: 2204         	movs	r2, #0x4
 f004702: fa52 f080    	.word	#0xfa52f080
 f004706: e0d5         	b	0xf0048b4 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x2e0> @ imm = #0x1aa
 f004708: f006 00f0    	.word	#0xf00600f0
 f00470c: 28a0         	cmp	r0, #0xa0
 f00470e: d020         	beq	0xf004752 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x17e> @ imm = #0x40
 f004710: 2890         	cmp	r0, #0x90
 f004712: d02c         	beq	0xf00476e <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x19a> @ imm = #0x58
 f004714: 2880         	cmp	r0, #0x80
 f004716: d134         	bne	0xf004782 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x1ae> @ imm = #0x68
 f004718: 458e         	cmp	lr, r1
 f00471a: f080 821e    	.word	#0xf080821e
 f00471e: 3202         	adds	r2, #0x2
 f004720: f08e 0003    	.word	#0xf08e0003
 f004724: 4288         	cmp	r0, r1
 f004726: f8c8 2080    	.word	#0xf8c82080
 f00472a: f080 821b    	.word	#0xf080821b
 f00472e: f81c 0000    	.word	#0xf81c0000
 f004732: 2e80         	cmp	r6, #0x80
 f004734: bf08         	it	eq
 f004736: 2800         	cmpeq	r0, #0x0
 f004738: f000 820f    	.word	#0xf000820f
 f00473c: f006 030f    	.word	#0xf006030f
 f004740: 4696         	mov	lr, r2
 f004742: ea50 2003    	.word	#0xea502003
 f004746: f04f 0302    	.word	#0xf04f0302
 f00474a: bf08         	it	eq
 f00474c: 230b         	moveq	r3, #0xb
 f00474e: 0100         	lsls	r0, r0, #0x4
 f004750: e09e         	b	0xf004890 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x2bc> @ imm = #0x13c
 f004752: f006 0007    	.word	#0xf0060007
 f004756: f04f 32ff    	.word	#0xf04f32ff
 f00475a: 3001         	adds	r0, #0x1
 f00475c: fa02 f000    	.word	#0xfa02f000
 f004760: f006 0208    	.word	#0xf0060208
 f004764: 43c0         	mvns	r0, r0
 f004766: 0100         	lsls	r0, r0, #0x4
 f004768: ea40 20c2    	.word	#0xea4020c2
 f00476c: e0ae         	b	0xf0048cc <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x2f8> @ imm = #0x15c
 f00476e: f046 0002    	.word	#0xf0460002
 f004772: 289f         	cmp	r0, #0x9f
 f004774: f000 81f1    	.word	#0xf00081f1
 f004778: f006 000f    	.word	#0xf006000f
 f00477c: 0200         	lsls	r0, r0, #0x8
 f00477e: 1cc3         	adds	r3, r0, #0x3
 f004780: e086         	b	0xf004890 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x2bc> @ imm = #0x10c
 f004782: f1a6 00b0    	.word	#0xf1a600b0
 f004786: 2819         	cmp	r0, #0x19
 f004788: f200 81e7    	.word	#0xf20081e7
 f00478c: e8df f010    	.word	#0xe8dff010

0f004790 <$d.76>:
 f004790: 1a 00 1b 00  	.word	0x001b001a
 f004794: 32 00 e5 01  	.word	0x01e50032
 f004798: e5 01 e5 01  	.word	0x01e501e5
 f00479c: e5 01 e5 01  	.word	0x01e501e5
 f0047a0: e5 01 e5 01  	.word	0x01e501e5
 f0047a4: e5 01 e5 01  	.word	0x01e501e5
 f0047a8: e5 01 e5 01  	.word	0x01e501e5
 f0047ac: e5 01 e5 01  	.word	0x01e501e5
 f0047b0: e5 01 e5 01  	.word	0x01e501e5
 f0047b4: e5 01 e5 01  	.word	0x01e501e5
 f0047b8: e5 01 e5 01  	.word	0x01e501e5
 f0047bc: e5 01 e5 01  	.word	0x01e501e5
 f0047c0: 54 00 68 00  	.word	0x00680054

0f0047c4 <$t.77>:
 f0047c4: e780         	b	0xf0046c8 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0xf4> @ imm = #-0x100
 f0047c6: 458e         	cmp	lr, r1
 f0047c8: f080 81c7    	.word	#0xf08081c7
 f0047cc: 3202         	adds	r2, #0x2
 f0047ce: f08e 0003    	.word	#0xf08e0003
 f0047d2: 4288         	cmp	r0, r1
 f0047d4: f8c8 2080    	.word	#0xf8c82080
 f0047d8: f080 81c4    	.word	#0xf08081c4
 f0047dc: f81c 0000    	.word	#0xf81c0000
 f0047e0: 4696         	mov	lr, r2
 f0047e2: 1e43         	subs	r3, r0, #0x1
 f0047e4: f000 000f    	.word	#0xf000000f
 f0047e8: 2b0f         	cmp	r3, #0xf
 f0047ea: f04f 0309    	.word	#0xf04f0309
 f0047ee: bf38         	it	lo
 f0047f0: 2302         	movlo	r3, #0x2
 f0047f2: e04d         	b	0xf004890 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x2bc> @ imm = #0x9a
 f0047f4: 2200         	movs	r2, #0x0
 f0047f6: 2600         	movs	r6, #0x0
 f0047f8: 4571         	cmp	r1, lr
 f0047fa: f000 81ae    	.word	#0xf00081ae
 f0047fe: f10e 0501    	.word	#0xf10e0501
 f004802: f08e 0003    	.word	#0xf08e0003
 f004806: 4288         	cmp	r0, r1
 f004808: f8c8 5080    	.word	#0xf8c85080
 f00480c: f080 81aa    	.word	#0xf08081aa
 f004810: f91c 0000    	.word	#0xf91c0000
 f004814: f006 031f    	.word	#0xf006031f
 f004818: 3607         	adds	r6, #0x7
 f00481a: 46ae         	mov	lr, r5
 f00481c: f000 047f    	.word	#0xf000047f
 f004820: 2800         	cmp	r0, #0x0
 f004822: fa04 f303    	.word	#0xfa04f303
 f004826: ea42 0203    	.word	#0xea420203
 f00482a: d4e5         	bmi	0xf0047f8 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x224> @ imm = #-0x36
 f00482c: f44f 7001    	.word	#0xf44f7001
 f004830: 46ae         	mov	lr, r5
 f004832: eb00 0082    	.word	#0xeb000082
 f004836: e043         	b	0xf0048c0 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x2ec> @ imm = #0x86
 f004838: 458e         	cmp	lr, r1
 f00483a: f080 818e    	.word	#0xf080818e
 f00483e: 3202         	adds	r2, #0x2
 f004840: f08e 0003    	.word	#0xf08e0003
 f004844: 4288         	cmp	r0, r1
 f004846: f8c8 2080    	.word	#0xf8c82080
 f00484a: f080 818b    	.word	#0xf080818b
 f00484e: f81c 0000    	.word	#0xf81c0000
 f004852: 0903         	lsrs	r3, r0, #0x4
 f004854: f000 000f    	.word	#0xf000000f
 f004858: 3310         	adds	r3, #0x10
 f00485a: 3001         	adds	r0, #0x1
 f00485c: 021b         	lsls	r3, r3, #0x8
 f00485e: e013         	b	0xf004888 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x2b4> @ imm = #0x26
 f004860: 458e         	cmp	lr, r1
 f004862: f080 817a    	.word	#0xf080817a
 f004866: 3202         	adds	r2, #0x2
 f004868: f08e 0003    	.word	#0xf08e0003
 f00486c: 4288         	cmp	r0, r1
 f00486e: f8c8 2080    	.word	#0xf8c82080
 f004872: f080 8177    	.word	#0xf0808177
 f004876: f81c 0000    	.word	#0xf81c0000
 f00487a: f06f 03f0    	.word	#0xf06f03f0
 f00487e: ea03 1300    	.word	#0xea031300
 f004882: f000 000f    	.word	#0xf000000f
 f004886: 3001         	adds	r0, #0x1
 f004888: ea43 4000    	.word	#0xea434000
 f00488c: 4696         	mov	lr, r2
 f00488e: 1d03         	adds	r3, r0, #0x4
 f004890: b2da         	uxtb	r2, r3
 f004892: 2a0c         	cmp	r2, #0xc
 f004894: d072         	beq	0xf00497c <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x3a8> @ imm = #0xe4
 f004896: 2a07         	cmp	r2, #0x7
 f004898: f200 815f    	.word	#0xf200815f
 f00489c: 0a1e         	lsrs	r6, r3, #0x8
 f00489e: e8df f012    	.word	#0xe8dff012

0f0048a2 <$d.78>:
 f0048a2: 0f 00 09 00  	.word	0x0009000f
 f0048a6: 15 00 3a 00  	.word	0x003a0015
 f0048aa: 50 00 5c 01  	.word	0x015c0050
 f0048ae: 5c 01 08 00  	.word	0x0008015c

0f0048b2 <$t.79>:
 f0048b2: e709         	b	0xf0046c8 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0xf4> @ imm = #-0x1ee
 f0048b4: f8d8 2024    	.word	#0xf8d82024
 f0048b8: 1a13         	subs	r3, r2, r0
 f0048ba: f8c8 3024    	.word	#0xf8c83024
 f0048be: e703         	b	0xf0046c8 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0xf4> @ imm = #-0x1fa
 f0048c0: f8d8 2024    	.word	#0xf8d82024
 f0048c4: 1813         	adds	r3, r2, r0
 f0048c6: f8c8 3024    	.word	#0xf8c83024
 f0048ca: e6fd         	b	0xf0046c8 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0xf4> @ imm = #-0x206
 f0048cc: f8d8 3024    	.word	#0xf8d83024
 f0048d0: f645 04c0    	.word	#0xf64504c0
 f0048d4: 2200         	movs	r2, #0x0
 f0048d6: f6c0 7400    	.word	#0xf6c07400
 f0048da: e002         	b	0xf0048e2 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x30e> @ imm = #0x4
 f0048dc: 3201         	adds	r2, #0x1
 f0048de: 2a10         	cmp	r2, #0x10
 f0048e0: d013         	beq	0xf00490a <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x336> @ imm = #0x26
 f0048e2: fa20 f602    	.word	#0xfa20f602
 f0048e6: 07f6         	lsls	r6, r6, #0x1f
 f0048e8: d0f8         	beq	0xf0048dc <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x308> @ imm = #-0x10
 f0048ea: 2a10         	cmp	r2, #0x10
 f0048ec: f080 8136    	.word	#0xf0808136
 f0048f0: b296         	uxth	r6, r2
 f0048f2: fa29 f606    	.word	#0xfa29f606
 f0048f6: 07f6         	lsls	r6, r6, #0x1f
 f0048f8: f000 8130    	.word	#0xf0008130
 f0048fc: f854 5022    	.word	#0xf8545022
 f004900: f853 6b04    	.word	#0xf8536b04
 f004904: f848 6025    	.word	#0xf8486025
 f004908: e7e8         	b	0xf0048dc <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x308> @ imm = #-0x30
 f00490a: f010 0f0d    	.word	#0xf0100f0d
 f00490e: bf08         	it	eq
 f004910: f8c8 3024    	.word	#0xf8c83024
 f004914: e6d8         	b	0xf0046c8 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0xf4> @ imm = #-0x250
 f004916: f413 4f70    	.word	#0xf4134f70
 f00491a: f040 8122    	.word	#0xf0408122
 f00491e: b2f0         	uxtb	r0, r6
 f004920: fa29 f000    	.word	#0xfa29f000
 f004924: 07c0         	lsls	r0, r0, #0x1f
 f004926: f000 811c    	.word	#0xf000811c
 f00492a: 0630         	lsls	r0, r6, #0x18
 f00492c: f645 0280    	.word	#0xf6450280
 f004930: 1580         	asrs	r0, r0, #0x16
 f004932: f6c0 7200    	.word	#0xf6c07200
 f004936: 5810         	ldr	r0, [r2, r0]
 f004938: f858 3020    	.word	#0xf8583020
 f00493c: f8c8 3024    	.word	#0xf8c83024
 f004940: e6c2         	b	0xf0046c8 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0xf4> @ imm = #-0x27c
 f004942: f413 1ff8    	.word	#0xf4131ff8
 f004946: f43f aebf    	.word	#0xf43faebf
 f00494a: f06f 0207    	.word	#0xf06f0207
 f00494e: 9d0a         	ldr	r5, [sp, #0x28]
 f004950: 0c18         	lsrs	r0, r3, #0x10
 f004952: fa52 f286    	.word	#0xfa52f286
 f004956: b2f6         	uxtb	r6, r6
 f004958: f8d8 3024    	.word	#0xf8d83024
 f00495c: eb05 06c6    	.word	#0xeb0506c6
 f004960: 2a08         	cmp	r2, #0x8
 f004962: f080 80fd    	.word	#0xf08080fd
 f004966: e8f3 5402    	.word	#0xe8f35402
 f00496a: 3801         	subs	r0, #0x1
 f00496c: f102 0201    	.word	#0xf1020201
 f004970: e8e6 5402    	.word	#0xe8e65402
 f004974: f8c8 3024    	.word	#0xf8c83024
 f004978: d1f2         	bne	0xf004960 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x38c> @ imm = #-0x1c
 f00497a: e6a5         	b	0xf0046c8 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0xf4> @ imm = #-0x2b6
 f00497c: f8d8 502c    	.word	#0xf8d8502c
 f004980: 1c68         	adds	r0, r5, #0x1
 f004982: bf04         	itt	eq
 f004984: f8d8 5028    	.word	#0xf8d85028
 f004988: f8c8 502c    	.word	#0xf8c8502c
 f00498c: 2d00         	cmp	r5, #0x0
 f00498e: f43f ae4a    	.word	#0xf43fae4a
 f004992: f643 604b    	.word	#0xf643604b
 f004996: f6c0 7000    	.word	#0xf6c07000
 f00499a: 4285         	cmp	r5, r0
 f00499c: d113         	bne	0xf0049c6 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x3f2> @ imm = #0x26
 f00499e: f8d8 1094    	.word	#0xf8d81094
 f0049a2: f851 0d7c    	.word	#0xf8510d7c
 f0049a6: 684a         	ldr	r2, [r1, #0x4]
 f0049a8: 69d3         	ldr	r3, [r2, #0x1c]
 f0049aa: 6955         	ldr	r5, [r2, #0x14]
 f0049ac: f8c8 0094    	.word	#0xf8c80094
 f0049b0: 0598         	lsls	r0, r3, #0x16
 f0049b2: f04f 006c    	.word	#0xf04f006c
 f0049b6: bf58         	it	pl
 f0049b8: 2068         	movpl	r0, #0x68
 f0049ba: 4410         	add	r0, r2
 f0049bc: f8c8 0024    	.word	#0xf8c80024
 f0049c0: 9809         	ldr	r0, [sp, #0x24]
 f0049c2: f7fc fb8e    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #-0x38e4
 f0049c6: f246 7618    	.word	#0xf2467618
 f0049ca: 1ea9         	subs	r1, r5, #0x2
 f0049cc: f2c2 0600    	.word	#0xf2c20600
 f0049d0: e9d6 2009    	.word	#0xe9d62009
 f0049d4: e9d6 360b    	.word	#0xe9d6360b
 f0049d8: f8c8 102c    	.word	#0xf8c8102c
 f0049dc: 1af6         	subs	r6, r6, r3
 f0049de: e9cd 3600    	.word	#0xe9cd3600
 f0049e2: 1a83         	subs	r3, r0, r2
 f0049e4: 4650         	mov	r0, r10
 f0049e6: f7ff fa60    	bl	0xf003eaa <hopter::unwind::unwind::UnwindAbility::get_for_pc::h00e64cd31472a101> @ imm = #-0xb40
 f0049ea: 2800         	cmp	r0, #0x0
 f0049ec: f43f ae1b    	.word	#0xf43fae1b
 f0049f0: e0b3         	b	0xf004b5a <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x586> @ imm = #0x166
 f0049f2: e9cd b210    	.word	#0xe9cdb210
 f0049f6: 2a00         	cmp	r2, #0x0
 f0049f8: bf18         	it	ne
 f0049fa: 2a01         	cmpne	r2, #0x1
 f0049fc: f43f ae0c    	.word	#0xf43fae0c
 f004a00: f81b 0b01    	.word	#0xf81b0b01
 f004a04: 3a02         	subs	r2, #0x2
 f004a06: 9004         	str	r0, [sp, #0x10]
 f004a08: 2300         	movs	r3, #0x0
 f004a0a: 2600         	movs	r6, #0x0
 f004a0c: 2500         	movs	r5, #0x0
 f004a0e: f81b 4b01    	.word	#0xf81b4b01
 f004a12: 2d3f         	cmp	r5, #0x3f
 f004a14: d102         	bne	0xf004a1c <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x448> @ imm = #0x4
 f004a16: 2c01         	cmp	r4, #0x1
 f004a18: f63f adfe    	.word	#0xf63fadfe
 f004a1c: f005 093f    	.word	#0xf005093f
 f004a20: f004 0c7f    	.word	#0xf0040c7f
 f004a24: f1c9 0120    	.word	#0xf1c90120
 f004a28: 46d6         	mov	lr, r10
 f004a2a: fa0c f009    	.word	#0xfa0cf009
 f004a2e: f1b9 0a20    	.word	#0xf1b90a20
 f004a32: fa2c f101    	.word	#0xfa2cf101
 f004a36: bf58         	it	pl
 f004a38: fa0c f10a    	.word	#0xfa0cf10a
 f004a3c: bf58         	it	pl
 f004a3e: 2000         	movpl	r0, #0x0
 f004a40: 4303         	orrs	r3, r0
 f004a42: b260         	sxtb	r0, r4
 f004a44: 2800         	cmp	r0, #0x0
 f004a46: d508         	bpl	0xf004a5a <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x486> @ imm = #0x10
 f004a48: 430e         	orrs	r6, r1
 f004a4a: 3a01         	subs	r2, #0x1
 f004a4c: 3507         	adds	r5, #0x7
 f004a4e: 1c51         	adds	r1, r2, #0x1
 f004a50: 46f2         	mov	r10, lr
 f004a52: f64e 79f1    	.word	#0xf64e79f1
 f004a56: d1da         	bne	0xf004a0e <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x43a> @ imm = #-0x4c
 f004a58: e5de         	b	0xf004618 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x44> @ imm = #-0x444
 f004a5a: 9804         	ldr	r0, [sp, #0x10]
 f004a5c: 46f2         	mov	r10, lr
 f004a5e: f88d 003c    	.word	#0xf88d003c
 f004a62: f64e 79f1    	.word	#0xf64e79f1
 f004a66: 9806         	ldr	r0, [sp, #0x18]
 f004a68: 900e         	str	r0, [sp, #0x38]
 f004a6a: eb03 000b    	.word	#0xeb03000b
 f004a6e: 900d         	str	r0, [sp, #0x34]
 f004a70: e9cd b20b    	.word	#0xe9cdb20b
 f004a74: 980d         	ldr	r0, [sp, #0x34]
 f004a76: 4558         	cmp	r0, r11
 f004a78: f67f adce    	.word	#0xf67fadce
 f004a7c: f89d 603c    	.word	#0xf89d603c
 f004a80: f10d 0b2c    	.word	#0xf10d0b2c
 f004a84: f10d 0950    	.word	#0xf10d0950
 f004a88: 980e         	ldr	r0, [sp, #0x38]
 f004a8a: 9006         	str	r0, [sp, #0x18]
 f004a8c: 4659         	mov	r1, r11
 f004a8e: 4648         	mov	r0, r9
 f004a90: 4632         	mov	r2, r6
 f004a92: f000 f87b    	bl	0xf004b8c <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6> @ imm = #0xf6
 f004a96: f89d 0050    	.word	#0xf89d0050
 f004a9a: 284b         	cmp	r0, #0x4b
 f004a9c: d15a         	bne	0xf004b54 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x580> @ imm = #0xb4
 f004a9e: 4648         	mov	r0, r9
 f004aa0: 4659         	mov	r1, r11
 f004aa2: 4632         	mov	r2, r6
 f004aa4: 9c16         	ldr	r4, [sp, #0x58]
 f004aa6: f000 f871    	bl	0xf004b8c <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6> @ imm = #0xe2
 f004aaa: f89d 0050    	.word	#0xf89d0050
 f004aae: 284b         	cmp	r0, #0x4b
 f004ab0: d150         	bne	0xf004b54 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x580> @ imm = #0xa0
 f004ab2: 4648         	mov	r0, r9
 f004ab4: 4659         	mov	r1, r11
 f004ab6: 4632         	mov	r2, r6
 f004ab8: 9d16         	ldr	r5, [sp, #0x58]
 f004aba: f000 f867    	bl	0xf004b8c <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6> @ imm = #0xce
 f004abe: f89d 0050    	.word	#0xf89d0050
 f004ac2: 284b         	cmp	r0, #0x4b
 f004ac4: d146         	bne	0xf004b54 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x580> @ imm = #0x8c
 f004ac6: 980c         	ldr	r0, [sp, #0x30]
 f004ac8: 9504         	str	r5, [sp, #0x10]
 f004aca: 2800         	cmp	r0, #0x0
 f004acc: d042         	beq	0xf004b54 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x580> @ imm = #0x84
 f004ace: 9916         	ldr	r1, [sp, #0x58]
 f004ad0: 46a4         	mov	r12, r4
 f004ad2: 9103         	str	r1, [sp, #0xc]
 f004ad4: 1e42         	subs	r2, r0, #0x1
 f004ad6: 990b         	ldr	r1, [sp, #0x2c]
 f004ad8: f04f 0e00    	.word	#0xf04f0e00
 f004adc: 2600         	movs	r6, #0x0
 f004ade: 2500         	movs	r5, #0x0
 f004ae0: f101 0b01    	.word	#0xf1010b01
 f004ae4: f81b 4c01    	.word	#0xf81b4c01
 f004ae8: 2d3f         	cmp	r5, #0x3f
 f004aea: d101         	bne	0xf004af0 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x51c> @ imm = #0x2
 f004aec: 2c01         	cmp	r4, #0x1
 f004aee: d831         	bhi	0xf004b54 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x580> @ imm = #0x62
 f004af0: f005 033f    	.word	#0xf005033f
 f004af4: f004 007f    	.word	#0xf004007f
 f004af8: f1c3 0120    	.word	#0xf1c30120
 f004afc: f1b3 0920    	.word	#0xf1b30920
 f004b00: fa00 f303    	.word	#0xfa00f303
 f004b04: fa20 f101    	.word	#0xfa20f101
 f004b08: bf58         	it	pl
 f004b0a: fa00 f109    	.word	#0xfa00f109
 f004b0e: bf58         	it	pl
 f004b10: 2300         	movpl	r3, #0x0
 f004b12: b260         	sxtb	r0, r4
 f004b14: f1b0 3fff    	.word	#0xf1b03fff
 f004b18: dc09         	bgt	0xf004b2e <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x55a> @ imm = #0x12
 f004b1a: 3a01         	subs	r2, #0x1
 f004b1c: f10b 0b01    	.word	#0xf10b0b01
 f004b20: 430e         	orrs	r6, r1
 f004b22: ea4e 0e03    	.word	#0xea4e0e03
 f004b26: 3507         	adds	r5, #0x7
 f004b28: 1c50         	adds	r0, r2, #0x1
 f004b2a: d1db         	bne	0xf004ae4 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x510> @ imm = #-0x4a
 f004b2c: e012         	b	0xf004b54 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x580> @ imm = #0x24
 f004b2e: 9b06         	ldr	r3, [sp, #0x18]
 f004b30: f64e 79f1    	.word	#0xf64e79f1
 f004b34: e9cd b20b    	.word	#0xe9cdb20b
 f004b38: 9a05         	ldr	r2, [sp, #0x14]
 f004b3a: eb03 010c    	.word	#0xeb03010c
 f004b3e: 4291         	cmp	r1, r2
 f004b40: d898         	bhi	0xf004a74 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x4a0> @ imm = #-0xd0
 f004b42: 9804         	ldr	r0, [sp, #0x10]
 f004b44: 4408         	add	r0, r1
 f004b46: 4290         	cmp	r0, r2
 f004b48: d994         	bls	0xf004a74 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x4a0> @ imm = #-0xd8
 f004b4a: 9803         	ldr	r0, [sp, #0xc]
 f004b4c: 2800         	cmp	r0, #0x0
 f004b4e: f43f ad63    	.word	#0xf43fad63
 f004b52: e00a         	b	0xf004b6a <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x596> @ imm = #0x14
 f004b54: f64e 79f1    	.word	#0xf64e79f1
 f004b58: e55e         	b	0xf004618 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x44> @ imm = #-0x544
 f004b5a: e7fe         	b	0xf004b5a <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x586> @ imm = #-0x4
 f004b5c: e7fe         	b	0xf004b5c <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x588> @ imm = #-0x4
 f004b5e: e7fe         	b	0xf004b5e <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x58a> @ imm = #-0x4
 f004b60: e7fe         	b	0xf004b60 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x58c> @ imm = #-0x4
 f004b62: e7fe         	b	0xf004b62 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x58e> @ imm = #-0x4
 f004b64: f7fb fd82    	bl	0xf00066c <core::slice::index::slice_index_order_fail::h189d1be8be941fca> @ imm = #-0x44fc
 f004b68: defe         	trap
 f004b6a: 4418         	add	r0, r3
 f004b6c: 9908         	ldr	r1, [sp, #0x20]
 f004b6e: f040 0001    	.word	#0xf0400001
 f004b72: f8c8 8000    	.word	#0xf8c88000
 f004b76: e9c1 8000    	.word	#0xe9c18000
 f004b7a: 9807         	ldr	r0, [sp, #0x1c]
 f004b7c: f8c1 8008    	.word	#0xf8c18008
 f004b80: 60c8         	str	r0, [r1, #0xc]
 f004b82: b019         	add	sp, #0x64
 f004b84: e8bd 0f00    	.word	#0xe8bd0f00
 f004b88: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004b8a: d4d4         	bmi	0xf004b36 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21+0x562> @ imm = #-0x58

0f004b8c <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6>:
 f004b8c: f04f 5c00    	.word	#0xf04f5c00
 f004b90: f8dc c000    	.word	#0xf8dcc000
 f004b94: ebbd 0c0c    	.word	#0xebbd0c0c
 f004b98: f1bc 0f38    	.word	#0xf1bc0f38
 f004b9c: da02         	bge	0xf004ba4 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x18> @ imm = #0x4
 f004b9e: dfff         	svc	#0xff
 f004ba0: 000e         	movs	r6, r1
 f004ba2: 0000         	movs	r0, r0
 f004ba4: b5f0         	push	{r4, r5, r6, r7, lr}
 f004ba6: af03         	add	r7, sp, #0xc
 f004ba8: e92d 0f00    	.word	#0xe92d0f00
 f004bac: b085         	sub	sp, #0x14
 f004bae: b2d2         	uxtb	r2, r2
 f004bb0: 2a0c         	cmp	r2, #0xc
 f004bb2: d828         	bhi	0xf004c06 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x7a> @ imm = #0x50
 f004bb4: e8df f012    	.word	#0xe8dff012

0f004bb8 <$d.81>:
 f004bb8: 0d 00 43 00  	.word	0x0043000d
 f004bbc: 80 00 92 00  	.word	0x00920080
 f004bc0: 0d 00 3d 00  	.word	0x003d000d
 f004bc4: 3d 00 3d 00  	.word	0x003d003d
 f004bc8: 3d 00 a4 00  	.word	0x00a4003d
 f004bcc: e3 00 f5 00  	.word	0x00f500e3
 f004bd0: 0d 00        	.short	0x000d

0f004bd2 <$t.82>:
 f004bd2: e9d1 2300    	.word	#0xe9d12300
 f004bd6: 2b08         	cmp	r3, #0x8
 f004bd8: d21d         	bhs	0xf004c16 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x8a> @ imm = #0x3a
 f004bda: f8cd 200f    	.word	#0xf8cd200f
 f004bde: f8bd 1010    	.word	#0xf8bd1010
 f004be2: e9dd 3602    	.word	#0xe9dd3602
 f004be6: f89d 2012    	.word	#0xf89d2012
 f004bea: f8a0 1009    	.word	#0xf8a01009
 f004bee: f8ad 1000    	.word	#0xf8ad1000
 f004bf2: 2100         	movs	r1, #0x0
 f004bf4: f8c0 6005    	.word	#0xf8c06005
 f004bf8: f88d 2002    	.word	#0xf88d2002
 f004bfc: f8c0 3001    	.word	#0xf8c03001
 f004c00: 72c2         	strb	r2, [r0, #0xb]
 f004c02: 60c1         	str	r1, [r0, #0xc]
 f004c04: e0d4         	b	0xf004db0 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x224> @ imm = #0x1a8
 f004c06: 2aff         	cmp	r2, #0xff
 f004c08: d113         	bne	0xf004c32 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0xa6> @ imm = #0x26
 f004c0a: 2105         	movs	r1, #0x5
 f004c0c: 7001         	strb	r1, [r0]
 f004c0e: b005         	add	sp, #0x14
 f004c10: e8bd 0f00    	.word	#0xe8bd0f00
 f004c14: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004c16: 6855         	ldr	r5, [r2, #0x4]
 f004c18: 3b08         	subs	r3, #0x8
 f004c1a: 6816         	ldr	r6, [r2]
 f004c1c: 3208         	adds	r2, #0x8
 f004c1e: e9c1 2300    	.word	#0xe9c12300
 f004c22: 214b         	movs	r1, #0x4b
 f004c24: e9c0 6502    	.word	#0xe9c06502
 f004c28: 7001         	strb	r1, [r0]
 f004c2a: b005         	add	sp, #0x14
 f004c2c: e8bd 0f00    	.word	#0xe8bd0f00
 f004c30: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004c32: 2136         	movs	r1, #0x36
 f004c34: 7001         	strb	r1, [r0]
 f004c36: b005         	add	sp, #0x14
 f004c38: e8bd 0f00    	.word	#0xe8bd0f00
 f004c3c: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004c3e: e9d1 2300    	.word	#0xe9d12300
 f004c42: 2b00         	cmp	r3, #0x0
 f004c44: f000 80c8    	.word	#0xf00080c8
 f004c48: eb02 0c03    	.word	#0xeb020c03
 f004c4c: f102 0b01    	.word	#0xf1020b01
 f004c50: 1e5c         	subs	r4, r3, #0x1
 f004c52: f04f 0800    	.word	#0xf04f0800
 f004c56: f04f 0900    	.word	#0xf04f0900
 f004c5a: 2200         	movs	r2, #0x0
 f004c5c: f81b ec01    	.word	#0xf81bec01
 f004c60: 2a3f         	cmp	r2, #0x3f
 f004c62: d103         	bne	0xf004c6c <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0xe0> @ imm = #0x6
 f004c64: f1be 0f02    	.word	#0xf1be0f02
 f004c68: f080 80e8    	.word	#0xf08080e8
 f004c6c: f002 033f    	.word	#0xf002033f
 f004c70: f00e 057f    	.word	#0xf00e057f
 f004c74: f1c3 0620    	.word	#0xf1c30620
 f004c78: f1b3 0a20    	.word	#0xf1b30a20
 f004c7c: fa05 f303    	.word	#0xfa05f303
 f004c80: fa25 f606    	.word	#0xfa25f606
 f004c84: bf58         	it	pl
 f004c86: fa05 f60a    	.word	#0xfa05f60a
 f004c8a: bf58         	it	pl
 f004c8c: 2300         	movpl	r3, #0x0
 f004c8e: ea48 0803    	.word	#0xea480803
 f004c92: ea49 0906    	.word	#0xea490906
 f004c96: fa4f f38e    	.word	#0xfa4ff38e
 f004c9a: f1b3 3fff    	.word	#0xf1b33fff
 f004c9e: f300 80e1    	.word	#0xf30080e1
 f004ca2: 3c01         	subs	r4, #0x1
 f004ca4: f10b 0b01    	.word	#0xf10b0b01
 f004ca8: 3207         	adds	r2, #0x7
 f004caa: 1c65         	adds	r5, r4, #0x1
 f004cac: d1d6         	bne	0xf004c5c <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0xd0> @ imm = #-0x54
 f004cae: 2200         	movs	r2, #0x0
 f004cb0: e9c1 c200    	.word	#0xe9c1c200
 f004cb4: 4662         	mov	r2, r12
 f004cb6: e091         	b	0xf004ddc <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x250> @ imm = #0x122
 f004cb8: e9d1 2300    	.word	#0xe9d12300
 f004cbc: 2b02         	cmp	r3, #0x2
 f004cbe: d374         	blo	0xf004daa <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x21e> @ imm = #0xe8
 f004cc0: 3b02         	subs	r3, #0x2
 f004cc2: f832 5b02    	.word	#0xf8325b02
 f004cc6: 2600         	movs	r6, #0x0
 f004cc8: e9c1 2300    	.word	#0xe9c12300
 f004ccc: 214b         	movs	r1, #0x4b
 f004cce: 7001         	strb	r1, [r0]
 f004cd0: e9c0 5602    	.word	#0xe9c05602
 f004cd4: b005         	add	sp, #0x14
 f004cd6: e8bd 0f00    	.word	#0xe8bd0f00
 f004cda: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004cdc: e9d1 2300    	.word	#0xe9d12300
 f004ce0: 2b04         	cmp	r3, #0x4
 f004ce2: d362         	blo	0xf004daa <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x21e> @ imm = #0xc4
 f004ce4: 3b04         	subs	r3, #0x4
 f004ce6: f852 5b04    	.word	#0xf8525b04
 f004cea: 2600         	movs	r6, #0x0
 f004cec: e9c1 2300    	.word	#0xe9c12300
 f004cf0: 214b         	movs	r1, #0x4b
 f004cf2: e9c0 5602    	.word	#0xe9c05602
 f004cf6: 7001         	strb	r1, [r0]
 f004cf8: b005         	add	sp, #0x14
 f004cfa: e8bd 0f00    	.word	#0xe8bd0f00
 f004cfe: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004d00: e9d1 2300    	.word	#0xe9d12300
 f004d04: 2b00         	cmp	r3, #0x0
 f004d06: d072         	beq	0xf004dee <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x262> @ imm = #0xe4
 f004d08: eb02 0e03    	.word	#0xeb020e03
 f004d0c: f102 0b01    	.word	#0xf1020b01
 f004d10: 1e5d         	subs	r5, r3, #0x1
 f004d12: f04f 0800    	.word	#0xf04f0800
 f004d16: f04f 0900    	.word	#0xf04f0900
 f004d1a: 2600         	movs	r6, #0x0
 f004d1c: f81b cc01    	.word	#0xf81bcc01
 f004d20: 2e3f         	cmp	r6, #0x3f
 f004d22: d106         	bne	0xf004d32 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x1a6> @ imm = #0xc
 f004d24: f1bc 0f7f    	.word	#0xf1bc0f7f
 f004d28: bf18         	it	ne
 f004d2a: f1bc 0f00    	.word	#0xf1bc0f00
 f004d2e: f040 80a3    	.word	#0xf04080a3
 f004d32: f006 033f    	.word	#0xf006033f
 f004d36: f00c 027f    	.word	#0xf00c027f
 f004d3a: f1c3 0420    	.word	#0xf1c30420
 f004d3e: f1b3 0a20    	.word	#0xf1b30a20
 f004d42: f106 0607    	.word	#0xf1060607
 f004d46: fa22 f404    	.word	#0xfa22f404
 f004d4a: bf58         	it	pl
 f004d4c: fa02 f40a    	.word	#0xfa02f40a
 f004d50: fa02 f203    	.word	#0xfa02f203
 f004d54: bf58         	it	pl
 f004d56: 2200         	movpl	r2, #0x0
 f004d58: ea48 0802    	.word	#0xea480802
 f004d5c: ea49 0904    	.word	#0xea490904
 f004d60: fa4f f28c    	.word	#0xfa4ff28c
 f004d64: f1b2 3fff    	.word	#0xf1b23fff
 f004d68: dc51         	bgt	0xf004e0e <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x282> @ imm = #0xa2
 f004d6a: 3d01         	subs	r5, #0x1
 f004d6c: f10b 0b01    	.word	#0xf10b0b01
 f004d70: 1c6a         	adds	r2, r5, #0x1
 f004d72: d1d3         	bne	0xf004d1c <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x190> @ imm = #-0x5a
 f004d74: 2200         	movs	r2, #0x0
 f004d76: e9c1 e200    	.word	#0xe9c1e200
 f004d7a: 4672         	mov	r2, lr
 f004d7c: e039         	b	0xf004df2 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x266> @ imm = #0x72
 f004d7e: e9d1 2300    	.word	#0xe9d12300
 f004d82: 2b02         	cmp	r3, #0x2
 f004d84: d311         	blo	0xf004daa <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x21e> @ imm = #0x22
 f004d86: 3b02         	subs	r3, #0x2
 f004d88: f932 6b02    	.word	#0xf9326b02
 f004d8c: e9c1 2300    	.word	#0xe9c12300
 f004d90: 214b         	movs	r1, #0x4b
 f004d92: 7001         	strb	r1, [r0]
 f004d94: 17f1         	asrs	r1, r6, #0x1f
 f004d96: e9c0 6102    	.word	#0xe9c06102
 f004d9a: b005         	add	sp, #0x14
 f004d9c: e8bd 0f00    	.word	#0xe8bd0f00
 f004da0: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004da2: e9d1 2300    	.word	#0xe9d12300
 f004da6: 2b04         	cmp	r3, #0x4
 f004da8: d208         	bhs	0xf004dbc <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x230> @ imm = #0x10
 f004daa: 2100         	movs	r1, #0x0
 f004dac: e9c0 2102    	.word	#0xe9c02102
 f004db0: 2113         	movs	r1, #0x13
 f004db2: 7001         	strb	r1, [r0]
 f004db4: b005         	add	sp, #0x14
 f004db6: e8bd 0f00    	.word	#0xe8bd0f00
 f004dba: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004dbc: f852 6b04    	.word	#0xf8526b04
 f004dc0: 3b04         	subs	r3, #0x4
 f004dc2: e9c1 2300    	.word	#0xe9c12300
 f004dc6: 17f1         	asrs	r1, r6, #0x1f
 f004dc8: e9c0 6102    	.word	#0xe9c06102
 f004dcc: 214b         	movs	r1, #0x4b
 f004dce: 7001         	strb	r1, [r0]
 f004dd0: b005         	add	sp, #0x14
 f004dd2: e8bd 0f00    	.word	#0xe8bd0f00
 f004dd6: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004dd8: f04f 0e00    	.word	#0xf04f0e00
 f004ddc: f8bd 100c    	.word	#0xf8bd100c
 f004de0: 9b02         	ldr	r3, [sp, #0x8]
 f004de2: f8ad 1004    	.word	#0xf8ad1004
 f004de6: 2100         	movs	r1, #0x0
 f004de8: 9300         	str	r3, [sp]
 f004dea: 2313         	movs	r3, #0x13
 f004dec: e02b         	b	0xf004e46 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x2ba> @ imm = #0x56
 f004dee: f04f 0c00    	.word	#0xf04f0c00
 f004df2: f8bd 100c    	.word	#0xf8bd100c
 f004df6: 9b02         	ldr	r3, [sp, #0x8]
 f004df8: f8ad 1004    	.word	#0xf8ad1004
 f004dfc: 2100         	movs	r1, #0x0
 f004dfe: 9300         	str	r3, [sp]
 f004e00: 2313         	movs	r3, #0x13
 f004e02: f8bd 6004    	.word	#0xf8bd6004
 f004e06: 9d00         	ldr	r5, [sp]
 f004e08: f880 c001    	.word	#0xf880c001
 f004e0c: e020         	b	0xf004e50 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x2c4> @ imm = #0x40
 f004e0e: 2e3f         	cmp	r6, #0x3f
 f004e10: e9c1 b500    	.word	#0xe9c1b500
 f004e14: dc28         	bgt	0xf004e68 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x2dc> @ imm = #0x50
 f004e16: f01c 0140    	.word	#0xf01c0140
 f004e1a: d025         	beq	0xf004e68 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x2dc> @ imm = #0x4a
 f004e1c: f006 013f    	.word	#0xf006013f
 f004e20: f04f 32ff    	.word	#0xf04f32ff
 f004e24: fa02 f301    	.word	#0xfa02f301
 f004e28: 3920         	subs	r1, #0x20
 f004e2a: bf58         	it	pl
 f004e2c: 2300         	movpl	r3, #0x0
 f004e2e: bf58         	it	pl
 f004e30: 408a         	lslpl	r2, r1
 f004e32: ea48 0803    	.word	#0xea480803
 f004e36: ea49 0902    	.word	#0xea490902
 f004e3a: e015         	b	0xf004e68 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x2dc> @ imm = #0x2a
 f004e3c: e9c1 b400    	.word	#0xe9c1b400
 f004e40: 2306         	movs	r3, #0x6
 f004e42: f04f 0e00    	.word	#0xf04f0e00
 f004e46: f8bd 6004    	.word	#0xf8bd6004
 f004e4a: 9d00         	ldr	r5, [sp]
 f004e4c: f880 e001    	.word	#0xf880e001
 f004e50: f8c0 5002    	.word	#0xf8c05002
 f004e54: 7003         	strb	r3, [r0]
 f004e56: 80c6         	strh	r6, [r0, #0x6]
 f004e58: e9c0 2102    	.word	#0xe9c02102
 f004e5c: b005         	add	sp, #0x14
 f004e5e: e8bd 0f00    	.word	#0xe8bd0f00
 f004e62: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004e64: e9c1 b400    	.word	#0xe9c1b400
 f004e68: 214b         	movs	r1, #0x4b
 f004e6a: e9c0 8902    	.word	#0xe9c08902
 f004e6e: 7001         	strb	r1, [r0]
 f004e70: b005         	add	sp, #0x14
 f004e72: e8bd 0f00    	.word	#0xe8bd0f00
 f004e76: bdf0         	pop	{r4, r5, r6, r7, pc}
 f004e78: e9c1 b500    	.word	#0xe9c1b500
 f004e7c: f04f 0c00    	.word	#0xf04f0c00
 f004e80: 2307         	movs	r3, #0x7
 f004e82: e7be         	b	0xf004e02 <hopter::unwind::unw_lsda::read_encoded_pointer::h6efd019a7f0cd3a6+0x276> @ imm = #-0x84

0f004e84 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818>:
 f004e84: f04f 5c00    	.word	#0xf04f5c00
 f004e88: f8dc c000    	.word	#0xf8dcc000
 f004e8c: ebbd 0c0c    	.word	#0xebbd0c0c
 f004e90: f5bc 7fbc    	.word	#0xf5bc7fbc
 f004e94: da02         	bge	0xf004e9c <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x18> @ imm = #0x4
 f004e96: dfff         	svc	#0xff
 f004e98: 005e         	lsls	r6, r3, #0x1
 f004e9a: 0000         	movs	r0, r0
 f004e9c: b5f0         	push	{r4, r5, r6, r7, lr}
 f004e9e: af03         	add	r7, sp, #0xc
 f004ea0: e92d 0f00    	.word	#0xe92d0f00
 f004ea4: b0d5         	sub	sp, #0x154
 f004ea6: f246 7818    	.word	#0xf2467818
 f004eaa: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004eae: f2c2 0800    	.word	#0xf2c20800
 f004eb2: e858 0f0f    	.word	#0xe8580f0f
 f004eb6: 3001         	adds	r0, #0x1
 f004eb8: e848 010f    	.word	#0xe848010f
 f004ebc: 2900         	cmp	r1, #0x0
 f004ebe: d1f8         	bne	0xf004eb2 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x2e> @ imm = #-0x10
 f004ec0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004ec4: e858 0f14    	.word	#0xe8580f14
 f004ec8: 1d01         	adds	r1, r0, #0x4
 f004eca: e848 1214    	.word	#0xe8481214
 f004ece: 2a00         	cmp	r2, #0x0
 f004ed0: d1f8         	bne	0xf004ec4 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x40> @ imm = #-0x10
 f004ed2: f64f 7afc    	.word	#0xf64f7afc
 f004ed6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004eda: f6c7 7aff    	.word	#0xf6c77aff
 f004ede: 4550         	cmp	r0, r10
 f004ee0: d85b         	bhi	0xf004f9a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x116> @ imm = #0xb6
 f004ee2: 0780         	lsls	r0, r0, #0x1e
 f004ee4: d068         	beq	0xf004fb8 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x134> @ imm = #0xd0
 f004ee6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004eea: e858 0f14    	.word	#0xe8580f14
 f004eee: 3804         	subs	r0, #0x4
 f004ef0: e848 0114    	.word	#0xe8480114
 f004ef4: 2900         	cmp	r1, #0x0
 f004ef6: d1f8         	bne	0xf004eea <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x66> @ imm = #-0x10
 f004ef8: bf10         	yield
 f004efa: e858 0f14    	.word	#0xe8580f14
 f004efe: 1d01         	adds	r1, r0, #0x4
 f004f00: e848 1214    	.word	#0xe8481214
 f004f04: 2a00         	cmp	r2, #0x0
 f004f06: d1f8         	bne	0xf004efa <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x76> @ imm = #-0x10
 f004f08: 4550         	cmp	r0, r10
 f004f0a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004f0e: d844         	bhi	0xf004f9a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x116> @ imm = #0x88
 f004f10: 0780         	lsls	r0, r0, #0x1e
 f004f12: d051         	beq	0xf004fb8 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x134> @ imm = #0xa2
 f004f14: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004f18: e858 0f14    	.word	#0xe8580f14
 f004f1c: 3804         	subs	r0, #0x4
 f004f1e: e848 0114    	.word	#0xe8480114
 f004f22: 2900         	cmp	r1, #0x0
 f004f24: d1f8         	bne	0xf004f18 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x94> @ imm = #-0x10
 f004f26: bf10         	yield
 f004f28: e858 0f14    	.word	#0xe8580f14
 f004f2c: 1d01         	adds	r1, r0, #0x4
 f004f2e: e848 1214    	.word	#0xe8481214
 f004f32: 2a00         	cmp	r2, #0x0
 f004f34: d1f8         	bne	0xf004f28 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0xa4> @ imm = #-0x10
 f004f36: 4550         	cmp	r0, r10
 f004f38: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004f3c: d82d         	bhi	0xf004f9a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x116> @ imm = #0x5a
 f004f3e: 0780         	lsls	r0, r0, #0x1e
 f004f40: d03a         	beq	0xf004fb8 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x134> @ imm = #0x74
 f004f42: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004f46: e858 0f14    	.word	#0xe8580f14
 f004f4a: 3804         	subs	r0, #0x4
 f004f4c: e848 0114    	.word	#0xe8480114
 f004f50: 2900         	cmp	r1, #0x0
 f004f52: d1f8         	bne	0xf004f46 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0xc2> @ imm = #-0x10
 f004f54: bf10         	yield
 f004f56: e858 0f14    	.word	#0xe8580f14
 f004f5a: 1d01         	adds	r1, r0, #0x4
 f004f5c: e848 1214    	.word	#0xe8481214
 f004f60: 2a00         	cmp	r2, #0x0
 f004f62: d1f8         	bne	0xf004f56 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0xd2> @ imm = #-0x10
 f004f64: 4550         	cmp	r0, r10
 f004f66: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004f6a: d816         	bhi	0xf004f9a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x116> @ imm = #0x2c
 f004f6c: 0780         	lsls	r0, r0, #0x1e
 f004f6e: d023         	beq	0xf004fb8 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x134> @ imm = #0x46
 f004f70: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004f74: e858 0f14    	.word	#0xe8580f14
 f004f78: 3804         	subs	r0, #0x4
 f004f7a: e848 0114    	.word	#0xe8480114
 f004f7e: 2900         	cmp	r1, #0x0
 f004f80: d1f8         	bne	0xf004f74 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0xf0> @ imm = #-0x10
 f004f82: bf10         	yield
 f004f84: e858 0f14    	.word	#0xe8580f14
 f004f88: 1d01         	adds	r1, r0, #0x4
 f004f8a: e848 1214    	.word	#0xe8481214
 f004f8e: 2a00         	cmp	r2, #0x0
 f004f90: d1f8         	bne	0xf004f84 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x100> @ imm = #-0x10
 f004f92: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004f96: 4550         	cmp	r0, r10
 f004f98: d9a3         	bls	0xf004ee2 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x5e> @ imm = #-0xba
 f004f9a: e858 0f14    	.word	#0xe8580f14
 f004f9e: 3804         	subs	r0, #0x4
 f004fa0: e848 0114    	.word	#0xe8480114
 f004fa4: 2900         	cmp	r1, #0x0
 f004fa6: d1f8         	bne	0xf004f9a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x116> @ imm = #-0x10
 f004fa8: f245 6078    	.word	#0xf2456078
 f004fac: 212c         	movs	r1, #0x2c
 f004fae: f6c0 7000    	.word	#0xf6c07000
 f004fb2: f7fb fb4a    	bl	0xf00064a <core::panicking::panic::h8dd566bdcd44a399> @ imm = #-0x496c
 f004fb6: e234         	b	0xf005422 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x59e> @ imm = #0x468
 f004fb8: f8d8 4054    	.word	#0xf8d84054
 f004fbc: 2c00         	cmp	r4, #0x0
 f004fbe: d061         	beq	0xf005084 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x200> @ imm = #0xc2
 f004fc0: e854 0f00    	.word	#0xe8540f00
 f004fc4: 1c41         	adds	r1, r0, #0x1
 f004fc6: e844 1200    	.word	#0xe8441200
 f004fca: 2a00         	cmp	r2, #0x0
 f004fcc: d1f8         	bne	0xf004fc0 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x13c> @ imm = #-0x10
 f004fce: f1b0 3fff    	.word	#0xf1b03fff
 f004fd2: f340 8227    	.word	#0xf3408227
 f004fd6: f8d4 0090    	.word	#0xf8d40090
 f004fda: 940a         	str	r4, [sp, #0x28]
 f004fdc: 1c41         	adds	r1, r0, #0x1
 f004fde: 2901         	cmp	r1, #0x1
 f004fe0: d853         	bhi	0xf00508a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x206> @ imm = #0xa6
 f004fe2: a83d         	add	r0, sp, #0xf4
 f004fe4: 2160         	movs	r1, #0x60
 f004fe6: f894 50cc    	.word	#0xf89450cc
 f004fea: f3bf 8f5f    	.word	#0xf3bf8f5f
 f004fee: 942f         	str	r4, [sp, #0xbc]
 f004ff0: f7fe ff3c    	bl	0xf003e6c <__aeabi_memclr8> @ imm = #-0x1188
 f004ff4: 2000         	movs	r0, #0x0
 f004ff6: 2128         	movs	r1, #0x28
 f004ff8: f88d 00c8    	.word	#0xf88d00c8
 f004ffc: a832         	add	r0, sp, #0xc8
 f004ffe: 3004         	adds	r0, #0x4
 f005000: f7fe ff34    	bl	0xf003e6c <__aeabi_memclr8> @ imm = #-0x1198
 f005004: e854 0f00    	.word	#0xe8540f00
 f005008: 1c41         	adds	r1, r0, #0x1
 f00500a: e844 1200    	.word	#0xe8441200
 f00500e: 2a00         	cmp	r2, #0x0
 f005010: d1f8         	bne	0xf005004 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x180> @ imm = #-0x10
 f005012: 2800         	cmp	r0, #0x0
 f005014: f100 8206    	.word	#0xf1008206
 f005018: 9431         	str	r4, [sp, #0xc4]
 f00501a: f894 c0cc    	.word	#0xf894c0cc
 f00501e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005022: 9c31         	ldr	r4, [sp, #0xc4]
 f005024: f8d4 9008    	.word	#0xf8d49008
 f005028: f8d4 308c    	.word	#0xf8d4308c
 f00502c: f1b9 0f00    	.word	#0xf1b90f00
 f005030: d040         	beq	0xf0050b4 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x230> @ imm = #0x80
 f005032: 68e1         	ldr	r1, [r4, #0xc]
 f005034: e859 0f00    	.word	#0xe8590f00
 f005038: 1c46         	adds	r6, r0, #0x1
 f00503a: e849 6200    	.word	#0xe8496200
 f00503e: 2a00         	cmp	r2, #0x0
 f005040: d1f8         	bne	0xf005034 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x1b0> @ imm = #-0x10
 f005042: f1b0 3fff    	.word	#0xf1b03fff
 f005046: f340 81ed    	.word	#0xf34081ed
 f00504a: b3ab         	cbz	r3, 0xf0050b8 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x234> @ imm = #0x6a
 f00504c: 6888         	ldr	r0, [r1, #0x8]
 f00504e: f8d4 b094    	.word	#0xf8d4b094
 f005052: 3801         	subs	r0, #0x1
 f005054: f8cd c020    	.word	#0xf8cdc020
 f005058: f020 0007    	.word	#0xf0200007
 f00505c: 4448         	add	r0, r9
 f00505e: 3008         	adds	r0, #0x8
 f005060: 460e         	mov	r6, r1
 f005062: 9309         	str	r3, [sp, #0x24]
 f005064: 4798         	blx	r3
 f005066: f1bb 0f00    	.word	#0xf1bb0f00
 f00506a: d00c         	beq	0xf005086 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x202> @ imm = #0x18
 f00506c: f8d4 20c4    	.word	#0xf8d420c4
 f005070: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005074: b2d1         	uxtb	r1, r2
 f005076: b301         	cbz	r1, 0xf0050ba <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x236> @ imm = #0x40
 f005078: 2901         	cmp	r1, #0x1
 f00507a: d105         	bne	0xf005088 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x204> @ imm = #0xa
 f00507c: 2110         	movs	r1, #0x10
 f00507e: f8cd b014    	.word	#0xf8cdb014
 f005082: e01d         	b	0xf0050c0 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x23c> @ imm = #0x3a
 f005084: e7fe         	b	0xf005084 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x200> @ imm = #-0x4
 f005086: e7fe         	b	0xf005086 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x202> @ imm = #-0x4
 f005088: e7fe         	b	0xf005088 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x204> @ imm = #-0x4
 f00508a: 6800         	ldr	r0, [r0]
 f00508c: 2800         	cmp	r0, #0x0
 f00508e: d0a8         	beq	0xf004fe2 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x15e> @ imm = #-0xb0
 f005090: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005094: e854 0f00    	.word	#0xe8540f00
 f005098: 1e41         	subs	r1, r0, #0x1
 f00509a: e844 1200    	.word	#0xe8441200
 f00509e: 2a00         	cmp	r2, #0x0
 f0050a0: d1f8         	bne	0xf005094 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x210> @ imm = #-0x10
 f0050a2: 2801         	cmp	r0, #0x1
 f0050a4: d104         	bne	0xf0050b0 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x22c> @ imm = #0x8
 f0050a6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0050aa: a80a         	add	r0, sp, #0x28
 f0050ac: f7fb ff88    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x40f0
 f0050b0: 2400         	movs	r4, #0x0
 f0050b2: e136         	b	0xf005322 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x49e> @ imm = #0x26c
 f0050b4: b103         	cbz	r3, 0xf0050b8 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x234> @ imm = #0x0
 f0050b6: e7fe         	b	0xf0050b6 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x232> @ imm = #-0x4
 f0050b8: e7fe         	b	0xf0050b8 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x234> @ imm = #-0x4
 f0050ba: f8cd b014    	.word	#0xf8cdb014
 f0050be: 2108         	movs	r1, #0x8
 f0050c0: f8dd c0c4    	.word	#0xf8ddc0c4
 f0050c4: fa22 fe01    	.word	#0xfa22fe01
 f0050c8: 462b         	mov	r3, r5
 f0050ca: f10c 0404    	.word	#0xf10c0404
 f0050ce: e000         	b	0xf0050d2 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x24e> @ imm = #0x0
 f0050d0: bf10         	yield
 f0050d2: 6825         	ldr	r5, [r4]
 f0050d4: e003         	b	0xf0050de <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x25a> @ imm = #0x6
 f0050d6: f3bf 8f2f    	.word	#0xf3bf8f2f
 f0050da: 2100         	movs	r1, #0x0
 f0050dc: b999         	cbnz	r1, 0xf005106 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x282> @ imm = #0x26
 f0050de: 1c69         	adds	r1, r5, #0x1
 f0050e0: d0f6         	beq	0xf0050d0 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x24c> @ imm = #-0x14
 f0050e2: 462a         	mov	r2, r5
 f0050e4: f1b5 3fff    	.word	#0xf1b53fff
 f0050e8: f340 8199    	.word	#0xf3408199
 f0050ec: e854 5f00    	.word	#0xe8545f00
 f0050f0: 4295         	cmp	r5, r2
 f0050f2: d1f0         	bne	0xf0050d6 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x252> @ imm = #-0x20
 f0050f4: e844 1200    	.word	#0xe8441200
 f0050f8: 2a00         	cmp	r2, #0x0
 f0050fa: d1ee         	bne	0xf0050da <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x256> @ imm = #-0x24
 f0050fc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005100: 2101         	movs	r1, #0x1
 f005102: 2900         	cmp	r1, #0x0
 f005104: d0eb         	beq	0xf0050de <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x25a> @ imm = #-0x2a
 f005106: 9607         	str	r6, [sp, #0x1c]
 f005108: 2101         	movs	r1, #0x1
 f00510a: 9e31         	ldr	r6, [sp, #0xc4]
 f00510c: f01e 0ff0    	.word	#0xf01e0ff0
 f005110: 9304         	str	r3, [sp, #0x10]
 f005112: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005116: f886 10cf    	.word	#0xf88610cf
 f00511a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00511e: d061         	beq	0xf0051e4 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x360> @ imm = #0xc2
 f005120: f44f 6070    	.word	#0xf44f6070
 f005124: f04f 0a00    	.word	#0xf04f0a00
 f005128: 9008         	str	r0, [sp, #0x20]
 f00512a: 2000         	movs	r0, #0x0
 f00512c: f04f 0b00    	.word	#0xf04f0b00
 f005130: 2500         	movs	r5, #0x0
 f005132: e9cd 0002    	.word	#0xe9cd0002
 f005136: f8cd c018    	.word	#0xf8cdc018
 f00513a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00513e: e856 0f00    	.word	#0xe8560f00
 f005142: 1e41         	subs	r1, r0, #0x1
 f005144: e846 1200    	.word	#0xe8461200
 f005148: 2a00         	cmp	r2, #0x0
 f00514a: d1f8         	bne	0xf00513e <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x2ba> @ imm = #-0x10
 f00514c: 2801         	cmp	r0, #0x1
 f00514e: d106         	bne	0xf00515e <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x2da> @ imm = #0xc
 f005150: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005154: a831         	add	r0, sp, #0xc4
 f005156: 4676         	mov	r6, lr
 f005158: f7fb ff32    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x419c
 f00515c: 46b6         	mov	lr, r6
 f00515e: 9e07         	ldr	r6, [sp, #0x1c]
 f005160: f01e 0ff0    	.word	#0xf01e0ff0
 f005164: d044         	beq	0xf0051f0 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x36c> @ imm = #0x88
 f005166: 2d00         	cmp	r5, #0x0
 f005168: bf1e         	ittt	ne
 f00516a: f108 0009    	.word	#0xf1080009
 f00516e: 4629         	movne	r1, r5
 f005170: f7fb ffb7    	blne	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #-0x4092
 f005174: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005178: e859 0f00    	.word	#0xe8590f00
 f00517c: 1e41         	subs	r1, r0, #0x1
 f00517e: e849 1200    	.word	#0xe8491200
 f005182: 2a00         	cmp	r2, #0x0
 f005184: d1f8         	bne	0xf005178 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x2f4> @ imm = #-0x10
 f005186: 2801         	cmp	r0, #0x1
 f005188: d105         	bne	0xf005196 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x312> @ imm = #0xa
 f00518a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00518e: 4648         	mov	r0, r9
 f005190: 4631         	mov	r1, r6
 f005192: f7fb ffb0    	bl	0xf0010f6 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::ha658a7f69128d260> @ imm = #-0x40a0
 f005196: 9906         	ldr	r1, [sp, #0x18]
 f005198: 1c48         	adds	r0, r1, #0x1
 f00519a: d010         	beq	0xf0051be <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x33a> @ imm = #0x20
 f00519c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0051a0: e854 0f00    	.word	#0xe8540f00
 f0051a4: 1e43         	subs	r3, r0, #0x1
 f0051a6: e844 3200    	.word	#0xe8443200
 f0051aa: 2a00         	cmp	r2, #0x0
 f0051ac: d1f8         	bne	0xf0051a0 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x31c> @ imm = #-0x10
 f0051ae: 2801         	cmp	r0, #0x1
 f0051b0: d105         	bne	0xf0051be <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x33a> @ imm = #0xa
 f0051b2: f108 0009    	.word	#0xf1080009
 f0051b6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0051ba: f7fb ff92    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #-0x40dc
 f0051be: 982f         	ldr	r0, [sp, #0xbc]
 f0051c0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0051c4: e850 1f00    	.word	#0xe8501f00
 f0051c8: 1e4a         	subs	r2, r1, #0x1
 f0051ca: e840 2300    	.word	#0xe8402300
 f0051ce: 2b00         	cmp	r3, #0x0
 f0051d0: d1f8         	bne	0xf0051c4 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x340> @ imm = #-0x10
 f0051d2: 2901         	cmp	r1, #0x1
 f0051d4: d104         	bne	0xf0051e0 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x35c> @ imm = #0x8
 f0051d6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0051da: a82f         	add	r0, sp, #0xbc
 f0051dc: f7fb fef0    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x4220
 f0051e0: 2401         	movs	r4, #0x1
 f0051e2: e09e         	b	0xf005322 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x49e> @ imm = #0x13c
 f0051e4: f8d6 b088    	.word	#0xf8d6b088
 f0051e8: f11b 017c    	.word	#0xf11b017c
 f0051ec: d332         	blo	0xf005254 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x3d0> @ imm = #0x64
 f0051ee: e7fe         	b	0xf0051ee <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x36a> @ imm = #-0x4
 f0051f0: e9cd a500    	.word	#0xe9cda500
 f0051f4: f44f 6050    	.word	#0xf44f6050
 f0051f8: f8dd a0bc    	.word	#0xf8dda0bc
 f0051fc: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005200: 2260         	movs	r2, #0x60
 f005202: f8ca 00c4    	.word	#0xf8ca00c4
 f005206: f817 0cad    	.word	#0xf8170cad
 f00520a: f837 1caf    	.word	#0xf8371caf
 f00520e: f88d 00ba    	.word	#0xf88d00ba
 f005212: a816         	add	r0, sp, #0x58
 f005214: f8ad 10b8    	.word	#0xf8ad10b8
 f005218: a93d         	add	r1, sp, #0xf4
 f00521a: f7fe fe24    	bl	0xf003e66 <__aeabi_memcpy8> @ imm = #-0x13b8
 f00521e: f10d 0cc8    	.word	#0xf10d0cc8
 f005222: a90b         	add	r1, sp, #0x2c
 f005224: e8bc 005d    	.word	#0xe8bc005d
 f005228: c15d         	stm	r1!, {r0, r2, r3, r4, r6}
 f00522a: e89c 007d    	.word	#0xe89c007d
 f00522e: c17d         	stm	r1!, {r0, r2, r3, r4, r5, r6}
 f005230: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005234: e85a 0f00    	.word	#0xe85a0f00
 f005238: 1e41         	subs	r1, r0, #0x1
 f00523a: e84a 1200    	.word	#0xe84a1200
 f00523e: 2a00         	cmp	r2, #0x0
 f005240: d1f8         	bne	0xf005234 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x3b0> @ imm = #-0x10
 f005242: 2801         	cmp	r0, #0x1
 f005244: d10a         	bne	0xf00525c <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x3d8> @ imm = #0x14
 f005246: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00524a: a82f         	add	r0, sp, #0xbc
 f00524c: f7fb feb8    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x4290
 f005250: ac32         	add	r4, sp, #0xc8
 f005252: e004         	b	0xf00525e <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x3da> @ imm = #0x8
 f005254: 4551         	cmp	r1, r10
 f005256: f240 80a1    	.word	#0xf24080a1
 f00525a: e7fe         	b	0xf00525a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x3d6> @ imm = #-0x4
 f00525c: ac32         	add	r4, sp, #0xc8
 f00525e: f89d 00ba    	.word	#0xf89d00ba
 f005262: 2260         	movs	r2, #0x60
 f005264: f8bd 10b8    	.word	#0xf8bd10b8
 f005268: f8ad 10c4    	.word	#0xf8ad10c4
 f00526c: a916         	add	r1, sp, #0x58
 f00526e: f88d 00c6    	.word	#0xf88d00c6
 f005272: a83d         	add	r0, sp, #0xf4
 f005274: f7fe fdf7    	bl	0xf003e66 <__aeabi_memcpy8> @ imm = #-0x1412
 f005278: f10d 0c2c    	.word	#0xf10d0c2c
 f00527c: 4620         	mov	r0, r4
 f00527e: e8bc 006e    	.word	#0xe8bc006e
 f005282: c06e         	stm	r0!, {r1, r2, r3, r5, r6}
 f005284: e89c 007e    	.word	#0xe89c007e
 f005288: c07e         	stm	r0!, {r1, r2, r3, r4, r5, r6}
 f00528a: 4640         	mov	r0, r8
 f00528c: f810 1b09    	.word	#0xf8101b09
 f005290: 21d0         	movs	r1, #0xd0
 f005292: f7fc f861    	bl	0xf001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e> @ imm = #-0x3f3e
 f005296: 2800         	cmp	r0, #0x0
 f005298: f000 807c    	.word	#0xf000807c
 f00529c: 4682         	mov	r10, r0
 f00529e: f89d 00c6    	.word	#0xf89d00c6
 f0052a2: f8bd 10c4    	.word	#0xf8bd10c4
 f0052a6: 2200         	movs	r2, #0x0
 f0052a8: f8aa 1019    	.word	#0xf8aa1019
 f0052ac: f88a 001b    	.word	#0xf88a001b
 f0052b0: e9dd 0102    	.word	#0xe9dd0102
 f0052b4: f88a 2018    	.word	#0xf88a2018
 f0052b8: 2201         	movs	r2, #0x1
 f0052ba: 9b07         	ldr	r3, [sp, #0x1c]
 f0052bc: e9ca 1007    	.word	#0xe9ca1007
 f0052c0: f10a 0024    	.word	#0xf10a0024
 f0052c4: a93d         	add	r1, sp, #0xf4
 f0052c6: e9ca 2200    	.word	#0xe9ca2200
 f0052ca: e9ca 3203    	.word	#0xe9ca3203
 f0052ce: f8ca 2014    	.word	#0xf8ca2014
 f0052d2: 2260         	movs	r2, #0x60
 f0052d4: f8ca 9008    	.word	#0xf8ca9008
 f0052d8: f7fe fdc5    	bl	0xf003e66 <__aeabi_memcpy8> @ imm = #-0x1476
 f0052dc: 9801         	ldr	r0, [sp, #0x4]
 f0052de: f10d 0cc8    	.word	#0xf10d0cc8
 f0052e2: e9ca 0b21    	.word	#0xe9ca0b21
 f0052e6: 9809         	ldr	r0, [sp, #0x24]
 f0052e8: f8ca 008c    	.word	#0xf8ca008c
 f0052ec: 9806         	ldr	r0, [sp, #0x18]
 f0052ee: f8ca 0090    	.word	#0xf8ca0090
 f0052f2: 9805         	ldr	r0, [sp, #0x14]
 f0052f4: f8ca 0094    	.word	#0xf8ca0094
 f0052f8: f10a 0098    	.word	#0xf10a0098
 f0052fc: e8bc 006e    	.word	#0xe8bc006e
 f005300: c06e         	stm	r0!, {r1, r2, r3, r5, r6}
 f005302: e89c 007e    	.word	#0xe89c007e
 f005306: c07e         	stm	r0!, {r1, r2, r3, r4, r5, r6}
 f005308: f04f 30ff    	.word	#0xf04f30ff
 f00530c: 9908         	ldr	r1, [sp, #0x20]
 f00530e: e9ca 1031    	.word	#0xe9ca1031
 f005312: 9800         	ldr	r0, [sp]
 f005314: f8ca 00cc    	.word	#0xf8ca00cc
 f005318: 9804         	ldr	r0, [sp, #0x10]
 f00531a: 4651         	mov	r1, r10
 f00531c: f7fc f9a8    	bl	0xf001670 <hopter::schedule::scheduler::make_new_task_ready::h68fd7e29e3ea370e> @ imm = #-0x3cb0
 f005320: 4604         	mov	r4, r0
 f005322: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005326: e858 0f14    	.word	#0xe8580f14
 f00532a: 3804         	subs	r0, #0x4
 f00532c: e848 0114    	.word	#0xe8480114
 f005330: 2900         	cmp	r1, #0x0
 f005332: d1f8         	bne	0xf005326 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x4a2> @ imm = #-0x10
 f005334: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005338: e858 0f0f    	.word	#0xe8580f0f
 f00533c: 3801         	subs	r0, #0x1
 f00533e: e848 010f    	.word	#0xe848010f
 f005342: 2900         	cmp	r1, #0x0
 f005344: d1f8         	bne	0xf005338 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x4b4> @ imm = #-0x10
 f005346: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00534a: f898 0005    	.word	#0xf8980005
 f00534e: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005352: b190         	cbz	r0, 0xf00537a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x4f6> @ imm = #0x24
 f005354: f8d8 003c    	.word	#0xf8d8003c
 f005358: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00535c: b968         	cbnz	r0, 0xf00537a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x4f6> @ imm = #0x1a
 f00535e: f3ef 8005    	.word	#0xf3ef8005
 f005362: b178         	cbz	r0, 0xf005384 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x500> @ imm = #0x1e
 f005364: f3ef 8005    	.word	#0xf3ef8005
 f005368: 280e         	cmp	r0, #0xe
 f00536a: bf1f         	itttt	ne
 f00536c: f64e 5004    	.word	#0xf64e5004
 f005370: f2ce 0000    	.word	#0xf2ce0000
 f005374: f04f 5180    	.word	#0xf04f5180
 f005378: 6001         	strne	r1, [r0]
 f00537a: b13c         	cbz	r4, 0xf00538c <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x508> @ imm = #0xe
 f00537c: f3ef 8010    	.word	#0xf3ef8010
 f005380: b672         	cpsid i
 f005382: e7fe         	b	0xf005382 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x4fe> @ imm = #-0x4
 f005384: f7fb fe19    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x43ce
 f005388: 2c00         	cmp	r4, #0x0
 f00538a: d1f7         	bne	0xf00537c <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x4f8> @ imm = #-0x12
 f00538c: b055         	add	sp, #0x154
 f00538e: e8bd 0f00    	.word	#0xe8bd0f00
 f005392: bdf0         	pop	{r4, r5, r6, r7, pc}
 f005394: f3ef 8010    	.word	#0xf3ef8010
 f005398: b672         	cpsid i
 f00539a: e7fe         	b	0xf00539a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x516> @ imm = #-0x4
 f00539c: 9003         	str	r0, [sp, #0xc]
 f00539e: 4640         	mov	r0, r8
 f0053a0: f8cd e004    	.word	#0xf8cde004
 f0053a4: 468a         	mov	r10, r1
 f0053a6: f8cd c018    	.word	#0xf8cdc018
 f0053aa: f810 2b09    	.word	#0xf8102b09
 f0053ae: f7fb ffd3    	bl	0xf001358 <hopter::allocator::Allocator::alloc_impl::h0a38aeecbae24e9e> @ imm = #-0x405a
 f0053b2: b318         	cbz	r0, 0xf0053fc <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x578> @ imm = #0x46
 f0053b4: 9908         	ldr	r1, [sp, #0x20]
 f0053b6: 4605         	mov	r5, r0
 f0053b8: 44aa         	add	r10, r5
 f0053ba: 2000         	movs	r0, #0x0
 f0053bc: e9c5 0000    	.word	#0xe9c50000
 f0053c0: 60a8         	str	r0, [r5, #0x8]
 f0053c2: b1e1         	cbz	r1, 0xf0053fe <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x57a> @ imm = #0x38
 f0053c4: f1aa 0064    	.word	#0xf1aa0064
 f0053c8: 2164         	movs	r1, #0x64
 f0053ca: f7fe fd4f    	bl	0xf003e6c <__aeabi_memclr8> @ imm = #-0x1562
 f0053ce: 9803         	ldr	r0, [sp, #0xc]
 f0053d0: f241 626b    	.word	#0xf241626b
 f0053d4: f84a 0d68    	.word	#0xf84a0d68
 f0053d8: f6c0 7200    	.word	#0xf6c07200
 f0053dc: 9805         	ldr	r0, [sp, #0x14]
 f0053de: f04f 7380    	.word	#0xf04f7380
 f0053e2: 9908         	ldr	r1, [sp, #0x20]
 f0053e4: f042 0201    	.word	#0xf0420201
 f0053e8: f040 0001    	.word	#0xf0400001
 f0053ec: f8cd a008    	.word	#0xf8cda008
 f0053f0: f8ca 301c    	.word	#0xf8ca301c
 f0053f4: e9ca 2005    	.word	#0xe9ca2005
 f0053f8: 4650         	mov	r0, r10
 f0053fa: e002         	b	0xf005402 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x57e> @ imm = #0x4
 f0053fc: e7fe         	b	0xf0053fc <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x578> @ imm = #-0x4
 f0053fe: f8cd a008    	.word	#0xf8cda008
 f005402: f8dd e004    	.word	#0xf8dde004
 f005406: f105 007c    	.word	#0xf105007c
 f00540a: f8dd c018    	.word	#0xf8ddc018
 f00540e: f501 7a00    	.word	#0xf5017a00
 f005412: 9003         	str	r0, [sp, #0xc]
 f005414: ea4f 200e    	.word	#0xea4f200e
 f005418: b280         	uxth	r0, r0
 f00541a: 9008         	str	r0, [sp, #0x20]
 f00541c: e68b         	b	0xf005136 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x2b2> @ imm = #-0x2ea
 f00541e: f000 f8c8    	bl	0xf0055b2 <alloc::sync::Arc$LT$T$C$A$GT$::downgrade::panic_cold_display::hb8c702af966d343f> @ imm = #0x190
 f005422: defe         	trap
 f005424: defe         	trap
 f005426: defe         	trap
 f005428: 4606         	mov	r6, r0
 f00542a: 9806         	ldr	r0, [sp, #0x18]
 f00542c: 3001         	adds	r0, #0x1
 f00542e: d056         	beq	0xf0054de <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x65a> @ imm = #0xac
 f005430: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005434: e854 0f00    	.word	#0xe8540f00
 f005438: 1e41         	subs	r1, r0, #0x1
 f00543a: e844 1200    	.word	#0xe8441200
 f00543e: 2a00         	cmp	r2, #0x0
 f005440: d1f8         	bne	0xf005434 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x5b0> @ imm = #-0x10
 f005442: 2801         	cmp	r0, #0x1
 f005444: d044         	beq	0xf0054d0 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x64c> @ imm = #0x88
 f005446: e04a         	b	0xf0054de <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x65a> @ imm = #0x94
 f005448: 4606         	mov	r6, r0
 f00544a: b1e5         	cbz	r5, 0xf005486 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x602> @ imm = #0x38
 f00544c: f108 0009    	.word	#0xf1080009
 f005450: 4629         	mov	r1, r5
 f005452: f7fb fe46    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #-0x4374
 f005456: e016         	b	0xf005486 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x602> @ imm = #0x2c
 f005458: 4606         	mov	r6, r0
 f00545a: e051         	b	0xf005500 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x67c> @ imm = #0xa2
 f00545c: 9607         	str	r6, [sp, #0x1c]
 f00545e: 4606         	mov	r6, r0
 f005460: 9831         	ldr	r0, [sp, #0xc4]
 f005462: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005466: e850 1f00    	.word	#0xe8501f00
 f00546a: 1e4a         	subs	r2, r1, #0x1
 f00546c: e840 2300    	.word	#0xe8402300
 f005470: 2b00         	cmp	r3, #0x0
 f005472: d1f8         	bne	0xf005466 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x5e2> @ imm = #-0x10
 f005474: 2901         	cmp	r1, #0x1
 f005476: d104         	bne	0xf005482 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x5fe> @ imm = #0x8
 f005478: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00547c: a831         	add	r0, sp, #0xc4
 f00547e: f7fb fd9f    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x44c2
 f005482: 2000         	movs	r0, #0x0
 f005484: 9006         	str	r0, [sp, #0x18]
 f005486: f1b9 0f00    	.word	#0xf1b90f00
 f00548a: d010         	beq	0xf0054ae <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x62a> @ imm = #0x20
 f00548c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005490: e859 0f00    	.word	#0xe8590f00
 f005494: 1e41         	subs	r1, r0, #0x1
 f005496: e849 1200    	.word	#0xe8491200
 f00549a: 2a00         	cmp	r2, #0x0
 f00549c: d1f8         	bne	0xf005490 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x60c> @ imm = #-0x10
 f00549e: 2801         	cmp	r0, #0x1
 f0054a0: d105         	bne	0xf0054ae <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x62a> @ imm = #0xa
 f0054a2: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0054a6: 9907         	ldr	r1, [sp, #0x1c]
 f0054a8: 4648         	mov	r0, r9
 f0054aa: f7fb fe24    	bl	0xf0010f6 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::ha658a7f69128d260> @ imm = #-0x43b8
 f0054ae: 9806         	ldr	r0, [sp, #0x18]
 f0054b0: 3001         	adds	r0, #0x1
 f0054b2: 2802         	cmp	r0, #0x2
 f0054b4: d313         	blo	0xf0054de <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x65a> @ imm = #0x26
 f0054b6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0054ba: 9806         	ldr	r0, [sp, #0x18]
 f0054bc: 3004         	adds	r0, #0x4
 f0054be: e850 1f00    	.word	#0xe8501f00
 f0054c2: 1e4a         	subs	r2, r1, #0x1
 f0054c4: e840 2300    	.word	#0xe8402300
 f0054c8: 2b00         	cmp	r3, #0x0
 f0054ca: d1f8         	bne	0xf0054be <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x63a> @ imm = #-0x10
 f0054cc: 2901         	cmp	r1, #0x1
 f0054ce: d106         	bne	0xf0054de <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x65a> @ imm = #0xc
 f0054d0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0054d4: f108 0009    	.word	#0xf1080009
 f0054d8: 9906         	ldr	r1, [sp, #0x18]
 f0054da: f7fb fe02    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #-0x43fc
 f0054de: 982f         	ldr	r0, [sp, #0xbc]
 f0054e0: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0054e4: e850 1f00    	.word	#0xe8501f00
 f0054e8: 1e4a         	subs	r2, r1, #0x1
 f0054ea: e840 2300    	.word	#0xe8402300
 f0054ee: 2b00         	cmp	r3, #0x0
 f0054f0: d1f8         	bne	0xf0054e4 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x660> @ imm = #-0x10
 f0054f2: 2901         	cmp	r1, #0x1
 f0054f4: d104         	bne	0xf005500 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x67c> @ imm = #0x8
 f0054f6: f3bf 8f5f    	.word	#0xf3bf8f5f
 f0054fa: a82f         	add	r0, sp, #0xbc
 f0054fc: f7fb fd60    	bl	0xf000fc0 <alloc::sync::Arc$LT$T$C$A$GT$::drop_slow::h8bf5bb2925c29391> @ imm = #-0x4540
 f005500: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005504: e858 0f14    	.word	#0xe8580f14
 f005508: 3804         	subs	r0, #0x4
 f00550a: e848 0114    	.word	#0xe8480114
 f00550e: 2900         	cmp	r1, #0x0
 f005510: d1f8         	bne	0xf005504 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x680> @ imm = #-0x10
 f005512: e021         	b	0xf005558 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x6d4> @ imm = #0x42
 f005514: 9806         	ldr	r0, [sp, #0x18]
 f005516: 3001         	adds	r0, #0x1
 f005518: 2802         	cmp	r0, #0x2
 f00551a: d316         	blo	0xf00554a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x6c6> @ imm = #0x2c
 f00551c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005520: 9806         	ldr	r0, [sp, #0x18]
 f005522: 3004         	adds	r0, #0x4
 f005524: e850 1f00    	.word	#0xe8501f00
 f005528: 1e4a         	subs	r2, r1, #0x1
 f00552a: e840 2300    	.word	#0xe8402300
 f00552e: 2b00         	cmp	r3, #0x0
 f005530: d1f8         	bne	0xf005524 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x6a0> @ imm = #-0x10
 f005532: 2901         	cmp	r1, #0x1
 f005534: d109         	bne	0xf00554a <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x6c6> @ imm = #0x12
 f005536: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00553a: f108 0009    	.word	#0xf1080009
 f00553e: 9906         	ldr	r1, [sp, #0x18]
 f005540: f7fb fdcf    	bl	0xf0010e2 <hopter::allocator::Allocator::free_impl::h2af3b256fb100bc1> @ imm = #-0x4462
 f005544: f7fb f8fd    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x4e06
 f005548: defe         	trap
 f00554a: f7fb f8fa    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x4e0c
 f00554e: defe         	trap
 f005550: f7fb f8f7    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x4e12
 f005554: defe         	trap
 f005556: 4606         	mov	r6, r0
 f005558: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00555c: e858 0f0f    	.word	#0xe8580f0f
 f005560: 3801         	subs	r0, #0x1
 f005562: e848 010f    	.word	#0xe848010f
 f005566: 2900         	cmp	r1, #0x0
 f005568: d1f8         	bne	0xf00555c <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x6d8> @ imm = #-0x10
 f00556a: f3bf 8f5f    	.word	#0xf3bf8f5f
 f00556e: f898 0005    	.word	#0xf8980005
 f005572: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005576: b1a8         	cbz	r0, 0xf0055a4 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x720> @ imm = #0x2a
 f005578: f8d8 003c    	.word	#0xf8d8003c
 f00557c: f3bf 8f5f    	.word	#0xf3bf8f5f
 f005580: b980         	cbnz	r0, 0xf0055a4 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x720> @ imm = #0x20
 f005582: f3ef 8005    	.word	#0xf3ef8005
 f005586: b910         	cbnz	r0, 0xf00558e <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x70a> @ imm = #0x4
 f005588: f7fb fd17    	bl	0xf000fba <hopter::interrupt::svc::svc_yield_current_task::h5b1a6ca2d8dfcbb4> @ imm = #-0x45d2
 f00558c: e00a         	b	0xf0055a4 <hopter::unwind::unwind::try_concurrent_restart::h55eee72ec02d6818+0x720> @ imm = #0x14
 f00558e: f3ef 8005    	.word	#0xf3ef8005
 f005592: 280e         	cmp	r0, #0xe
 f005594: bf1f         	itttt	ne
 f005596: f64e 5004    	.word	#0xf64e5004
 f00559a: f2ce 0000    	.word	#0xf2ce0000
 f00559e: f04f 5180    	.word	#0xf04f5180
 f0055a2: 6001         	strne	r1, [r0]
 f0055a4: 4630         	mov	r0, r6
 f0055a6: f000 f815    	bl	0xf0055d4 <_Unwind_Resume> @ imm = #0x2a
 f0055aa: defe         	trap
 f0055ac: f7fb f8c9    	bl	0xf000742 <core::panicking::panic_in_cleanup::hc63a2cb2e57153b5> @ imm = #-0x4e6e
 f0055b0: defe         	trap

0f0055b2 <alloc::sync::Arc$LT$T$C$A$GT$::downgrade::panic_cold_display::hb8c702af966d343f>:
 f0055b2: f04f 5c00    	.word	#0xf04f5c00
 f0055b6: f8dc c000    	.word	#0xf8dcc000
 f0055ba: ebbd 0c0c    	.word	#0xebbd0c0c
 f0055be: f1bc 0f08    	.word	#0xf1bc0f08
 f0055c2: da02         	bge	0xf0055ca <alloc::sync::Arc$LT$T$C$A$GT$::downgrade::panic_cold_display::hb8c702af966d343f+0x18> @ imm = #0x4
 f0055c4: dfff         	svc	#0xff
 f0055c6: 0002         	movs	r2, r0
 f0055c8: 0000         	movs	r0, r0
 f0055ca: b580         	push	{r7, lr}
 f0055cc: 466f         	mov	r7, sp
 f0055ce: f7fb f82b    	bl	0xf000628 <core::panicking::panic_fmt::ha5901c099395c21f> @ imm = #-0x4faa
 f0055d2: defe         	trap

0f0055d4 <_Unwind_Resume>:
 f0055d4: f3ef 8305    	.word	#0xf3ef8305
 f0055d8: b913         	cbnz	r3, 0xf0055e0 <_Unwind_Resume+0xc> @ imm = #0x4
 f0055da: dffd         	svc	#0xfd

0f0055dc <$d.86>:
 f0055dc: 00 02 00 00  	.word	0x00000200

0f0055e0 <$t.87>:
 f0055e0: b084         	sub	sp, #0x10
 f0055e2: 4669         	mov	r1, sp
 f0055e4: f7fe fff6    	bl	0xf0045d4 <hopter::unwind::unwind::resume_unwind::h3fe01b5dea8dea21> @ imm = #-0x1014
 f0055e8: bc0f         	pop	{r0, r1, r2, r3}
 f0055ea: f102 0204    	.word	#0xf1020204
 f0055ee: e892 0ff0    	.word	#0xe8920ff0
 f0055f2: ec93 8b10    	.word	#0xec938b10
 f0055f6: f3ef 8305    	.word	#0xf3ef8305
 f0055fa: b903         	cbnz	r3, 0xf0055fe <_Unwind_Resume+0x2a> @ imm = #0x0
 f0055fc: dffe         	svc	#0xfe
 f0055fe: f8d2 d020    	.word	#0xf8d2d020
 f005602: 4708         	bx	r1
 f005604: defe         	trap

0f005606 <rust_begin_unwind>:
 f005606: f04f 5c00    	.word	#0xf04f5c00
 f00560a: f8dc c000    	.word	#0xf8dcc000
 f00560e: ebbd 0c0c    	.word	#0xebbd0c0c
 f005612: f1bc 0f08    	.word	#0xf1bc0f08
 f005616: da02         	bge	0xf00561e <rust_begin_unwind+0x18> @ imm = #0x4
 f005618: dfff         	svc	#0xff
 f00561a: 0002         	movs	r2, r0
 f00561c: 0000         	movs	r0, r0
 f00561e: b580         	push	{r7, lr}
 f005620: 466f         	mov	r7, sp
 f005622: f7fe fdfb    	bl	0xf00421c <hopter::unwind::unwind::start_unwind_entry::hab72bc47e885ba0f> @ imm = #-0x140a
 f005626: e7fe         	b	0xf005626 <rust_begin_unwind+0x20> @ imm = #-0x4

0f005628 <rust_eh_personality>:
 f005628: e7fe         	b	0xf005628 <rust_eh_personality> @ imm = #-0x4
 f00562a: d4d4         	bmi	0xf0055d6 <_Unwind_Resume+0x2> @ imm = #-0x58
 f00562c: d4d4         	bmi	0xf0055d8 <_Unwind_Resume+0x4> @ imm = #-0x58
 f00562e: d4d4         	bmi	0xf0055da <_Unwind_Resume+0x6> @ imm = #-0x58
