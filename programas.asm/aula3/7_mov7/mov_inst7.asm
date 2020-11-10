;------------------------------------------------------------------------
;Lucas Eiki Okada
;------------------------------------------------------------------------

		section .data
	name db 'lucas'	;define byte
	
		section .text
	
	global _start
	_start:
		
		;mov ebx,[name]		;ebx = name content
		;mov ebx,name		;ebx = name address
		;lea ebx,[name]		;=mov ebx,name. ebx = name address
		;lea ebx,name		;invalid. lea carry only address
		
		mov eax, 1
		int 0x80
