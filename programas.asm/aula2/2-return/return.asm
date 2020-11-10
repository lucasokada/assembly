;--------------------------------------------------------------
;Lucas Eiki Okada
;--------------------------------------------------------------

	section .text	;code section
global _start

	_start:
	
	mov ebx,1	;move 1 to ebx register

	mov eax, 1	;exit command to kernel
	int 0x80	;int: interrupt. 0x80 interrupt number. make system calls to the kernel	
	
	
