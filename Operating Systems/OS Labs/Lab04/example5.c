#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

// Signal handler for SIGUSR1 in child
void sigusr1_handler(int sig) {
    printf("Child received SIGUSR1 (signal %d).\n", sig);
}

int main() {
    pid_t pid;

    // Create a pipe for synchronization (optional)
    // ...

    pid = fork();

    if (pid == -1) { // Error
        perror("fork");
        exit(EXIT_FAILURE);
    } else if (pid == 0) { // Child process
        // Register SIGUSR1 handler
        if (signal(SIGUSR1, sigusr1_handler) == SIG_ERR) {
            perror("signal");
            exit(EXIT_FAILURE);
        }

        printf("Child process ID: %d. Waiting for SIGUSR1...\n", getpid());

        // Infinite loop to keep child alive
        while (1) {
            pause(); // Wait for signals
        }
    } else { // Parent process
        printf("Parent process ID: %d. Child PID: %d\n", getpid(), pid);

        // Sleep for 3 seconds before sending SIGUSR1
        sleep(3);

        printf("Parent sending SIGUSR1 to child.\n");
        if (kill(pid, SIGUSR1) == -1) {
            perror("kill");
            exit(EXIT_FAILURE);
        }

        // Optionally, wait for child to handle the signal
        sleep(1);

        // Terminate the child process
        printf("Parent sending SIGTERM to child.\n");
        if (kill(pid, SIGTERM) == -1) {
            perror("kill");
            exit(EXIT_FAILURE);
        }

        // Wait for the child process to terminate
        wait(NULL);
        printf("Child process terminated.\n");
    }

    return 0;
}
