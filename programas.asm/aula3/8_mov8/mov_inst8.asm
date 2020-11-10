;------------------------------------------------------------------------
;Lucas Eiki Okada
;-----------------------------------------------------------------------

		section .data
	name db 'unesp',0x10	;define byte. new line
	
		section .text

	global _start
	_start:
	
		mov eax,4	;system call to write
		mov ebx,1	;print on screen
		mov edx,name	;edx ponint to name
		mov ecx,6	;name lenght
		xchg ecx,edx	;ecx = edx content and edx = ecx content
		int 0x80	;kernel
		
		mov ebx,0	;return 0
		mov eax,1	;exit
		int 0x80		
