#ifndef FB3_2_H
#define FB3_2_H

#define NHASH 9997
#define MULTIPLIER 31

extern int yylineno;
void yyerror(const char *s, ...);

/* nodes in the abstract syntax tree */

struct ast {
    int nodetype;
    struct ast *l;
    struct ast *r;
};

struct numval {
    int nodetype;
    double number;
};

struct symref {
    int nodetype;
    struct symbol *s;
};

struct symasgn {
    int nodetype;
    struct symbol *s;
    struct ast *v;
};

/* define symbol table */

struct symbol {
    char *name;
    double value;
    struct ast *func;       /* ast for the function */
    struct symlist *syms;   /* list of dummy args */
};

struct symlist {
    struct symbol *sym;
    struct symlist *next;
};

extern struct symbol symtab[NHASH];
struct symbol *lookup(char *sym);
void symlistfree(struct symlist *sl);
struct symlist *newsymlist(struct symbol *sym, struct symlist *next);

struct ast *newast(int nodetype, struct ast *l, struct ast *r);
struct ast *newnum(double d);
struct ast *newref(struct symbol *s);
struct ast *newasgn(struct symbol *s, struct ast *v);
double eval(struct ast *a);
void treefree(struct ast *a);

struct ast *newfunc(struct symbol *s, struct symlist *syms, struct ast *body);
double callbuiltin(struct fncall *f);
double calluser(struct ufncall *f);

#endif
