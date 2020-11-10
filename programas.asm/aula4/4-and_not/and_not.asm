SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	var1 db 0xFF ;255D; 11111111B
	var2 db 0x15 ; 21D; 00010101B 
	
section .text
	global _start
	
	_start:
	;mov eax,var1 ;11111111B
	;and eax,var2 ;00010101B = 00010101 = var2
	;not eax      ;11101010B = C1
	;inc eax      ;11101011B = C2 
	;int 0x80
	
	xor eax,eax ; mov eax,0
	sub eax,[var2]
	mov ebx,eax
	int 0x80
	
	mov ebx,eax
	mov eax,SYS_EXIT
	int 0x80
	
