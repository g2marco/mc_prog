package mx.com.neogen.test;

import java.io.IOException;
import java.util.ArrayList;
import mx.com.neogen.test.code.Evaluator;
import mx.com.neogen.test.code.EvaluatorTranslator;
import mx.com.neogen.code.ExpressionParser;
import mx.com.neogen.test.code.impls.LogicalEvaluator;
import mx.com.neogen.code.interfaces.Parser;
import mx.com.neogen.code.beans.Operator;
import mx.com.neogen.code.enums.OperatorTypeEnum;
import mx.com.neogen.code.impls.CLikeTranslator;
import mx.com.neogen.test.code.impls.JavaLogicalEvaluatorTranslator;
import mx.com.neogen.test.code.impls.TextTreeTranslator;


public class MainLogical {

    public static void main(String[] args) {
        var items = new ArrayList<Operator>();
        
        items.add( new Operator( OperatorTypeEnum.UNARY, "not", "!", 1) {
            @Override
            public Boolean execute( Object... values) {
                return !((Boolean) values[0]);
            }
        });
        
        items.add( new Operator( OperatorTypeEnum.UNARY, "!", "!", 1) {
            @Override
            public Boolean execute( Object... values) {
                return !((Boolean) values[0]);
            }
        });
        
        items.add( new Operator( OperatorTypeEnum.BINARY, " or ", "||", 3) {
            @Override
            public Boolean execute( Object... values) {
                return (Boolean) values[0] || (Boolean) values[1];
            }
        });
        
        items.add( new Operator( OperatorTypeEnum.BINARY, " and ", "&&", 4) {
            @Override
            public Boolean execute( Object... values) {
                return (Boolean) values[0] && (Boolean) values[1];
            }
        });
        
               
        items.add( new Operator( OperatorTypeEnum.BINARY, "==", 8) {
            @Override
            public Boolean execute( Object... values) {
                return values[0].equals( values[1]);
            }
        });
        
        items.add( new Operator( OperatorTypeEnum.BINARY, "!=", 8) {
            @Override
            public Boolean execute( Object... values) {
                return !(values[0].equals( values[1]));
            }
        });
        
        items.add( new Operator( OperatorTypeEnum.BINARY, " not equals ", "!=",  8) {
            @Override
            public Boolean execute( Object... values) {
                return !(values[0].equals( values[1]));
            }
        });
        
        items.add( new Operator( OperatorTypeEnum.BINARY, " equals ", "==", 8) {
            @Override
            public Boolean execute( Object... values) {
                return values[0].equals( values[1]);
            }
        });
                
        
        try (
            EvaluatorTranslator evtran = new JavaLogicalEvaluatorTranslator( "D:\\tmp\\Main.java");
        ) {
            evtran.init();
            
            var debuParser = false;
            var parser = new ExpressionParser( items.toArray( new Operator[] {}), debuParser);
            var evaluator = new LogicalEvaluator( evtran);
            
            int test = 0;
        
            testCase( ++test, parser, evaluator, "alfa", "alfa", "alfa");
            
            testCase( ++test, parser, evaluator, "not alfa", "!alfa", "alfa");
            
            testCase( ++test, parser, evaluator,    "!alfa", "!alfa", "alfa");
            
            testCase( ++test, parser, evaluator, "alfa and beta", "alfa &&  beta", "alfa", "beta");
            
            testCase( ++test, parser, evaluator, "alfa == beta",  "alfa == beta", "alfa", "beta");
            
            testCase( ++test, parser, evaluator, "not alfa and beta", "!alfa &&  beta", "alfa", "beta");
            
            testCase( ++test, parser, evaluator, "alfa not equals beta and beta", "alfa != beta && beta", "alfa", "beta");
            
            testCase( ++test, parser, evaluator, "alfa or beta and gamma", "alfa || beta && gamma", "alfa", "beta", "gamma");
            
            testCase( ++test, parser, evaluator,
                "alfa and beta or not gamma", "alfa  && beta || !gamma", "alfa", "beta", "gamma"
            );
            
            testCase( ++test, parser, evaluator,
                "(alfa and beta) or gamma"  , "(alfa  && beta) || gamma", "alfa", "beta", "gamma"
            );
            
            testCase( ++test, parser, evaluator,
                "not alfa and beta or gamma", "!alfa    &&  beta || gamma", "alfa", "beta", "gamma"
            );
            
            testCase( ++test, parser, evaluator,
                "not (alfa and beta) or gamma", "!(alfa && beta) || gamma", "alfa", "beta", "gamma"
            );
            
            testCase( ++test, parser, evaluator,
                "alfa and (beta or gamma)", "alfa && (beta || gamma)", "alfa", "beta", "gamma"
            );
            
            testCase( ++test, parser, evaluator,
                "alfa and (beta or not gamma)", "alfa && (beta || !gamma)", "alfa", "beta","gamma"
            );
            
            testCase( ++test, parser, evaluator,
                "((alfa and beta) or (gamma and beta))",
                "((alfa &&  beta) || (gamma && beta))", 
                "alfa", "beta","gamma"
            );
            
            testCase( ++test, parser, evaluator,
                "(not (alfa and beta) or (gamma and beta))",
                "(!(alfa &&  beta) || (gamma && beta))",
                "alfa", "beta","gamma"
            );
            
            testCase( ++test, parser, evaluator,
                "(((alfa or beta) and omega) or (gamma and beta))",
                "(((alfa || beta)  && omega) || (gamma  && beta))", 
                "alfa", "beta", "gamma", "omega"
            );
        
            testCase( ++test, parser, evaluator,
                "(((alfa or beta) and omega) or not (gamma and beta))",
                "(((alfa || beta)  && omega) ||    !(gamma  && beta))",
                "alfa", "beta", "gamma", "omega"
            );
            
            testCase( ++test, parser, evaluator,
                "gamma or beta and epsilon and phi or delta",
                "gamma || beta  && epsilon  && phi || delta", 
                "gamma", "beta", "epsilon", "phi", "delta"
            );
            
            testCase( ++test, parser, evaluator,
                "(((alfa or beta) or omega) or (gamma or beta and ((epsilon and phi) or delta)))",
                "(((alfa || beta) || omega) || (gamma || beta &&  ((epsilon &&  phi) || delta)))",
                "alfa", "beta", "gamma", "omega", "epsilon", "phi", "delta"
            );
            
            testCase( ++test, parser, evaluator,
                "((not(alfa or beta) or omega) or (gamma or beta and ((epsilon and phi) or delta)))",
                "((  !(alfa || beta) || omega) || (gamma || beta  && ((epsilon &&  phi) || delta)))",
                "alfa", "beta", "gamma", "omega", "epsilon", "phi", "delta"
            );
            
            testCase( ++test, parser, evaluator,
                "((alfa or beta) or omega) or (gamma or beta and ((epsilon and phi) or delta))",
                "((alfa || beta) || omega) || (gamma || beta  && ((epsilon  && phi) || delta))",
                "alfa", "beta", "gamma", "omega", "epsilon", "phi", "delta"
            );
            
            testCase( ++test, parser, evaluator,
                "((alfa or beta) or omega) or not (gamma or beta and ((epsilon and phi) or delta))",
                "((alfa || beta) || omega) ||    !(gamma || beta &&  ((epsilon &&  phi) || delta))",
                "alfa", "beta", "gamma", "omega", "epsilon", "phi", "delta"
            );
                        
        } catch( Exception ex) {
            ex.printStackTrace();
            
        }
    }
    
    private static void testCase( int test, Parser parser, Evaluator evaluator, String expression, String nativeExpression, String... variables) throws IOException {
        var translator = new TextTreeTranslator();  
        var nativeTranslator = new CLikeTranslator();
        
        info( "\ntree for " + test + ": [" + expression + "]");
        info( "native expression: " + nativeExpression);
        
        var root = parser.parse( expression);
        info( "toString( root)  : " + root);
        info( "c-like translate : " + nativeTranslator.translate( null, root));
        info( translator.translate( null, root));
        evaluator.evaluate( test, nativeExpression, root, variables);
    }
    
    
    
    private static void info( Object data) {
        System.out.println( data);
    }
    
}
