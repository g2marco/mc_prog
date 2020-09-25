package mx.com.neogen.pic.beans.metadata;

import com.eurk.core.util.UtilReflection;

/**
 *  Each memory area is a set of memory banks
 *      This class stores information about a memory bank
 *
 * @author Marco Antonio Garcia Garcia		g2marco@yahoo.com.mx
 */
public class BankMetadata {

	private String name;
	private int startAddress;
	private int length;

    
	public BankMetadata() {
		super();
	}


	public String getName() {
		return name;
	}

	public void setName( String name) {
		this.name = name;
	}

	public int getStartAddress() {
		return startAddress;
	}

	public void setStartAddress( int startAddress) {
		this.startAddress = startAddress;
	}

	public int getLength() {
		return length;
	}

	public void setLength( int length) {
		this.length = length;
	}

    
    @Override
    public String toString() {
        return UtilReflection.toString( this);
    }
    
}