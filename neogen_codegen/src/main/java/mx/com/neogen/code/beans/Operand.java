package mx.com.neogen.code.beans;

import mx.com.neogen.code.enums.OperandTypeEnum;

/**
 *  Each operand has a type which determines de value
 *      type = literal , value is a string representing a literal value
 *      type = variable, value is a string containing a variable name
 *      type = expression, value is a node
 */
public class Operand {
    
    private OperandTypeEnum type;
    private Object value;
    
    
    public Operand() {
        super();
    }

    public OperandTypeEnum getType() {
        return type;
    }

    public void setType(OperandTypeEnum type) {
        this.type = type;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return value.toString();
    }

}
