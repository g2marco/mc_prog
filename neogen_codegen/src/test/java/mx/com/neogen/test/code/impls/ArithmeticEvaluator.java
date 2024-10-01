package mx.com.neogen.test.code.impls;

import mx.com.neogen.test.code.Evaluator;
import mx.com.neogen.test.code.EvaluatorTranslator;



public class ArithmeticEvaluator extends Evaluator {
    
	
    public ArithmeticEvaluator( EvaluatorTranslator translator) {
        super( translator);
    }
    
	@Override
    protected Object[][] generateEvaluationVectors( int length) {
        final Object[][] vectors = new Object[ (int) Math.pow(2, length)][];
        
        for( int i = 0; i < vectors.length; ++i) {
            vectors[i] = generateVector( i, length);
        }
        
        return vectors;
    }
    
    protected Object[] generateVector( int value, int length) {
        Object[] vector = new Object[ length];
        
        for( int i = length - 1; i >= 0; --i) {
            vector[ i] = (100*Math.random())*Math.random();
        }
        
        return vector;
    }
}
