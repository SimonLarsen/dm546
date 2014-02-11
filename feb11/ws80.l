%{
int c = 0;	
#include <stdio.h>
%}

%option noyywrap

%%
[ \t]+		{ /* Ignore */ }
\n			{
		      c = 0;
              printf("\n");
			}
.			{
			  if(c >= 80) {
				  c = 0;
				  printf("\n");
			  }
			  printf("%s",yytext);
			  c++;
			}
%%

main() {
	yylex();
}
