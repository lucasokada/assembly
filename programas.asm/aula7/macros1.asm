section .data
	var1 db 4
	
section .text

%macro dobro 0
	add eax,eax
%endmacro

%macro quadrado 0
	mov ebx,eax
	mul ebx
%endmacro

global _start	
	_start:
	
	mov eax,[var1]
	dobro
	quadrado
	mov ebx,eax
	mov eax,1
	int 0x80
	
