;----------------------------------------------------------------------
;Lucas Eiki Okada
;----------------------------------------------------------------------

		section .data
	message db 'ASSEMBLY'	;stringo to print
	
		section .text
	global _start
	_start:
		mov edx,1	;message lenght
		mov ebx,1	;write in the screen. stdout
		mov ecx,message	;message to write. pointer to the first position of the string, that is the 'A'
		mov eax,4	;system call to write
		int 0x80	;kernel
		
		mov edx,1	;message lenght
		mov ebx,1	;write in the screen. stdout
		mov ecx,message	;message to write. pointer to the first position of the string, that is the 'A'
		add ecx,1	;add the pointer. now the pointer is in the second position of the string, that is the 'S'
		mov eax,4	;system call to write
		int 0x80
		
		mov eax,1	;system call exit
		int 0x80
