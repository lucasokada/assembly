SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDIN     equ 1
STDOUT    equ 0
RETURN    equ 0

section .bss
	prev1 resb 1 
	prev2 resb 1 
	naux  resb 1	

section .data
	n db 8
	f db 0

section .text
	global _start
	_start:
	
	mov al,[n]
	mov [prev1],byte 1	
	mov [prev2],byte 1
	mov [naux], byte 2
	
	cmp al,0
	je  isZero
	
	cmp al,1
	je  isOne
	
	cmp al,2
	je  isTwo
	
	for:;===============f3
	inc byte[naux]
	cmp al,[naux]
	jl  end_fib
	
	mov bl,[prev2]
	mov dl,[prev1]
	
	add bl,dl	;prev2 + prev1(f(n-1)+f(n-2))
	
	mov dl,[prev2]
	mov [prev2],bl
	mov [prev1],dl
	
	mov [f],bl
	jmp for
	
	isZero:
	mov [f],byte 0
	jmp end_fib
	
	isOne:
	mov [f],byte 1
	jmp end_fib
	
	isTwo:
	mov [f],byte 1
	
	
	end_fib:
	mov ebx,[f]
	mov eax,SYS_EXIT
	int 0x80
	
	
	
