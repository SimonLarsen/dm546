%{
#include "y.tab.h"
%}

%option noyywrap

%%

[ \t]+						/* Ignore */

"int"						{ return tINT; }
"bool"						{ return tBOOL; }
","							{ return ','; }

[a-zA-Z_][a-zA-Z0-9_]*		{ yylval.stringconst = (char *)malloc(strlen(yytext)+1);
							  strcpy(yylval.stringconst, yytext);
							  return tIDENTIFIER; }

.							{ yyerror(); }

%%
