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
%token T_EQUALEQ
%token T_GREAT
%token T_GREATEQ
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
%token T_INT
%token T_BOOL
%token T_NEW
%token T_NOT
%token T_NONE
%token T_DOT
%token T_ID
%token T_INTVALUE
%token T_EOF
%token T_UMINUS
%token T_DO
%token T_WHILE

/* WRITEME: Specify precedence here */

%left T_OR
%left T_AND
%left T_GREAT T_GREATEQ T_EQUALEQ
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE
%right T_NOT T_UMINUS
%%

/* WRITEME: This rule is a placeholder, since Bison requires
            at least one rule to run successfully. Replace
            this with your appropriate start rules. */

Start : ClassList
	;

/* WRITME: Write your Bison grammar specification here */

ClassList : ClassList Class | Class
	;

Class : T_ID T_LEFTBRACK MemberList MethodList T_RIGHTBRACK
	;

Type : T_INT | T_BOOL | T_ID
;

MemberList : MemberList Member
	|Member
 	|%empty
	;

Member : Type T_ID 
;

MethodList : MethodList Method
	| Method	
	| %empty
	;

Method : T_ID T_LEFTPAREN Args T_RIGHTPAREN T_COLON ReturnT T_LEFTBRACK Body T_RIGHTBRACK
	| T_ID T_LEFTPAREN Args T_RIGHTPAREN T_ARROW ReturnT T_LEFTBRACK Body T_RIGHTBRACK
	;

Args : Arg | %empty
	;

Arg : Arg T_COMMA Expr | Expr 
	;

Argument : Type T_ID
	;

ReturnT : Type | T_NONE
	;

Body : Declarations Statements Return
	;

Declarations : Declarations Type Declaration | %empty
	;

Declaration : Declaration T_COMMA T_ID | T_ID
	;

Statements : Statements Statement
	;

Statement : Assignment | IfElse | DoWhile | MethodCall | T_PRINT Expr
	;

Assignment : T_ID T_EQUAL Expr | T_ID T_DOT T_ID T_EQUAL Expr
	;

IfElse : T_IF Expr T_LEFTBRACK Block T_RIGHTBRACK
| T_IF Expr T_LEFTBRACK Block T_RIGHTBRACK T_ELSE T_LEFTBRACK Block T_RIGHTBRACK
	;

DoWhile : T_WHILE Expr T_LEFTBRACK Block T_RIGHTBRACK
| T_DO T_LEFTBRACK Block T_RIGHTBRACK T_WHILE Expr
	;

Block : Block Statement | Statement | %empty
	;

Return : T_RETURN Expr
	;

Expr :  Expr T_PLUS Expr
	|	Expr T_MINUS Expr
	|	Expr T_MULTIPLY Expr
	|	Expr T_DIVIDE Expr
	|	Expr T_GREAT Expr
	|	Expr T_GREATEQ Expr
	|	Expr T_EQUALEQ Expr
	|	Expr T_AND Expr
	|	Expr T_OR Expr
	|	T_NOT Expr
	|	T_MINUS Expr %prec T_UMINUS
	|	T_ID
	|	T_ID T_DOT T_ID
	|	MethodCall
	|	T_LEFTPAREN Expr T_RIGHTPAREN
	|	T_INTVALUE
	|	T_TRUE
	|	T_FALSE
	|	T_NEW T_ID
	|	T_NEW T_ID T_LEFTPAREN Parameters T_RIGHTPAREN
	;

MethodCall : T_ID T_LEFTPAREN Args T_RIGHTPAREN
| T_ID T_DOT T_ID T_LEFTPAREN Args T_RIGHTPAREN
;

Parameters : Parameter
;

Parameter : Parameter T_COMMA Expr | Expr
;


%%

extern int yylineno;

void yyerror(const char *s) {
  fprintf(stderr, "%s at line %d\n", s, yylineno);
  exit(1);
}
