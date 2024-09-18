package mx.com.neogen.pic.prg.services;

import com.eurk.core.util.UtilBean;
import com.eurk.core.util.UtilText;
import java.io.File;
import java.io.IOException;
import mx.com.neogen.commons.messages.Logger;
import mx.com.neogen.pic.prg.beans.ItemTicket;
import mx.com.neogen.pic.prg.components.ProgrammingTask;
import mx.com.neogen.pic.prg.components.RequestGenerator;
import mx.com.neogen.pic.prg.components.TicketManager;
import mx.com.neogen.server.app.HttpRequest;
import mx.com.neogen.server.app.Response;
import mx.com.neogen.server.util.HttpBaseRunner;

/**
 *  ruta: POST: /_data_/manage/device/{id}?action={action}
 *   
 *  - registra la accion 
 *  - encarga su ejecución
 *  - devuelve el número de ticket
 * 
 *  operacion                                           !    request data
 *  ----------------------------------------------------!------------------------
 *  read  | read_config  | read_data  | read_program    !    id, action
 *  write | write_config | write_data | write_program   !   id, action, hexfile
 * 
 *  operacion              !     memory area(s)
 * ------------------------!------------------------
 *  read     | write       !  all memory areas
 *  read_xxx | write_xxx   !  specific memory area
 * 
 */
public class TicketRequestServlet extends HttpBaseRunner {
    private final Logger log;

    public TicketRequestServlet( Logger log) {
        super();
        
        this.log = log;
    }

    @Override
    protected void execute( HttpRequest request, Response response) throws IOException {
        
        // 1. genera peticion en base a la accion
        var action = request.getParams().get( "action");
        var device = request.getRouteParams().get( "id");
        
        var generator = new RequestGenerator();
        
        String peticion = generator.generateRequest( device, action, getFile( request));
        
        System.out.println( "\n" + peticion);
        
        // 2. encarga la ejecución de la peticion
        
        var item = new ItemTicket( UtilText.generarRandomString( 6));
        TicketManager.register( item.getTicket());
        
        var worker = new ProgrammingTask( log, peticion, item.getTicket());
        
        var thread = new Thread( worker);
        thread.start();
        
        // 3. devuelve el numero de ticket
        
        response.addHeader( "Content-Type", "application/json; charset=utf-8");
        response.write( UtilBean.objectToByteArray( item));
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
