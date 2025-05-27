# Compiler and flags
CC = gcc
CFLAGS = -Wall -g

# Source files
SOURCES = example1.c example2.c example3.c example4.c example5.c

# Object files
OBJECTS = example1 example2 example3 example4 example5

# Default target
all: $(OBJECTS)

# Targets for each file
example1: example1.c
	$(CC) $(CFLAGS) -o $@ $<

example2: example2.c
	$(CC) $(CFLAGS) -o $@ $<

example3: example3.c
	$(CC) $(CFLAGS) -o $@ $<

example4: example4.c
	$(CC) $(CFLAGS) -o $@ $<

example5: example5.c
	$(CC) $(CFLAGS) -o $@ $<

# Clean target to remove compiled files
clean:
	rm -f $(OBJECTS)
