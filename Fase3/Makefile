CC=gcc

install: sati.l sati.y
	flex sati.l
	yacc -d sati.y
	$(CC) -o sati y.tab.c lex.yy.c

.PHONY: clean

clean:
	rm sati y.tab.c y.tab.h lex.yy.c
