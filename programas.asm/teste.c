#include <stdio.h>

//Para compilar: gcc -m32 proc5.c
//Install: sudo apt-get install gcc-multilib

#define L 10

int main ()
{
    int vet[L]={9,7,4,3,8,1,2,4,-5,3};
    extern int sum_asm(int*, int);
    int r = sum_asm(vet, L);
    printf ("Valor da Soma: %d \n", r);
  

}