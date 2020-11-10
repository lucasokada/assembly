section .data
arr1        dd 7,2,2,3,7,3,2,9,3
L           dd 3
i           dd 0
j           dd 0
int_lenght  dd 4
position    dd 0
result      dd 0

section .text

%macro calc_position 2
    push eax
    xor eax,eax
    mov eax,edx         
    mul dword[%1]
    add eax,[%2]
    mul dword[int_lenght]
    mov [position],eax
    pop eax
%endmacro

global _start
    _start:
    mov edx,[L]
    mov ecx,arr1

    loop_cond1:
    cmp [i],edx
    jge exit

        loop_cond2:
        cmp [j],edx
        jge loop_exit

            loop_body:
            mov esi,[j]
            cmp [i],esi
            jne not_equal

            calc_position i,j
            mov edi,[position]
            add eax,[arr1+edi]

            not_equal:
            inc dword[j]
            mov edx,[L]
            jmp loop_cond2

        loop_exit:
        inc dword[i]
        mov [j],dword 0
        jmp loop_cond1
        
    exit:
    mov [result],eax

    mov ebx,[result]
    mov eax,1
    int 0x80
