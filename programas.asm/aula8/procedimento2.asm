section .data

    size eq 10
    arr1 db 'x','b','h','s','a','q','r','t','e','z'
    arr2 db 't','e','f','r','i','s','o','t','e','x'

section .text
    global _start
    _start:

    mov edi,arr1
    mov esi,size
    call booble_sort
    mov ecx,arr1
    mov edx,size
    call exibicao
    mov al,1
    int 0x80

    booble_sort:
    xor ecx,ecx
    jmp loop_body2

    loop_body2:
        xor edx,edx
        jmp loop_cond1

        loop_body1:
            mov ah,[edi+ecx]
            mov bh,[edi+edx]
            cmp ah,bh
            jge end
            mov [edi+ecx],bh
            mov [edi+edx],ah
        end:
            inc edx
        loop_cond1:
            cmp edx,esi
            jl loop_body1
            inc ecx
        loop_cond2:
            cmp ecx,esi
            jl loop_body2
    ret

    exibiçao:
    mov eax,4
    mov ebx,1
    int 0x80
    ret
    
