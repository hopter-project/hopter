../opt/llvm/bin/llvm-objdump --disassemble --demangle target/thumbv7em-none-eabihf/debug/deps/hopter-765de21662b592af.o > hopter.s 

../opt/llvm/bin/ld.lld --verbose link.ld.in target/thumbv7em-none-eabihf/release/examples/mailbox_uart-f0e9177fdc1cd6f6.o  target/thumbv7e
m-none-eabihf/release/libhopter.rlib 

../opt/llvm/bin/ld.lld --verbose new_link.ld target/thumbv7em-none-eabihf/release/examples/hello_world-734508d427c6609f.o