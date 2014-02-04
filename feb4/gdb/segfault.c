#include <stdio.h>

int foo(int *a, int *b) {
	return (*a)*(*b);
}

int bar(int *a, int *b) {
	return (*a)-(*b);
}

int baz(int *a, int *b) {
	return (*a)+(*b);
}

int work(int *a, int *b, int *c) {
	return foo(a,b)*bar(a,c)*baz(b,c);
}

int main() {
	int a, b, c;
	a = 1;
	b = 2;
	c = 3;

	int *x, *y,* z;
	x = &a;
	y = &b;
	z = 0;

	int res = work(x, y, z);
	printf("res = %d\n", res);

	return 0;
}
