package mx.com.neogen.test.code.impls;

import mx.com.neogen.code.interfaces.Translator;
import mx.com.neogen.code.beans.Node;
import mx.com.neogen.code.beans.Operand;
import mx.com.neogen.code.enums.OperandTypeEnum;

public class TextTreeTranslator implements Translator {

    public TextTreeTranslator() {
        super();
    }
    
    
    @Override
    public String translate( String signal, Node root) {
        return translate( root, 0);
    }
    
    protected String translate( Node node, int level) {
        var strb = new StringBuilder();

        tabs( strb, level);
        
        strb.append( "[").append( node.getOperator()).append( "]");
        
        for( Operand operand : node.getOperands()) {
            strb.append( translate( operand, level + 1));
        }
        
        return strb.toString();
    }
    
    protected String translate( Operand operand, int level) {
        var strb = new StringBuilder();

        if( operand.getType().equals( OperandTypeEnum.EXPRESSION)) {
            strb.append( translate( (Node) operand.getValue(), level));
        } else {
            tabs( strb, level);
            strb.append( operand.getValue());
        }
        
        return strb.toString();
    }
    
    private void tabs( StringBuilder strb, int level) {
        strb.append( "\n");
        
        for( int i = 0; i < level; ++i) {
            strb.append( "    ");
        }
    }
            
}
