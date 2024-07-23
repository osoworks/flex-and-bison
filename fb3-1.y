/* fb3-1.y: Bison parser for arithmetic expressions */

%{
#include <stdio.h>
#include <stdlib.h>
#include "fb3-1.h"
int yylex(void);
void yyerror(const char *s, ...);
%}

%union {
	struct ast *a;
	double d;
}

%token <d> NUMBER
%token ADD SUB MUL DIV ABS OP CP EOL
%type <a> exp

%left ADD SUB
%left MUL DIV
%right NEG
%right ABS

%%
calclist: %empty
	| calclist exp EOL	{ printf("= %4.4g\n", eval($2)); treefree($2); printf("> "); }
	| calclist EOL		{ printf("> "); }
	;

exp:	exp ADD exp	{ $$ = newast('+', $1, $3); }
	| exp SUB exp	{ $$ = newast('-', $1, $3); }
	| exp MUL exp	{ $$ = newast('*', $1, $3); }
	| exp DIV exp	{ $$ = newast('/', $1, $3); }
	| NUMBER	{ $$ = newnum($1); }
    	| ABS exp	{ $$ = newast('|', $2, NULL); }
	| OP exp CP	{ $$ = $2; }
	| SUB exp %prec NEG	{ $$ = newast('M', $2, NULL); }
%%

int main(void) {
	printf("> ");
	return yyparse();
}

void yyerror(const char *s, ...) {
	fprintf(stderr, "error: %s\n", s);
}
