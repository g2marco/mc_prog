package mx.com.neogen.pic.prg.beans;

import mx.com.neogen.pic.beans.DeviceBuffer;


public class ItemTicket {
    
    private String ticket;
    private boolean done;
    private DeviceBuffer data;
    private String device;
    
    
    public ItemTicket() {
       this( null);
    }
    
    public ItemTicket( String ticket) {
        super();    
        this.ticket = ticket;
    }
    
    
    public String getTicket() {
        return ticket;
    }

    public void setTicket(String ticket) {
        this.ticket = ticket;
    }

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }

    public DeviceBuffer getData() {
        return data;
    }

    public void setData(DeviceBuffer data) {
        this.data = data;
    }

    public String getDevice() {
        return device;
    }

    public void setDevice(String device) {
        this.device = device;
    }
    
}
