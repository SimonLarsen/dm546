#include "formals.h"

FORMAL *theformal;

int main() {
	yyparse();
	prettyFORMAL(theformal);
	return 0;
}
