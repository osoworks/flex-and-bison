/* Declartions for a calculator fb3_1 */

#ifndef FB3_1_H
#define FB3_1_H

/*interface to the lexer */
extern int yylineo; /*from lexer*/
void yyerror(const char *s, ...);

/* nodes in the abstract syntax tree */
struct ast {
	int nodetype;
	struct ast *l;
	struct ast *r;
};

struct numval {
	int nodetype; /* type K for constant */
	double number;
};

/* build an AST */
struct ast *newast(int nodetype, struct ast *l, struct ast *r);
struct ast *newnum(double d);

/* evaluate an AST */
double eval(struct ast *);

/* delete and free an AST */
void treefree(struct ast *);

#endif
