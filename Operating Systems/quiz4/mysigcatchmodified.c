#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>

void signal_handler(int sig)
{
    volatile static int count = 0;
    if( count < 2)
    {
        printf("\rIgnoring signal %d(SIGINT)\n", sig);
        count += 1;
    }

    else
    {
        printf("\rCaught signal %d(SIGINT)\n", sig);
        exit(EXIT_SUCCESS);
    }
}

int main(int argc, char* argv[])
{
    if(signal(SIGINT, signal_handler) == SIG_ERR)
    {
        perror("Error in signal");
        exit(EXIT_FAILURE);
    }

    while(1)
    {
        printf("Waiting for signal...(Ctrl+C)\n");
        sleep(2);
    }
}
