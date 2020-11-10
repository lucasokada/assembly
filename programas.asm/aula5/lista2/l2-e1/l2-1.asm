SYS_EXIT  equ 1
SYS_WRITE equ 4
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	idade  db 54
	idade1 db 16
	idade2 db 18
	idade3 db 70
	msg1   db 'O cidadão não pode votar!   ' ,0xA
	msg2   db 'O voto é facultativo         ',0xA
	msg3   db 'O cidadão é obrigado a votar' ,0xA ;tam = 31
	
section .text
	global _start
	
	_start:
	
	mov al,[idade]
	mov bl,[idade1]		;16
	cmp al,bl			;al - bl
	
	jb  sem_voto			;idade < 16
	
	jae verifica_facultativo	;idade >= 16
	
	
sem_voto:
	mov ecx,msg1
	jmp printa

verifica_facultativo:
	mov bl,[idade2]		;bl = 18
	cmp al,bl
	jae verifica_obrigado		;idade >= 18
	jb  facultativo		;idade < 18
	
	;------------------------------------------------------------

facultativo:
	mov ecx,msg2
	jmp printa
	
verifica_obrigado:
	mov bl,[idade3]		;bl = 70
	cmp al,bl
	jb  obrigado			;idade < 70
	jae facultativo		;idade >= 70

obrigado:
	mov ecx,msg3

printa:
	mov ebx,STDOUT
	mov eax,SYS_WRITE	
	mov edx,31
	int 0x80
	
finaliza:
	mov ebx,RETURN
	mov eax,SYS_EXIT
	int 0x80


	
