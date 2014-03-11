/*
 * Eksempel på simpel jump table implementering.
 * Ækvivalent med følgende:
 *
 * switch(i) {
 *     case 0: printf("stm0\n"); break;
 *     case 1: printf("stm1\n"); break;
 *     case 2: printf("stm2\n"); break;
 * }
 */

#include <stdio.h>

void func0(void) {
	printf("stm0\n");
}

void func1(void) {
	printf("stm1\n");
}
void func2(void) {
	printf("stm2\n");
}

void (*jump_table[3])(void) = {func0, func1, func2};

int main() {
	int i = 2;

	jump_table[i]();

	return 0;
}
