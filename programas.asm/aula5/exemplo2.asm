

section .data
	var1  db 13
	var2  db 5
	msge  db 'iguais    ',0xA
	msgne db 'diferentes',0xA
	
section .text
	global _start
	
	_start:
	mov eax,[var1]
	mov ebx,[var2]
	cmp eax,ebx
	je equal
	
diff:	mov ecx,msgne
	jmp print
	
equal:	mov ecx,msge

print:	mov ebx,1
	mov eax,4
	mov edx,11
	int 0x80
	
	mov ebx,0
	mov eax,1
	int 0x80

