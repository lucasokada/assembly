SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	msge  db 'iguais    ',0xA
	msgne db 'diferentes',0xA
	
section .text
	global _start
	
	_start:
	mov eax,6
	mov ebx,5
	cmp eax,ebx
	je lequ
	
ldiff:	mov ecx,msgne
	jmp wmsg
	
lequ:	mov ecx,msge

wmsg:	mov edx,11
	mov ebx,STDOUT
	mov eax,SYS_WRITE
	int 0x80
	
	mov ebx,RETURN
	mov eax,SYS_EXIT
	int 0x80
