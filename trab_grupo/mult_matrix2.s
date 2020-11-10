#No caso, o código em gas está semelhante à implementação em nasm, mudando somente a sintaxe

.data
    int_lenght:     #guarda o tamanho de um inteiro(4bytes)
        .long 4
    i:              #índicie para acesso das posições da matriz
        .long 0
    j:              #índicie para acesso das posições da matriz
        .long 0
    k:              #índicie para acesso das posições da matriz
        .long 0
    position:       #utilizada em conjunto com a macro calc_position para armazenar a posição de um elemento
         .long 0
    result:         #utilizada como auxiliar em algumas operações
        .long 0

    .macro reset_registers 
    #reseta registradores de uso geral
        xor %eax,%eax
        xor %ecx,%ecx
        xor %edx,%edx
        xor %esi,%esi
        xor %edi,%edi
    .endm

    .macro reset_aux
    #reseta variáveis auxiliares i,j,k
        movl $0,(i)
        movl $0,(j)
        movl $0,(k)
    .endm

    .macro calc_position num1, num2
        #calcula posição na memória dos índicies passados por parâmetro através da fórmula ((L*i)+j)*4
        pushl %eax
        xorl %eax,%eax
        movl %edx,%eax         
        mull \num1
        addl \num2,%eax
        mull (int_lenght)
        movl %eax,(position)
        popl %eax
    .endm

    .macro matrix_mul 
    #O algoritmo para multiplicar matrizes segue a mesma lógica do algorítmo em C, onde temos 3 loops vao até L, tendo 
    #i,j,k como controladores do loop. Após a entrada nesses loops, as posições dos elementos correspondentes a seus índicies
    #na memória são calculadas pela macro calc_position, depois, a multiplicação entre os elementos é feita e icrementada em
    #no registrador acumulador, onde a cada loop o valor da multiplicação é somado. Feito isso, o valor final é colocado na
    #matrix matrix_result, passada por parâmetro. No fim, todo processo é repetido até que i seja igual a L.

        loop_cond1:
            xorl %eax,%eax      #eax é zerado para as próximas interações
            
            cmp %edx,(i)
            jge loop_exit1

            loop_cond2:
                cmp %edx,(j)
                jge loop_exit2

                loop_cond3:
                    cmp %edx,(k)
                    jge loop_exit3

                    loop_body:
                        calc_position i,k
                        
                        pushl %esi
                        movl (position),%esi
                        pushl %eax
                        movl (%esi,%ecx),%eax   #[ecx+esi] = elemento da matrixA na posição calculada
                        
                        movl 28(%ebp),%edx
                        calc_position k,j

                        movl (position),%esi
                        movl (%edi,%esi),%edx   #[edi+esi] = elemento da matrixC na posição calculada
                        mull %edx

                        movl %eax,(result)
                        popl %eax
                        popl %esi

                        addl (result),%eax

                        incl (k)
                        movl 28(%ebp),%edx
                        jmp loop_cond3

                loop_exit3:
                    movl 28(%ebp),%edx
                    calc_position i,j       #calcula posição onde será inserido elemento na matrix resultante
                    movl (position),%edx
                    movl %eax,(%esi,%edx)   #adiciona elemento na matrix resultante 

                    incl (j)
                    movl $0,(k)
                    xorl %eax,%eax          #zera eax para próximas interações em loop2
                    
                    movl 28(%ebp),%edx 
                    jmp loop_cond2

            loop_exit2:
                incl (i)
                movl $0,(j)
                jmp loop_cond1

        loop_exit1:
    .endm

    .macro matrix_sum   
    #O algoritmo para somar matrizes o algoritmo usado foi o mesmo que em C, onde temos 2 loops que vão até L, sendo 
    #controlados por i,j. Após a entrada nos loops, as posições das matrizes são calculadas pela macro calc_position. Após
    #isso, é feita a soma entre esses elementos no registrador auxiliar inicializado com zero e armazenando seu valor. Por
    #fim, o valor armazenado é colocado na matriz resultante da soma, na posição referente aos índicies. Esse processo é 
    #repetido até que i seja igual a L 
        loop_condition1:
        xorl %eax,%eax
        cmpl %edx,(i)
        jge exit_loop
        
            loop_condition2:
            cmpl %edx,(j)
            jge exit1

                loop_body2:
                calc_position i,j
                movl (position),%edx
                addl (%ecx,%edx),%eax
                addl (%edi,%edx),%eax

            exit2:
            movl %eax,(%esi,%edx)
            xorl %eax,%eax
            movl 28(%ebp),%edx	
            incl (j)
            jmp loop_condition2

        exit1:
        incl (i)
        movl $0,(j)
        jmp loop_condition1

    exit_loop:
    .endm

    .macro matrix_diagonal_sum 
    #O algorítmo para somar a diagonal principal de uma matriz é o mesmo implementado em C. No caso temos dois loops 
    #controlados po i e j. Após entrar nesses loops, é verificado se os índicies i e j são iguais, ou seja, que estamos em
    #um elemento que faz parte da diagonal principal da matriz. Se essa verificação for atendida, a posição referente aos
    #índicies i e j é calculada pela macro calc_position, e somamos o valor desse elemento no registrador acumulador 
    #inicializado em zero. Todo o processo é repetido até que i seja igual a L
       loop_c1:
        cmpl %edx,(i)
        jge final_exit

            loop_c2:
            cmpl %edx,(j)
            jge exit

            final_loop_body:
                movl (j),%esi
                cmpl (i),%esi
                jne not_equal

                calc_position i,j
                movl (position),%edi
                addl (%ecx,%edi),%eax

            not_equal:
                incl (j)
                mov 28(%ebp),%edx
                jmp loop_c2

        exit:
        incl (i)
        movl $0,(j)
        jmp loop_c1
    
    final_exit:
    movl %eax,(result)  #resultado final é guardado em result
    .endm

.global mult_matrix2
mult_matrix2:
    push %ebp
    mov %esp,%ebp

    #parametros passados para registradores
    movl 8(%ebp),%ecx     #ecx = matrixA
    movl 16(%ebp),%edi    #edi = matrixC
    movl 20(%ebp),%esi    #esi = matrix_result
    movl 28(%ebp),%edx    #edx = L
    matrix_mul
    
    #preparação para nova operação
    reset_registers
    reset_aux
    #parametros passados para registradores
    movl 12(%ebp),%ecx    #ecx = matrixB
    movl 20(%ebp),%edi    #edi = mul_matrix
    movl 24(%ebp),%esi    #esi = sum_matrix
    movl 28(%ebp),%edx    #edx = L
    matrix_sum

    #preparação para nova operação
    reset_registers
    reset_aux
    #parametros passados para registradores
    mov 28(%ebp),%edx    #edx = L
    mov 24(%ebp),%ecx    #esi = sum_matrix
    matrix_diagonal_sum 
    
    reset_registers
    reset_aux

    mov (result),%eax

    mov %ebp,%esp
    pop %ebp
ret
