SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	base     db 3
	exp      db 5
	potencia db 1
	

section .text
	global _start
	_start:
	
	;calc_pot
	
	mov bl,[base]
	mov dl,[exp]
	mov al,[potencia]
	
	while:
	cmp dl,0
	je exit
	mul bl
	dec dl
	mov [potencia],ax
	jmp while
	
	exit:
	mov ebx,[potencia]
	mov eax,SYS_EXIT	
	int 0x80	
	
