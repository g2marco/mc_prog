#include <stdio.h>
#include <stdlib.h>

typedef enum {
    OBJETO,
    PROPIEDAD,
    LITERAL,
    STRING,
    ARRAY
} TipoJSONToken;

typedef struct JSONTokenStruct {
    TipoJSONToken tipo;
    int ini;
    int end;
    struct JSONTokenStruct * values;
    struct JSONTokenStruct * next;
} JSONToken;


void print_tipo( TipoJSONToken tipo) {
    if( tipo == 0) {
        printf( "objeto");
    } else if( tipo == 1) {
        printf( "propiedad");
    } else if( tipo == 2) {
        printf( "literal");
    } else if( tipo == 3) {
        printf( "string");
    } else if( tipo == 4) {
        printf( "array");
    }
}

void print_token( JSONToken * token, int nivel) {
    
    if ( nivel == 0) {
        printf( "\ntipo: "); print_tipo( token->tipo);
        printf( "\nini : %d", token->ini);
        printf( "\nend : %d", token->end);
    } else if( nivel == 1) {
        printf( "\n\ttipo: "); print_tipo( token->tipo);
        printf( "\n\tini : %d", token->ini);
        printf( "\n\tend : %d", token->end);
    } else if( nivel == 2) {
        printf( "\n\t\ttipo: "); print_tipo( token->tipo);
        printf( "\n\t\tini : %d", token->ini);
        printf( "\n\t\tend : %d", token->end);
    } else if ( nivel == 3) {
        printf( "\n\t\t\ttipo: "); print_tipo( token->tipo);
        printf( "\n\t\t\tini : %d", token->ini);
        printf( "\n\t\t\tend : %d", token->end);
    }
    
    if( token->values != NULL) {
        print_token( token->values, nivel + 1);
    }
    
    if( token->next != NULL) {
        print_token( token->next, nivel);
    }
        
}   





JSONToken * obtenerToken( TipoJSONToken tipo, int ini) {
    JSONToken * token = (JSONToken *) malloc( sizeof( JSONToken));
    
    token->tipo = tipo;
    
    token->ini = ini;
    token->end = ini;
    
    token->values = NULL;
    token->next   = NULL;
    
    return token;
}

int obtenerString( JSONToken * parent, char * string, int posicion) {
    JSONToken * token = obtenerToken( ((parent->tipo == OBJETO)? PROPIEDAD : STRING), posicion);
    
    if( parent->values == NULL) {
        parent->values = token;
        parent->next   = NULL;
    } else {
        JSONToken * next = parent->values;
        while( next->next != NULL) {
            next = next->next;
        }
        next->next = token;
    }
    
    while( string[posicion++] != '"');
    token->end = posicion-1;
    
    if( parent->tipo != PROPIEDAD) {
        parent->end = posicion;
    }
    
    return posicion; 
}

JSONToken * obtenerNodoAsignacion( JSONToken * token) {
    
    if( token->values == NULL ) {
        return token->values;
    } else {
        JSONToken * next = token->next;
        while( next->next != NULL) {
            next = next->next;
        }
        return next->values;
    }
}

unsigned int createArray( int posicion, char * string) {
    unsigned int i = 0;
    char token[200];
 
    while( ( token[i] = string[posicion++]) != ']') {
        printf( "%c", token[i]);
        if ( token[i] == ',') {
            i = 0;
            token[i] = '\0';
            
            printf( ": %s ", token);
        } else {
            ++i;
        }
    }
    
    return posicion;
}



JSONToken * parseJSON( char * string, JSONToken * node, int posicion, int nivel) {
    
    char caracter;
    int asignarItem = 0; 
    int siguienteItem = 0;
    
    while( posicion < 42) {
        caracter = string[ posicion++];
        
        if( caracter == '{') {
            if( node == NULL) {
                node = obtenerToken( OBJETO, posicion - 1);
            }
            parseJSON( string, node, posicion, nivel + 1);
            
            return node;
            
        } else if ( caracter == '}') {
            --nivel;
            node->end = posicion;
            
            return node;
            
        } else if( caracter == '"') {
            if ( asignarItem == 0) {
                posicion = obtenerString( node, string, posicion);
            
            } else {
                posicion = obtenerString( obtenerNodoAsignacion( node->values), string, posicion);
            
                asignarItem = 0;
            }
        
        } else if( caracter == ':') {
            asignarItem = 1;
        
        } else if( caracter == ',') {
            siguienteItem = 1;
            
        } else if ( caracter == '[') {
            posicion = createArray( posicion, string);
        
        }
    }
}



int main( void) {
    
    char * string = "{\"hola\":\"como estas\",\"hola\":\"como estas\"}";
        //
        //,\"program\":[{\"prop1\":\"valor 1\",\"prop2\":[1234,4321]},{\"prop1\":\"valor 2\",\"prop2\":[93939, 87854]}]}";

    JSONToken * root = parseJSON( string, NULL, 0, 0);
    
    print_token( root, 0);
    
    printf( "\ndone\n");

    return 0;
}