section .data
    var1 dw 15
    var2 dw 7

section .text 
    global _start
    _start:
    push word[var1]
    push word[var2]
    call triplo_maior
    mov eax,ebx
    mov eax,1
    int 0x80

    triplo_maior:
    push ebp
    mov ebp,esp
    mov ax,[ebp+10]
    mov bx,[ebp+8]
    cmp ax,bx
    jl  b_maior
    jmp triplo

    b_maior:
    mov ax,bx

    triplo
    mov bx,3
    mov esp,ebp
    pop ebp
    ret 4