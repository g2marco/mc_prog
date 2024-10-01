package mx.com.neogen.code.beans;

import java.util.List;

public class BeanProgram {

    private final List<Signal> signals;
    private final List<Assignment> assignments;
    
    
    public BeanProgram( List<Signal> signals, List<Assignment> assignments) {
        super();
        this.signals = signals;
        this.assignments = assignments;
    }

    public List<Signal> getSignals() {
        return signals;
    }

    public List<Assignment> getAssignments() {
        return assignments;
    }

    @Override
    public String toString() {
        var strb = new StringBuilder();
        
        list( strb, "signals", signals);
        list( strb, "assignments", assignments);
        
        return strb.toString();
    }
    
    private void list( StringBuilder strb, String title,  List<? extends Object> items) {
        strb.append( "\n").append( title).append( ":");
        
        for( Object item : items) {
            strb.append( "\n\t").append( item);
        }
    }
    
}
