SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDOUT    equ 1
STDIN     equ 0
RETURN    equ 0

section .data
	p        db 2,3,5
	n        db 8,6,7
	media    db 5
	
	msg      db 'Aprovado:'
	new_line db 0xA
	
section .bss
	aux1      resb 1
	aux2      resb 1
	aux3      resb 1
	sum1      resb 1 ;media aluno
	sumP      resb 1
	sinal     resb 1
	min_media resb 1
	
	
section .text
	global _start
	_start:
	
	;----------------------------------soma dos pesos
	mov edx,p
	mov bl,[edx]
	inc edx
	add bl,[edx]
	inc edx
	add bl,[edx]
	mov [sumP],bl
	int 0x80
	
	;-----------------------------------mul
	mov ecx,n
	mov edx,p
	mov al,[ecx]	;al = 8
	mov bl,[edx]	;bl = 2
	mul bl		;al * bl = 16; cabe em al
	mov[aux1],al	;aux1 = 16
	
	inc ecx
	inc edx
	mov al,[ecx]	;al = 6
	mov bl,[edx]	;bl = 3
	mul bl		;al * bl = 18; cabe em al 
	mov [aux2],al	;aux2 = 18
	
	inc ecx
	inc edx
	mov al,[ecx]	;al = 7
	mov bl,[edx]	;bl = 5
	mul bl		;al * bl = 30; cabe em al
	mov [aux3],al	;aux3 = 35
	int 0x80
	
	;-----------------------------------sum dividendo
	mov al,[aux1]
	mov [sum1],al	;sum1 = 16
	
	mov al,[aux2]
	add [sum1],al	;sum1 = 16+18
	
	mov al,[aux3]
	add[sum1],al	;sum1 = 16+18+35 = 69. 69 de 100 é a nota
	int 0x80
	
	;------------------------------------calc media minima
	mov al,[media]
	mov bl,[sumP]
	mul bl
	mov [min_media],ax
	int 0x80
	
	;----------------------------------------diferença
	
	mov al,[sum1]
	sub al,[min_media]	;al = 19D = 00010011B
	;----------------------------------------complemento 2
	
	not al	;al = 11101100
	inc al	;al = 11101101
	;--------------------------------------------move bms
	
	mov bl,2
	mul bl	;agora 0 ou 1 estara em ah
	
	;----------------------------------------------to char
	add ah,'0'	;char
	mov [sinal],ah
	
	;-----------------------------------------------print
	mov ebx,STDOUT
	mov eax,SYS_WRITE
	mov edx,9 
	mov ecx,msg
	int 0x80
	
	mov ebx,STDOUT
	mov eax,SYS_WRITE
	mov edx,1
	mov ecx,sinal
	int 0x80
	
	mov ebx,STDOUT
	mov eax,SYS_WRITE
	mov edx,1
	mov ecx,new_line
	int 0x80
	
	;--------------------------------------------------to number
	mov bl,[sinal]
	sub bl,byte 48
	
	mov eax,1
	int 0x80
