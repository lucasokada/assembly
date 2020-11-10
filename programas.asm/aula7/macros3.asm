section .data
	base db 3
	exp  db 3
	
%macro pot 2
	mov al,1
	mov bl,%1
	mov cl,%2

	ini:
	cmp cl,1
	jl res
	dec cl
	mul bl 
	jmp ini
	
	res:
	mov %1,al
%endmacro

section .text
	global _start
	_start:
	
	pot [base],[exp]
	mov bl,[base]
	mov eax,1
	int 0x80
