SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	var  db 70
	
section .bss
	c1 resb 1
	c2 resb 1
	
section .text
	global _start
	
	_start:
	
	mov al,[var]  ; al = 01000110
	not al        ; al = 10111001(C1)
	inc byte[al]  ; al = 10111010(C2)
	mov ebx,eax
	mov eax,SYS_EXIT
	int 0x80
