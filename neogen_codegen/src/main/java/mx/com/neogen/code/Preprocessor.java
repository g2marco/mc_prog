package mx.com.neogen.code;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Preprocessor {
    
    private boolean multiLineComment;
    
    
    public Preprocessor() {
        super();
    }
    
    
    public List<String> readSentences( String filePath) throws IOException {
        var lines = readLines( filePath);
        return filterSentences( lines);
    }
    
    protected List<String> readLines( String filePath) throws IOException {   
        try ( 
            var reader = new BufferedReader( new FileReader( filePath));
        ) {
            // leer lineas del archivo
            var lines = new ArrayList<String>();
            String line;
        
            while( (line = reader.readLine()) != null ) {
                lines.add( line);
            }
            
            return lines;            
        }
    }
    
    protected List<String> filterSentences( List<String> lines) {
        this.multiLineComment = false;
        
        var items = new ArrayList<String>();
        
        var strb = new StringBuilder();
        
        for( String line : lines) {
            appendLine( strb, line);
           
            if ( isSentenciaTerminada( strb)) {
                items.add( strb.toString());
                strb = new StringBuilder();
            }
        }
        
        return items;
    }
    
    protected void appendLine( StringBuilder strb, String line) {
        int idx;
        var text = line;
        
        if ( multiLineComment) {
            idx = line.indexOf("*/");
            if( idx < 0) {
                return;
            }
            multiLineComment = false;
            text = text.substring( idx + 2).trim();
        }
        
        idx  = text.indexOf( "//");
        text = ((idx >= 0)? text.substring( 0, idx) : text).trim();
        
        idx = text.indexOf( "/*");
        text = ((idx >= 0)? text.substring( 0, idx) : text).trim();
        
        strb.append( strb.length() > 0? ' ' : "").append( text);
        
        multiLineComment = idx >= 0;
    }
    
    protected boolean isSentenciaTerminada( StringBuilder strb) {
        return strb.length() > 0? strb.charAt( strb.length() - 1) == ';' : false;
    }

}
