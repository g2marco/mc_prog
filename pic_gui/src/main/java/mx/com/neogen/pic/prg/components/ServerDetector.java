package mx.com.neogen.pic.prg.components;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.Optional;
import mx.com.neogen.commons.messages.Logger;
import mx.com.neogen.server.util.AppProperties;

public class ServerDetector {

    private final Logger LOG;
    private int intentos;
    
    
    public ServerDetector( Logger log) {
        super();
        LOG = log;
    }
    
    
    public Optional<String> find() {
        var lastServerIP = AppProperties.getProperty( "serverHost");
        var serverPort   = Integer.valueOf( AppProperties.getProperty( "serverPort"));
        
        Optional<String> nextIP = Optional.of( lastServerIP);
        boolean found   = false;
        intentos = 0;
        
        while ( !found && nextIP.isPresent()) {
           var serverIP = nextIP.get();
                    
            LOG.print( "checking IP: " + serverIP);

            try {
                found = "ggma".equals( requestServer( serverIP, serverPort));
                LOG.println( "\tservice found [OK]");
                
            } catch ( IOException ex) {
                LOG.println(  "\tservice NOT found");
            }

            if( !found) {
                intentos++;
                nextIP = getNextIP( serverIP);
            }
        }

        return nextIP;
    }

    private String requestServer( String serverIP, Integer serverPort) throws IOException {
        Socket socket = null;

        try {
            socket = new Socket();
            socket.connect( new InetSocketAddress( serverIP, serverPort), 2000);

            OutputStream outputStream = socket.getOutputStream();

            // request
            outputStream.write( "ggma".getBytes());
            outputStream.write( 0);

            // response
            final InputStream response = socket.getInputStream();

            final StringBuilder strb = new StringBuilder();
            int value;

            while( (value = response.read()) != 0) {
                strb.append( (char) value);
            }

            return strb.toString();

        } finally {
            close( socket);
        }
    }

    private void close( Socket socket) {
        if (socket == null ||  socket.isClosed()) {
            return;
        }

        try {
            socket.close();
        } catch (Exception ex) {
            System.out.println( ex.getMessage());
        }
    }

    private Optional<String> getNextIP( String last) {
       
        int idxValue = last.lastIndexOf( ".") + 1;
        int value = Integer.parseInt( last.substring( idxValue));
        value += (intentos % 2) == 1? intentos : -intentos;

        return (value == 1 || value == 255)? Optional.empty() : Optional.of( last.substring( 0, idxValue) + value);
    }

}
