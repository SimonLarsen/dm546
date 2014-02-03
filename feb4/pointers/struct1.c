#include <stdio.h>

typedef struct {
	int val;
} stuff;

void change(stuff x) {
	x.val = 123;
}

int main() {
	stuff x;
	x.val = 42;
	
	change(x);
	printf("x.val = %d\n", x.val);

	return 0;
}
