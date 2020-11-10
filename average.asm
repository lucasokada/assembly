SYS_EXIT   equ 1
SYS_WRITE  equ 4
SYS_READ   equ 3
STDOUT     equ 1
STDIN      equ 0

section .bss
	average		resb 1

section .data
	array		db  49,50,94,40,67,44,38,90,84,53,68,15,43,88,50,34,63,87,38,92
	len		equ $- array

section .text
	global _start
	_start:
	
	mov ecx,array
	xor dh,dh
	mov ax,0
	mov bl,0
	
	loop_condition:
	cmp bl,len
	jge loop_exit
	
	loop_body:
	mov dl,[ecx + ebx]
	add ax,dx
	inc bl
	jmp loop_condition
	
	loop_exit:
	
	mov bl,len
	div bl
	mov [average], al

	mov ebx,[average]
	mov eax,1
	int 0x80
	
	
