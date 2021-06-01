%{
%}
%lex
%options case-insensitive

integer [0-9]+
double {integer}"."{integer}

%%
\s+                         /* skip whitespace */

{double}                    return 'Number_Literal'
{integer}                   return 'Number_Literal'
"*"                         return '*'
"/"                         return '/'
"+"                         return '+'
"-"                         return '-'
"("                         return '('
")"                         return ')'
<<EOF>>                     return 'EOF'

/lex

%start START

%%

START : SUM EOF         { $$ = $1; console.log($1); return $$; }
    ;

SUM : SUM '+' SUM       { $$ = $1 + $3; }
    | SUM '-' SUM       { $$ = $1 - $3; }
    | MULT              { $$ = $1; }
    ;

MULT : MULT '*' MULT    { $$ = $1 * $3; }
    |  MULT '/' MULT    { $$ = $1 / $3; }
    | VAL
    ;

VAL : '(' SUM ')'       { $$ = $2; }
    | Number_Literal    { $$ = Number($1); }
    ;

/*
    Para utilizarlo hay que compilarlo con el comando "jison nombreArchivo.jison".
    Usando una función que genera.
*/