package com.mycompany.mavenproject1;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

public class Main {

    public static void main(String[] args)  {   
 
        Socket socket = null;
       
        try {
            socket = new Socket( "192.168.1.79", 9734);
            
            OutputStream outputStream = socket.getOutputStream();
            
            InputStream txtFile = new FileInputStream( "D:\\tmp\\request.txt");
        
            // request
            send( txtFile, outputStream);    
            outputStream.write( 0);
            
            // response
            InputStream response = socket.getInputStream();
            int value;
            
            StringBuilder strb = new StringBuilder();
            
            while( (value = response.read()) != 0) {
                strb.append( (char) value);
            }
            
            System.out.println("respuesta:\n" + strb.toString());
            
        } catch ( Exception ex) {
            ex.printStackTrace();
            
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
    
    private static void send( InputStream inputStream, OutputStream outputStream) throws IOException {
        
        byte[] buffer = new byte[1024];
        int bytes;
        
        while( (bytes = inputStream.read( buffer)) > 0) {
            outputStream.write( buffer, 0, bytes);
        }
        
        inputStream.close();
          
    }
    
}
