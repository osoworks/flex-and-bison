%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
[a-zA-Z]+	{ printf("WORD: %s\n", yytext); }
\n		{ printf("NEWLINE\n"); }
.		{ }
%%

int main(int argc, char **argv){
	if (argc > 1) {
		FILE *file = fopen(argv[1], "r");
		if (!file) {
			perror(argv[1]);
			return 1;
		}
		yyin = file;
		yylex();
		fclose(file);
	} else {
		yylex();
	}
	return 0;
}

int yywrap()	
{
	return 1;
}
