CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -pedantic -m32 -ggdb

default: bintree

bintree.o: bintree.c bintree.h
	$(CC) -c $< $(CFLAGS)

bintree: bintree.o
	$(CC) -o $@ $^ $(CFLAGS)
