package mx.com.neogen.pic.prg.services;

import com.eurk.core.beans.respuesta.RespuestaItemWS;
import com.eurk.core.util.UtilBean;
import java.io.File;
import java.io.IOException;
import mx.com.neogen.commons.messages.Logger;
import mx.com.neogen.pic.prg.beans.ItemTicket;
import mx.com.neogen.pic.prg.components.RequestGenerator;
import mx.com.neogen.server.app.HttpRequest;
import mx.com.neogen.server.app.Response;
import mx.com.neogen.server.util.HttpBaseRunner;


public class BufferRequestServlet extends HttpBaseRunner {
    private final Logger log;

    public BufferRequestServlet( Logger log) {
        super();
        this.log = log;
    }
    
    
    @Override
    protected void execute( HttpRequest request, Response response) throws IOException {
        var action = request.getParams().get( "action");
        var device = request.getRouteParams().get( "id");
        
        var generator = new RequestGenerator();  
        var item = new ItemTicket(); 
        item.setData( generator.generateBuffer( device, action, getFile( request)));
        
        response.addHeader( "Content-Type", "application/json; charset=utf-8");
        response.write( UtilBean.objectToByteArray( new RespuestaItemWS<>(item)));
    }
    
    private File getFile( HttpRequest request) {
        if ( request.getFiles().isEmpty()) { 
            return null;
        }
        
        File file = null;
        
        for( var entry : request.getFiles().entrySet()) {
            file = entry.getValue().getFile();
        }
        
        return file;
    }
    
}
