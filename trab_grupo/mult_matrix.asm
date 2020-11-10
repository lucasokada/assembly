section .data
int_lenght  dd 4        ;guarda o tamanho de um inteiro(4bytes)
i           dd 0        ;índicie para acesso das posições da matriz
j           dd 0        ;índicie para acesso das posições da matriz
k           dd 0        ;índicie para acesso das posições da matriz
position    dd 0        ;utilizada em conjunto com a macro calc_position para armazenar a posição de um elemento
result      dd 0        ;utilizada como auxiliar em algumas operações

%macro reset_registers 0
;reseta registradores de uso geral
    xor eax,eax
    xor ecx,ecx
    xor edx,edx 
    xor esi,esi
    xor edi,edi
%endmacro

%macro reset_aux 0
;reseta variáveis auxiliares i,j,k
    mov [i],dword 0
    mov [j],dword 0
    mov [k],dword 0
%endmacro

%macro calc_position 2
;calcula posição na memória dos índicies passados por parâmetro através da fórmula ((L*i)+j)*4
    push eax        
    xor eax,eax
    mov eax,edx         
    mul dword[%1]
    add eax,[%2]
    mul dword[int_lenght]
    mov [position],eax
    pop eax
%endmacro

%macro matrix_mul 0
;O algoritmo para multiplicar matrizes segue a mesma lógica do algorítmo em C, onde temos 3 loops vao até L, tendo 
;i,j,k como controladores do loop. Após a entrada nesses loops, as posições dos elementos correspondentes a seus índicies
;na memória são calculadas pela macro calc_position, depois, a multiplicação entre os elementos é feita e icrementada em
;no registrador acumulador, onde a cada loop o valor da multiplicação é somado. Feito isso, o valor final é colocado na
;matrix matrix_result, passada por parâmetro. No fim, todo processo é repetido até que i seja igual a L.

    loop_cond1:
    xor eax,eax         ;eax é zerado para as próximas interações
    cmp [i],edx
    jge loop_exit1

        loop_cond2:
        cmp [j],edx
        jge loop_exit2

            loop_cond3:
            cmp [k],edx
            jge loop_exit3

                loop_body:
                calc_position i,k
                
                push esi
                mov esi,[position]
                push eax
                mov eax,[ecx+esi]   ;[ecx+esi] = elemento da matrixA na posição calculada
                
                mov edx,[ebp+28] 
                calc_position k,j

                mov esi,[position]
                mov edx,[edi+esi]   ;[edi+esi] = elemento da matrixC na posição calculada
                mul edx

                mov [result],eax
                pop eax
                pop esi

                add eax,[result]

                inc dword[k]
                mov edx,[ebp+28] 
                jmp loop_cond3

            loop_exit3:
            mov edx,[ebp+28] 
            calc_position i,j       ;calcula posição onde será inserido elemento na matrix resultante
            mov edx,[position]
            mov [esi+edx],eax       ;adiciona elemento na matrix resultante 

            inc dword[j]
            mov [k],dword 0
            xor eax,eax         ;zera eax para próximas interações em loop2
            
            mov edx,[ebp+28] 
            jmp loop_cond2

        loop_exit2:
        inc dword[i]
        mov [j],dword 0
        jmp loop_cond1

    loop_exit1:
%endmacro

%macro matrix_sum 0
;O algoritmo para somar matrizes o algoritmo usado foi o mesmo que em C, onde temos 2 loops que vão até L, sendo 
;controlados por i,j. Após a entrada nos loops, as posições das matrizes são calculadas pela macro calc_position. Após
;isso, é feita a soma entre esses elementos no registrador auxiliar inicializado com zero e armazenando seu valor. Por
;fim, o valor armazenado é colocado na matriz resultante da soma, na posição referente aos índicies. Esse processo é 
;repetido até que i seja igual a L 
    loop_condition1:
    xor eax,eax
    cmp [i],edx
    jge exit_loop
        
        loop_condition2:
        cmp [j],edx
        jge exit1

            loop_body2:
            calc_position i,j
            mov edx,[position]
            add eax,[ecx+edx]
            add eax,[edi+edx]

        exit2:
        mov [esi+edx],eax
        xor eax,eax
        mov edx,[ebp+28]
        inc dword[j]
        jmp loop_condition2

    exit1:
    inc dword[i]    
    mov [j],dword 0
    jmp loop_condition1

    exit_loop:
%endmacro

%macro matrix_diagonal_sum 0
;O algorítmo para somar a diagonal principal de uma matriz é o mesmo implementado em C. No caso temos dois loops 
;controlados po i e j. Após entrar nesses loops, é verificado se os índicies i e j são iguais, ou seja, que estamos em
;um elemento que faz parte da diagonal principal da matriz. Se essa verificação for atendida, a posição referente aos
;índicies i e j é calculada pela macro calc_position, e somamos o valor desse elemento no registrador acumulador 
;inicializado em zero. Todo o processo é repetido até que i seja igual a L
    loop_c1:
    cmp [i],edx
    jge final_exit

        loop_c2:
        cmp [j],edx
        jge exit

            final_loop_body:
            mov esi,[j]
            cmp [i],esi
            jne not_equal

            calc_position i,j
            mov edi,[position]
            add eax,[ecx+edi]

            not_equal:
            inc dword[j]
            mov edx,[ebp+28]
            jmp loop_c2

        exit:
        inc dword[i]
        mov [j],dword 0
        jmp loop_c1
    
    final_exit:
    mov [result],eax        ;resultado final é guardado em result
%endmacro

global mult_matrix
    mult_matrix:

    push ebp
    mov ebp,esp

    ;parametros passados para registradores
    mov ecx,[ebp+8]     ;ecx = matrixA
    mov edi,[ebp+16]    ;edi = matrixC
    mov esi,[ebp+20]    ;esi = matrix_result
    mov edx,[ebp+28]    ;edx = L
    matrix_mul          ;multipicacao de matriz 

    ;preparação para nova operação
    reset_registers
    reset_aux
    ;parametros passados para registradores
    mov ecx,[ebp+12]    ;ecx = matrixB
    mov edi,[ebp+20]    ;edi = mul_matrix
    mov esi,[ebp+24]    ;esi = sum_matrix
    mov edx,[ebp+28]    ;edx = L
    matrix_sum

    ;preparação para nova operação
    reset_registers
    reset_aux
    ;parametros passados para registradores
    mov edx,[ebp+28]    ;edx = L
    mov ecx,[ebp+24]    ;esi = sum_matrix
    matrix_diagonal_sum 

    reset_registers
    reset_aux

    mov eax,[result]    ;valor final passado para eax, que será retornado para o programa principal

    mov esp,ebp
    pop ebp
    ret
