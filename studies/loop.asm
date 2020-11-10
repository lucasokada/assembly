section .data
	param db 6
	
section .text 
global _start
_start:
	mov al,[param]
	mov bl,0
	
cont:
	add bl,al
	sub al,1
	jnz cont	;jump if not zero
	
	mov eax,1
	int 0x80

