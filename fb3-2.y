%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "fb3-2.h"
%}

%union {
    struct ast *a;
    double d;
    struct symbol *s;
    struct symlist *sl;
}

%token <d> NUMBER
%token <s> NAME
%token <s> FUNC
%token ADD SUB MUL DIV ABS ASSIGN EOL OP CP
%token CMP LET

%type <a> exp stmt stmtlist explist
%type <a> list
%type <sl> symlist

%right '='
%left ADD SUB
%left MUL DIV
%nonassoc ABS UMINUS
%nonassoc CMP

%start calclist

%%

calclist: /* nothing */
        | calclist stmt EOL {
            printf("= %4.4g\n> ", eval($2));
            treefree($2);
        }
        | calclist LET NAME OP symlist CP ASSIGN list EOL {
            dodef($3, $5, $8);
            printf("Defined %s\n> ", $3->name);
        }
        | calclist error EOL { yyerrok; printf("> "); }
        ;

stmtlist: /* empty */
        | stmtlist stmt EOL
        ;

stmt: NAME ASSIGN exp { $$ = newasgn($1, $3); }
    | exp
    ;

exp: NUMBER { $$ = newnum($1); }
    | NAME { $$ = newref($1); }
    | exp ADD exp { $$ = newast('+', $1, $3); }
    | exp SUB exp { $$ = newast('-', $1, $3); }
    | exp MUL exp { $$ = newast('*', $1, $3); }
    | exp DIV exp { $$ = newast('/', $1, $3); }
    | OP exp CP { $$ = $2; }
    | SUB exp %prec UMINUS { $$ = newast('M', $2, NULL); }
    | ABS exp { $$ = newast('|', $2, NULL); }
    | exp CMP exp { $$ = newcmp($2->nodetype, $1, $3); }  // Corrected usage
    | NAME OP explist CP { $$ = newcall($1, $3); }
    | FUNC OP explist CP { $$ = newfunc($1, $3); }
    ;

explist: /* empty */ { $$ = NULL; }
       | exp { $$ = newsymlist($1, NULL); }
       | exp ',' explist { $$ = newast('L', $1, $3); }
       ;

symlist: NAME { $$ = newsymlist($1, NULL); }
       | NAME ',' symlist { $$ = newsymlist($1, $3); }
       ;

list: stmtlist
    ;

%%

void yyerror(const char *s, ...) {
    va_list ap;
    va_start(ap, s);
    fprintf(stderr, "%d: error: ", yylineno);
    vfprintf(stderr, s, ap);
    fprintf(stderr, "\n");
    va_end(ap);
}

int main(int argc, char **argv) {
    yyparse();
    return 0;
}
