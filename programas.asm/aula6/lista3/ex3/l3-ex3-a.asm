section .data
	base     db  2
	expoente db  7
	i        db  0
	n        equ base
	
section .bss
	sum   resb 1
	valor resb 1
	
section .text
	global _start
	_start:
	
	mov al,[base]
	mov bl,[expoente] ;controla quantas vezes a soma ocorrera
	mov dl,[n] ;controlar quantidade de somas
	mov [valor],byte 0

	loop2:
	cmp [expoente],byte 1
	je  exit
	
	loop1: ;calcular
	inc byte[i]
	
	cmp dl,[i]
	jl continue
	
	add [valor],al
	jmp loop1
	
	continue:
	mov al,[valor]
	mov [valor],byte 0
	dec byte[expoente]
	mov [i],byte 0
	jmp loop2
	
	
	exit:
	mov ebx,eax
	mov eax,1
	int 0x80 
	
