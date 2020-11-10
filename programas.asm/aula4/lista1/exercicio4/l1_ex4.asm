SYS_EXIT  equ 1
SYS_WRITE equ 4 
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 1

section .data
	var db 5
	
section .bss 
	aux1     resb 1
	aux2     resb 1
	
section .text
	global _start
	_start:
	
	;calc fatorial
	mov al,[var]      ;al = 5
	mov [aux1],al
	dec byte[aux1]    ;aux1 = 4
	mov bl,[aux1]
	mul bl
	
	mov bx,ax         ;bx = 20
	dec byte[aux1]    ;aux1 = 3
	mov bl,[aux1] 
	mul bl
	
	mov ebx,eax
	dec byte[aux1]
	mov bl,[aux1]
	mul bl
	mov ebx,eax       ;ebx = 120
	mov [aux1],ebx    ; aux1 = 120
	int 0x80
;--------------------------------------------------------------	
	;calc sum
	mov al,[var]    ;al = 5
	mov [aux2],al
	dec byte[aux2]  ;aux2 = 4
	add al,[aux2]   ;al = 5 + 4
	
	dec byte[aux2]  ;aux2 = 3
	add al,[aux2]   ;al = 5 + 4 + 3
	
	dec byte[aux2]  ;aux2 = 2
	add al,[aux2]   ;al = 5 + 4 + 3 + 2
	
	dec byte[aux2]  ;aux2 = 1
	add al,[aux2]   ;al = 5 + 4 + 3 + 2 + 1
	mov ebx,eax
	mov [aux2],ebx  ;aux2 = 15
	int 0x80
;--------------------------------------------------------------
	
	;calc result
	
	mov al,[aux1]
	mov bl,[aux2]
	sub al,bl
	mov ebx,eax
	mov eax,SYS_EXIT
	int 0x80
