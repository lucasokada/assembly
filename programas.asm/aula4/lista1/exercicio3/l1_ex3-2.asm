SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	var db 70
	
section .text
	global _start
	_start:
	
	mov  al,[var]
	xor  bl,bl
	sub  bl,1
	imul bl
	mov ebx,eax
	mov eax,SYS_EXIT
	int 0x80
	

