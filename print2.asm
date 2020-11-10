section .data
    number   dw 53
    string   db '0000'
    len      equ $- string
    

section .data
    global _start
    _start:
    mov ecx,string
    add ecx,len 
    dec ecx

    mov ax,[number]
    mov bx,10

    ;xor edx,edx 
    ;div bx

    ;xor edx,edx 
    ;div bx

    loop_condition:
    test eax,eax
    jz   loop_exit

    loop_body:
    xor edx,edx
    div bx
    add dx,48
    mov [ecx],dx
    dec ecx
    jmp loop_condition

    loop_exit:
    xor esi,esi
    xor ecx,ecx
    xor eax,eax
    xor edx,edx
    xor ebx,ebx
    mov esi,0

    mov ecx,string
    inc ecx
    inc ecx
    inc ecx

    ;loop_print_condition:
    ;cmp esi,len
    ;jg  exit

    ;loop_print:
    mov eax,4
    mov ebx,1
    mov edx,1
    int 0x80

    ;inc esi
    ;inc ecx
    ;jmp loop_print_condition

    exit:
    mov ebx,[string + 2]
    mov eax,1
    int 0x80