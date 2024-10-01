package mx.com.neogen.code.beans;

/**
 *  - Un nodo define una operacion (operator) y sus operandos (1 o mas)
 *  - Lo operandos pueden ser variables, literales, o bien otros nodos que deben ser evaluados primero
 */
public class Node {
    
    private Operator operator;
    private Operand[] operands;

    
    public Node() {
        super();
    }
    
    
    public Operator getOperator() {
        return operator;
    }

    public void setOperator(Operator operator) {
        this.operator = operator;
    }

    public Operand[] getOperands() {
        return operands;
    }

    public void setOperands(Operand[] operands) {
        this.operands = operands;
    }

    @Override
    public String toString() {
        if( operands.length == 1) {
            return "(" + (operator == null? "" : operator) + " " + operands[0] + ")";
        } else {
            return "(" + operands[0] + operator + operands[1] + ")";
        }
    }
    
}
