SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	var1 db 'A' ;01000001 = 65D
	var2 db 'B' ;01000010 = 66D
	var3 db 'C' ;01000011 = 67D
	var4 db 'D' ;01000100 = 68D -> 10111011(C1) -> 10111100(C2) = 188
	var5 db 'E' ;01000110 = 69D
	var6 db 'F' ;01000110 = 70D
	var7 db 'G' ;01000111 = 71D
	var8 db 'H' ;01001000 = 72D -> 10110111(C1) -> 10111000 = 184
	
section .bss
	result1 resb 2
	result2 resb 2
	result3 resb 2   

section .text
	global _start
	
	_start:
	;X = A + (B * C) – (D * F) + G – H
	
	;	B*C
	mov al,[var2]
	mov bl,[var3]
	mul bl
	mov [result1],ax
	;mov ebx,eax
	;mov eax,1
	int 0x80
	
	;	D*F
	mov al,[var4]
	mov bl,[var6]
	mul bl
	mov [result2],ax
	;mov ebx,eax
	;mov eax,1
	int 0x80
	
	;	G-H
	mov ax,[var7]
	sub ax,[var8]
	mov [result3],ax
	int 0x80
	
	;	a+(B*C) -> ax
	mov ax,[var1]
	add ax,[result1]
	; 	ax - (D*F) -> ax
	sub ax,[result2]
	;	ax + G - H -> ax
	add ax,[result3]
	mov bx,ax
	mov eax,1
	int 0x80
	
	
	
	
	
	
	
	
	
