%option yylineno
%pointer

%{
    #include <cstdlib>
    #include <cerrno>
    #include <climits>
    #include <limits>
    #include "parser.hpp"
    #include <stdio.h>

    void yyerror(const char *);
%}

/* WRITEME: Write any definitions here. You can find information on
            definitions here:
            http://flex.sourceforge.net/manual/Definitions-Section.html */

/* WRITEME: If you are going to use start conditions, write them here.
            You can find more information on start conditions here:
            http://flex.sourceforge.net/manual/Start-Conditions.html
            You will probably want to use exclusive conditions rather
            than inclusive conditions (use the %x instead of the %s). */

%%

  /* WRITEME: Write your Flex token rules here */

"//".*            ;
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]      ;
[ \t\n]           ; 
"+"               { return T_PLUS; }
"-"               { return T_MINUS; }
"*"               { return T_MULTIPLY; }
"/"               { return T_DIVIDE; }
"="               { return T_EQUAL; }
"=="              { return T_EQEQUAL; }
"<"               { return T_LESS; }
"<="              { return T_LESSEQ; }
";"               { return T_SEMIC; }
":"               { return T_COLON; }
"->"              { return T_ARROW; }
"("               { return T_LEFTPAREN; }
")"               { return T_RIGHTPAREN; }
"{"               { return T_LEFTBRACK; }
"}"               { return T_RIGHTBRACK; }
","               { return T_COMMA; }
"and"             { return T_AND; }
"or"              { return T_OR; }
"if"              { return T_IF; }
"else"            { return T_ELSE; }
"while"           { return T_WHILE; }
"do"              { return T_DO; }
"true"            { return T_TRUE; }
"false"           { return T_FALSE; }
"print"           { return T_PRINT; }
"return"          { return T_RETURN; }
"for"             { return T_FOR; }
"int"             { return T_INT; }
"bool"            { return T_BOOL; }
"new"             { return T_NEW; }
"not"             { return T_NOT; }
"none"            { return T_NONE; }
"."               { return T_DOT; }
[a-zA-Z][a-zA-Z0-9]*     { return T_ID; }
0|[1-9][0-9]*            { return T_INTVALUE; }
.                 { yyerror("invalid character"); }
%%

int yywrap(void) {
  return 1;
}
