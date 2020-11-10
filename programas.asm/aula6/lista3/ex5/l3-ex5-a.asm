SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	a   db 2
	b   db 3
	i   db 0
	res db 0
	
section .text 
	global _start
	_start:
	
	mov al,[a]
	mov bl,[b]
	cmp al,bl
	jl  for
	jge mult
	
	for:
	mov al,[a]
	cmp al,[i]
	jbe exit
	
	mov al,[res]
	add al,[i]
	mov [res],al
	
	inc byte[i]
	jmp for
	
	mult:
	mov  al,[a]
	mov  bl,[b]
	imul bl
	mov [res],ax
	
	exit:
	mov ebx,[res]
	mov eax,SYS_EXIT
	int 0x80
	
	
