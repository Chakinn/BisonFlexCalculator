	bison -d infix.y
    g++ -c infix.tab.c -o infix.tab.o
	flex infix.l
    g++ -c lex.yy.c -o lex.yy.o
	g++ infix.tab.o lex.yy.o -o infix -lm
	cat input.txt | ./infix > output.txt