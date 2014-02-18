%{
#include <stdio.h>
#include "tree.h"

extern char *yytext;
extern EXP *theexpression;

void yyerror() {
   printf("syntax error before %s\n",yytext); 
}
%}

%union {
   int intconst;
   char *stringconst;
   struct EXP *exp;
}

%token <intconst> tINTCONST
%token <stringconst> tIDENTIFIER 

%type <exp> program exp

%start program

%left '+' '-'
%left '*' '/' '%'
%left UMINUS

%% 
program: exp
         { theexpression = $1;}
;

exp : tIDENTIFIER
      {$$ = makeEXPid($1);}
    | tINTCONST
      {$$ = makeEXPintconst($1);}
    | exp '*' exp
      {$$ = makeEXPtimes($1,$3);}
    | exp '/' exp
      {$$ = makeEXPdiv($1,$3);}
    | exp '+' exp
      {$$ = makeEXPplus($1,$3);}
    | exp '-' exp
      {$$ = makeEXPminus($1,$3);}
	| exp '%' exp
	  {$$ = makeEXPmodulo($1,$3);}
    | '(' exp ')'
      {$$ = $2;}
	| '|' exp '|'
	  {$$ = makeEXPabs($2);}
	| '-' exp	%prec UMINUS
	  {$$ = makeEXPminus(makeEXPintconst(0), $2);}
;

%%
