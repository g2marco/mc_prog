package mx.com.neogen.test.code.impls;

import java.io.IOException;
import mx.com.neogen.test.code.EvaluatorTranslator;

public class JavaArithmeticEvaluatorTranslator extends EvaluatorTranslator {

    
    public JavaArithmeticEvaluatorTranslator( String path) throws IOException {
        super( path);
    }
    
    
    @Override
    public void init() throws IOException {
        super.init();
        
        writeLine( "public class MainArithmetic {\n");
        writeLine( "\tpublic static void main(String[] args) {");
        writeLine( "\t\tdouble alfa, beta, gamma, omega, epsilon, phi, delta;");
        writeLine( "\t\tboolean match;");
        writeLine( "\t\tString msg;");
    }

    @Override
    public void beforeTest(int test, String expression) throws IOException {
        writeLine( "\n\t\tSystem.out.println( \"\\ntest " + test + ", expression: " + expression +"\");");
        writeLine( "\t\tmsg = \"\";\n");
    }

    @Override
    public void entryTest(int test, String[] variables, Object[] values, String expression, Object result) throws IOException {
        for( int i = 0; i < variables.length; ++i) {
            writeLine( "\t\t" + variables[i] + " = " + values[i] + ";");
        }
        writeLine("\t\tmatch = (" + expression + ") == " + result + ";");
        writeLine("\t\tif ( !match) { msg += \"vector_" + test + "\\n\"; }\n");
    }

    @Override
    public void afterTest( int test, String expression) throws IOException {
        writeLine( "\t\tSystem.out.println( \"test " + test + ": \" + (msg.length() == 0? \"OK\" : (\"expression: " + expression +", has errors:\\n\" + msg)));\n");
    }
    
    @Override
    public void close() throws IOException {
        writeLine( "\t}");
        writeLine( "}");

        super.close();
    }
    
}
