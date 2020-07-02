package mx.com.neogen.pic.programmmer.gui.listeners;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.Map;
import javax.swing.JTextArea;
import javax.swing.JTextField;



public class ClienteFirmaElectronica implements ActionListener {
	
	private Map<String, ?> modelo;
	
    
	public ClienteFirmaElectronica( Map<String, ?> modelo) {
		super();
		this.modelo = modelo;
	}
	
    
    @Override
	public void actionPerformed(ActionEvent e) {
		JTextArea textArea = ((JTextArea) modelo.get( "consola"));
		String buffer = textArea.getText();
		String servidor = ((JTextField) modelo.get( "cadena")).getText();
		
        System.out.println("connecting to " + servidor);
        
        textArea.setText( program_device( servidor, buffer));
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
            StringBuilder strb = new StringBuilder();
            printStackTrace( strb, ex);
            
            return strb.toString();
            
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
    

	private void printStackTrace( StringBuilder strb, Throwable tirable) {
	
		if ( tirable != null) {
			strb.append( "\n - - - - - - - - - - - - - - - - - - - - - - - - - -");
			strb.append( "\n\t[CAUSA]: ").append( tirable.getMessage());
			strb.append( "\n - - - - - - - - - - - - - - - - - - - - - - - - - -");
			
			StackTraceElement[] stack = tirable.getStackTrace();
			
			if ( stack != null) {
				for ( int i = 0; i < stack.length; ++i) {
					strb.append( "\n").append( stack[i]);
				}
			}
			
			printStackTrace(strb, tirable.getCause());
		}
	}

}
