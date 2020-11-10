SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	var1 db 5
	var2 db 8
	
section .text
	global _start
	
	_start:
	
	mov eax,[var1] ;the eax register will always be used in mut operations!!
	mov ebx,[var2]
	mul ebx	      ; bx . ax
	mov ebx,eax 
	mov eax,SYS_EXIT
	int 0x80
	
