%{
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define MAXTAGPOST 20
#define MAX 10000

typedef struct ts{
     char *tag;
     int n;
}*TAG;

typedef TAG tagList[MAX];

tagList ltag;
char * tagsPost[MAXTAGPOST];
char * title;
char * id;
char * category;
char * text;
char * date;
int numberTags = 0;
int j = 0;

int search(char *tag, tagList tags ){
     int i = 0;
     int n = strlen(tag);

     while( i < MAX && tags[i] != NULL ){
          if(!strcmp(tag,tags[i]->tag)){
               (tags[i]->n)++;
               break;
          }
          else
               i++;
     }
     if( i < MAX && tags[i] == NULL){
          TAG tmp = malloc(sizeof(struct ts));
          tmp->tag = malloc(sizeof(char) * n);
          strcpy(tmp->tag,tag);
          tmp->n = 1;
          tags[i] = tmp;
          return 0;
     }
     else
          return 1;
}

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

#TAG:   				{BEGIN TAGS; numberTags = 0;}
<TAGS>tag:\{ 			{BEGIN TAG;}
<TAGS>\n 				{BEGIN INITIAL;}

<TAG>\}   				{BEGIN TAGS;}
<TAG>[^}]+ 				{tagsPost[numberTags++]=strdup(yytext); search(yytext,ltag);}

#ID:\{					{BEGIN ID;}
<ID>[^ ]+				{id = strdup(yytext); BEGIN CLEAN;}

<CLEAN>[^}]+\}\n		{BEGIN CATEGORY;}

<CATEGORY>.+\n\n    	{yytext[yyleng-1] = '\0'; category = strdup(yytext); BEGIN TITLE;}

<TITLE>.+				{title = strdup(yytext);}
<TITLE>\n      		    {BEGIN INITIAL;}

#DATE:\ *\[[^]]+\]\ *   {BEGIN DATE;}
<DATE>[^\n]+ 		 	{date = strdup(yytext);}
<DATE>\n[^\n]*\n\n 		{BEGIN TEXT;}

<TEXT>[^<]+				{text = strdup(yytext); BEGIN INITIAL;}

\<\/pub\>				{FILE *fp;
						char * idPost = strdup(id);
						fp = fopen(strcat(id,".html"), "w");
						fprintf(fp, "<html>\n<head>\n<pub id =%s>\n<title>%s</title>\n</head>", idPost, title);
						fprintf(fp, "<body><h1><author_date>%s</author_date></h1>\n<p><tags>TAGS:\n", date);
						for(j= 0; j < numberTags; j++){
							fprintf(fp,"<tag>%s , </tag>\n", tagsPost[j]);
						}
						fprintf(fp,"</tags></p><p><category>%s</category></p><text>%s</text>\n</body>\n</html>", category, text);
						fclose(fp);}

%%

int yywrap(){
    return 1;
}

int main(){
    yylex();
    FILE *fp;
	fp = fopen("tags.html", "w");
	fprintf(fp, "<html><body><h1>Indice de tags</h1>");
	for(int i = 0; i < MAX && ltag[i] != NULL; i++){
		fprintf(fp, "<li>Tag: %s | Ocorrência: %d</li>\n\n", ltag[i]->tag,ltag[i]->n);
	}
    fprintf(fp, "</body></html>");
    return 0;
}
