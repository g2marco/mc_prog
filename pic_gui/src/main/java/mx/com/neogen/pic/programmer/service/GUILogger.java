package mx.com.neogen.pic.programmer.service;

import com.eurk.core.util.UtilText;

import javax.swing.*;

public class GUILogger implements Logger {

    private final JTextArea item;


    public GUILogger(JTextArea textArea) {
        super();
        this.item = textArea;
    }


    @Override
    public void info(Object data) {
        if ( data == null) {
            item.append( "null");
        }

        if ( data instanceof Throwable) {
            item.append( UtilText.stackTraceToString( (Throwable) data));

        } else {
            item.append( data.toString());
        }

        item.append( "\n");
    }

    @Override
    public void error(String message, Throwable causa) {
        info( "[ERROR] " + message);
        info( causa);
    }

}
