%{
#include <stdio.h>

char * tag;
%}


%x TAGS
%x TAG

%%
#TAG:   		{printf("<tags>\n");BEGIN TAGS;}
    		
<TAGS>tag:\{ 	{BEGIN TAG;}
<TAGS>\n 		{printf("\n</tags>\n"); BEGIN INITIAL;}

<TAG>\}   		{BEGIN TAGS;}  
<TAG>[^}]+ 		{printf("<tag>%s</tag>", yytext);}
%%

int yywrap(){
    return 1;
}

int main(){
    printf("Início da filtragem");
    yylex();
    printf("Fim da filtragem");
    return 0;
}


