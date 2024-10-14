package mx.com.neogen.pic.prg.enums;

import com.eurk.core.util.UtilBinary;

public enum PicDeviceEnum {

    // PIC12F683 datasheet
    
    PIC12F635(  "00 1111 101x xxxx"),
    PIC12F683(  "00 0100 011x xxxx"),
    PIC16F631(  "01 0100 001x xxxx"),
    PIC16F636(  "01 0000 101x xxxx"),
    PIC16F639(  "01 0000 101x xxxx"),
    PIC16F677(  "01 0100 010x xxxx"),
    PIC16F684(  "01 0000 100x xxxx"),
    PIC16F685(  "00 0100 101x xxxx"),
    PIC16F687(  "01 0011 001x xxxx"),
    PIC16F688(  "01 0001 100x xxxx"),
    PIC16F689(  "01 0011 010x xxxx"),
    PIC16F690(  "01 0100 000x xxxx"),
    
    // PIC16F84A datasheet
    
    PIC16F84A(  "00 0101 011x xxxx"),
    
    // PIC16F627A datasheet
    
    PIC16F627A( "01 0000 010x xxxx"),
    PIC16F628A( "01 0000 011x xxxx"),
    PIC16F648A( "01 0001 000x xxxx");
    
    private final int id;
    
    private PicDeviceEnum( String id) {
        this.id = UtilBinary.parseBinaryString( id.replace( 'x', '0'));
    }
    
    
    public static PicDeviceEnum find( int id) {
        int mask = UtilBinary.parseBinaryString( "11 1111 1110 0000");
        for ( var value : values()) {
            if ( value.id == (id & mask)) {
                return value;
            }
        }
        
        return null;
    }
    
}
