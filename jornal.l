%{
#include <stdio.h>

char * id;
%}


%x TAGS
%x TAG
%x DATE
%x ID
%x CLEAN
%x CATEGORY
%x TITLE
%x TEXT

%%
\<pub\>					{yytext[yyleng-1] = '\0'; printf("%s %s>", yytext, id) ;}
"Etiquetas:"[^\n]+		{printf("limpo");}
_+\n[A-Z ]+:			{printf("Nada");}

#TAG:   				{printf("<tags>\n");BEGIN TAGS;}
<TAGS>tag:\{ 			{BEGIN TAG;}
<TAGS>\n 				{printf("\n</tags>\n"); BEGIN INITIAL;}

<TAG>\}   				{BEGIN TAGS;}  
<TAG>[^}]+ 				{printf("<tag>%s</tag>", yytext);}

#DATE:\ *\[[^]]+\]\ *   {printf("<author_date>"); BEGIN DATE;}
<DATE>[^\n]+ 		 	{printf("%s", yytext);}
<DATE>\n 			 	{printf("</author_date>\n"); BEGIN TEXT;}

<TEXT>[^<]+				{printf("<text>\n%s</text>\n", yytext); BEGIN INITIAL;}

#ID:\{					{BEGIN ID;}
<ID>[^ ]+				{id = strdup(yytext); BEGIN CLEAN;}

<CLEAN>[^}]+\}\n		{BEGIN CATEGORY;}

<CATEGORY>.+\n    		{yytext[yyleng-1] = '\0'; printf("<category>%s</category>\n", yytext); BEGIN TITLE;}

<TITLE>.+				{printf("<title>%s", yytext);}		
<TITLE>\n      		    {printf("</title>"); BEGIN INITIAL;}

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

