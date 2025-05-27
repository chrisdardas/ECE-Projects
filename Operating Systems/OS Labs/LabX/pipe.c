#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>  
#include <sys/wait.h>
#include <string.h>

int main(int argc, char* argv[])
{
    pid_t pid;
    int fd_parent[2];
    int fd_child[2];
    char* message = (char*)malloc(100 * sizeof(char));
    int size_msg ;


    if(pipe(fd_parent) == -1)
    {
        perror("Pipe failed");
        exit(EXIT_FAILURE);
    }

    if(pipe(fd_child) == -1)
    {
        perror("Pipe failed");
        exit(EXIT_FAILURE);
    }

    pid = fork();


    if (pid < 0)
    {
        perror("Fork failed");
        exit(EXIT_FAILURE);
    }

    else if(pid == 0)
    {
        char* message_child = (char*)malloc(100 * sizeof(char));
        strcpy(message_child, "Hello from child");
        int child_size = strlen(message_child) + 1;

        close(fd_parent[1]); // Close write end of parent pipe
        close(fd_child[0]); // Close read end of child pipe

        read(fd_parent[0], &size_msg, sizeof(size_msg));
        read(fd_parent[0], message, size_msg);
        printf("Message from parent(In child process): %s\n", message);
        write(fd_child[1], &child_size, sizeof(int));
        write(fd_child[1], message_child, strlen(message_child) + 1);
        close(fd_child[1]);
        close(fd_parent[0]);

        free(message_child); // Free memory
    }

    else
    {
        char* message_child = (char*)malloc(sizeof(char) * 100);
        int child_size = 0;
        close(fd_parent[0]); // Close read end of parent pipe
        close(fd_child[1]); // Close write end of child pipe

        strcpy(message, "Hello from parent");
        size_msg = strlen(message) + 1;
        write(fd_parent[1], &size_msg, sizeof(size_msg));
        write(fd_parent[1], message, size_msg);
       
        read(fd_child[0], &child_size, sizeof(int));
        read(fd_child[0], message_child, child_size);
        printf("Message from child(In parent): %s\n", message_child);
        close(fd_parent[1]);
        close(fd_child[0]);

        waitpid(-1, NULL, 0); // Wait for child process to finish
        free(message); // Free memory
        free(message_child); // Free memory
    }

    return 0;
}
