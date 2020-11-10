;------------------------------------------------------------------------
;Lucas Eiki Okada
;------------------------------------------------------------------------
		section .data
	departamento 	db 'DEMAC', 0AH	;hexadecimal value. equivalent to 0xA. linefeed
	unidade 	db 'I'			
			db 'G'
			db 'C'
			db 'E'		
			db 0xA			;hexadecimal value. equivalent to linefeed('\n')			
			
		section .text
	global _start
	_start:
	
	mov ebx,1		;write in the screen. stdout
	mov ecx,unidade	;point to string unidade
	mov eax,4		;system call to write
	mov edx,5		;string unidade lengt
	int 0x80
	
	mov ebx,1		;write in the screen.stdout
	mov ecx,departamento	;point to string departamento
	mov eax,4		;system call to write
	mov edx,6		;string departamento lenght
	int 0x80
	
	mov ebx,0		;system exit(0=ok, 1=error)
	mov eax,1		;system exit to kernel
	int 0x80
	
	;print IGCE and DEMAC
