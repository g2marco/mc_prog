package mx.com.neogen.code.beans;

import mx.com.neogen.code.enums.TargetTypeEnum;


public class SignalTarget {
    
    private String name;
    private TargetTypeEnum type;
    
    
    public SignalTarget() {
        super();
    }

    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public TargetTypeEnum getType() {
        return type;
    }

    public void setType(TargetTypeEnum type) {
        this.type = type;
    }

    public int getIndex() {
        return Integer.valueOf( name.substring( name.length() - 1));
    }
    
    @Override
    public String toString() {
        return "{name: " + name + ", type: " + type + "}";
    }
    
}
