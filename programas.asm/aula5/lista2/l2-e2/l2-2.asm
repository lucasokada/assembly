SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDIN     equ 1
STDOUT    equ 0
RETURN    equ 0

section .data
	x    db 68
	n1   db 50
	n2   db 100
	n3   db 150
	n4   db 200
	msg1 db "valido  ",0xA
	msg2 db "invalido",0xA
	
section .data
	global _start
	
	_start:
	
	mov al,[x]
	mov bl,[n1]	;bl = 50
	cmp al,bl
	jb  invalido	 ;x < 50	 
	jae verifica100  ;x >= 50 
	
valido:
	mov ecx,msg1
	jmp printa

invalido:
	mov ecx,msg2
	jmp printa
	
verifica100:
	mov bl,[n2]	;bl = 100
	cmp al,bl
	je  valido		;x == 100
	jb  valido		;x < 100 && x > 50
	ja  verifica150	;x > 100
	
verifica150:
	mov bl,[n3]		;bl = 150
	cmp al,bl
	je  valido		;x == 150
	ja  verifica200	;x > 150
	jb  invalido		;x < 150 && x > 100
	
verifica200:
	mov bl,[n4]	;bl = 200
	cmp al,bl
	je valido 	;x == 200
	jb valido	;x > 150 $$ x < 200
	ja invalido	;x > 200

printa:
	mov ebx,STDOUT
	mov eax,SYS_WRITE
	mov edx,9
	int 0x80

	mov ebx,RETURN
	mov eax,SYS_EXIT
	int 0x80
