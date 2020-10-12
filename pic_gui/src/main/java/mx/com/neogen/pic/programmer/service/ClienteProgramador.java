package mx.com.neogen.pic.programmer.service;

import com.eurk.core.util.UtilText;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.Map;


public class ClienteProgramador extends BaseListener implements ActionListener  {
	
	
	public ClienteProgramador( Map<String, ?> modelo) {
		super( modelo);
	}
	
    
    @Override
	public void actionPerformed(ActionEvent e) {
	        
		String buffer = getText( "consola");
		String servidor = ((JTextField) modelo.get( "cadena")).getText();
		
        LOG.info( "connecting to " + servidor + " ...");
        LOG.info( "[respuesta] ");
        LOG.info( program_device( servidor, buffer));
	}
    
   
    public String program_device(String serverIP, String buffer)  {   
 
        Socket socket = null;
       
        try {
            socket = new Socket( serverIP, 9734);
            
            OutputStream outputStream = socket.getOutputStream();
            
            // request
            outputStream.write( buffer.getBytes());    
            outputStream.write( 0);
            
            // response
            InputStream response = socket.getInputStream();
            int value;
            
            StringBuilder strb = new StringBuilder();
            
            while( (value = response.read()) != 0) {
                strb.append( (char) value);
            }
            
            return strb.toString();
            
        } catch ( Exception ex) {
            return UtilText.stackTraceToString( ex);
               
        } finally {
            
            if( socket != null && !socket.isClosed()) {
                try {
                    socket.close(); 
                } catch( Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

}
