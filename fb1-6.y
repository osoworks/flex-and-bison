%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
	int intval;
}

%token <intval> NUMBER
%token ADD SUB MUL DIV ABS OP CP NEWLINE

%type <intval> exp term factor

%%

calclist: /* nothing */
	| calclist exp NEWLINE { printf("= %d\n", $2); }
	;

exp:	term
   	| exp ADD term { $$ = $1 + $3; }
	| exp SUB term { $$ = $1 - $3; }
	;

term:	factor
    	| term MUL factor { $$ = $1 * $3; }
	| term DIV factor { $$ = $1 / $3; }
	;

factor:	NUMBER
      	| ABS factor { $$ = abs($2); }
	| OP exp CP { $$ = $2; }
	| SUB factor { $$ = -$2; }
	;
%%

void yyerror(const char *s) {
	fprintf(stderr, "error: %s\n", s);
}

int main(void) {
	return yyparse();
}
