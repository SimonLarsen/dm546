%{
#include <stdlib.h>
#include <stdio.h>

#include "formals.h"

extern char *yytext;
extern FORMAL *theformal;

void yyerror() {
	printf("syntax error before %s\n", yytext);
	exit(1);
}

FORMAL *append_formal(FORMAL *list, FORMAL *new) {
	FORMAL *p = list;
	while(p->next != NULL) {
		p = p->next;
	}
	p->next = new;
	return list;
}

%}

%union {
	char *stringconst;
	struct FORMAL *formal;
	struct TYPE *type;
}

%token <stringconst> tIDENTIFIER
%token <type> tINT tBOOL

%type <formal> formals neformals formal
%type <type> type

%start start

%%

start : formals
	    { theformal = $1; }

formals : /* empty */
		  { $$ = NULL; }
		| neformals
		  { $$ = $1; }

neformals : formal
		    { $$ = $1; }
		  | neformals ',' formal
		    {
				$$ = append_formal($1, $3);
			}


formal : type tIDENTIFIER
	     { $$ = makeFORMAL($1, $2); }

type : tINT
	   { $$ = makeTYPEint(); }
	 | tBOOL
	   { $$ = makeTYPEbool(); }

%%
