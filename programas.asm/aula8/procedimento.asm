section .data 
    var1 db 12
    var2 db 5

section .text
    global _start
    _start:

    mov al,[var1]
    mov bl,[var2]
    call tripo_maior
    mov bx,ax
    mov eax,1
    int 0x80

;------------------------------------------

    tripo_maior:
    cmp al,bl
    jl  b_maior
    jmp triplo

    b_maior:
    mov al,bl

    triplo:
    mov bl,3
    mul bl
    ret