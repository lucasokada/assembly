	SYS_EXIT  equ 1
	RET_EXIT  equ 5 ;retur code
	SYS_READ  equ 3
	SYS_WRITE equ 4
	STD_IN    equ 0
	STD_OUT   equ 1
	MAX_IN    equ 10 ;you can entry words with max of 10 elements

section .data
	msg db "enter your name: ", 0xA, 0xD
	len equ $-  msg
		
section .bss ;blocked start by symbol.  Information initialization that will be used
	name resb 2
		
section .text
  global _start
  _start:

	; ax: acumulator for numeric operations
	; bx: acumutator for base register
	; cx: count register. used for strings
	; dx: data register

	mov eax, SYS_WRITE 
	mov ebx, STD_OUT
	mov ecx, msg
	mov edx, len
	int 0x80

	;entrada dados
	mov eax, SYS_READ
	mov ebx, STD_IN
	mov ecx, name
	mov edx, MAX_IN
	int 0x80
	
exit:
	mov eax, SYS_EXIT
	mov ebx, RET_EXIT  ;xor ebx, ebx
	int 0x80
	
	
	
	
