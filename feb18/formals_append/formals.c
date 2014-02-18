#include "formals.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

TYPE *makeTYPEint() {
	TYPE *t = malloc(sizeof(TYPE));
	t->type = t_int;
	return t;
}

TYPE *makeTYPEbool() {
	TYPE *t = malloc(sizeof(TYPE));
	t->type = t_bool;
	return t;
}

FORMAL *makeFORMAL(TYPE *type, char *name) {
	FORMAL *f = malloc(sizeof(FORMAL));
	f->type = type;
	f->name = malloc(strlen(name)+1);
	strcpy(f->name, name);
	f->next = NULL;
	return f;
}

void prettyTYPE(TYPE *t) {
	if(t->type == t_int) {
		printf("int");
	} else {
		printf("bool");
	}
}
void prettyFORMAL(FORMAL *f) {
	while(f != NULL) {
		prettyTYPE(f->type);
		printf(" %s", f->name);
		if(f->next != NULL) printf(", ");
		f = f->next;
	}
}
