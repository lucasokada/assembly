;*****************************************************************
;		trabalho individual LM				   
;		LUcas eiki okadA			           
;		A: tarefa 0                                      
;		B: tarefa 1
;		C: tarefa 1
;*****************************************************************

SYS_EXIT   equ 1
SYS_WRITE  equ 4
SYS_READ   equ 3
STDOUT     equ 1
STDIN      equ 0
RETURN	   equ 0

section .bss
	average	resb 1
	ten_digit	resb 1
	factorial	resd 1
	rest_div	resb 1
	result_div	resb 1

section .data
	array		db 90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90
	len			equ $- array
	aux			db 0
	char_code 	equ 48
	string		db '0000000000'
	new_line	db 0xA

%macro average_calc 1
	mov ecx,array
	mov ax,0
	mov bl,0
	
	loop_average_condition:
	cmp bl,len
	jge loop_average_exit
	
	loop_average_body:
	mov dl,[ecx + ebx]
	add ax,dx
	inc bl
	jmp loop_average_condition	

	loop_average_exit:

		;A ideia do primeiro trecho dessa macro é percorrer todas as posiçoes do vetor, somando-as.
		;Na situação máxima, a soma será 1800(99 x 20)(11bits), sendo necessário um registrador de 2bytes para representá-lo
	
	mov bl,len
	div bl
	mov [%1], al

		;Na segunda parte da macro dividimos a soma dos elementos pela quantidade de elementos. Já que a média deve ser
	;arredondada para baixo simplesmente utilizamos al, que contém o quociente da divisão(al-quociente, ah-resto).
		;Após isso, o valor da média é armazenado na "variável" passada no parâmetro(average). 
		;Já que o valor da média nunca será um valor maior que 99(caso máximo), podemos representá-lo com apenas 1byte,
	;por isso, average pode ser um "define byte"

%endmacro

%macro ten_digit_calc 2
	mov bl,10
	mov al,[%1]
	div bl
	mov [%2],al
		;Para obter a dezena do número passado como primeiro parâmetro(average),basta dividi-lo por 10.(número nunca passaŕa 
	;de 99.Portanto terá sempre uma ou duas casas inteiras. Sendo assim, apenas uma divisão por 10 é suficiente) 
		;O quociente da divisão será sua dezena, portanto, o valor da dezena estará armazenado em al e o resto da divisão em ah
		;Após isso, o valor da dezena é armazenado no segundo parâmetro(ten_digit). Assim como no caso anterior, um "define byte"
	;é suficiente para esse, pois nunca passará de 127(número máximo representado com 8bits(1byte)).
%endmacro

%macro factorial_calc 2
		;Na macro para calcular o fatorial de um número de 1 - 9(a casa decimal nunca seŕa 0, pois os valores do vetor
		;devem ser maores que 10 como diz o enunciado, então no caso mínimo(10 x 20 / 20 = 10), teríamos uma média de 10 
		;e uma dezena de 1), o primeiro parâmetro, que é o número que seŕa calculado é decrementado a cada multiplicação,
		;até que esse chegue em 1, onde o programa sai do loop. Além disso, inicializa-se eax com 1, fator neutro da 
		;multiplicação, permitindo que os valores das próximas fiquem armazenados.
	mov ebx,[%1]
	mov eax,1
	
	loop_factorial_condition:
	cmp ebx,1
	jle loop_factorial_exit
	
	loop_factorial_body:
	mul ebx
	dec ebx
	jmp loop_factorial_condition
	
	loop_factorial_exit:
	mov [%2],eax
		;No fim da macro, o valor do fatorial é armazenado em factorial, que deve ser definido por um "reserve double"(4bytes),
	;pois, na situação máxima(9! = 362880 -> 19bits) precisamos de 4bytes(32bits) para representá-lo.
	
%endmacro

%macro to_char_register 1
		;Para transformar um numero em caractere, basta adicionar 48(código ascii de '0') à ele, para transformá-lo em um
	;código ascii e possa ser printado em tela.
	add %1,byte char_code
%endmacro

%macro reset_general_registers 0
		;Macro para zerar registradores de uso geral. 
	xor eax,eax
	xor ebx,ebx
	xor ecx,ecx
	xor edx,edx
%endmacro

%macro print 1
					;Macro para printar o ultimo resultado obtido.
	mov eax,SYS_WRITE	
	mov ebx,STDOUT
	mov edx,%1		;O parâmetro passado é o tamanho da string.
	int 0x80

		;ecx já está apontando para o começo da string, por isso não esta apresentado aqui.
%endmacro

section .texts
	global _start
	_start:
	
;--------------------------A-------------------------
	reset_general_registers	;zera registradores de uso geral para que nenhum lixo de memória atrapalhe as operaçoes.
	average_calc average	;calculo da média.
	
;--------------------------B-------------------------
	reset_general_registers	;zera registradores de uso geral para que nenhum lixo de memória atrapalhe as operaçoes.
	ten_digit_calc average, ten_digit	;calculo da dezena.
			
;--------------------------C-------------------------

	reset_general_registers	;zera registradores de uso geral para que nenhum lixo de memória atrapalhe as operaçoes.
	factorial_calc ten_digit, factorial	;calculo do fatorial.
	
;-------------------------print----------------------
	
	reset_general_registers	;zera registradores de uso geral para que nenhum lixo de memória atrapalhe as operaçoes.
							
							;Para que possamos printar o valor do fatorial, devemos fazer multiplas divisoes por 10, 
						;onde seu resto é e convertido para caractere e colocado na ultima posiçao da string. Após isso,
						;o quociente da divisão anterior é dividido novamente por 10 e o processo se repete até .
	mov eax,[factorial]	
	mov ebx,10
	mov ecx,new_line
	mov esi,1				;esi fará a contagem do tamanho da string.
	loop_print_body:
	div ebx
	to_char_register edx
	inc esi					;Incrementa o tamanho.
	dec ecx					;ecx aponta para "new_line" no começo da iteração. Como "new_line" foi declarado depois de string e
						;ocupa apenas 1byte,se decrementarmos o ponteiro, ecx passará a apontar para ultima posição de 
						;"string", assim, a "string" será preenchida de trás pra frente.
	mov [ecx],dl			;Já que o resto sempre terá apenas uma casa,  ficará armazenado em dl.
							;O conteúdo da posição apontada por eax recebe o codigo ascii de dl(resto).
	loop_print_condition:
	xor edx,edx				;Zera edx para que possa ser comparado com eax.
	cmp eax,edx				;Se eax, que gruarda o resultado das divisões, que serão divididas novamente por 10, for 0
						;o loop termina.
	jg loop_print_body

							;Para que a representação de todos os fatorias, de 1 a 9 seja possível, devemos considerar a situaçao
						;máxima(9! = 362880), devemos utilizar os registradores de 32 bits(eax, ebx, edx...).

	print esi				;print que tem como parâmetro o tamanho da string

	exit:
	mov ebx,RETURN
	mov eax,SYS_EXIT
	int 0x80
	
	
;casos de teste:	
;90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90
;80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80
;70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70,70
;60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60
;50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50
;40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40
;30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30
;20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20
;10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10
