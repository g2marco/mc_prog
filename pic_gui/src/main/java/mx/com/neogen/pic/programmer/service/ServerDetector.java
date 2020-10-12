package mx.com.neogen.pic.programmer.service;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class ServerDetector {

    private final Logger LOG;

    public ServerDetector( Logger log) {
        super();
        LOG = log;
    }

    public String find( String lastServerIP) {
        final List<String> ips = new ArrayList<>();

        boolean found   = false;
        boolean ipsDone = false;
        String serverIP = lastServerIP;

        while ( !found && !ipsDone) {
            LOG.info( "checking IP: " + serverIP);

            try {
                found = "ggma".equals( requestServer( serverIP));
                LOG.info( "\tservice found [OK]");
            } catch ( IOException ex) {
                LOG.info(  "\tservice NOT found");
            }

            if( !found) {
                serverIP = getNextIP(ips, serverIP);
                ipsDone  = serverIP == null;
            }
        }

        if( found) {
            return serverIP;
        } else {
            throw new RuntimeException( "No PIC-PROGRAMMER server found");
        }
    }

    private String requestServer( String serverIP) throws IOException {
        Socket socket = null;

        try {
            socket = new Socket();
            socket.connect( new InetSocketAddress( serverIP, 9734), 500);

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

    private String getNextIP( List<String> ips, String serverIP) {
        ips.add( serverIP);

        int i = ips.size();
        boolean isPositivo = (i % 2) == 1;

        int value = Integer.valueOf( serverIP.substring( serverIP.lastIndexOf( ".") + 1));
        value += isPositivo? i : -i;

        if( value == 1 || value == 255) {
            return null;
        } else {
            return serverIP.substring( 0, serverIP.lastIndexOf( ".") + 1) + value;
        }
    }

}
