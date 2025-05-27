#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>


int main(int argc, char* argv[])
{
    printf("Parent ID: %d\n", getpid());
    __pid_t pid = fork();
    if(pid < 0)
    {
        perror("Fork failed");
        exit(EXIT_FAILURE);
    }
    
    else if(pid == 0)
    {
        printf("Child ID: %d\n", getpid());
        __pid_t pid2 = fork();
        if(pid2 < 0)
        {
            perror("Fork failed");
            exit(EXIT_FAILURE);
        }
        else if(pid2 == 0)
        {
            printf("Child2 ID: %d\n", getpid());
            __pid_t pid3 = fork();
            if(pid3 < 0)
            {
                perror("Fork failed");
                exit(EXIT_FAILURE);
            }
            else if(pid3 == 0)
            {
                printf("Child3 ID: %d\n", getpid());
            }
        }
    }
    else
    {
        while(waitpid(-1, NULL, 0) > 0);
    }

    return 0;
    
}