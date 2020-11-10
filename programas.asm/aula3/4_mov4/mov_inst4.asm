;------------------------------------------------------------------------
;Lucas Eiki Okada
;------------------------------------------------------------------------

		section .data
	LINE_BREAK equ 10	;10 = 0xA = 0AH = line break code
				;constant
	chx times 2	db 'X',LINE_BREAK		;define byte 2X = 2bytes
	chz		db 'Z', LINE_BREAK
	
	
		section .text
	global _start
	_start:
		mov ebx,1	;
		mov eax,4	;system call to write
		mov edx,2	;chx string lenght
		mov ecx,chx	;point to ecx
		int 0x80	;kernel
		
		mov ebx,1	;
		mov eax,4	;system call to write
		mov edx,4	;string lenght
		add ecx,2	;add 2 to ecx pointer position
		int 0x80
		
		mov ebx,1	;
		mov eax,4	;system call to write
		mov edx,2	
		add ecx,2	
		int 0x80	;kernel
		
		mov ebx,0
		mov eax,1
		int 0x80	;kernel
		
		;consecutive memory allocation
		
