#include "tree.h"
#include "pretty.h"

int lineno;

void yyparse();

EXP *theexpression;

void main() {
	lineno = 1;
	yyparse();
	prettyEXP(theexpression);
}
