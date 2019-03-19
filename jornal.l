%{
#include <stdio.h>

char * id;
%}


%x TAGS
%x TAG
%x DATE
%x ID
%x CLEAN

%%
#TAG:   		{printf("<tags>\n");BEGIN TAGS;}

<TAGS>tag:\{ 	{BEGIN TAG;}
<TAGS>\n 		{printf("\n</tags>\n"); BEGIN INITIAL;}

<TAG>\}   		{BEGIN TAGS;}  
<TAG>[^}]+ 		{printf("<tag>%s</tag>", yytext);}

#DATE:			{printf("<author_date>"); BEGIN DATE;}
<DATE>"[116eb]"/[^\n]+ 		{}
<DATE>\n 		{printf("</author_date>\n"); BEGIN INITIAL;}

Nacional		{printf("<category>%s</category>", yytext);}

2015[^\n]+\n_	{printf("<title>%s</title>", yytext);}

2015[^_<]+	{printf("<text>\n%s</text>\n", yytext); }	

(_)+\n[A-Z ]+:	{printf("Nada");}

#ID:\{			{BEGIN ID;}
<ID>[^ ]+		{id = strdup(yytext); BEGIN CLEAN;}

<CLEAN>[^}]+\}	{BEGIN INITIAL;}	

\<pub\>			{yytext[yyleng-1] = '\0'; printf("%s %s>", yytext, id) ;}

"Etiquetas:"[^\n]+	{printf("limpo");}

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

