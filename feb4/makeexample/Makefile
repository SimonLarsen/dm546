CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -pedantic -m32

default: main

main: main.o other.o
	$(CC) main.o other.o -o main $(CFLAGS)

main.o: main.c
	$(CC) -c main.c $(CFLAGS)

other.o: other.c other.h
	$(CC) -c other.c $(CFLAGS)

.PHONY: clean
clean:
	rm -f main.o other.o
