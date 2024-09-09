/* This is the memory layout for the example code running with QEMU
   emulating the netduinoplus2 board (Cortex-M4F). */

MEMORY
{
  RAM (xrw) : ORIGIN = 0x20000000, LENGTH = 128K
  CCMRAM (xrw) : ORIGIN = 0x10000000, LENGTH = 64K
  FLASH (rx) : ORIGIN = 0x8000000, LENGTH = 1024K
  /* NOTE 1 K = 1 KiBi = 1024 bytes */
}

/* Length of the contiguous stack placed at the beginning of the RAM region.
   The value must match the one in Hopter configuration parameters. */
_contiguous_stack_length = 0x1000;
