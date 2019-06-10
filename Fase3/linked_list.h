#ifndef _LINKED_LIST_H_
#define _LINKED_LIST_H_

typedef struct sinonimos{
     char *nome;
     struct sinonimos *next;
}*Sinonimos;

typedef struct palavra{
     char *nome;
     char *def;
     char *trd;
     Sinonimos sin;
}*Palavra;

typedef struct dicionario{
     Palavra pal;
     struct dicionario *next;
}*Dicionario;

#endif
