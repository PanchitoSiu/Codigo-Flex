%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "monedas.tab.h"

int yylex(void);
void yyerror(char *s);

typedef struct {
    char* nombre;
    double tasa;
} Moneda;

Moneda monedas[] = {
    {"USD", 1.0},  // La tasa de cambio de USD a USD es 1
    {"PEN", 3.71},
    {"EUR", 0.91},  
    {"JPY", 148.16},  
    {"BOB", 6.85}  
};

double obtenerTasa(char* nombre) {
    int numMonedas = sizeof(monedas) / sizeof(Moneda);
    for (int i = 0; i < numMonedas; i++) {
        if (strcmp(monedas[i].nombre, nombre) == 0) {
            return monedas[i].tasa;
        }
    }
    printf("No se encontro la taza: %s\n", nombre);
    return 0;
}
%}

%token NUMERO MONEDA A

%union {
    double numero; 
    char* texto;
}

%type <numero> NUMERO
%type <texto> MONEDA A

%%

INICIO
    : NUMERO MONEDA A MONEDA
    {
        double tasaOrigen = obtenerTasa($2);
        double tasaDestino = obtenerTasa($4);
        if (tasaOrigen == 0 || tasaDestino == 0) {
            return 0;
        }
        double conversion = $1 * tasaDestino / tasaOrigen;
        printf("CONVERSION EXITOSA\n");
        printf("MONTO: %.2f\n", $1);
        printf("MONEDA_ORIGEN: %s\n", $2);
        printf("MONEDA_DESTINO: %s\n", $4);
        printf("CONVERSION: %.2f %s\n", conversion, $4);
    }
;

%%

int main()
{
    yyparse();
    return 0;
}

void yyerror(char *s)
{
    printf("\n%s\n", s);
}

int yywrap()
{
    return 1;
}
