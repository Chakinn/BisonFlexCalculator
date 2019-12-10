%{
    #include <stdlib.h>
    #include "infix.tab.h"
    #include <ctype.h>
%}

%option noyywrap

%%
[ \t]
.*[\\]\n {
    char* yycopy = strdup(yytext);
    for(int i=yyleng-3; i>=0; i--) {
        unput(yycopy[i]);
    }
    free(yycopy);
}
[\#].*
[0-9]+ {
    yylval = atoi(yytext);
    return NUM;
    }
.|\n {return yytext[0];}
<<EOF>> {return 0;}
%%

void skipLine() {
    int c=getchar();
    while(c!='\n') {
        printf("%c",c);
        if(c==EOF) {
            return ;
        }
        c=getchar();
    }
}
