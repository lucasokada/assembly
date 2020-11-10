SYS_EXIT  equ 1
SYS_WRITE equ 4 
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	res   db 0
	count db 1
	a     db 10
	
section .text
	global _start
	_start:
	
	;---------------------
	while:
	mov al,[count]	
	mov bl,[a]
	cmp al,bl
	jg  exit
	
	cmp al,5
	jle case1
	
	cmp al,10
	jge case2
	jl  else
	
	increment:
	inc byte[count]
	jmp while
	;-----------------------
	
	case1:
	add [res],byte 3
	jmp increment
	
	case2:
	cmp al,15
	jle case2.2
	jg  else

	case2.2:
	add [res],byte 2
	jmp increment
		
	else:
	inc byte[res]
	jmp increment
	
	exit:
	mov ebx,[res]
	mov eax,SYS_EXIT
	int 0x80
	
	
