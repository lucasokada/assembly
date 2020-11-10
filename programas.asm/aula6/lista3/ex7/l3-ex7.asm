
;O programa está invertendo. Contudo, está printando um espaço a mais no penultimo espaço.

SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	msg         db ' Isto é uma frase de teste '
	len         equ $-  msg
	count       db 0
	
section .bss
	msgi    resb len
	last_p  resb 1
	
section .text 
	global _start
	_start:
	
	;posicionaFinal
	mov edx,msgi
	mov ecx,msg
	mov ebx,msg;first position
	
	add ecx,len
	mov [last_p],ecx
	sub [last_p],byte 2
	
	;-------------------------------------------
	end_string:
	mov ecx,[last_p]
	mov [edx],byte 32
	inc edx
	jmp whileNotSpace
	
	inc_space:
	cmp [count],byte 0
	je  inc_edx
	jne continue
	
	inc_edx:
	inc edx
	mov [count],byte 1
	
	continue:
	mov [edx],byte 32
	mov [count],byte 0
	
	
	last_space:
	mov ecx,[last_p]		
	;-----------------------------whileNotSpace
	whileNotSpace:
	cmp ecx,ebx        ;1 letra
	je  final_cicle	
		
	cmp [ecx],byte 32 ;space
	je  found_space 
	
	dec ecx
	jmp whileNotSpace
	;===========================================
	
	found_space:
	mov [last_p],ecx
	dec byte[last_p]
	
	;----------------------------------whileAdd
	whileAdd:
	inc ecx
	
	cmp [ecx],byte 32;space
	;je  last_space
	je inc_space
	
	mov eax,[ecx]	
	mov [edx],eax
	
	inc edx
	jmp whileAdd
	;============================================
	
	final_cicle:
	mov eax,[ecx]
	mov [edx],eax
	inc ecx
	
	cmp [ecx],byte 32;space
	je  print
	
	inc edx
	jmp final_cicle
	
	
	end:
	mov ebx,RETURN
	mov eax,SYS_EXIT
	int 0x80
