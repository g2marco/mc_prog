package mx.com.neogen.test.code.impls;

import java.io.IOException;
import mx.com.neogen.test.code.EvaluatorTranslator;

public class JavaLogicalEvaluatorTranslator extends EvaluatorTranslator {

    
    public JavaLogicalEvaluatorTranslator( String path) throws IOException {
        super( path);
    }
    
    
    @Override
    public void init() throws IOException {
        super.init();
        
        writeLine( "public class Main {\n");
        writeLine( "\tpublic static void main(String[] args) {");
        writeLine( "\t\tboolean alfa, beta, gamma, omega, epsilon, phi, delta, match;");
        writeLine( "\t\tString msg;");
    }

    @Override
    public void beforeTest(int test, String expression) throws IOException {
        writeLine( "\t\tSystem.out.println( \"\\ntest " + test + ", expression: " + expression +"\");");
        writeLine( "\t\tmsg = \"\";");
    }

    @Override
    public void entryTest(int test, String[] variables, Object[] values, String expression, Object result) throws IOException {
        for( int i = 0; i < variables.length; ++i) {
            writeLine( "\t\t" + variables[i] + " = " + values[i] + ";");
        }
        writeLine("\t\tmatch = (" + expression + ") == " + result + ";");
        writeLine("\t\tif ( !match) { msg += \"vector_" + test + "\\n\"; }");
    }

    @Override
    public void afterTest( int test, String expression) throws IOException {
        writeLine( "\t\tSystem.out.println( \"test " + test + ": \" + (msg.length() == 0? \"OK\" : (\"expression: " + expression +", has errors:\\n\" + msg)));");
    }
    
    @Override
    public void close() throws IOException {
        writeLine( "\t}");
        writeLine( "}");

        super.close();
    }
    
}
