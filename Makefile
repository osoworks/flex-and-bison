all: fb3-1

fb3-1: fb3-1.l fb3-1.y fb3-1.h fb3-1funcs.c
	bison -d fb3-1.y
	flex -o fb3-1.lex.c fb3-1.l
	gcc -o $@ fb3-1.tab.c fb3-1.lex.c fb3-1funcs.c -lm

clean:
	rm -f fb3-1 fb3-1.tab.c fb3-1.tab.h fb3-1.lex.c

.SILENT : clean
