package mx.com.neogen.pic.programmer.gui.listeners;

import com.eurk.core.util.UtilText;
import java.util.Map;
import javax.swing.JTextArea;
import javax.swing.JTextField;


public class BaseListener {

    protected final Map<String, ?> modelo;
    
    
    public BaseListener( Map<String, ?> modelo) {
		super();
		this.modelo = modelo;
	}
	
    
    protected void toConsole( Object data) {
        final JTextArea textArea = getPropiedad( "consola");
        
        if ( data == null) {
            textArea.setText( "null");
        } 
        
        if ( data instanceof Throwable) {
            textArea.setText( UtilText.stackTraceToString( (Throwable) data));
            
        } else {
            textArea.setText( data.toString());
        
        }
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
