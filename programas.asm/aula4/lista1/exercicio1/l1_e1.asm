SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	array db 1,1,1,1 
	
section .text
	global _start
	
	_start:
	
	mov ecx,array
	;mov ebx,[ecx]
	;mov eax,SYS_EXIT
	int 0x80
	
	inc ecx
	mov [ecx],byte 2
	;mov ebx,[ecx]
	;mov eax,SYS_EXIT
	int 0x80
	
	inc ecx
	mov [ecx],byte 4
	;mov ebx,[ecx]
	;mov eax,SYS_EXIT
	int 0x80
	
	inc ecx
	mov [ecx],byte 8
	;mov ebx,[ecx]
	;mov eax,SYS_EXIT
	int 0x80
	
	mov ecx,array ;arr[0]
	mov ebx,[ecx]
	inc ecx       ;arr[1]
	add ebx,[ecx]
	inc ecx       ;arr[2]
	add ebx,[ecx]
	inc ecx       ;arr[3]   	
	add ebx,[ecx]
	mov eax,SYS_EXIT
	int 0x80
	

	
	
