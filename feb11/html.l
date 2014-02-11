%{
#include <stdio.h>
%}

%option noyywrap

%%
"<"[^>]+">" 		{ /* Ignore */ }
%%

main() {
	yylex();
}
