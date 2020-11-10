SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	l1   db 4
	l2   db 4
	l3   db 4
	
	msg1 db 'equilatero',0xA
	msg2 db 'isoceles  ',0xA
	msg3 db 'escaleno  ',0xA
	msg4 db 'triangulo existe    ',0xA
	msg5 db 'triangulo nao existe',0xA
	
section .bss
	var_existe resb 1
	
section .text
	global _start
	
	_start:

	mov al,[l1]
	mov bl,[l2]
	mov dl,[l3]
	
condicao_existencia:
	add bl,dl	;bl = l2 + l3
	cmp al,bl	;cmp l1, (l2+l3)
	ja  nao_existe	;l1 > l2 + l3
	jbe existe
	
existe:
	mov ecx,msg4	
	mov [var_existe],byte 1 ;existe = 1
	jmp print_existe
	
nao_existe:
	mov ecx,msg5
	mov [var_existe],byte 0 ;existe = 0
	jmp print_existe
	
print_existe:
	mov ebx,STDOUT
	mov eax,SYS_WRITE
	mov edx,21
	int 0x80
	
	cmp [var_existe],byte 1
	je  tipo_triangulo	;se existir
	jne end		;se nao existir
	
tipo_triangulo:
	mov al,[l1]
	mov bl,[l2]
	mov dl,[l3]
	
	cmp al,bl 		;cmp l1,l2
	je  verifica_eq	;l1 == l2
	jne verifica_isoceles 	;l1 != l2
	
verifica_eq:
	cmp al,dl	;cmp l1,l3
	je  equilatero	;l1 = l2 = l3
	jne isoceles	;l1 = l2 $$ l1 != l3
	
verifica_isoceles:
	cmp al,dl		;cmp l1,l3
	jne verifica_esc	;l1 != l3 && l1 != l2
	je  isoceles		;l1 != l2 && l1 == l3
	
verifica_esc:
	cmp bl,dl		;cmp l2,l3
	je  isoceles		;l2 == l3 $$ l2 != l1
	jne escaleno		;l1 != l2 != l3
	
equilatero:
	mov ecx,msg1
	jmp print_triangulo
	
isoceles:
	mov ecx,msg2
	jmp print_triangulo

escaleno:
	mov ecx,msg3
	jmp print_triangulo
	
	
print_triangulo:
	mov ebx,STDOUT
	mov eax,SYS_WRITE
	mov edx,11
	int 0x80
	
	
end:
	mov ebx,RETURN
	mov eax,SYS_EXIT
	int 0x80
