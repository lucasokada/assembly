SYS_EXIT   equ 1
SYS_WRITE  equ 4
SYS_READ   equ 3
STDOUT     equ 1
STDIN      equ 0

section .data
	array  db 4, 0, 11, 4, 2, 1, 10, 13, 55, 22, 19
	len    equ $- array
	aux    db 0
	
%macro selection_sort 0

	mov ecx,array
	mov ah,len
	dec ah

	loop_condition2:
	cmp byte[aux],len
	jge exit_macro
	mov al,[aux]
	mov edx,ecx
	inc edx
	
	loop_condition1:
	cmp al,ah
	jge loop_body2
	
	loop_body1:
	mov bl,[ecx]
	mov bh,[edx]
	cmp bl,bh
	jg  change
	
	loop_continue1:
	inc edx
	inc al
	jmp loop_condition1
	
	loop_body2:
	inc ecx
	inc byte[aux]
	jmp loop_condition2
;--------------------------------------------------;

	change:
	mov [ecx],bh
	mov [edx],bl
	jmp loop_continue1
	
	exit_macro:
		
%endmacro
	
section .text
	global _start
	_start:
	
	selection_sort
	
	mov ax,len
	mov bl,2
	div bl
	
	mov edx,0
	mov dl,al ;quociente
	
	;já que o tamanho do array é um número ímpar, todo número impar dividido por dois tem um quocient = x e um resto = 1.
	;nesse caso, a posiçao média do array sera o conteudo do elemento no indice x, ja que 0 conta como uma posicao
	;obs: array deve estar ordenado
	
	mov ebx,0
	mov ebx,[array + edx]
	
	exit:
	mov eax,1
	int 0x80
	

