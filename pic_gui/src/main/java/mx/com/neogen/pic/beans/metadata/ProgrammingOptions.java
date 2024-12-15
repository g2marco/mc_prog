package mx.com.neogen.pic.beans.metadata;

import com.eurk.core.util.UtilReflection;


public class ProgrammingOptions {
    private Integer programmingType;
    private Integer bulkEraseType;
    private Integer cpDisableType;
    private String  cpDisableWord;
    
    
    public ProgrammingOptions() {
        super();
    }

    
    public Integer getProgrammingType() {
        return programmingType;
    }

    public void setProgrammingType( Integer programmingType) {
        this.programmingType = programmingType;
    }

    public Integer getBulkEraseType() {
        return bulkEraseType;
    }

    public void setBulkEraseType(Integer bulkEraseType) {
        this.bulkEraseType = bulkEraseType;
    }

    public Integer getCpDisableType() {
        return cpDisableType;
    }

    public void setCpDisableType(Integer cpDisableType) {
        this.cpDisableType = cpDisableType;
    }

    public String getCpDisableWord() {
        return cpDisableWord;
    }

    public void setCpDisableWord(String cpDisableWord) {
        this.cpDisableWord = cpDisableWord;
    }

    
    @Override
    public String toString() {
        return UtilReflection.toString( this);
    }
    
}
