#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>
#include "fb3-2.h"

/* symbol table */
struct symbol symtab[NHASH];

/* hash a symbol */
static unsigned symhash(char *sym) {
    unsigned int hash = 0;
    unsigned c;

    while (c = *sym++) hash = hash*9 ^ c;

    return hash;
}

struct symbol *lookup(char* sym) {
    struct symbol *sp = &symtab[symhash(sym) % NHASH];
    int scount = NHASH; /* how many have we looked at */

    while (--scount >= 0) {
        if (sp->name && !strcmp(sp->name, sym)) { return sp; }

        if (!sp->name) { /* new entry */
            sp->name = strdup(sym);
            sp->value = 0;
            sp->func = NULL;
            sp->syms = NULL;
            return sp;
        }

        if (++sp >= symtab+NHASH) sp = symtab; /* try the next entry */
    }
    yyerror("symbol table overflow\n");
    abort(); /* tried them all, table is full */
}

/* ... (rest of the functions) */
