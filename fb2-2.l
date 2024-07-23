%{
#include <stdio.h>
#include <stdlib.h>

int word_count = 0;
int line_count = 0;
int char_count = 0;
%}

%%
[a-zA-Z]+	{ word_count++; }
\n		{ line_count++;	}
.		{ char_count++; }
%%

int main(int argc, char **argv)
{
	if (argc > 1) {
		for (int i = 1; i < argc; i++) {
			FILE *file = fopen(argv[i], "r");
			if (!file) {
				perror(argv[i]);
				continue;
			}
			yyin = file;
			yylex();
			fclose(file);
		}
		printf("Words: %d, Lines: %d, Characters: %d\n", word_count, line_count, char_count);
	} else {
		fprintf(stderr, "Usage: %s <file1> <file2> ...\n", argv[0]);
	}
	return 0;
}

int yywrap() {
	return 1;
}
