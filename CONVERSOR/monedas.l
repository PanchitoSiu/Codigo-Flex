#package codigo
%option noyywrap
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "monedas.tab.h"
    void yyerror(char *);
%}

DIGIT [0-9]
NUM {DIGIT}+("."{DIGIT}+)?

%%

{NUM}   { yylval.numero = atof(yytext); return NUMERO; }
"USD"   { yylval.texto = strdup(yytext); return MONEDA; }
"PEN"   { yylval.texto = strdup(yytext); return MONEDA; }
"EUR"   { yylval.texto = strdup(yytext); return MONEDA; }
"JPY"   { yylval.texto = strdup(yytext); return MONEDA; }
"BOB"   { yylval.texto = strdup(yytext); return MONEDA; }
"to"    { yylval.texto = strdup(yytext); return A; }
[[:blank:]]+ ;
.       yyerror("La moneda no existe");

%%
