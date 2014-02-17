%{

%}

%token id num 
%start B

%%

B : B "&&" A
  | B "||" A
  | A

A : A "==" E
  | A '>' E
  | A '<' E
  | E

E : E '+' T
  | E '-' T
  | T

T : T '*' F
  | T '/' F
  | F

F : id
  | num
  | '(' E ')'

%%
