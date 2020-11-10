;--------------------------------------------------------------------------
;Lucas Eiki Okada
;------------------------------------------------------------------------

		section .data
	name db 'A'	;define byte
	
		section .text
	global _start
	_start:
		
		mov eax,4		;
		add eax,48		;eax += 4. 48 = 0x30 or 30H hexadecimal	

		mov [name],eax 	;name content = eax
		
		mov edx,1		;name lenght. now the content of name is 4
		mov ebx,1		;stdout. 
		mov ecx,name		;ecx point to name
		mov eax,4		;system call to write
		int 0x80		;call kernel
		
		mov ebx,0
		mov eax,1
		int 0x80
		
