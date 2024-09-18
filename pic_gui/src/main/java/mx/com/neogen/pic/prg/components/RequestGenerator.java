package mx.com.neogen.pic.prg.components;

import com.eurk.core.util.UtilBean;
import com.eurk.core.util.UtilStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import mx.com.neogen.commons.exception.PeticionIncorrectaException;
import mx.com.neogen.pic.beans.metadata.DeviceBufferMetadata;
import mx.com.neogen.pic.hexfile.RawDataToBuffer;


public class RequestGenerator {
	
    /**
     *  Genera la peticion de acuerdo al dispositivo | accion | archivo hex
     * 
     */
	public String generateRequest( String device, String action, File hexFile) throws IOException {
        
        // metadatos del dispositivo
        var metadata = obtenerMetadata( device);
        trimMetadata( metadata, obtenerArea( action));
        
        // preparacion de device buffer
        var operation = obtenerOperacion( action);
        var buffer = RawDataToBuffer.initDeviceBuffer( hexFile, metadata);
        
        // generación de peticion
        
        return DataFormatter.formatRequest( metadata, operation, buffer);
    }
    
    private DeviceBufferMetadata obtenerMetadata( String device) throws IOException {
        try (
            InputStream inputStream = UtilStream.obtenerRecursoAsStream( device + ".json");
        ) {
            return UtilBean.parseBean( inputStream,  DeviceBufferMetadata.class);
        }
    }
    
    private String obtenerOperacion( String action) {
        var idx = action.indexOf( '_');
        return idx == -1 ? action : action.substring( 0, idx);
    }
    
    private String obtenerArea( String action) {
        var idx = action.indexOf( '_');
        return idx == -1? null : action.substring( idx + 1);
    }
        
    private void trimMetadata( DeviceBufferMetadata metadata, String area) {
        if ( area == null) {
            return;
        }
        
        switch ( area) {
            case "data"   : metadata.setConfig(  null); metadata.setProgram( null); break;
            case "program": metadata.setConfig(  null); metadata.setData(    null); break;
            case "config" : metadata.setProgram( null); metadata.setData(    null); break;
            default:
                throw new PeticionIncorrectaException( "Area de memoria no valida / reconocida: " + area);
        }
    }
        
}
