section .data
	var1 db 3
	
	%macro dobro 1
		add %1,%1
	%endmacro
	
	%macro quadrado 1
		mov eax,%1
		mov ebx,%1
		mul ebx
		mov %1,eax
	%endmacro
	
section .text
	global _start
	_start:
	
	mov edx,[var1]
	dobro edx
	quadrado edx
	mov ebx,edx
	
	mov eax,1
	int 0x80
		
