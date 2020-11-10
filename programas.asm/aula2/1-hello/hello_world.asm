;---------------hello_world---------------
;Lucas Eiki Okada.
;-----------------------------------------

section .data: ;declaraçao das "variaveis"

	msg db 'Hello World', 0xa ;variavel do tipo binaria com conteudo hello world, na posicao 0xa
	len equ $ - msg ;tamanho da variavel

section .txt: ;programa

global _start

_start:
	mov edx, len ;tamanho da variavel
	mov ecx, msg ;mensagem
	mov ebx, 1 ;arquivo de saida
	mov eax, 4 ;manda informaçao para o sistema
	int 0x80 ;finaliza(endereco do kernel)
;saida
	mov eax, 1 ;padrao
	mov ebx, 0 ;padrao
	int 0x80 
	

