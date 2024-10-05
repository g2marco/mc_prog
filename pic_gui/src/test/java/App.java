
import java.io.File;
import java.io.IOException;
import mx.com.neogen.commons.messages.Logger;
import mx.com.neogen.pic.prg.components.TicketManager;
import mx.com.neogen.pic.prg.services.BufferRequestServlet;
import mx.com.neogen.pic.prg.services.MetadataRequestServlet;
import mx.com.neogen.pic.prg.services.TicketRequestServlet;
import mx.com.neogen.pic.prg.services.TicketResponseServlet;
import mx.com.neogen.server.enums.HttpMethodEnum;
import mx.com.neogen.server.thread.ControlThread;
import mx.com.neogen.server.thread.ServerThread;
import mx.com.neogen.server.util.AppProperties;


public class App {
        
    public static void main(String[] args) throws IOException {
        
        AppProperties.load( obtenerPathConfigFile( new String[] { "/home/g2marco/work/c_code/mc_prog/pic_gui/dist/app_properties.xml"}));
        var LOG = new Logger() {
            @Override
            public void print(Object data) {    System.out.print( data);    }
            @Override
            public void println(Object data) {  System.out.println( data);  }
            @Override
            public void error(String message, Throwable causa) { error( message); causa.printStackTrace();  }
            @Override
            public void error(String message) { println(message);}
        };
        
        //
        var server = new ServerThread( LOG);
                    
        server.addRoute( HttpMethodEnum.GET , "/_data_/get/metadata/{id}"   , new MetadataRequestServlet()  );
        server.addRoute( HttpMethodEnum.POST, "/_data_/get/buffer/{id}"   , new BufferRequestServlet( LOG));
        server.addRoute( HttpMethodEnum.POST, "/_data_/manage/device/{id}", new TicketRequestServlet( LOG));
        server.addRoute( HttpMethodEnum.GET , "/_data_/get/ticket/{id}"   , new TicketResponseServlet()   );
                    
        TicketManager.init();
                    
        server.start();
        //      
        
        var control = new ControlThread( server);
        control.start();
        
        try {
            // espera la finalización del servidor
            server.join();
            
        } catch( InterruptedException ex) {
            
        }
        
        System.out.println("\n[main] terminado");
        System.exit( 0);
    }
    
    private static String obtenerPathConfigFile( String[] args) {
        if( args.length == 0) {
            // ruta no definida en linea de comandos, utiliza ubicación y nombre por default
            return "." + File.separator + "app_properties.xml";

        } else {
            // ruta definida en linea de comandos
            return args[0];
        }
    }

}
