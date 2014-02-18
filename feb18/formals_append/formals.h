#ifndef FORMALS_H
#define FORMALS_H

typedef struct TYPE {
	enum {t_int, t_bool} type;
} TYPE;

typedef struct FORMAL {
	struct TYPE *type;
	struct FORMAL *next;
	char *name;
} FORMAL;

TYPE *makeTYPEint();
TYPE *makeTYPEbool();
FORMAL *makeFORMAL(TYPE *type, char *name);
void prettyTYPE(TYPE *t);
void prettyFORMAL(FORMAL *f);

#endif
