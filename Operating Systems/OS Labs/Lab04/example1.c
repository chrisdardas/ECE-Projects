#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    pid_t pid;

    // Create a new process
    pid = fork();

    if (pid < 0) { // Error in fork
        perror("fork failed");
        exit(EXIT_FAILURE);
    }
    else if (pid == 0) { // Child process
        printf("Child Process: PID = %d, Parent PID = %d\n", getpid(), getppid());
        // Child can execute a different program
        execlp("/bin/ls", "ls", "-l", NULL);
        // If execlp fails
        perror("execlp failed");
        exit(EXIT_FAILURE);
    }
    else { // Parent process
        printf("Parent Process: PID = %d, Created Child PID = %d\n", getpid(), pid);
        // Wait for child process to finish
        wait(NULL);
        printf("Parent Process: Child has terminated.\n");
    }

    return 0;
}
