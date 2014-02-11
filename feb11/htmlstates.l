%{
#include <stdio.h>
%}

%option noyywrap

%x TAG

%%

"<"                { BEGIN TAG; }
<TAG>">"           { BEGIN INITIAL; }
<TAG>.             { /* Ignore */ }

%%
main() {
	yylex();
}
