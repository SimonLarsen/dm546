%{

%}

%start S
%token id

%%

S : E

E : "while" E "do" E
  | id ":=" E
  | E '+' E
  | id

%%
