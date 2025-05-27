CC = gcc

CFLAGS = -Wall -g

SRC = mysigcatch.c mysigcatchmodified.c

OBJ = mysigcatch mysigcatchmodified


all: $(OBJ)


mysigcatch: mysigcatch.c
	$(CC) $(CFLAGS) $^ -o $@

mysigcatchmodified: mysigcatchmodified.c
	$(CC) $(CFLAGS) $^ -o $@

.PHONY: clean

clean:
	rm -f $(OBJ)
