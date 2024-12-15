package mx.com.neogen.pic.prg.components;

import com.eurk.core.util.UtilBinary;
import java.util.ArrayList;
import java.util.List;
import mx.com.neogen.pic.beans.Bank;
import mx.com.neogen.pic.beans.DeviceBuffer;
import mx.com.neogen.pic.beans.metadata.BankMetadata;
import mx.com.neogen.pic.beans.metadata.DeviceBufferMetadata;
import mx.com.neogen.pic.beans.metadata.LocationMetadata;


public class DataFormatter {

    public static String formatRequest( DeviceBufferMetadata metadata, String operation, DeviceBuffer buffer) {
        final StringBuilder strb = new StringBuilder();
              
        // operacion
        
        strb.append( "o=").append(
            switch (operation) { 
                case "write" -> 'p';
                case "read"  -> 'r';
                case "reset" -> 'e';
                default -> throw new IllegalArgumentException( "Invalid value for operation argument: [" + operation + "]"); 
            }
        ).append( "\n");
        
        // longitud de cada area de memoria
        
        strb.append( "a").
            append( "=c").append( metadata.getConfig()  == null? 0 : metadata.getConfig().length ).
            append( ",p").append( metadata.getProgram() == null? 0 : metadata.getProgram().length).
            append( ",d").append( metadata.getData()    == null? 0 : metadata.getData().length   ).
            append( "\n");
        
        // voltajes
        
        strb.append( "v=n").append( "\n");
 
        // opciones de borrado
        var options = metadata.getOptions();
        
        strb.append( "e=").
        append( options.getProgrammingType()).append( ",").
        append( options.getBulkEraseType()).append( ",").
        append( options.getCpDisableType()).append( ",").
        append( UtilBinary.parseBinaryString( options.getCpDisableWord())).
        append( "\n");
        
        int banks;
        BankMetadata meta;
        Bank bank;
        Integer[] locations;
        
        // bancos de programa
        
        if ( metadata.getProgram() == null) {
            
        } else {
            banks = metadata.getProgram().length;
        
            for( int i = 0; i < banks; ++i) {
                meta = metadata.getProgram()[i];
                bank = buffer.getProgram()[i];
            
                strb.append( "p").append( i).append( "i=").append( meta.getStartAddress()).append( "\n");
                strb.append( "p").append( i).append( "l=").append( meta.getLength()).append( "\n");
                strb.append( "p").append( i).append( "v=");

                locations = bank.getLocations();
            
                for( int j = 0 ; j < locations.length; ++j) {
                    if ( j != 0) {
                      strb.append( ",");
                    }
                  strb.append( locations[j]);
                }
            }
        
            strb.append( "\n");
        }
        
        // bancos de datos
        
        if ( metadata.getData() == null) {
            
        } else {
            banks = metadata.getData().length;
        
            for( int i = 0; i < banks; ++i) {
                meta = metadata.getData()[i];
                bank = buffer.getData()[i];
            
                strb.append( "d").append( i).append( "i=").append( meta.getStartAddress()).append( "\n");
                strb.append( "d").append( i).append( "l=").append( meta.getLength()).append( "\n");
                strb.append( "d").append( i).append( "v=");

                locations = bank.getLocations();
            
                for( int j = 0 ; j < locations.length; ++j) {
                    if ( j != 0) {
                      strb.append( ",");
                    }
                    strb.append( locations[j]);
                }
            }
        
            strb.append( "\n");
        }
        
        //  localidades de configuracion
        
        if ( metadata.getConfig() == null) {
            
        } else {
            int configLocations = metadata.getConfig().length;
        
            LocationMetadata locationMeta;
        
            for ( int i = 0; i < configLocations; ++i) {
                locationMeta = metadata.getConfig()[i];
            
                strb.append( "c").append( i).append( "a=").append( locationMeta.getAddress()).append( "\n");
                strb.append( "c").append( i).append( "i=").append( locationMeta.getName()).append( "\n");
                strb.append( "c").append( i).append( "v=").append(  buffer.getConfig()[i]).append( "\n");
                strb.append( "c").append( i).append( "r=").append(  locationMeta.isRead()? "t" : "f").append( "\n");
                strb.append( "c").append( i).append( "w=").append( locationMeta.isWrite()? "t" : "f").append( "\n");
            }
        }
        
        return strb.toString();
    }
    
    /*
        Extrae la información de un archivo de respuesta
    
        p0i=0
        p0l=1024
        p0v=8231,10272,0,0,0,0,0...

        d0i=0
        d0l=224
        d0v=0,0,0,0,0,0,0,0,0,0,...

        c0v=255
        c1v=0
        c2v=255
        c3v=170
        ...
    */ 
    public static DeviceBuffer parseResponse( List<String> lines) {
        var item = new DeviceBuffer();
        
        String line;
        
        var info = new Info();
        int i = 0;
        
        List<Bank> program = new ArrayList<>();
        List<Bank> data    = new ArrayList<>();
        List<Integer> config = new ArrayList<>();
        
        while( i < lines.size()) {
            line = lines.get(i);
            i++;
            
            if ( !isDataLine( line)) {
                continue;
            }
            
            setInfoLine( info, line);
            
            /*               
            area = p, d , c
                idx  = 0, 1, 2, 3, ....
                    prop = i, l, v, ... 
            */
            
            switch ( info.area) {
                case 'p':
                    updateBanks( info, line, program);
                    break;
                    
                case 'd':
                    updateBanks( info, line, data   );
                    break;
                    
                case 'c':
                    updateLocations( info, line, config);
                    break;
            }
        }
        
        item.setProgram(  program.toArray( Bank[]::new));
        item.setData(     data.toArray(    Bank[]::new));
        item.setConfig( config.toArray( Integer[]::new));
        
        return item;
    }
    
    /*
        p0i=0                           d0i=0
        p0l=1024                        p0l=1024
        p0v=8231,10272,0,0,0,0,0...     d0v=0,0,0,0,0,0,0,0,0,0,...
    */
    private static void updateBanks( Info info, String line, List<Bank> banks) {
        var value = line.substring( line.indexOf( '=') + 1);
        
        switch( info.prop) {
            case 'i': 
                banks.add( new Bank());        
                break;
               
            case 'l':
                banks.getLast().setLocations( new Integer[ Integer.parseInt(value)]);
                break;
                
            case 'v':
                setLocations( banks.getLast().getLocations(), value);
                break;
        }
    }
    
    //  c0v=255
    //  c1v=0
    //  c2v=255
    //  c3v=170
    //  ...
    private static void updateLocations( Info info, String line, List<Integer> locations) {
        if ( info.prop !='v') {
            return;
        }
        
        var value = line.substring( line.indexOf( '=') + 1);
        locations.add( Integer.valueOf( value));
    }

    private static boolean isDataLine( String line) {
        char letra = line.charAt( 0);
        return letra == 'p' || letra == 'd' || letra == 'c';
    }
    
    private static void setInfoLine( Info info, String line) {
        info.area = line.charAt( 0);
        info.idx  = Character.digit( line.charAt( 1), 10);
        info.prop = line.charAt( 2);
    }
    
    private static void setLocations( Integer[] locations, String value) {
        int i = 0;
        for ( var item : value.split( ",") ) {
            locations[i++] = Integer.valueOf( item);
        }
    }
    
    private static class Info {
        char area;
        int   idx;
        char prop;
    }
    
}
