CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -pedantic -m32

default: hashtable

hashtable.o: hashtable.c hashtable.h
	$(CC) -c $^ $(CFLAGS)

hashtable: hashtable.o
	$(CC) -o $@ $^ $(CFLAGS)
