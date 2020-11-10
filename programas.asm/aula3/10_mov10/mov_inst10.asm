;----------------------------------------------------------------------
;Lucas Okada
;----------------------------------------------------------------------
	section .data
	
		value db 30
	
	section .text
		
	global _start
		
	_start:
		
		;mov [value],5		;error, number 5 not specified
		mov [value], byte 5	;value content = 20. 5 is specified
		mov byte [value], 5	;ok. value is specified
		
		mov ebx,[value]	;ebx = value content
		
		mov eax,1
		int 0x80
