package mx.com.neogen.code.beans;

import mx.com.neogen.code.enums.OperatorTypeEnum;

public class Operator {
    
    private final OperatorTypeEnum type;
    private final String value;
    private final String symbol;
    private final int precedence;
    
    
    public Operator( OperatorTypeEnum type, String value, String symbol, int precedence) {
        super();
        
        this.type  = type;
        this.value = value;
        this.symbol = symbol;
        this.precedence = precedence;
    }
    
    public Operator( OperatorTypeEnum type, String value, int precedence) {
        this(type, value, value, precedence);
    }
    
    
    public OperatorTypeEnum getType() {
        return type;
    }

    public String getValue() {
        return value;
    }
    
    public String getSymbol() {
        return symbol;
    }
    
    public int getPrecedence() {
        return precedence;
    }
    

    public Object execute(  Object... values) {
        throw new IllegalStateException( "Subclasses may provide implementation for this method");
    }
    
    
    @Override
    public String toString() {
        return value;
    }
    
}
