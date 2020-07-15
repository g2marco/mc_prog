package mx.com.neogen.pic.beans.metadata;

import com.eurk.core.util.UtilReflection;

/**
 *  Represents a single location in the configuratión memory
 *
 * @author Marco Antonio Garcia Garcia		g2marco@yahoo.com.mx
 */
public class LocationMetadata {

	private String   name;
	private int   address;
	private boolean  read;
    private boolean write;
    private String  value;
    
    
	public LocationMetadata() {
		super();
	}
    
    
	public String getName() {
		return name;
	}

	public void setName( String name) {
		this.name = name;
	}

	public int getAddress() {
		return address;
	}

	public void setAddress( int address) {
		this.address = address;
	}

    public boolean isRead() {
        return read;
    }

    public void setRead(boolean read) {
        this.read = read;
    }

    public boolean isWrite() {
        return write;
    }

    public void setWrite(boolean write) {
        this.write = write;
    }

    public String getValue() {
        return value;
    }
    
    public void setValue( String value) {
        this.value = value;
    }
    
    
    
    @Override
    public String toString() {
        return UtilReflection.toString( this);
    }
    
}