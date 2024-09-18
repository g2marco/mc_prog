package mx.com.neogen.pic.beans.metadata;


public class DeviceBufferMetadata {
    
    private BankMetadata[] program;
    private BankMetadata[] data;
    private LocationMetadata[] config;

    
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

    public LocationMetadata[] getConfig() {
        return config;
    }

    public void setConfig( LocationMetadata[] config) {
        this.config = config;
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
        for( LocationMetadata location : config) {
            strb.append( "\n\t\t").append( location);
        }
        
        return strb.toString();
    }
    
}
