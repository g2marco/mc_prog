package mx.com.neogen.pic.programmer.service;

import javax.swing.*;
import java.util.Map;


public class BaseListener {

    protected final Map<String, ? super Object> modelo;
    protected  Logger LOG;

    
    public BaseListener( Map<String, ? super Object> modelo) {
		super();
		this.modelo = modelo;
	}

    protected String getText( String name) {
        final Object item = getPropiedad( name);
        
        if( item == null) {
            throw new IllegalArgumentException( "No existe una propiedad con el nombre: " + name); 
        }
        
        if ( item instanceof JTextField) {
            return ((JTextField) item).getText();
        }
        
        if ( item instanceof JTextArea) {
            return ((JTextArea) item).getText();
        }
        
        throw new IllegalArgumentException( "La propiedad " + name + " no es un control de texto");
    }

    protected void setText( String name, String text) {
        final Object item = getPropiedad( name);

        if( item == null) {
            throw new IllegalArgumentException( "No existe una propiedad con el nombre: " + name);
        }

        if ( item instanceof JTextField) {
            ((JTextField) item).setText( text);
            return;
        }

        if ( item instanceof JTextArea) {
            ((JTextArea) item).setText( text);
            return;
        }

        throw new IllegalArgumentException( "La propiedad " + name + " no es un control de texto");
    }

    protected void init() {
        this.LOG = new GUILogger( getPropiedad( "consola"));
    }
    
    protected <T> T getPropiedad( String name) {
        return (T) modelo.get( name);
    }

    protected void setPropiedad( String name, Object value) {
        modelo.put( name, value);
    }

    protected void disableAction() {
        ((JButton) modelo.get( "action")).setEnabled( false);
    }

    protected void enableAction() {
        ((JButton) modelo.get( "action")).setEnabled( true);
    }

}