		section .data
	message db 'hello world',0xA

		section .text
	global _start
	_start:
		
		mov ebx,1	;print on screen
		mov eax,4	;system call to print
		mov edx,12	;lenght of message
		mov ecx,message	;ecx points message
		int 0x80
		
		mov ebx,0
		mov eax,1
		int 0x80
