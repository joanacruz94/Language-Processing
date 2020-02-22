CC=gcc

install: jornal.l
	flex -o jornal.c jornal.l
	$(CC) -o jornal jornal.c

.PHONY: clean

clean:
	rm jornal jornal.c
