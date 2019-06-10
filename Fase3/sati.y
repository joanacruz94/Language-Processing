%{
     extern int yylex();
     extern int yylineno;
     extern char *yytext;
     void yyerror(char*);

     #include <stdlib.h>
     #include <stdio.h>
     #include <string.h>
     #include <ctype.h>

/* Estruturas de dados */
     typedef struct sinonimos{
          char *nome;
          struct sinonimos *next;
     }*Sinonimos;

     typedef struct palavra{
          char *nome;
          char *def;
          char *trd;
          Sinonimos sin;
          int ref;
     }*Palavra;

     typedef struct dicionario{
          Palavra pal;
          struct dicionario *next;
     }*Dicionario;

/* Prototipos */
     Palavra create_word();
     void add_name(Palavra p, char *name);
     void add_name(Palavra p, char *name);
     void add_def(Palavra p, char *def);
     void add_trd(Palavra p, char *trd);
     void add_sin(Palavra p, char *sin);
     Dicionario insert_word(Dicionario dic, Palavra p);
     Palavra lookup(Dicionario dic, char *p);

     Dicionario dic = NULL;
     Palavra pal = NULL;
%}

%union{
  char* texto;
}
%token DEF SIN TRD WORD
%type<texto> DEF SIN TRD WORD NOME ARGUMENTO

%%

/* ----------------------------- Gramatica ---------------------------------- */


DICIONARIO : PALAVRAS
           ;
PALAVRAS   : PALAVRAS PALAVRA                {dic = insert_word(dic,pal);}
           |
           ;
PALAVRA    : NOME ARGUMENTOS
           ;
NOME       : WORD                            {pal = create_word() ; add_name(pal,$1);}
           ;
ARGUMENTOS : ARGUMENTOS ARGUMENTO
           |
           ;
ARGUMENTO  : DEF                             {add_def(pal,$1);}
           | TRD                             {add_trd(pal,$1);}
           | SIN                             {add_sin(pal,$1);}
           ;

%%
/* ------------------------------ Codigo ------------------------------------ */

Palavra create_word(){
     Palavra p = malloc(sizeof(struct palavra));
     p->nome = NULL;
     p->def  = NULL;
     p->trd  = NULL;
     p->sin  = NULL;
     p->ref  = 0;

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

/* Palavra mencionada */
void set_ref(Palavra p){
     p->ref = 1;
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

/* --------------------------------- Latex -----------------------------------*/

void initLatex(FILE *f){
     fprintf(f,"\\documentclass{article}\n");
     fprintf(f,"\\usepackage[bottom]{footmisc}\n\n");
     fprintf(f,"\\begin{document}\n");
}

/* ---------------------------------- Main -----------------------------------*/


void yyerror(char *error){
  fprintf(stderr, "ERROR : %s \n", error);
}

void parseDic(char* texto){
  char in[500];
  sprintf(in, "%s", texto);
  yyin = fopen(in, "r");
  yyparse();
}
