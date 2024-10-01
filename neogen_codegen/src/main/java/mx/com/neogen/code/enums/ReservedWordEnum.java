package mx.com.neogen.code.enums;


public enum ReservedWordEnum {
    IS(               "is"),
    WHEN(           "when"),
    FOR(             "for"),
    EVERY(         "every"),
    WHILE(         "while"),
    UNTIL(         "until"),
    OTHERWISE( "otherwise"),
    COMA(              ",");

    private String value;
    
    private ReservedWordEnum( String value) {
        this.value = value;
    }
    
    
    public String getValue() {
        return value;
    }
    
    
    public static ReservedWordEnum obtenerValor( String token) {
        if ( token == null || token.isBlank()) {
            return null;
        }
        
        var value = token.toLowerCase();
        
        for ( ReservedWordEnum item : values()) {
            if( item.value.equals( value)) {
                return item;
            }
        }
        
        return null;
    }
    
}
