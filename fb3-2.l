%{
#include "fb3-2.h"
#include "fb3-2.tab.h"
%}

%option noyywrap nodefault yylineno

EXP     ([Ee][-+]?[0-9]+)

%%
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"="     { return ASSIGN; }
"|"     { return ABS; }
"("     { return OP; }
")"     { return CP; }
"<"     { return CMP; }
">"     { return CMP; }
"<="    { return CMP; }
">="    { return CMP; }
"=="    { return CMP; }
"!="    { return CMP; }
"let"   { return LET; }
"func"  { return FUNC; }
\n      { return EOL; }

[a-zA-Z][a-zA-Z0-9]*    { yylval.s = lookup(yytext); return NAME; }
[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}?       { yylval.d = atof(yytext); return NUMBER; }

[ \t]  /* ignore whitespace */
"//".* /* ignore comments */
.      { yyerror("Mystery character %c\n", *yytext); return 0; }
%%

int yywrap() {
    return 1;
}
