package mx.com.neogen.code.enums;


public enum SignalTypeEnum {
    input ( 1),
    output( 0),
    memory( -1);
    
    int direction;
    
    SignalTypeEnum( int direction) { 
        this.direction = direction;
    }
    
    
    public int getDirection() {
        return direction;
    }
}
