#include <stdio.h>

void fun(int y) {
	y = 42;
}

int main() {
	int x;
	fun(x);
	printf("%d\n", x);
	return 0;
}
