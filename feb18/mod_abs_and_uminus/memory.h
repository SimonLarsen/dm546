#ifndef MEMORY_H
#define MEMORY_H

#include <stdlib.h>

void *checked_malloc(size_t n);

#define NEW(type) (type *)checked_malloc(sizeof(type))

#endif
