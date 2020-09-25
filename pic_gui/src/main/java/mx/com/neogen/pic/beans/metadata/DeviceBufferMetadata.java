package mx.com.neogen.pic.beans.metadata;

import com.eurk.core.util.UtilReflection;


public class DeviceBufferMetadata {
    
    private BankMetadata[] program;
    private BankMetadata[] data;
    private LocationMetadata[] configuration;

    
    public DeviceBufferMetadata() {
        super();
    }

    
    public BankMetadata[] getProgram() {
        return program;
    }

    public void setProgram(BankMetadata[] program) {
        this.program = program;
    }

    public BankMetadata[] getData() {
        return data;
    }

    public void setData(BankMetadata[] data) {
        this.data = data;
    }

    public LocationMetadata[] getConfiguration() {
        return configuration;
    }

    public void setConfiguration(LocationMetadata[] configuration) {
        this.configuration = configuration;
    }
    
    
    @Override
    public String toString() {
        final StringBuilder strb = new StringBuilder();
        
        strb.append( "\ndevice metadata");
        
        strb.append( "\n\tprogram:");
        for( BankMetadata bank : program) {
            strb.append( "\n\t\t").append( bank);
        }
        
        strb.append( "\n\tdata:");
        for( BankMetadata bank : data) {
            strb.append( "\n\t\t").append( bank);
        }
        
        strb.append( "\n\tconfiguraion:");
        for( LocationMetadata location : configuration) {
            strb.append( "\n\t\t").append( location);
        }
        
        return strb.toString();
    }
    
}
