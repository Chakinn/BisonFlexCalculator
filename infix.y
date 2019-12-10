%{
    #include <stdio.h>
    #include <math.h>
    #include <setjmp.h>
    #include "queue.c"
    void yyerror (char const *);
    extern int yylex();
    extern int yyparse();
    

    struct Queue* queue; 

    void yyerror(const char* s);
    jmp_buf jbuf;
    extern void skipLine();

    int mdiv(int a, int b);
    int mmod(int a, int b);
%}



%token NUM
%left '-' '+'
%left '*' '/' '%'
%precedence NEG 
%right '^'    

%%
input:
  %empty
  | input line
;


line:
  '\n'
| exp '\n'  { printAll(queue); printf ("\nWynik: %d\n", $1); }
| error '\n' {yyerrok;}
;

exp:
  NUM               { enQueue(queue,{$1,0});}
| exp '+' exp       { $$ = $1 + $3; enQueue(queue,{'+',1});}
| exp '-' exp       { $$ = $1 - $3; enQueue(queue,{'-',1});     }
| exp '*' exp       { $$ = $1 * $3; enQueue(queue,{'*',1});     }
| exp '/' exp       {
                        if($3==0) {
                            longjmp(jbuf,1);
                        }
                        $$ = mdiv($1,$3);
                        enQueue(queue,{'/',1});     
                    }
| exp '%' exp       {
                        if($3==0) {
                            longjmp(jbuf,1);
                        }
                        $$ = mmod($1,$3);
                        enQueue(queue,{'%',1});     
                     }
| '-' exp  %prec NEG { $$ = -$2; enQueue(queue,{'~',1});         }
| exp '^' exp       { $$ = pow ($1, $3); enQueue(queue,{'^',1}); }
| '(' exp ')'       { $$ = $2;}
;
%%


int main(int argc, char** args) {
    queue = createQueue();
    if(setjmp(jbuf)!=0) {
        yyerror("Nie dziel przez 0");
    }
    yyparse();
}

void yyerror(const char* s) {
    clearQueue(queue);
    printf("%s\n",s);
    //skipLine();
}

int mdiv(int a, int b) {
    if(b>0 && a>=0 || b<0 && a<0) {
        return a/b;
    }
    else {
        int temp = a/b;
        if(temp*b!=a) {
            return temp-1;
        }
    }
}

int mmod(int a, int b) {
    if(b>0) {
        if(a>=0) {
            return a%b;
        }
        else {
            int q = mdiv(a,b);
            return a-q*b;
        }
    }
    else {
        if(a<0) {
            return -(a%b);
        }
        else {
            int q = mdiv(a,b);
            return a-q*b;
        }
    }

    //int q = mdiv(a,b);
    //return a-q*b;
}


