/*English -> American*/
%%
"colour" { printf("color"); }
"flavour" { printf("flavor"); }
"clever" { printf("smart"); }
"smart"	{ printf("elegant"); }
"conservative"	{ printf("Liberal"); }

. { printf("%s", yytext); }
%%
