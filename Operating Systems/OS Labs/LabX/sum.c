#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>


int add(int* num1, int* num2, int* num3)
{
    return *num1 + *num2 + *num3;
}

int main(int argc, char* argv[])
{
    int num1, num2, num3;
    int sum = 0;
    printf("Enter three numbers: \n");
    scanf("%d %d %d", &num1, &num2, &num3);
    sum = add(&num1, &num2, &num3);
    printf("Sum of the three numbers: %d\n", sum);
}