package mx.com.neogen.code.beans;

import mx.com.neogen.code.enums.SignalTypeEnum;

public class Signal {
    
    private String name;
    private SignalTypeEnum type;    // input, output, memory
    private SignalTarget target;    // pin         , location

    
    public Signal() {
        super();
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public SignalTypeEnum getType() {
        return type;
    }

    public void setType(SignalTypeEnum type) {
        this.type = type;
    }

    public SignalTarget getTarget() {
        return target;
    }

    public void setTarget(SignalTarget target) {
        this.target = target;
    }

    @Override
    public String toString() {
        return "signal: {name: " + name + ", type: " + type + ", target: " + target + "}";
    }
    
}
