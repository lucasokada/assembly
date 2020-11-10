SYS_EXIT  equ 1 
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

		;expressao 9 - (-9) + 5 + (-10)
section .data 
	var1 db 9     ;00001001B
	var2 db 0xF7  ;11110110B(C1) = 11110111(C2) = -9/247	
	var3 db 5     ;00000101B	
	var4 db 0xF6  ;00001010 = 10; 11110101(C1) =11110110(C2) = 0xF6 = -10
	
section .text
	global _start
	
	_start:
	mov eax,[var1]
	sub eax,[var2]
	add eax,[var3]
	add eax,[var4]
	mov ebx,eax
	mov eax,SYS_EXIT
	int 0x80
	

