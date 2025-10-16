%{ 
#include <stdio.h> 
#include <stdlib.h> 
#include <string.h> 
#include <ctype.h> 
char* make_str(const char *s) { 
char *buf = malloc(100); 
strcpy(buf, s); 
return buf; 
} 
int is_number(const char *s) { 
for (int i = 0; s[i]; i++) { 
if (!isdigit(s[i])) return 0; 
} 
return 1; 
} 
int yylex(void); 
int yyerror(char *s); 
%} 
%union { 
char* str; 
} 
%token <str> NUMBER ID 
%type <str> expr 
%left '+' '-' 
%left '*' '/' 
%left UMINUS 
%% 
program: 
       program stmt 
     |  
     ; 
 
stmt: expr '\n'   { printf("Optimized Expression: %s\n", $1); } 
    ; 
 
expr: expr '+' expr   { 
                        if(is_number($1) && is_number($3)) {  
                            int val = atoi($1) + atoi($3); 
                            char buf[50]; sprintf(buf,"%d",val); 
                            $$ = make_str(buf); 
                        } 
                        else if(strcmp($1,"0")==0) $$=$3; 
                        else if(strcmp($3,"0")==0) $$=$1; 
                        else { 
                            char buf[100]; sprintf(buf,"%s+%s",$1,$3); 
                            $$ = make_str(buf); 
                        } 
                      } 
    | expr '-' expr   { 
                        if(is_number($1) && is_number($3)) { 
                            int val = atoi($1) - atoi($3); 
                            char buf[50]; sprintf(buf,"%d",val); 
                            $$ = make_str(buf); 
                        } 
                        else if(strcmp($3,"0")==0) $$=$1; 
                        else { 
                            char buf[100]; sprintf(buf,"%s-%s",$1,$3); 
                            $$ = make_str(buf); 
                        } 
                      } 
    | expr '*' expr   { 
                        if(is_number($1) && is_number($3)) {  
                            int val = atoi($1) * atoi($3); 
                            char buf[50]; sprintf(buf,"%d",val); 
                            $$ = make_str(buf); 
                        } 
                        else if(strcmp($1,"1")==0) $$=$3; 
                        else if(strcmp($3,"1")==0) $$=$1; 
                        else if(strcmp($1,"0")==0 || 
strcmp($3,"0")==0) $$="0"; 
                        else if(strcmp($1,"2")==0) { 
                            char buf[100]; sprintf(buf,"%s<<1",$3); 
                            $$ = make_str(buf); 
                        } 
                        else if(strcmp($3,"2")==0) { 
                            char buf[100]; sprintf(buf,"%s<<1",$1); 
                            $$ = make_str(buf); 
                        } 
                        else { 
                            char buf[100]; sprintf(buf,"%s*%s",$1,$3); 
                            $$ = make_str(buf); 
                        } 
                      } 
    | expr '/' expr   { 
                        if(is_number($1) && is_number($3) && 
atoi($3)!=0) { 
                            int val = atoi($1) / atoi($3); 
                            char buf[50]; sprintf(buf,"%d",val); 
                            $$ = make_str(buf); 
                        } 
                        else if(strcmp($3,"1")==0) $$=$1; 
                        else if(strcmp($3,"2")==0) {  
                            char buf[100]; sprintf(buf,"%s>>1",$1); 
                            $$ = make_str(buf); 
                        } 
                        else { 
                            char buf[100]; sprintf(buf,"%s/%s",$1,$3); 
                            $$ = make_str(buf); 
                        } 
                      } 
    | NUMBER          { $$=$1; } 
    | ID              { $$=$1; } 
    | '-' expr %prec UMINUS { 
                        char buf[100]; sprintf(buf,"-%s",$2); 
                        $$=make_str(buf); 
                      } 
    | '(' expr ')'    { $$=$2; } 
    ; 
%% 
 
int yyerror(char *s) { 
    printf("Error: %s\n",s); 
    return 0; 
} 
 
int main() { 
    printf("Enter expressions (Ctrl+D to exit):\n"); 
    yyparse(); 
    return 0; 
}