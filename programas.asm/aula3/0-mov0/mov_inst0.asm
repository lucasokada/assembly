;---------------------------------------------------------------
;Lucas Eiki Okada
;---------------------------------------------------------------

		section .data
	char1	db	'A'	;(define_byte)allocates 1 byte for char1 with A value
				;0x41, 41h, 65 are other forms to define A
		section .text
	
	global _start
	
	_start: 
		mov edx, 1	;move 1 to edx register
				;dx is know as the data register, also used in input/output, and also used with ax
				
		mov ebx, 1	;move 1 to ebx register
				;bx is know as the base register. could be used to indexed addressing 
				
		mov ecx, char1	;move the content of char1 to exc register
				;cx is know as the count register. store the loop count in iterative operantions
				
		mov eax, 4	;move 4 to eax register(sys_write)
				;ax is the primary accumulator. usede in input/output and arithmetic instructions
				
		int 0x80	;interrupt: transfers the program flow to who is handling that interrupt. In that case 0x80
				;in linux 0x80 is the kernel.
		
		;end
		mov ebx, 0	; normal
		mov eax, 1	;exit command to kernel(sys_exit)
		int 0x80	;call kernel
			
;print A
;reference: https://www.tutorialspoint.com/assembly_programming/assembly_registers.htm
