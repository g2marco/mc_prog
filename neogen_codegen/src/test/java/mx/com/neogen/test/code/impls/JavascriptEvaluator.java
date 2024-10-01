package mx.com.neogen.test.code.impls;


public class JavascriptEvaluator  {

    /*
    public JavascriptEvaluator( String path) throws IOException {
        super( path);
    }

    @Override
    public void init() throws IOException {
        write( "<html>");
        write( "<head>");
        write( "<script>");
        write( "let alfa, beta, gamma, omega, epsilon, phi, delta;");
               
    }

    @Override
    public void evaluate( int test, String expression, Node root, String... variables) throws IOException {
        boolean[][] values = generateEvaluationVectors( variables.length);
       
        write( "\n// inicial test " + test);
        write( "msg = '';");
        
        for( int i = 0; i < values.length; ++i) {
            addEntryTest( i, variables, values[i], expression, evaluate( root, variables, values[i]));
        }
        
        write( "console.log( 'test " + test + ": ' + (msg.length == 0? 'OK' : ('Errors:\\n' + msg)));");
    }
    
    @Override
    protected void addEntryTest(int indice, String[] variables, boolean[] vector, String expression, boolean myValue) throws IOException {
        for( int i = 0; i < variables.length; ++i) {
            write( variables[i] + " = " + vector[i] + ";");
        }
        write("match = (" + expression + ") == " + myValue + ";");
        write("if ( !match) { msg += 'vector_" + indice + "\\n'; }");
    }
    
    @Override
    public void close() throws IOException {
        write( "</script>");
        write( "</head>");
        write( "<body></body>");
        write( "</html>");

        super.close();
    }
    */
}
