;------------------------------------------------------------------------
;Lucas Eiki Okada
;------------------------------------------------------------------------

		section .data
	char1 db 'A', 10	;define byte for char1 with A value. 10 :new line code
	char2 db 10,'B',10,10 	;define byte for char2. 10 = new line

		section .text
	global _start
	_start:		;tell linker entry point
		mov edx,2	;message lenght
		mov ebx,1	;stdout
		mov ecx,char1	;message to write
		mov eax,4	;system call to write
		int 0x80	;call kernel
		
		mov edx,4	;message lenght
		mov ebx,1	;stdout
		mov ecx,char2	;message to write
		mov eax,4	;system call to write
		int 0x80	
		
		mov eax,1	;system call exit
		int 0x80	
		
	;prit:
	;A
	;
	;B
	
