SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	array  db 'J','I','H','G','F','E','D','C','B','A'
	lenght db 10
	i      db 0
	iaux   db 0
	
section .bss
	auxarr    resb 10
	
section .text
	global _start
	_start:
		
	mov bl,al
	dec bl
	mov ecx,array
		
	loop1:
	mov al,[lenght]
	inc byte[i]	
	cmp [i],al
	jae print
	
	loop2:
	cmp [iaux],bl
	jae loop1
	
	add ecx,[iaux]
	mov edx,[ecx]
	
	inc ecx    	 
	cmp edx,[ecx] 
	ja  troca
	inc byte[iaux]	
	jmp loop2
	
	troca:
	mov eax,[ecx]	;eax = a[j+1]
	mov[ecx],edx	
	dec ecx
	mov [ecx],eax
	inc byte[iaux]	
	jmp loop2

	print:
	mov ebx,1
	mov eax,4
	mov edx,10
	mov ecx,array
	int 0x80

	exit:
	mov ebx,[ecx]
	mov eax,1
	int 0x80
