package mx.com.neogen.pic.prg.components;

import java.util.HashMap;
import java.util.Map;

public final class TicketManager {
    
    private static TicketManager instancia;
    private final Map<String, Boolean> tickets;
    
    
    private TicketManager() {
        super();    
        this.tickets = new HashMap<>();
    }
    
    
    public static synchronized TicketManager init() {
        if ( instancia == null) {
            instancia = new TicketManager();
        }
        return instancia;
    }
    
    public static void register( String ticket) {
        instancia.tickets.put( ticket, false);
    }
    
    public static boolean isDone( String ticket) {
        var value = instancia.tickets.get( ticket);
        return value == null ? false : value;
    }
    
    public static void done( String ticket) {
        instancia.tickets.put( ticket, true);
    }
    
}