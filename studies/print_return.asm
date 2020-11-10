		section .data
	name db 'lucas okada',0xA

		section .text
	global _start

	_start:
		mov ebx,1	;print on screen
		mov eax,4	;system call to print
		mov edx,12	;lenght of name
		mov ecx,name	;ecx points to name
		int 0x80	;call kernel

		mov ebx,name	;ebx return name to OS
		mov eax,1	;system call to exit
		int 0x80	
