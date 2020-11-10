section .data
	ascii_zero  equ 48
	number      equ  435
	char        db  '0'
	
section .data 
	global _start
	_start:
	
	mov edi, number
	
	loop1:
	mov eax,edi
	mov bx,10
	div bx
	mov di,ax
	add dx,ascii_zero
	mov [char],dx
	mov eax,4
	mov ebx,1
	mov ecx,char
	mov edx,1
	int 0x80
	
	loop2:
	xor edx,edx
	mov eax,edi
	cmp eax,edx
	jg  loop1
	
	mov eax,1
	int 0x80
