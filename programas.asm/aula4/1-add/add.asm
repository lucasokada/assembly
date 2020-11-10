SYS_EXIT    equ 1
RETURN      equ 0
SYS_READ    equ 3
SYS_WRITE   equ 4
STDIN       equ 0
STDOUT      equ 1
MAX         equ 10
	
section .data
	var1 db 10
	var2 db 30
	var3 db 5
	var4 db 17,21
	len1 equ $- var1
	len2 equ $- var2
	len3 equ $- var3 
	
section .bss

	resultado  resb MAX
	tamanho    resb MAX
	
section .text 
	
	global _start
	
	_start:
	
	;mov eax,[var1] ;register eax receives the content of var1
	;add eax,[var3] ;sum eax+var3
	;mov [resultado],eax
	;mov ebx,[resultado]
	;mov eax,SYS_EXIT
	;int 0x80
	
	;mov eax,len3
	;add eax,len1	;sum len3+len1 = 4
	;mov [tamanho],eax
	;mov ebx,[tamanho]
	;mov eax,SYS_EXIT
	;int 0x80
	
	;mov eax,var4	;aponta eax para var4
	;mov ebx,[eax]
	;mov eax,SYS_EXIT
	;int 0x80
	
	;mov eax,var4
	;add eax,1
	;mov ebx,[eax]
	;mov eax,SYS_EXIT
	;int 0x80
	
	;mov eax,SYS_WRITE
	;mov ebx,STDOUT
	;mov ecx,[resultado]
	;mov edx,[tamanho]
	;int 0x80
	;nao funciona!!
	
	;mov ebx,RETURN
	;mov eax,SYS_EXIT
	;int 0x80

	
	
	
	
