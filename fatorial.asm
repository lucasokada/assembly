SYS_EXIT   equ 1
SYS_WRITE  equ 4
SYS_READ   equ 3
STDOUT     equ 1
STDIN      equ 0

section .bss
	fatorial resd 1
	resto    resd 1
	result   resb 1

section .data
	tam db 6
	
section .text
	global _start
	_start:
	
	mov bl,[tam]
	mov ax,1	
	
	loop_condition:
	cmp bl,1
	jle loop_exit
	
	loop_body:
	mul bl
	dec bl
	jmp loop_condition
	
	loop_exit:
	
	mov ebx,eax
	mov eax,1
	int 0x80
	
