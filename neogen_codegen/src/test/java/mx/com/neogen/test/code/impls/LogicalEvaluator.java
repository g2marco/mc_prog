package mx.com.neogen.test.code.impls;

import mx.com.neogen.test.code.Evaluator;
import mx.com.neogen.test.code.EvaluatorTranslator;



public class LogicalEvaluator extends Evaluator {
    
	
    public LogicalEvaluator( EvaluatorTranslator translator) {
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
        int mask = 1;
        
        for( int i = length - 1; i >= 0; --i) {
            vector[ i] = (value & mask) != 0;
            mask <<= 1; 
        }
        
        return vector;
    }
}
