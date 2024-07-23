%{
#include "fb1-6.tab.h"
%}

%%
"+"	{ return ADD; }
"-"	{ return SUB; }
"*"	{ return MUL; }
"/"	{ return DIV; }
"|"	{ return ABS; }
"("	{ return OP; }
")"	{ return CP; }
[0-9]+	{ yylval.intval = atoi(yytext); return NUMBER; }
\n	{ return NEWLINE; }
[ \t]	{ /* ignore whitespace */ }
.	{ printf("Mystery character %c\n", *yytext); }
%%
