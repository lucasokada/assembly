SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data

	var1 db 'A'
	var2 db 'B'
	var3 db 'C'
	var4 db 'D'
	var5 db 'G'
	var6 db 'H'
	
section .bss
	
	aux1 resb 1
	aux2 resb 2
	aux3 resb 1
	aux4 resb 2

section .text
	global _start
	
	_start:
	
	;----------------------------- X = H ­- [B *(­-D)] + [(-­C) * G] + A

	;	(-D)
	xor al,al      ;al = 00000000
	sub al,[var4]  ;al = -D
	mov [aux1],al  ;aux1 = -D
	int 0x80


	;	B*(-D)
	mov al,[var2]  ;al = B
	mov bl,[aux1]  ;bl = -D
	mul bl
	mov [aux2],ax ; = **aux2 = B*(-D) 
	;mov ebx,eax
	;mov eax,SYS_EXIT
	int 0x80
	
	;	(-C)
	xor al,al  ;al = 00000000
	sub al,[var3]
	mov [aux3],al
	int 0x80
	
	;	G*(-C)
	mov al,[var5]
	mov bl,[aux3]
	mul bl
	mov [aux4],ax ; **aux4 = G*(-C) 
	;mov ebx,eax
	;mov eax,SYS_EXIT
	int 0x80
	
	;calc
	mov ax,[var6]
	sub ax,[aux2] ;  ax = H ­- [B *(­-D)]
	add ax,[aux4] ;  ax = H ­- [B *(­-D)] + [(-­C) * G]
	add ax,[var1] ;  ax = H ­- [B *(­-D)] + [(-­C) * G] + A
	mov ebx,eax
	mov eax,SYS_EXIT
	int 0x80
	
	
	
	
	
	
