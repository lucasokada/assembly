;-------------------------------------------------------------------------
;Lucas Okada
;------------------------------------------------------------------------

		section .data
	ROWS		equ	4
	COLUMNS	equ	3
	TOTAL 		equ	ROWS * COLUMNS
	
	%assign	SIZE  2	;constante numerica
	%iassign	value 3
	
		section .text
	global _start
	_start:
	
		mov ebx,TOTAL 	;ebx = TOTAL
		%assign SIZE 10	;size = 10
		%assign value 20	;value = 20
		mov ebx,SIZE		;ebx = size
		
		%iassign number 4	;constante. number = 4
		mov ebx,number	;ebx=valor
		
		mov eax,1		;exit ; return number
		int 0x80 	
	
		
	
