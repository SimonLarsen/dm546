CC=gcc
CFLAGS=-std=c99 -Wall -Wextra -pedantic -m32

default: p1 p2 struct1 struct2 struct3

p1: p1.c
	$(CC) -o $@ $(CFLAGS) $^

p2: p2.c
	$(CC) -o $@ $(CFLAGS) $^

struct1: struct1.c
	$(CC) -o $@ $(CFLAGS) $^

struct2: struct2.c
	$(CC) -o $@ $(CFLAGS) $^

struct3: struct2.c
	$(CC) -o $@ $(CFLAGS) $^
