%{ 
%}

%start S
%token id

%nonassoc "do"
%right ":="
%left '+'

%%

S : E

E : "while" E "do" E
  | id ":=" E
  | E '+' E
  | id

%%
