section .data
	dividendo dw 29
	divisor   db 4
	
section .text
	global _start
	_start:
	
	mov ax,[dividendo]
	mov bl,[divisor]
	div bl
	
	mov bl,al ;quociente
	;mov bl,ah ;resto
	
	mov eax,1
	int 0x80
