section .text
global sum_asm

    sum_asm:
    push ebp
    mov ebp,esp

    mov edx,[ebp+8]     ;array
    mov esi,[ebp+12]    ;lenght
    xor eax,eax         ;sum acumulator
    xor ecx,ecx         ;lenght count

    loop_condition:
        cmp ecx,esi
        jge loop_exit

        loop_body:
        add eax,[edx + ecx * 4]
        inc ecx
        jmp loop_condition

    loop_exit:

    ;mov ebx,ebx     ;erro

    mov esp,ebp
    pop ebp
    ret

    
