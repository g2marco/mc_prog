package mx.com.neogen.test.code;

import java.io.Closeable;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;


public abstract class EvaluatorTranslator implements Closeable {
    
    protected Writer writer;
    protected String path;
    
    public EvaluatorTranslator( String path) {
        super();
        this.path = path;
    }
    
    
    public void init() throws IOException {
        writer = new FileWriter( path);
    }
    
    public abstract void beforeTest( int test, String expression) throws IOException;
        
    public abstract void entryTest( int i, String[] variables, Object[] values, String expression, Object result) throws IOException;
        
    public abstract void afterTest( int test, String expression) throws IOException;

    @Override
    public void close() throws IOException {
        if ( writer != null) {
            writer.close();
        }
    }
    
    protected void writeLine( String line) throws IOException {
        writer.write( line);
        writer.write( "\n");
    }
    
}
