SYS_EXIT  equ 1
SYS_WRITE equ 4
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	numbers db 110,110,21
	lenght  db 2
	i       db 0

section .bss
	menor resb 1

section .text
	global _start
	_start:
	
	mov ecx,numbers
	mov al,[ecx]
	mov [menor],al
	mov dl,[lenght]
	
	for:
	cmp dl,[i]
	jbe exit	;2 <= i
			
	inc ecx
	mov bl,[ecx]
	cmp [menor],bl
	
	jg  maior
	jle menor_igual
	 
	maior: 
	mov [menor],bl
	
	menor_igual:
	inc byte [i]
	jmp for
	
	
	exit:
	mov ebx,[menor]
	mov eax,SYS_EXIT
	int 0x80
