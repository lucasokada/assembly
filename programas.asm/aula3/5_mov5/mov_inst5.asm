;------------------------------------------------------------------------
;Lucas Eiki Okada
;------------------------------------------------------------------------

		section .data
	msg db 'lucas okada'
	
		section .text
		
	global _start
	_start:
	
		mov ebx,msg	;ebx points to msg
		mov ebx,[msg]	;ebx receive the content of msg
		
		mov eax,1
		int 0x80
