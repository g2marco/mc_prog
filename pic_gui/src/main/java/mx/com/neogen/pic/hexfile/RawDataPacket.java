package mx.com.neogen.pic.hexfile;

import com.eurk.core.util.UtilBinary;


/**
 *	<p>	This class represents a single line of data from an hex file.</p>
 *	<p>	Each raw data packect is composed by:
 *		<ul>
 *			<li>The starting address word (two bytes).</li>
 *			<li>N data bytes consecutively placed in low-high order.</li>
 *		</ul>
 *	</p>
 *	@author Marco Antonio García García		g2marco@yahoo.com.mx
 */
public class RawDataPacket {

	private short startAddress;		//		start address word 
	private short[]	   rawData;		//		consecutive data bytes

	/**
	 * 	<p>	Initilizes this raw data packet with the start address and 
	 *  	the data in a singe row.
	 *  </p>
	 * 
	 * @param startAddress
	 * 		<p> Start address of the data packet.</p>
	 * @param rawData
	 * 		<p> Actual data bytes from the line.</p>
	 */
	public RawDataPacket(	final short startAddress, final short[] rawData) {
		this.startAddress  = startAddress;
		this.rawData       = rawData;
	}


	/**
	 * 	<p> Returns the start address of this data packet.</p>
	 */
	public short getStartAddress() {
		return this.startAddress;
		
	}

	/**
	 * 	<p>	Returns the data bytes of this packet.</p>
	 */
	public short[] getRawData() {
		return this.rawData;
	}

	@Override
	public String toString() {
		final StringBuilder strb = new StringBuilder();
		
		strb.append( "[addr=").append( startAddress).append( ", data= ");
		
		for ( short dataByte : rawData){
			strb.append( UtilBinary.toHexString( dataByte)).append( " ");
		}
		
		return strb.toString();
	}
	
}