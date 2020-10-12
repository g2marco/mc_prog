package mx.com.neogen.pic.programmer.service;

import com.eurk.core.util.UtilText;

import javax.swing.*;
import java.util.Map;


public class BaseListener {

    protected final Map<String, ?> modelo;
    protected final Logger LOG;

    
    public BaseListener( Map<String, ?> modelo) {
		super();
		this.modelo = modelo;
		this.LOG = new GUILogger( getPropiedad( "consola"));
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
    
    protected <T> T getPropiedad( String name) {
        return (T) modelo.get( name);
    }

}
