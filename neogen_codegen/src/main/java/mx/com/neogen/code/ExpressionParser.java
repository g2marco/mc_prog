package mx.com.neogen.code;

import mx.com.neogen.code.interfaces.Parser;
import mx.com.neogen.code.enums.OperatorTypeEnum;
import mx.com.neogen.code.beans.Operator;
import mx.com.neogen.code.enums.OperandTypeEnum;
import mx.com.neogen.code.beans.Operand;
import mx.com.neogen.code.beans.Node;
import java.util.ArrayList;
import java.util.List;

public class ExpressionParser implements Parser {
    
    private final Operator[] operators;
    private final boolean debug;
    
    
    public ExpressionParser( Operator[] operators, boolean debug) {
        super();
        
        this.operators = operators;
        this.debug = debug;
    }
    
    
    /**
     * Parses an expression creating an evaluation tree, returns the root node
     */
    @Override
    public Node parse( String expression) {
        validateParenthesisBalance( expression);
        return parseExpression( expression.trim());
    }
    
    /** 
     * divides an expression, extracting the operator and the operands
     */
    private Node parseExpression( String expression) {
        
        int uptoIdx = findAgrupationStart( expression);
        
        logDebug( "\nbefore: " + expression + ", upto: " + uptoIdx);
        
        if ( uptoIdx == 0) {
            expression = expression.substring( 1, expression.length() - 1);
            uptoIdx = findAgrupationStart( expression);
        }
        
        logDebug( "after : " + expression + ", upto: " + uptoIdx);
         
        logDebug( "\tgetting binary operator" );
        var operator = findOperator( OperatorTypeEnum.BINARY, expression, uptoIdx);
        
        if( operator == null) {
            logDebug( "\tgetting unary operator");
            operator = findOperator( OperatorTypeEnum.UNARY, expression, uptoIdx);
        } 
        
        return createNode( operator, expression, uptoIdx);
    }
    
    
    private Node createNode( Operator operator, String expression, int uptoIdx) {
        var node = new Node();
        
        Operand operand;
        OperandTypeEnum type;
        
        if ( operator == null) {
            operand = new Operand();
            type = findOperandType( expression);
            
            operand.setType( type);
            operand.setValue( expression);
            
            node.setOperands( new Operand[] { operand});
            
        } else {
            node.setOperator( operator);
            
            var tokens = findOperands( expression, operator, uptoIdx);
        
            var operands = new ArrayList<Operand>();
            
            
            for( String token : tokens) {
                operand = new Operand();
                
                type = findOperandType( token);
                operand.setType( type);
                switch( type) {
                    case EXPRESSION:
                        operand.setValue( parseExpression( token));
                        break;
                        
                    case LITERAL:
                    case VARIABLE: 
                        operand.setValue( token);
                        break;
                }
                       
                operands.add( operand);
            }
        
            node.setOperands( operands.toArray( new Operand[] {}));
        }
        
        return node;
    }
        
    /**
     * Encuentra el token operador con el mayor indice
     */
    private Operator findOperator( OperatorTypeEnum type, String expression, int uptoIndex) {
        int idx;
        Operator item = null;
        
        int startIdx = findEndOfAgrupation(expression);
        expression = expression.substring( startIdx, uptoIndex);
        
        logDebug( "\t\t" + expression);
        
        int maxIdx = 0;
        int topIdx;
        
        for( Operator operator : operators) {
            if ( !operator.getType().equals( type)) { 
                continue;
            }
            
            idx = expression.lastIndexOf( operator.getValue());
            
            if ( idx < 0) {
                continue;
            }
            
            logDebug( "\t\toperator: " + operator.getValue() + ", indice: " + idx);
            
            topIdx = idx + operator.getValue().length();
            if ( item == null) {
                item = operator;
                maxIdx = topIdx;
            } else {
                if ( operator.getPrecedence() < item.getPrecedence()) {
                    item = operator;
                    maxIdx = topIdx;
                    
                } else if ( operator.getPrecedence() == item.getPrecedence()) {
                    if ( topIdx > maxIdx) {
                        // el operador termina mas a la derecha
                        item = operator;
                        maxIdx = topIdx;
                        
                    } else if ( topIdx == maxIdx && (operator.getValue().length() > item.getValue().length())) {
                        // el operado termina en la misma posicion, pero tiene mayor longitud
                        item = operator;
                        maxIdx = topIdx;
                    }
                }
            }
        }
        
        logDebug( "\t\toperator found: " + item);
        
        return item; 
    }
    
    /**
     * Determina si la expresion tiene por lo menos un operador del tipo solicitado
     * @param type          tipo de operador
     * @param expression    expresion analizada
     * @param uptoIndex     indice maximo de analisis
     * @return              true, si la expresion tiene por lo menos un 
     */
    private boolean hasOperator( OperatorTypeEnum type, String expression, int uptoIndex) {
        int idx;
        expression = expression.substring( 0, uptoIndex);        
        
        for( Operator operator : operators) {
            if ( !operator.getType().equals( type)) { 
                continue;
            }
            
            idx = expression.lastIndexOf( operator.getValue());
            
            if ( idx < 0) {
                continue;
            }
            
            return true;
        }
        
        return false; 
    }
    
    private int findEndOfAgrupation( String expression) {
        if( !expression.startsWith( "(")) {
            return 0;
        }
        
        int level = 0;
        char character;
        char[] chars = expression.toCharArray();
        
        for( int i = 0 ; i < chars.length; ++i) {
            character = chars[i];
            
            switch ( character) {
                case '(': level++; break;
                case ')': level--; break;
                default :
            }
            
            if ( level == 0) {
                return i;
            }
        }
        
        return expression.length();
    }
    
    private int findAgrupationStart( String expression) {
        if ( !expression.endsWith( ")")) {
            return expression.length();
        }
        
        int level = 0;
        char character;
        
        for( int i = expression.length() - 1; i >= 0; --i) {
            character = expression.charAt( i);
            
            switch ( character) {
                case '(': level--; break;
                case ')': level++; break;
                default :
            }
            
            if ( level == 0) {
                return i;
            }
        }
        
        return -1;
    }
    
    private OperandTypeEnum findOperandType( String token) {
        if( isExpression( token)) {
            return OperandTypeEnum.EXPRESSION;
        }
        
        if( isLiteral( token)) {
            return OperandTypeEnum.LITERAL;
        }
        
        if( isVariable( token)) {
            return OperandTypeEnum.VARIABLE;
        }
        
        throw new RuntimeException( "unkown token type: " + token);
    } 
    
    
    private boolean isExpression( String token) {
        return
            hasOperator( OperatorTypeEnum.UNARY, token, token.length()) ||
            hasOperator( OperatorTypeEnum.BINARY, token, token.length()) 
        ;
    }
    
    private boolean isLiteral( String token) {
        return "ON".equals( token) || "OFF".equals( token) || isNumber( token);
    }
    
    private boolean isNumber( String token) {
        try {
            Double.valueOf( token);
            return true;
        } catch( Exception ex) {
            return false;
        }
    }
    
    private boolean isVariable( String token) {
        return true;
    }
    
    private List<String> findOperands( String expression, Operator operator, int uptoIdx) {
        var items = new ArrayList<String>();
        
        var idx = expression.substring( 0, uptoIdx).lastIndexOf( operator.getValue());
        
        if ( idx > 0) {
            items.add( expression.substring( 0, idx).trim());
        }
        
        idx += operator.getValue().length();
        
        if( idx <= (expression.length() - 1)) {
            items.add( expression.substring( idx).trim());
        }
        
        return items;
    }
    
    private void validateParenthesisBalance( String expression) {
        int level = 0;
        for( char character : expression.toCharArray()) {
            switch ( character) {
                case '(': level++; break;
                case ')': level--; break;
                default :
            }
            // running level must not be less than 0
            if ( level < 0) {
                throw new RuntimeException( "unbalanced parethesis on expression: " + expression);
            }
        }
        
        if ( level != 0) {
            throw new RuntimeException( "unbalanced parethesis on expression: " + expression);
        }
    }
        
    private void logDebug( Object data) {
        if ( !debug) {
            return;
        }
        System.out.println( data);
    }
}
