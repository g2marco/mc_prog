package com.mycompany.mavenproject1;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class Datagram {
    private static DatagramSocket socket = null;
 
    public static void main(String[] args) throws Exception {   

        // escucha respuestas
        DatagramSocket escucha = new DatagramSocket();
        
        byte[] request = { 'a'};
        DatagramPacket dgp = new DatagramPacket( request, request.length, InetAddress.getByName( "192.168.1.79"), 9797);
        
        escucha.send( dgp);
        
        dgp = new DatagramPacket( request, request.length);
        escucha.receive( dgp);
        
        byte[] response = dgp.getData();
        System.out.println("response: " + new String( response) );
    }
 
    public static void broadcast( String broadcastMessage, InetAddress address) throws IOException {
        socket = new DatagramSocket();
        socket.setBroadcast(true);
 
        byte[] buffer = broadcastMessage.getBytes();
 
        DatagramPacket packet = new DatagramPacket(buffer, buffer.length, address, 9797);
        
        socket.send( packet);
        
        socket.close();
    }
    
}