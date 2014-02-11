%{
#include <stdio.h>
%}

%option noyywrap

%%
"idiot"		{ printf("intellectually challenged person"); }
%%

int main() {
	yylex();
}
