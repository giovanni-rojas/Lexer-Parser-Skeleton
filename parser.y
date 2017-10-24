%{
    #include <cstdlib>
    #include <cstdio>
    #include <iostream>

    #define YYDEBUG 1

    int yylex(void);
    void yyerror(const char *);
%}

%error-verbose

/* WRITEME: List all your tokens here */

%token T_PLUS
%token T_MINUS
%token T_MULTIPLY
%token T_DIVIDE
%token T_EQUAL
%token T_EQEQUAL
%token T_LESS
%token T_LESSEQ
%token T_SEMIC
%token T_COLON
%token T_ARROW
%token T_LEFTPAREN
%token T_RIGHTPAREN
%token T_LEFTBRACK
%token T_RIGHTBRACK
%token T_COMMA
%token T_AND
%token T_OR
%token T_IF
%token T_ELSE
%token T_TRUE
%token T_FALSE
%token T_PRINT
%token T_RETURN
%token T_FOR
%token T_INT
%token T_BOOL
%token T_NEW
%token T_NOT
%token T_NONE
%token T_DOT
%token T_ID
%token T_DOT
%token T_ID
%token T_INTVALUE
%token T_EOF
%token T_UMINUS


/* WRITEME: Specify precedence here */

%left T_AND
%left T_OR
%left T_LESS T_LESSEQ T_EQEQUAL
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE
%right T_NOT T_UMINUS
%%

/* WRITEME: This rule is a placeholder, since Bison requires
            at least one rule to run successfully. Replace
            this with your appropriate start rules. */

Start : Classes
      ;

/* WRITME: Write your Bison grammar specification here */

Classes : Classes Class | Class
	;

Class : T_ID T_COLON T_ID T_LEFTBRACK Members Methods T_RIGHTBRACK
	| T_ID T_LEFTBRACK Members Methods T_RIGHTBRACK
	;

Members : Members Member |
	;

Member : Type T_ID

Methods : Methods Method |
	;

Method : T_ID T_LEFTPAREN Args T_RIGHTPAREN T_COLON ReturnT T_LEFTBRACK Body T_RIGHTBRACK
	| T_ID T_LEFTPAREN Args T_RIGHTPAREN T_ARROW ReturnT T_LEFTBRACK Body T_RIGHTBRACK
	;

Args : Arg |
	;

Arg : Arg T_COMMA Argument | Argument
	;

Argument : Type T_ID
	;


ReturnT : Type | T_NONE

Body : Declarations Statements Return
	;

Declarations : Declarations Type Declaration
	;

Declaration :

Statements :

Statement :

Assignment :

IfElse :

ForLoop : 

Block : 

Return :

Expr : Expr T_PLUS Expr | 

MethodCall : 

Parameters :

Parameter : 

%%

extern int yylineno;

void yyerror(const char *s) {
  fprintf(stderr, "%s at line %d\n", s, yylineno);
  exit(1);
}
