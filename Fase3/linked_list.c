#include "linked_list.h"
#include <stdlib.h>
#include <string.h>

/* Cria uma palavra */
Palavra create_word(){
     Palavra p = malloc(sizeof(struct palavra));
     p->nome = NULL;
     p->def  = NULL;
     p->trd  = NULL;
     p->sin  = NULL;

     return p;
}

/* Adiciona o nome da palavra */
void add_name(Palavra p, char *name){
     p->nome = name;
}

/* Adiciona a definicacao de uma palavra */
void add_def(Palavra p, char *def){
     p->def = def;
}

/* Adiciona a traducao em ingles de uma palavra */
void add_trd(Palavra p, char *trd){
     p->trd = trd;
}

/* Adiciona um sinonimo de um palavra */
void add_sin(Palavra p, char *sin){
     Sinonimos s = malloc(sizeof(struct sinonimos));
     s->nome = strdup(sin);
     s->next = p->sin;
     p->sin  = s;
}

/* Adiciona uma palavra ao dicionario */
Dicionario insert_word(Dicionario dic, Palavra p){
     Dicionario new = malloc(sizeof(struct dicionario));
     new->pal = p;
     new->next = dic;
     dic = new;

     return new;
}

/* Procura uma palavra no dicionario */
Palavra lookup(Dicionario dic, char *p){
     Palavra tmp = dic->pal;

     while( tmp && strcmp(tmp->nome,p) )
          tmp = dic->next->pal;

     return tmp;
}
