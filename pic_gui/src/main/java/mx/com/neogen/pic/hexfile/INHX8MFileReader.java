package mx.com.neogen.pic.hexfile;

import com.eurk.core.util.UtilBinary;
import com.eurk.core.util.UtilStream;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.text.MessageFormat;
import mx.com.neogen.commons.exception.FormatoInvalidoException;
import mx.com.neogen.commons.exception.OperacionNoRealizadaException;

/**
 * 	<p> This class reads an INHX8M file line by line. For each line in the 
 * 		file, a RawDataPacket is generated.
 * 	</p>
 * 	<p> Each line of an INHX8M file has the following format:
 * 		<br/>:NNAAAATTLLHHLLHH...LLHHCC
 * 		<br/>, where:
 * 		<ul>
 * 			<li>':' is the start of a data line.</li>
 * 			<li>'NN' is an even number [0x00-0x10], it is the number of bytes
 * 				included on the line.</li>
 * 			<li>'AAAA' is the address of first byte.</li>
 * 			<li>'TT' identifies type of the line
 * 				00 = regular data line
 * 				01 = end of file line
 * 			</li>
 * 			<li>'LLHHLLHH...LLHH' is a sequence of NN data bytes</li> 
 * 			<li>'CC' is a checksum byte.</li>
 * 		</ul>
 *	</p>
 *
 * @author Marco Antonio García García		g2marco@yahoo.com.mx
 */
public class INHX8MFileReader {

	private static final String MSG_OPEN_ERROR    = "Imposible to open file '{0}' for reading";
	private static final String MSG_INVALID_LINE  = "Line {0} is not valid for an INHX8M file: [{1}]";
	private static final String MSG_INVALID_CRC	  = "Line {0} has an invalid CRC value: [{1}]";
	private static final String MSG_INVALID_CHARS = "Line {0} contains invalid character: [{1}]";
	private static final String MSG_WRONG_LENGTH  = "Line {0} has an invalid length: [{1}]";
	
	// 		indexes of some specific fields in byte array
	private static final int IDX_NUMERO_BYTES 	= 0;
	private static final int IDX_INIT_ADDR_HIGH = 1;
	private static final int IDX_INIT_ADDR_LOW  = 2;
	private static final int IDX_DATA_START		= 4;
	
	/**
	 * 	<p>	The maximum line length of an INHX8M file line is 43 characters,
	 * 		(:10AAAA00+8*4+CC")
	 * 	</p>
	 * 	<p>	Such line contains 8 data words (16 bytes).</p>
	 */
	private static final int MAX_INHX8M_LINE_LENGTH = 43;

	/**
	 *	<p>	The minimum line length of an INHX8M file line is 11 characters,
	 *		(:00XXXX01CC)
	 *	</p>
	 *	<p>	This line contains no data words.</p>
	 */
	private static final int MIN_INHX8M_LENGTH = 11;

	
	private BufferedReader reader;
	private int lineNumber;
	

	/**
	 * 	<p>	Creates a reader from a file path.</p>
	 */
	public INHX8MFileReader( final String pathFile) {
		super();
		
		try {
			reader = new BufferedReader( new FileReader( pathFile));
			lineNumber = 0;
			
		} catch (Exception ex) {
			throw new OperacionNoRealizadaException( 
				MessageFormat.format(MSG_OPEN_ERROR, pathFile), ex
			);
		}
	}
	
	/**
	 * 	<p> Reads the next data line from the file </p>
	 *
	 * @return
	 * 		<p> A RawDataPacket object containing the information of the next
	 * 			line. It returns null when there is no more data lines 
	 * 			available. 
	 * 		</p>
	 * 		<p>	A run-time exception es thrown when trying to parse an invalid
	 * 			line.
	 * 		</p> 
	 */
	public RawDataPacket read() throws IOException {
		
		final String line = reader.readLine();
		lineNumber++;
		
		if ( !isValidLine( line)) {				// not a valid INHX8M line
			throw generateException(MSG_INVALID_LINE, line);
		}

		if ( isEOFLine(line)) {					// valid EOF line
            UtilStream.close( reader);
			return null;						
		}
		
		try {
			final short[] bytesInLine = toArray( line);
			
			if ( !isValidCRC( bytesInLine)) {	// CRC data doesn't match
				throw generateException( MSG_INVALID_CRC, line);
			}

			return createPacket( bytesInLine);

		} catch (NumberFormatException nfe) {
			throw generateException( MSG_INVALID_CHARS, line, nfe);

		} catch (IndexOutOfBoundsException ioobe) {
			throw generateException( MSG_WRONG_LENGTH, line, ioobe);
		
		} catch (Exception ex) {
			throw ex;
		}

	}

	/**
	 *	Validates an INHX8M data line.
	 *
	 * @param hexLine
	 * 		line of characteres read from a file
	 *
	 * @return
	 * 		'true' if it is a valid INHX8M line. It returns 'false' otherwise.
	 */
	private static boolean isValidLine( String hexLine) {
		
		// 		line must be not null
		if ( hexLine == null) {				return false;	}
		
		// 		line must start with ':'
		if ( !hexLine.startsWith( ":")) {	return false;	}

		// 		line must have a valid and even length 
		int lineLength = hexLine.length();
		if ( lineLength < MIN_INHX8M_LENGTH || lineLength > MAX_INHX8M_LINE_LENGTH) {
			return false;
		}
		if ( (lineLength - 1)%2 != 0) {		return false;	}
		
		//		line must be 'data' or 'eof' 
		return isDataLine( hexLine) || isEOFLine( hexLine);
		
	}

	// 		'data' line ID is '00'
	private static boolean isDataLine( String hexLine) {
		return hexLine.substring( 7, 9).equals( "00");
	}

	// 		'eof' line ID is '01'
	private static boolean isEOFLine( String hexLine) {
		return hexLine.substring( 7, 9).equals( "01");
	}

	// 		convert hex data to short values
	private static short[] toArray( String dataLine) {
		final int  length  = dataLine.length() / 2;
		final short[] array = new short[ length];
		
		int charPos = 1;
		
		for ( int i = 0;  i < length ; ++i, charPos += 2) {
			array[ i] = (short) Short.parseShort( 
				dataLine.substring( charPos, charPos + 2), 16
			);
		}
		return array;
	}

	//		runs CRC checsum of a line
	private static boolean isValidCRC( short[] dataBytes) {
		int suma = 0;
		for ( short data: dataBytes) {
			suma += data;
		}

		return (suma % 256) == 0;
	}

	// 		forms a RawDataPacket from the short array
	//		it uses short instead of byte in order to avoid sign problems
	//
	private static RawDataPacket createPacket( short[] dataBytes) {
		
		final short initAddres = UtilBinary.createWord( 
			dataBytes[ IDX_INIT_ADDR_LOW], dataBytes[ IDX_INIT_ADDR_HIGH]
		);

		final int dataLength = dataBytes[ IDX_NUMERO_BYTES];
		final short[]	data = new short[ dataLength];

		int i = IDX_DATA_START;
		for ( int pos = 0; pos < dataLength; ++pos) {
			data[pos] = dataBytes[ i++];
		}

		return new RawDataPacket( initAddres, data);
	}
	
	//		generates exception due to an error condition
	private RuntimeException generateException(	String msgPattern, String line	) {
		return new FormatoInvalidoException( MessageFormat.format( msgPattern, lineNumber, line));
	}
	
	//		generates exception due to an exception
	private RuntimeException generateException(	String msgPattern, String line, Throwable cause) {
		return new FormatoInvalidoException( MessageFormat.format( msgPattern, lineNumber, line), cause);
	}

}