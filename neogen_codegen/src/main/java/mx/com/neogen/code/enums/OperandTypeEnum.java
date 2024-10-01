package mx.com.neogen.code.enums;

/** 
 * Identifica el tipo de operando en un punto del arbol de evaluacion de expresion
 *  - expression : el operando es una expresion que debe ser evaluada
 *  - literal    : el operando es un valor literla
 *  - variable   : el operando es una variable, cuyo valor debe determinarse
 */
public enum OperandTypeEnum {
    EXPRESSION,
    LITERAL,    
    VARIABLE;
}
