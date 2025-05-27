#CC= gcc
CC= arm-linux-gnueabihf-gcc
INC_DIRS= -I/home/cdardas/openssl-1.1.1t/openssl-arm/include -I/home/cdardas/libwebsockets/include -I/home/cdardas/libwebsockets/build 
LIB_DIRS= -L/home/cdardas/openssl-1.1.1t/openssl-arm/lib

CFLAGS= -Wall -g $(INC_DIRS)
LDFLAGS= $(LIB_DIRS) -lwebsockets -pthread -lssl -lcrypto -ljansson -lrt

SRC= $(pwd)project.c
TARGET= test


all: $(TARGET)


$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

clean:
	rm -f $(TARGET)
