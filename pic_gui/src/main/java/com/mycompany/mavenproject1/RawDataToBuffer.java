package com.mycompany.mavenproject1;

import com.eurk.core.util.UtilBinary;
import java.io.IOException;
import mx.com.neogen.pic.hexfile.INHX8MFileReader;
import mx.com.neogen.pic.hexfile.RawDataPacket;

public class RawDataToBuffer {


    public StringBuilder createRequest( INHX8MFileReader reader) throws IOException {
        StringBuilder strb = new StringBuilder();
        
        strb.append( "o=p").append( "\n");
        strb.append( "a=c8,p1,d1").append( "\n");
        strb.append( "v=n").append( "\n");
        strb.append( "p0i=0").append( "\n");
        strb.append( "p0l=1024").append( "\n");
        strb.append( "p0v=");
        
        RawDataPacket packet;
        short[] banco = new short[1024];
        int idx;
        
        while ( (packet = reader.read()) != null) {
            idx = packet.getStartAddress() /2;
            System.out.println("idx: " + idx);
            for( int j = 0; j <packet.getRawData().length; j = j + 2) {
                banco[idx++] = UtilBinary.createWord( packet.getRawData()[j], packet.getRawData()[j +1]);
            }
        }
        for( int i = 0 ; i < banco.length; ++i) {
            if ( i != 0) {
                strb.append( ",");
            }
            strb.append( banco[i]);
        }
        
        strb.append( "\n");
        strb.append( "d0i=0").append( "\n");
        strb.append( "d0l=224").append( "\n");
        strb.append( "d0v=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0").append( "\n");
        strb.append( "c0a=8192").append( "\n");
        strb.append( "c0i=ID0").append( "\n");
        strb.append( "c0v=255").append( "\n");
        strb.append( "c0r=t").append( "\n");
        strb.append( "c0w=t").append( "\n");
        strb.append( "c1a=8193").append( "\n");
        strb.append( "c1i=ID1").append( "\n");
        strb.append( "c1v=0").append( "\n");
        strb.append( "c1r=t").append( "\n");
        strb.append( "c1w=t").append( "\n");
        strb.append( "c2a=8194").append( "\n");
        strb.append( "c2i=ID2").append( "\n");
        strb.append( "c2v=255").append( "\n");
        strb.append( "c2r=t").append( "\n");
        strb.append( "c2w=t").append( "\n");
        strb.append( "c3a=8195").append( "\n");
        strb.append( "c3i=ID3").append( "\n");
        strb.append( "c3v=170").append( "\n");
        strb.append( "c3r=t").append( "\n");
        strb.append( "c3w=t").append( "\n");
        strb.append( "c4a=8196").append( "\n");
        strb.append( "c4i=Reserved").append( "\n");
        strb.append( "c4r=f").append( "\n");
        strb.append( "c4w=f").append( "\n");
        strb.append( "c5a=8197").append( "\n");
        strb.append( "c5i=Reserved").append( "\n");
        strb.append( "c5r=f").append( "\n");
        strb.append( "c5w=f").append( "\n");
        strb.append( "c6a=8198").append( "\n");
        strb.append( "c6i=Device ID").append( "\n");
        strb.append( "c6v=4160").append( "\n");
        strb.append( "c6r=t").append( "\n");
        strb.append( "c6w=f").append( "\n");
        strb.append( "c7a=8199").append( "\n");
        strb.append( "c7i=Configuration").append( "\n");
        strb.append( "c7v=16152").append( "\n");
        strb.append( "c7r=t").append( "\n");
        strb.append( "c7w=t").append( "\n");
    
        return strb;
    }
        
    
}
