package mx.com.neogen.pic.prg.gui;

import com.eurk.core.util.UtilText;
import javax.swing.*;
import mx.com.neogen.commons.messages.Logger;

public class GUILogger implements Logger {

    private final JTextArea item;


    public GUILogger( JTextArea textArea) {
        super();
        this.item = textArea;
    }


    @Override
    public void print( Object data) {
        if ( data == null) {
            item.append( "null");
        }

        if ( data instanceof Throwable) {
            item.append( UtilText.stackTraceToString( (Throwable) data));

        } else {
            item.append( data.toString());
        }
    }
    
    @Override
    public void println( Object data) {
        print( data);
        item.append( "\n");
    }

    @Override
    public void error(String message) {
        println( "[ERROR] " + message);
    }
    
    @Override
    public void error(String message, Throwable causa) {
        error( message);
        println( causa);
    }

}
