package mx.com.neogen.pic.prg.services;

import com.eurk.core.beans.respuesta.RespuestaItemWS;
import com.eurk.core.util.UtilBean;
import com.eurk.core.util.UtilStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import mx.com.neogen.commons.exception.InfraestructuraException;
import mx.com.neogen.commons.exception.NegocioException;
import mx.com.neogen.server.app.HttpRequest;
import mx.com.neogen.server.app.Response;
import mx.com.neogen.server.util.HttpBaseRunner;

/**
 *  route: GET: /data/get/metadata/{id}
 * 
 *      - consulta y devuelve los metadatos del dispositivo solicitado
 * 
 */
public class MetadataRequestServlet extends HttpBaseRunner {

    @Override
    protected void execute(HttpRequest request, Response response) throws IOException {
        var device = request.getRouteParams().get( "id");
        
        InputStream inputStream = null;
        
        try {
            inputStream = UtilStream.obtenerRecursoAsStream( device + "_config.json");
            
            if( inputStream == null) {
                throw new NegocioException( "No available metadata for device: " + device);
            }
            
            var item = new RespuestaItemWS<Map>( (Map) UtilBean.parseBean( inputStream, Map.class));
            
            response.addHeader( "Content-Type", "application/json; charset=utf-8");
            response.write( UtilBean.objectToByteArray( item));
            
        } catch( IOException ex) {
            throw new InfraestructuraException( "Error while reading metadata file", ex);
        
        } finally {
            UtilStream.close( inputStream);
        
        }
    }
    
}
