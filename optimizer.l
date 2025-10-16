%{
#include "y.tab.h"
#include <string.h>
int yylex(void);
%}

%%

[0-9]+        { yylval.str = strdup(yytext); return NUMBER; }
[a-zA-Z]+     { yylval.str = strdup(yytext); return ID; }
[ \t]         ;             /* ignore spaces and tabs */
\n            { return '\n'; }
.             { return yytext[0]; }   /* return any other character */

%%

int yywrap() { return 1; }