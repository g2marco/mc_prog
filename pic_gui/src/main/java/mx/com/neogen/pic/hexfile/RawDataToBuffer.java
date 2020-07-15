package mx.com.neogen.pic.hexfile;

import com.eurk.core.util.UtilBinary;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import mx.com.neogen.pic.beans.Bank;
import mx.com.neogen.pic.beans.DeviceBuffer;
import mx.com.neogen.pic.beans.metadata.BankMetadata;
import mx.com.neogen.pic.beans.metadata.DeviceBufferMetadata;
import mx.com.neogen.pic.beans.metadata.EnumMemoryArea;
import mx.com.neogen.pic.beans.metadata.LocationMetadata;

public class RawDataToBuffer {

    public DeviceBuffer initDeviceBuffer( File hexFile, DeviceBufferMetadata metadata) throws IOException {        
        
        final DeviceBuffer buffer = initDeviceBuffer( metadata);        
        
        RawDataPacket packet;
        INHX8MFileReader reader = null;
        
        try {
            reader = new INHX8MFileReader( hexFile);
            
            while ( (packet = reader.read()) != null) {
                updateBuffer( buffer, metadata, packet);
            }
 
            return buffer;
        
        } finally {
            if ( reader != null) { reader.close(); }
        }
    }
    
    public String createRequest( DeviceBufferMetadata metadata, DeviceBuffer buffer) {
        final StringBuilder strb = new StringBuilder();
              
        // operacion
        
        strb.append( "o=p").append( "\n");
        
        // longitud de cada area de memoria
        
        strb.append( "a").
            append( "=c").append( metadata.getConfiguration().length).
            append( ",p").append( metadata.getProgram().length).
            append( ",d").append( metadata.getData().length).
            append( "\n");
        
        // voltajes
        
        strb.append( "v=n").append( "\n");
 
        // bancos de programa
        
        int banks;
        BankMetadata meta;
        Bank bank;
        Integer[] locations;
        
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
        
        // bancos de datos
        
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
        
        //  localidades de configuracion
        
        int configLocations = metadata.getConfiguration().length;
        
        LocationMetadata locationMeta;
        
        for ( int i = 0; i < configLocations; ++i) {
            locationMeta = metadata.getConfiguration()[i];
            
            strb.append( "c").append( i).append( "a=").append(         locationMeta.getAddress()).append( "\n");
            strb.append( "c").append( i).append( "i=").append(            locationMeta.getName()).append( "\n");
            strb.append( "c").append( i).append( "v=").append(      buffer.getConfiguration()[i]).append( "\n");
            strb.append( "c").append( i).append( "r=").append(  locationMeta.isRead()? "t" : "f").append( "\n");
            strb.append( "c").append( i).append( "w=").append( locationMeta.isWrite()? "t" : "f").append( "\n");
        }
        
        return strb.toString();
    }
    
    private DeviceBuffer initDeviceBuffer( DeviceBufferMetadata metadata) {        
        final DeviceBuffer buffer = new DeviceBuffer();
        
        int banks;
        Bank bank;
        BankMetadata meta;
        
        // inicializa bancos de programa
        
        banks = metadata.getProgram().length;
    
        buffer.setProgram( new Bank[ banks]);
        
        for ( int i = 0; i < banks; ++i) {
            meta = metadata.getProgram()[i];
            bank = new Bank();
            buffer.getProgram()[i] = bank;
            
            bank.setLocations( new Integer[ meta.getLength()]);
            Arrays.fill( bank.getLocations(), 0);
        }
        
        // inicializa bancos de datos
        
        banks = metadata.getData().length;
    
        buffer.setData( new Bank[ banks]);
        
        for ( int i = 0; i < banks; ++i) {
            meta = metadata.getData()[i];
            bank = new Bank();
            buffer.getData()[i] = bank;
            
            bank.setLocations( new Integer[ meta.getLength()]);
            Arrays.fill( bank.getLocations(), 0);
        }
        
        
        // inicializa localidades de configuracion
        
        int locations = metadata.getConfiguration().length;
        buffer.setConfiguration( new Integer[ locations]);
        Arrays.fill( buffer.getConfiguration(), 0);
        
        return buffer;
    }
 
    private void updateBuffer( DeviceBuffer buffer, DeviceBufferMetadata metadata, RawDataPacket packet) {
        
        int address = packet.getStartAddress() / 2;
        
        final EnumMemoryArea areaMemoria = determinaAreaMemoria( address, metadata);
        final Integer[] locations = obtenerLocalidades( address, buffer, metadata);
        
        BankMetadata bankMeta;
        int idx;
        
        switch( areaMemoria) {
                
            case PROGRAM:
                bankMeta  = obtenerBankMetadata( address, metadata.getProgram());
                
                for( int j = 0; j < packet.getRawData().length; j = j + 2) {
                    idx = address - bankMeta.getStartAddress();
                    locations[ idx] = (int) UtilBinary.createWord( packet.getRawData()[j], packet.getRawData()[j +1]);
                    
                    address++;                    
                }
                
                break;
                
            case DATA:
                bankMeta = obtenerBankMetadata( address, metadata.getData());
                
                for( int j = 0; j < packet.getRawData().length; ++j) {
                    idx = address - bankMeta.getStartAddress();
                    locations[ idx] = (int) packet.getRawData()[j];
                    address++;
                }
                
                break;
            
            default:        // configuration
                
                for( int j = 0; j < packet.getRawData().length; j = j + 2) {
                    idx = address - metadata.getConfiguration()[0].getAddress();
                    
                    locations[idx] = (int) UtilBinary.createWord( packet.getRawData()[j], packet.getRawData()[j +1]);
                    
                    address++;
                }                
        } 
        
    }

    private EnumMemoryArea determinaAreaMemoria( int address, DeviceBufferMetadata metadata) {
        int min;
        int max;
        
        for( BankMetadata meta : metadata.getProgram()) {
            min = meta.getStartAddress();
            max = min + meta.getLength();
            
            if( address >= min && address < max) {
                return EnumMemoryArea.PROGRAM;
            }
        }
        
        for( BankMetadata meta : metadata.getData()) {
            min = meta.getStartAddress();
            max = min + meta.getLength();
            
            if( address >= min && address < max) {
                return EnumMemoryArea.DATA;
            }
        }
        
        for( LocationMetadata meta : metadata.getConfiguration()) {
            if( address == meta.getAddress()) {
                return EnumMemoryArea.CONFIGURATION;
            }
        }
        
        throw new IllegalArgumentException( "La dirección esta fuera del alcance del dispositivo: " + address);
    }
    
    private Integer[] obtenerLocalidades( int address, DeviceBuffer buffer, DeviceBufferMetadata metadata) {
        
        int min;
        int max;
        
        int banks;
        BankMetadata meta;
        
        banks= metadata.getProgram().length;
        
        for( int i = 0; i < banks; ++i) {
            meta = metadata.getProgram()[i];
            
            min = meta.getStartAddress();
            max = min + meta.getLength();
            
            if( address >= min && address < max) {
                return buffer.getProgram()[i].getLocations();
            }
        }
        
        banks = metadata.getData().length;
        for( int i = 0; i < banks; ++i) {
            meta = metadata.getData()[i];
            
            min = meta.getStartAddress();
            max = min + meta.getLength();
            
            if( address >= min && address < max) {
                return buffer.getData()[i].getLocations();
            }
        }
            
        for( LocationMetadata locationMeta : metadata.getConfiguration()) {
            if( address == locationMeta.getAddress()) {
                return buffer.getConfiguration();
            }
        }
        
        throw new IllegalArgumentException( "La dirección esta fuera del alcance del dispositivo: " +address); 
        
    }
    
    
     private BankMetadata obtenerBankMetadata( int address, BankMetadata[] banks) {
        
        int min;
        int max;
        
        for ( BankMetadata meta : banks) {            
            min = meta.getStartAddress();
            max = min + meta.getLength();
            
            if( address >= min && address < max) {
                return meta;
            }
        }
        
        throw new IllegalArgumentException( "La dirección esta fuera del alcance del dispositivo: " +address); 
        
    }
}
