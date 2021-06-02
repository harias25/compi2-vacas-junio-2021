/* Definición Léxica */
%lex

%options case-insensitive

escapechar                          [\'\"\\bfnrtv]
escape                              \\{escapechar}
acceptedcharsdouble                 [^\"\\]+
stringdouble                        {escape}|{acceptedcharsdouble}
stringliteral                       \"{stringdouble}*\"

acceptedcharssingle                 [^\'\\]
stringsingle                        {escape}|{acceptedcharssingle}
charliteral                         \'{stringsingle}\'

BSL                                 "\\".
%s                                  comment
%%

"//".*                              /* skip comments */
"/*"                                this.begin('comment');
<comment>"*/"                       this.popState();
<comment>.                          /* skip comment content*/
\s+                                 /* skip whitespace */

"print"                     return 'print';
"null"                      return 'null';
"true"                      return 'true';
"false"                     return 'false';

"+"                         return 'plus';
"-"                         return 'minus';
"*"                         return 'times';
"/"                         return 'div';
"%"                         return 'mod';
"^^"                        return 'pow';

";"                         return 'semicolon';
"("                         return 'lparen';
")"                         return 'rparen';


"&&"                                return 'and';
"||"                                return 'or';
"!"                                 return 'not';

/* Number literals */
(([0-9]+"."[0-9]*)|("."[0-9]+))     return 'DoubleLiteral';
[0-9]+                              return 'IntegerLiteral';

[a-zA-Z_][a-zA-Z0-9_ñÑ]*            return 'identifier';

{stringliteral}                     return 'StringLiteral'
{charliteral}                       return 'CharLiteral'

//error lexico
.                                   {
                                        console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column);
                                    }

<<EOF>>                     return 'EOF'

/lex

//SECCION DE IMPORTS
%{
    const {Print} = require("../Instrucciones/Primitivas/Print");
    const {Primitivo} = require("../Expresiones/Primitivo");
%}

// DEFINIMOS PRESEDENCIA DE OPERADORES
%left 'or'
%left 'and'
%left 'plus' 'minus'
%left 'times' 'div' 'mod'
%left 'pow'
%left 'not'
%left UMINUS

%left 'lparen' 'rparen'


// DEFINIMOS PRODUCCIÓN INICIAL
%start START

%%


/* Definición de la gramática */
START : INSTRUCCIONES EOF         { $$ = $1; return $$; }
    ;

INSTRUCCIONES:
    INSTRUCCIONES INSTRUCCION                                                                                           {
                                                                                                                            $1.push($2);
                                                                                                                            $$ = $1;
                                                                                                                        }
	| INSTRUCCION                                                                                                       {
                                                                                                                            $$ = [$1];
                                                                                                                        } ;

INSTRUCCION:
    PRINT semicolon                                                                                                     {
                                                                                                                            $$ = $1
                                                                                                                        };

PRINT:
    print lparen EXPR rparen                                                                                            {
                                                                                                                            $$ = new Print($3, @1.first_line, @1.first_column);
                                                                                                                        } ;

EXPR:
    IntegerLiteral                                                                                                    {
                                                                                                                            $$ = new Primitivo(Number($1), @1.first_line, @1.first_column);
                                                                                                                        }

    | DoubleLiteral                                                                                                     {
                                                                                                                            $$ = new Primitivo(Number($1), @1.first_line, @1.first_column);
                                                                                                                        }

    | StringLiteral                                                                                                     {
                                                                                                                            $$ = new Primitivo($1, @1.first_line, @1.first_column);
                                                                                                                        }

    | CharLiteral                                                                                                       {
                                                                                                                            $$ = new Primitivo($1, @1.first_line, @1.first_column);
                                                                                                                        }

    | null                                                                                                             {
                                                                                                                            $$ = new Primitivo(null, @1.first_line, @1.first_column);
                                                                                                                        }

    | true                                                                                                             {
                                                                                                                            $$ = new Primitivo(true, @1.first_line, @1.first_column);
                                                                                                                        }

    | false                                                                                                            {
                                                                                                                            $$ = new Primitivo(false, @1.first_line, @1.first_column);
                                                                                                                       };