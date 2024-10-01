package mx.com.neogen.code.beans;

import java.util.List;

public class Assignment {
    
    private String signal;
    private List<AssignmentElement> elements;
    
    
    public Assignment() {
        super();
    }


    public String getSignal() {
        return signal;
    }

    public void setSignal(String signal) {
        this.signal = signal;
    }

    public List<AssignmentElement> getElements() {
        return elements;
    }

    public void setElements(List<AssignmentElement> elements) {
        this.elements = elements;
    }
    
    
    @Override
    public String toString() {
        return "{signal: " + signal + ", elements: " + elements + "}";
    }

}
