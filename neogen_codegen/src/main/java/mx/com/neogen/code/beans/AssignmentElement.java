package mx.com.neogen.code.beans;

public class AssignmentElement {

    private String expression;
    private String conditionFor;
    private String conditionWhile;
    private String conditionEvery;
    private String conditionUntil;
    private String conditionWhen;

    
    public AssignmentElement() {
        super();
    }
    
    public String getExpression() {
        return expression;
    }

    public void setExpression(String expression) {
        this.expression = expression;
    }

    public String getConditionFor() {
        return conditionFor;
    }

    public void setConditionFor(String conditionFor) {
        this.conditionFor = conditionFor;
    }

    public String getConditionWhile() {
        return conditionWhile;
    }

    public void setConditionWhile(String conditionWhile) {
        this.conditionWhile = conditionWhile;
    }

    public String getConditionEvery() {
        return conditionEvery;
    }

    public void setConditionEvery(String conditionEvery) {
        this.conditionEvery = conditionEvery;
    }

    public String getConditionUntil() {
        return conditionUntil;
    }

    public void setConditionUntil(String conditionUntil) {
        this.conditionUntil = conditionUntil;
    }

    public String getConditionWhen() {
        return conditionWhen;
    }

    public void setConditionWhen(String conditionWhen) {
        this.conditionWhen = conditionWhen;
    }
    
    
    public String getTemplate() {
        var strb = new StringBuilder( "expr");
        
        if ( conditionFor   != null) { strb.append(   "_for"); }
        if ( conditionWhile != null) { strb.append( "_while"); }
        if ( conditionEvery != null) { strb.append( "_every"); }
        if ( conditionUntil != null) { strb.append( "_until"); }
    
        return strb.toString();
    }
    
    
    @Override
    public String toString() {
        return "expression: " + expression + 
            (conditionFor   == null? "" : ", for  : " + conditionFor  ) +
            (conditionWhile == null? "" : ", while: " + conditionWhile) +
            (conditionEvery == null? "" : ", every: " + conditionEvery) +
            (conditionUntil == null? "" : ", until: " + conditionUntil) +
            (conditionWhen  == null? "" : ", when : " + conditionWhen )
        ;
    }

}
