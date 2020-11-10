section .data
arr1        dd 9,10,1,4,2,3,5,6,7
arr2        dd 9,8,7,6,5,4,3,2,1
arr3        dd 0,0,0,0,0,0,0,0,0
L           dd 3
int_lenght  dd 4
i           dd 0
j           dd 0
position    dd 0
result      dd 0
espaco      dd 8

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

    mov ecx,arr1
    mov esi,arr2
    mov edi,arr3
    mov edx,[L] 
    
    loop_condition1:
    xor eax,eax
    cmp [i],edx
    jge exit
        
        loop_condition2:
        cmp [j],edx
        jge loop_exit1
            
            loop_body:
            calc_position i,j
            mov edx,[position]
            add eax,[arr1+edx]
            add eax,[arr2+edx]
            mov edx,[L] 
            
        loop_exit2:
        mov edx,[position]
        mov [arr3+edx],eax
        xor eax,eax
        mov edx,[L] 
        inc dword[j]
        jmp loop_condition2
        
    loop_exit1:
    inc dword[i]
    mov [j],dword 0
    jmp loop_condition1
    
    exit:

    mov ebx,[arr3+28]
    mov eax,1
    int 0x80