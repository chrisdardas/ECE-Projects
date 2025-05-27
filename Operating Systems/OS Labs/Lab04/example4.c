#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

// Signal handler for SIGINT (does nothing)
void sigint_handler(int sig) {
    printf("\nReceived SIGINT (signal %d), but ignoring it.\n", sig);
}

int main() {
    // Register the SIGINT handler to ignore the signal
    if (signal(SIGINT, sigint_handler) == SIG_ERR) {
        perror("signal");
        exit(EXIT_FAILURE);
    }

    printf("Process ID: %d\n", getpid());
    printf("Press Ctrl+C to attempt to send SIGINT.\n");

    // Infinite loop to keep the program running
    while (1) {
        printf("Running... Try pressing Ctrl+C.\n");
        sleep(2);
    }

    return 0;
}
