CC = gcc
CFLAGS = -std=c99 -Wall -Wextra -pedantic -m32 -ggdb
LDLIBS = -lfl

OBJECTS = y.tab.o lex.yy.o main.o tree.o pretty.o memory.o

main: y.tab.o lex.yy.o main.o tree.o pretty.o memory.o
	$(CC) y.tab.o lex.yy.o main.o tree.o pretty.o memory.o -o exp $(LDLIBS)

lex.yy.o: lex.yy.c
	$(CC) $(CFLAGS) -c $<

main.o: main.c tree.h pretty.h
	$(CC) $(CFLAGS) -c $<

memory.o: memory.c
	$(CC) $(CFLAGS) -c $<

pretty.o: pretty.c pretty.h
	$(CC) $(CFLAGS) -c $<

tree.o: tree.c tree.h memory.h
	$(CC) $(CFLAGS) -c $<

y.tab.o: y.tab.c tree.h
	$(CC) $(CFLAGS) -c $<

y.tab.c y.tab.h: exp.y
	bison -y -d exp.y

lex.yy.c: exp.l y.tab.h 
	flex exp.l

.PHONY: clean
clean:
	rm -f *.o y.tab.c y.tab.h lex.yy.c
