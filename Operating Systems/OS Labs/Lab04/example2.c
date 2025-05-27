#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main() {
    pid_t pid, ppid;

    // Get the PID of the current process
    pid = getpid();

    // Get the PPID of the current process
    ppid = getppid();

    printf("Current Process ID (PID): %d\n", pid);
    printf("Parent Process ID (PPID): %d\n", ppid);

    return 0;
}
