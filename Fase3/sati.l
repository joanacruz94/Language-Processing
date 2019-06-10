%x def sin trd word

%{

#include "y.tab.h"

%}

STRING ([a-zA-Z0-9]|[áàâãéèêíóôõúçñÁÀÂÃÉÈÍÓÔÕÚÇ,-.]|\ )

%option noyywrap

%%
{STRING}+\{                                   {yytext[yyleng-1]='\0';
                                              yylval.texto = strdup(yytext);
                                              BEGIN (word); return WORD;}

<word>\}                                      {BEGIN 0;}

<word>\n                                      ;

<word>[\ \t]*def:[\ \t]*\"                    {BEGIN (def);}

<def>\"                                       {BEGIN (word);}

<def>{STRING}+                                {yylval.texto = strdup(yytext);
                                              return DEF;}

<word>[\ \t]*sin:[\ \t]*\"                    {BEGIN (sin);}

<sin>\"                                       {BEGIN (word);}

<sin>\n                                       ;

<sin>{STRING}+                                {yylval.texto = strdup(yytext);
                                              return SIN;}

<word>[\ \t]*trd:[\ \t]*\"                    {BEGIN (trd);}

<trd>\"                                       {BEGIN (word);}

<trd>\n                                       ;

<trd>{STRING}+                                {yylval.texto = strdup(yytext);
                                              return TRD;}

.|\n                                          ;
%%
