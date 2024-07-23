/* fb3-1.l: Flex lexer for arithmetic expressions */

%{
#include "fb3-1.tab.h"
#include "fb3-1.h"
%}

%%
[0-9]+(\.[0-9]+)?	{ yylval.d = atof(yytext); return NUMBER; }
"+"			{ return ADD; }
"-"			{ return SUB; }
"*"			{ return MUL; }
"/"			{ return DIV; }
"|"			{ return ABS; }
"("			{ return OP; }
")"			{ return CP; }
[\t]			{ /* ignore whitespace */ }
.			{ return *yytext; }
\n			{ return EOL; }
%%

int yywrap() {
	return 1;
}
