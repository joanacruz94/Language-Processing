%option noyywrap
%{
     FILE *out;
     Palavra lookup(Dicionario dic, char *p);
%}

SPACE ([ \n\t]+)
NOME ([a-zA-Z]|[áàâãéèêíóôúçñÁÀÂÃÉÈÍÓÔÕÚÇ]|[0-9])

%%
{NOME}+             {
                         Palavra p = lookup(dic,yytext);
                         if( p ){
                              underlineRef(yytext,p->trd);
                              set_ref(p);
                         }
                         else
                              fprintf(out,"%s",yytext);
                    }
%%

void underlineRef(char *pt, char *en){
      fprintf(out,"\\underline{%s}\\footnote{%s}",pt,en);
}

void latex(int argc, char **argv){
     char input[500], output[500];
     for(i = 0; i < argc; i++){
          
     }
}
