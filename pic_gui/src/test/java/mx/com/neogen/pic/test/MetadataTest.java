package mx.com.neogen.pic.test;

import com.eurk.core.util.UtilBean;
import com.eurk.core.util.UtilStream;
import java.io.InputStream;
import mx.com.neogen.commons.messages.AppLogger;
import mx.com.neogen.pic.beans.metadata.DeviceBufferMetadata;

public class MetadataTest {
    
    private static AppLogger LOG = AppLogger.getLogger( MetadataTest.class);
            
    
    public static void main(String[] args) {
        
        try (
            InputStream inputStream = UtilStream.obtenerRecursoAsStream( "PIC16F627A-device-buffer.json");
        ) {
            final DeviceBufferMetadata metadata = UtilBean.parseBean( inputStream, DeviceBufferMetadata.class);
            LOG.debug( metadata);
            
        } catch ( Exception ex) {
            LOG.error( "Error al obtener medatadatos de dispositivo", ex);
            
        }
        
    }
}
