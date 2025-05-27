#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

int main(int argc, char* argv[])
{
    FILE *fp = fopen("file.txt", "w");
    
    if(fp == NULL)
    {
        perror("Error opening file");
        exit(EXIT_FAILURE);
    }

    pid_t pid = fork();
    
    if(pid < -1)
    {
        perror("Error creating child process");
        exit(EXIT_FAILURE);
    }

    else if(pid == 0)
    {
        fprintf(fp, "Child process id: %d\n", getpid());
    }

    else
    {
        fprintf(fp, "Parent process id: %d\n", getpid());
        waitpid(-1, NULL, 0);
        fclose(fp);
    }
    return 0;
}