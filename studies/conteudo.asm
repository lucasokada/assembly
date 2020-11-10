	SYS_EXIT  equ 1
	RET_EXIT  equ 5 ;retur code
	SYS_READ  equ 3
	SYS_WRITE equ 4
	STD_IN    equ 0
	STD_OUT   equ 1
	
		
		Section .data
		
	nome db 'lucas okada', 0xA
	len  db  $- nome
	
		section .bss
	aux  resb 2
		
		Section .text
		
	global _start
		
	_start:
		
		mov ebx,SYS_EXIT
		mov eax,SYS_WRITE
		mov edx,len
		mov ecx,nome
		int 0x80
		
		mov ebx,[nome]
		mov [aux],ebx
		mov ebx,SYS_EXIT
		mov eax,SYS_WRITE
		mov edx,1
		mov ecx,aux
		int 0x80
		
		mov eax,1
		int 0x80
