RETURN    equ 0
SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0

section .data
	var1 db 40H ; 64D , 01000000B
	var2 db 50H ; 80D , 01010000B
	
section .bss
	var3 resw 1
	
section .text
	global _start
	
	_start:

	;mov eax,[var1]
	;xor eax,eax ; = mov ebx,0
	;mov ebx,eax ;
	;int 0x80
	
	;	var2 - var1
	;mov eax,[var2]
	;sub eax,[var1] 
	;mov ebx,eax
	;int 0x80
	
	;	var1 - var2
	;mov eax,[var1]
	;sub eax,[var2] ;64 - 80
	;;80D=01010000B; C1 = 10101111; C2 = 10110000B = 176D
	;mov ebx,eax
	;int 0x80
	
	;	var1 + var2
	;mov eax,[var1]
	;add eax,[var2]
	;mov ebx,eax
	;int 0x80
		
	mov eax, SYS_EXIT
	int 0x80
	
	
	
	
