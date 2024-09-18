package mx.com.neogen.pic.prg.services;

import com.eurk.core.beans.respuesta.RespuestaItemWS;
import com.eurk.core.beans.respuesta.RespuestaWS;
import com.eurk.core.util.UtilBean;
import com.eurk.core.util.UtilStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import mx.com.neogen.commons.exception.InfraestructuraException;
import mx.com.neogen.pic.beans.DeviceBuffer;
import mx.com.neogen.pic.prg.beans.ItemTicket;
import mx.com.neogen.pic.prg.components.DataFormatter;
import mx.com.neogen.pic.prg.components.TicketManager;
import mx.com.neogen.pic.prg.enums.PicDeviceEnum;
import mx.com.neogen.server.app.HttpRequest;
import mx.com.neogen.server.app.Response;
import mx.com.neogen.server.util.AppProperties;
import mx.com.neogen.server.util.HttpBaseRunner;

/**
 *  route: GET: /_data_/get/ticket/{id}
 * 
 *      - consulta ticket
 *      - devuelve status + [respuesta]
 * 
 */
public class TicketResponseServlet extends HttpBaseRunner {

    @Override
    protected void execute(HttpRequest request, Response response) throws IOException {
        var ticket = request.getRouteParams().get( "id");
        
        var item = generarRespuesta( ticket);
        
        response.addHeader( "Content-Type", "application/json; charset=utf-8");
        response.write( UtilBean.objectToByteArray( item));
    }
    
    private RespuestaWS generarRespuesta( String ticket) {
        
        var item = new ItemTicket( ticket);      
        
        try {
            if ( TicketManager.isDone( ticket)) {
                item.setDone( true);
                
                var data = parseResponse( AppProperties.getProperty( "response_path"), ticket);
                item.setData( data);
                
                if ( data.getConfig() != null && data.getConfig().length != 0) {
                    item.setMetadata( readMetadata( data.getConfig()));
                }
            }
            
            return new RespuestaItemWS<>(item);
            
        } catch( Exception ex) {
            return new RespuestaWS( ex);
        }
    }
    
    private DeviceBuffer parseResponse( String path, String ticket) {
        var file = new File( path, "rsp_" + ticket + ".txt");
        var lines = UtilStream.leerLineasArchivo( file);
        
        if ( lines.isEmpty()) {
            throw new InfraestructuraException( "Respuesta vacía, situación de error desconocida");
        }
        
        if ( !lines.get( 0).startsWith( "o=")) {
            // error / exception
            throw new InfraestructuraException( String.join( "\n", lines));
        }
        
        return DataFormatter.parseResponse( lines);
    }
    
    private String readMetadata( Integer[] locations) throws IOException {
        var device = PicDeviceEnum.find( locations[6]);
        
        try (
            InputStream inputStream = UtilStream.obtenerRecursoAsStream( device.name() + "_config.json");
        ) {
            var mapa = (Map) UtilBean.parseBean( inputStream, Map.class);
            mapa.put( "device", device.name());
            
            return new String( UtilBean.objectToByteArray( mapa));
        }
    }
    
}
