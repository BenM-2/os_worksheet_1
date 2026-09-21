
add.out: add.o driver.o asm_io.o
	gcc -m32 driver.o add.o asm_io.o -o add.out
add.o:
	nasm -f elf add.asm -o add.o
driver.o:
	gcc -m32 -c driver.c -o driver.o
asm_io.o:
	nasm -f elf asm_io.asm -o asm_io.o
	

