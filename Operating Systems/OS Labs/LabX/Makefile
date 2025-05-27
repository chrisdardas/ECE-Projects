CC = gcc

CFLAGS = -Wall -Wextra -g

SRC = fork.c pipe.c kill.c writeFile.c sum.c

OBJ = fork_test pipe_test kill_test write_file_test sum

all: $(OBJ)


fork_test: fork.c
	$(CC) $(CFLAGS) $^ -o $@ 

pipe_test: pipe.c
	$(CC) $(CFLAGS) $^ -o $@ 

kill_test: kill.c
	$(CC) $(CFLAGS) $^ -o $@ 

write_file_test: writeFile.c
	$(CC) $(CFLAGS) $^ -o $@

sum: sum.c
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: clean

clean:
	rm -f $(OBJ) file.txt
