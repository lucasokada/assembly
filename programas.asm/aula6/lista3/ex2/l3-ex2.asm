SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDIN     equ 1
STDOUT    equ 0
RETURN    equ 0

section .bss
	fatorial resb 1
	sum      resb 1
	result   resb 1
	
section .data
	num db 5
	i   db 0

section .text
	global _start
	_start:
	
	;---------------calc fatorial
	mov al,[num]
	mov bl,[num]
	
	while:
	dec bl
	mul bl
	cmp bl,1
	je  fat
	jne while
	
	fat:
	mov [fatorial],ax
	
	;-------------calc soma
	
	mov al,0
	mov [sum],al
	
	for:
	mov al,[num]
	cmp al,[i]
	jbe calc_result
	
	sub al,[i]
	add [sum],al
	
	inc byte[i]
	jmp for
	
	;------------calc result
	
	calc_result:
	mov al,[fatorial]
	mov bl,[sum]
	sub al,bl
	mov [result],al
	
	mov ebx,[result]
	mov eax,1
	int 0x80
