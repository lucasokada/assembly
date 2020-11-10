section .data
	array   db 'a','b','c'
	tamanho db 3
	index   db 0
	
section .text
	global _start
	_start:
	
	mov ecx,array
	
	for:
	
	mov al,[tamanho]
	cmp al,byte [index]
	jbe exit
	
	print:
	mov ebx,1
	mov eax,4
	mov edx,1
	int 0x80
	
	inc ecx
	inc byte [index]
	jmp for
	
	
	exit:
	mov ebx,0
	mov eax,1
	int 0x80
	
