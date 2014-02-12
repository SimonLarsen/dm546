#include <stdio.h>
#include "memory.h"

void *checked_malloc(size_t size) {
	void *p = malloc(size);
	if(!p) {
		fprintf(stderr, "malloc(%d) failed.\n", size);
		exit(1);
	}
	return p;
}
