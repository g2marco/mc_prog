package mx.com.neogen.pic.programmer.service;

import com.eurk.core.util.UtilText;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.Map;


public class ClienteProgramador extends BaseListener implements ActionListener {
	
	
	public ClienteProgramador( Map<String, ? super Object> modelo) {
		super( modelo);
	}
	
    
    @Override
	public void actionPerformed(ActionEvent e) {
	    init();

	    disableAction();

		final String buffer = getPropiedad( "request");
		final String servidor = getText( "ipServidor");

        new Thread(new Runnable() {
            @Override
            public void run() {
                final String respuesta = program_device( servidor, buffer);

                LOG.info( "[respuesta]");
                LOG.info( respuesta);

                enableAction();
            }
        }).start();
	}

    private String program_device( String serverIP, String buffer)  {

        Socket socket = null;
       
        try {
            LOG.info( "connecting to " + serverIP + " ...\n");

            socket = new Socket( serverIP, 9734);

            LOG.info( "\tconnected [OK], waiting response");

            OutputStream outputStream = socket.getOutputStream();

            // request
            outputStream.write( buffer.getBytes());    
            outputStream.write( 0);
            
            // response
            InputStream response = socket.getInputStream();
            int value;
            
            final StringBuilder strb = new StringBuilder();
            
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
