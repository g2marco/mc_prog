package mx.com.neogen.pic.prg.components;

import com.eurk.core.util.UtilText;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.Socket;
import mx.com.neogen.commons.messages.Logger;
import mx.com.neogen.server.util.AppProperties;


public class ProgrammingTask implements Runnable {
	
    private final Logger log;
    private final String request;
    private final String ticket;
    
    
    public ProgrammingTask( Logger log, String request, String ticket) {
        super();
        
        this.log = log;
        this.request = request;
        this.ticket  = ticket;
    }
    
    
    @Override
	public void run() {
        var servidor = AppProperties.getProperty( "serverHost");
        var puerto   = Integer.valueOf( AppProperties.getProperty( "serverPort"));
        
        // invoca servicio y obtiene respuesta
        var response = execute_request( servidor, puerto, request);
        
        // guarda respuesta en carpeta de tickets
        saveResponse( ticket, response);
        
        // marca la peticion como atendida
        TicketManager.done( ticket);
	}

    /**
     *  Solicita una accion al servidor, usando la información:
     *      - envía peticion de servicio 
     *      - espera la respuesta 
     *      - devuelve la respuesta obtenido como un string
     *
     * @param serverHost    ip o hostname del servidor de programacion
     * @param serverPort    puerto del servicio de programacion
     * @param request       data buffer con la información de la petición
     * 
     * @return  respuesta obtenida del servidor de programación
     */
    private String execute_request( String serverHost, Integer serverPort, String request)  {
        Socket socket = null;
       
        try {
            log.print( "connecting to " + serverHost + " ...");

            socket = new Socket( serverHost, serverPort);

            log.println( "\tconnected [OK], waiting response");

            var outputStream = socket.getOutputStream();

            // request
            outputStream.write( request.getBytes());
            outputStream.write( 0);
            
            // response
            var response = socket.getInputStream();
            int value;
            
            var strb = new StringBuilder();
            
            while( (value = response.read()) != 0) {
                strb.append( (char) value);
            }
            
            log.println( "respuesta obtenida");
            
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
    
    private void saveResponse( String ticket, String respuesta) {
        var path = AppProperties.getProperty( "response_path");
        var file = new File( path, "rsp_" + ticket + ".txt");
        
        try ( BufferedWriter writer = new BufferedWriter( new FileWriter( file)) ) {
            writer.write( respuesta);
            writer.flush();
            
        } catch( IOException ex) {
            ex.printStackTrace();
        }
    }

}
