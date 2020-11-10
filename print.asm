SECTION .data
	NUMBER dd 362880
	char DD '00000000000000000'
	break DB 10

SECTION .text
	global _start
	_start:

	mov eax,[NUMBER]
	;xor edx,edx
	mov ebx,10
	mov ecx,break
	mov esi,1
	repeat_body:
	;xor edx,edx
	div ebx
	add edx,48
	inc esi
	dec ecx
	mov [ecx],dl
	repeat_cond:
	xor edx,edx
	cmp eax,edx
	jg repeat_body

	;***** Display *****************
	mov eax,4
	mov ebx,1
	mov edx,esi
	int 0x80

	mov eax,1
	mov ebx,0
	int 0x80
