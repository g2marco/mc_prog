package mx.com.neogen.test.code;

import java.io.IOException;
import mx.com.neogen.code.beans.Node;
import mx.com.neogen.code.beans.Operand;

public abstract class Evaluator {
    
    protected EvaluatorTranslator translator;
    
    
    public Evaluator( EvaluatorTranslator translator) {
        super();
        this.translator = translator;
    }
    
    public void evaluate( int test, String expression, Node root, String... variables) throws IOException {
        Object[][] values = generateEvaluationVectors( variables.length);
        
        translator.beforeTest( test, expression);
        
        for( int i = 0; i < values.length; ++i) {
            translator.entryTest( i, variables, values[i], expression, evaluate( root, variables, values[i]));
        }
        
        translator.afterTest( test, expression);
    }
    
    protected Object evaluate( Node node, String[] variables, Object[] vector) {
        Object valorA, valorB;
        
        if ( node.getOperator() == null) {
            valorA = getOperand( node.getOperands()[0], variables, vector);
            return valorA;
            
        } else {
            switch( node.getOperator().getType()) {
                case UNARY:
                    valorA = getOperand( node.getOperands()[0], variables, vector);
                    return node.getOperator().execute( valorA);
            
                case BINARY:
                    valorA = getOperand( node.getOperands()[0], variables, vector);
                    valorB = getOperand( node.getOperands()[1], variables, vector);
                    return node.getOperator().execute( valorA, valorB);
                
                default:
                    throw new RuntimeException( "Tipo de Operador no considerado: " + node.getOperator().getType());
            }
        }
    }
    
    protected Object getOperand( Operand operand, String[] variables, Object[] vector) {
        switch( operand.getType()) {
            case EXPRESSION:
                return evaluate( (Node) operand.getValue(), variables, vector);
                
            case VARIABLE:
                return vector[ findIndice( operand.getValue().toString(), variables)];
                        
            case LITERAL:
                return Boolean.valueOf( operand.getValue().toString());
            
            default:
                throw new RuntimeException( "Tipo de Operando no considerado: " + operand.getType());
        }
    }
        
    protected int findIndice( String name, String[] items) {
        for( int i = 0; i < items.length; ++i) {
            if ( items[i].equals( name)) {
                return i;
            }
        }
        
        throw new RuntimeException( "Identificador de variable no encontrado: " + name);
    }
    
    protected abstract Object[][] generateEvaluationVectors( int length);
    
}
