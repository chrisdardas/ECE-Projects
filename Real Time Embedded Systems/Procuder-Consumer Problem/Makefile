CC=gcc
CFLAGS=-Wall -g 
CMATH= -lm


SRC= /home/chris/cprogs/pitsianis/producer_consumer.c
TARGET= producer_consumer

all: $(TARGET)


$(TARGET): $(SRC)
	 $(CC) $(CFLAGS)  $^ -o $@ $(CMATH) 

clean:
	rm -f $(TARGET)
