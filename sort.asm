;**********************************************************
;			selection sort			    *
;**********************************************************
SYS_EXIT   equ 1
SYS_WRITE  equ 4
SYS_READ   equ 3
STDOUT     equ 1
STDIN      equ 0

section .data
	array  db 4, 0, 6, 4, 2, 1, 10, 13, 55, 22, 19
	len    equ $- array
	aux    db 0 
	
section .text
	global _start
	_start:
	
	mov ecx,array
	mov ah,len
	dec ah
	
;-----------------------sort-----------------------;
	loop_condition2:
	cmp byte[aux],len
	jge exit
	mov al,[aux]
	mov edx,ecx
	inc edx
	
	loop_condition1:
	cmp al,ah
	jge loop_body2
	
	loop_body1:
	mov bl,[ecx]
	mov bh,[edx]
	cmp bl,bh
	jg  change
	
	loop_continue1:
	inc edx
	inc al
	jmp loop_condition1
	
	loop_body2:
	inc ecx
	inc byte[aux]
	jmp loop_condition2
;--------------------------------------------------;

	change:
	mov [ecx],bh
	mov [edx],bl
	jmp loop_continue1

	
	exit:
	mov edx,5
	mov ch,[array + edx]
	mov ebx,ecx
	mov eax,1
	int 0x80
	
	
