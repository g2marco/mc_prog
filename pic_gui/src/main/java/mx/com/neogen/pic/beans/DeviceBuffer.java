package mx.com.neogen.pic.beans;


/**
 *	Values of all memory areas in a device
 *
 *	@author Marco Antonio Garcia Garcia		g2marco@yahoo.com.mx
 */
public class DeviceBuffer {

    private Bank[] program;
    private Bank[] data;
    private Integer[] config;
    

	public DeviceBuffer() {
		super();
	}
    

    public Bank[] getProgram() {
        return program;
    }

    public void setProgram(Bank[] program) {
        this.program = program;
    }

    public Bank[] getData() {
        return data;
    }

    public void setData(Bank[] data) {
        this.data = data;
    }

    public Integer[] getConfig() {
        return config;
    }

    public void setConfig( Integer[] config) {
        this.config = config;
    }
    
}