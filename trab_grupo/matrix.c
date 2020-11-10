#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define L 20//4000

int **aloca_matrix()
{
    int i;

    int **matrix = (int **)malloc(sizeof(int*) * L);
    for(i=0; i<L; i++){
        matrix[i] = (int *)malloc(sizeof(int) * L);
    }

    return matrix;
}

int *aloca_array()
{
    int len = L*L;

    int *array = (int *)malloc(len * sizeof(int));
    return array;
}

void preenche_matrix(int **matrix)
{
    int i, j;

    for(i=0; i<L; i++){
        for(j=0; j<L; j++){
            matrix[i][j] = rand() % 10;
        }
    }
}

void reset_matrix(int **matrix)
{
    int i,j;

    for(i=0; i<L; i++){
        for(j=0; j<L; j++){
            matrix[i][j] = 0;
        }
    }
}

void mul_matrix(int **matrixA, int **matrixB, int **matrix_result)
{
    int i, j, k;
    int result = 0;

    for(i=0; i<L; i++){
        for(j=0; j<L; j++){
            for(k=0; k<L; k++){
                result += matrixA[i][k] * matrixB[k][j];
            }

            matrix_result[i][j] = result;
            result = 0;
        }
    }
}

void sum_matrix(int **matrixA, int **matrixB, int **matrix_sum)
{
    int i, j;

    for(i=0; i<L; i++){
        for(j=0; j<L; j++){
            matrix_sum[i][j] = matrixA[i][j] + matrixB[i][j];
        }
    }
}

int sum_diagonal_principal(int **matrixA)
{
    int sum = 0;
    int i, j;

    for(i=0; i<L; i++){
        for(j=0; j<L; j++){
            
            if(i == j){
                sum += matrixA[i][j];
            }
        }
    }

    return sum;
}

int funcao_final(int **matrixA, int **matrixB, int **matrixC, int **matrix_mul,  int **matrix_sum)
{
    int i,j;
    int sum = 0;

    mul_matrix(matrixA, matrixC, matrix_mul);
    sum_matrix(matrix_mul, matrixB, matrix_sum);
    sum = sum_diagonal_principal(matrix_sum);

    return sum;
}



int* to_array(int **matrix)
{
    int i,j;
    int k=0;
    int *array = aloca_array();

    for(i=0; i<L; i++){
        for(j=0; j<L; j++){
            array[k] = matrix[i][j];
            k++;
        }
    }

    return array;
}

int** to_matrix(int *array)
{
    int **matrix = aloca_matrix();
    int len = L*L;
    int i,j,k=0;

    for(i=0; i<L; i++)
    {
        for(j=0; j<L; j++)
        {
            matrix[i][j] = array[k];
            k++;
        }
    }

    return matrix;
}

void printa_matrix(int **matrix)
{
    int i, j;

    for(i=0; i<L; i++){
        for(j=0; j<L; j++){
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int main()
{
    srand(time(NULL));
    clock_t start,end;
    int **matrixA = aloca_matrix();
    int **matrixB = aloca_matrix();
    int **matrixC = aloca_matrix();
    int **matrix_mul = aloca_matrix();
    int **matrix_sum = aloca_matrix();
    int diagonal_sum;
    double time_c, time_nasm, time_gas;

    preenche_matrix(matrixA);
    preenche_matrix(matrixB);
    preenche_matrix(matrixC);

    printf("\nMatriz A:\n");
    printa_matrix(matrixA);

    printf("\nMatrizB:\n");
    printa_matrix(matrixB);

    printf("\nMatrizC\n");
    printa_matrix(matrixC);

    //------------------EXECUÇÃO DA FUNÇAO EM C------------------
    printf("\n****************Código em C****************\n");
    
    start = clock();
    diagonal_sum = funcao_final(matrixA, matrixB, matrixC, matrix_mul, matrix_sum);
    end = clock();

    time_c = ((double)end - start) / CLOCKS_PER_SEC;

    printf("\nmatrix_mul\n");
    printa_matrix(matrix_mul);

    printf("\nmatrix_sum\n");
    printa_matrix(matrix_sum);

    printf("\ndiagonal_sum\n");
    printf("%d\n", diagonal_sum);

    //------------------preparação para execução do código em assembly------------------
    reset_matrix(matrix_mul);
    reset_matrix(matrix_sum);
    diagonal_sum = 0;

    int *arrayA = to_array(matrixA);
    int *arrayB = to_array(matrixB);
    int *arrayC = to_array(matrixC);
    int *array_mul = to_array(matrix_mul);
    int *array_sum = to_array(matrix_sum);

    //------------------EXECUÇÃO DA FUNCAO EM NASM------------------
    printf("\n****************Código em nasm****************\n");
    extern int mult_matrix(int*, int*, int*, int*, int*, int);

    start = clock();
    diagonal_sum = mult_matrix(arrayA, arrayB, arrayC, array_mul, array_sum, L);
    end = clock();

    time_nasm = ((double)end - start) / CLOCKS_PER_SEC; 

    matrix_mul = to_matrix(array_mul);
    printf("\nmatrix_mul\n");
    printa_matrix(matrix_mul);

    matrix_sum = to_matrix(array_sum);
    printf("\nmatrix_sum\n");
    printa_matrix(matrix_sum);

    printf("\ndiagonal_sum\n");
    printf("%d\n", diagonal_sum);

    //------------------preparação para execução do código em gas------------------
    reset_matrix(matrix_mul);
    reset_matrix(matrix_sum);
    diagonal_sum = 0;

    arrayA = to_array(matrixA);
    arrayB = to_array(matrixB);
    arrayC = to_array(matrixC);
    array_mul = to_array(matrix_mul);
    array_sum = to_array(matrix_sum);

      //------------------EXECUÇÃO DA FUNCAO EM GAS-----------------
    printf("\n****************Código em gas****************\n");
    extern int mult_matrix2(int*, int*, int*, int*, int*, int);

    start = clock();
    diagonal_sum = mult_matrix2(arrayA, arrayB, arrayC, array_mul, array_sum, L);
    end = clock();

    time_gas = ((double)end - start) / CLOCKS_PER_SEC;

    matrix_mul = to_matrix(array_mul);
    printf("\nmatrix_mul\n");
    printa_matrix(matrix_mul);

    matrix_sum = to_matrix(array_sum);
    printf("\nmatrix_sum\n");
    printa_matrix(matrix_sum);

    printf("\ndiagonal_sum\n");
    printf("%d\n", diagonal_sum);


    free(matrixA);
    free(matrixB);
    free(matrixC);
    free(matrix_mul);
    free(matrix_sum);

    printf("\n****************tempos****************\n");
    printf("tempo em c: %f\n", time_c);
    printf("tempo em nasm: %f\n", time_nasm);
    printf("tempo em gas: %f\n", time_gas);
}
