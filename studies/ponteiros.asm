		section .data
	pointer db 't','e','s','t', 0xA

		section .text
	global _start
	_start:

		mov ebx,1
		mov eax,4
		mov edx,1
		mov ecx,pointer
		int 0x80

		mov ebx,1
                mov eax,4
                mov edx,1
		mov ecx,pointer
		add ecx,1
		int 0x80
		
		mov ebx,1
                mov eax,4
                mov edx,1
                mov ecx,pointer
                add ecx,2
		int 0x80

		mov ebx,0
		mov eax,1
		int 0x80
