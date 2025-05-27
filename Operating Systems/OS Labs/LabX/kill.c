#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <signal.h>

void singal_handler(int sig)
{
    printf("Received signal from parent process (%d)\n", sig);
    exit(EXIT_SUCCESS);
}

int main(int argc, char* argv[])
{
    pid_t pid = fork();

    if(pid < 0)
    {
        perror("Error creating child process");
        exit(EXIT_FAILURE);
    }

    else if(pid == 0)
    {
        if(signal(SIGINT, singal_handler) == SIG_ERR)
        {
            perror("Error setting signal handler");
            exit(EXIT_FAILURE);
        }

        while(1)
        {
            printf("Waiting singal from parent ...\n");
            sleep(1);
        }
    }

    else
    {
        sleep(5);
        printf("Sending signal to child process\n");
        kill(pid, SIGINT);
        waitpid(-1, NULL, 0);
    }
    return 0;
}