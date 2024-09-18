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
    
    public static DeviceBuffer initDeviceBuffer( File hexFile, DeviceBufferMetadata metadata) throws IOException {        
        var buffer = initDeviceBuffer( metadata);
        
        if ( hexFile == null) {
            return buffer;
        }
        
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
    
    private static DeviceBuffer initDeviceBuffer( DeviceBufferMetadata metadata) {
        var buffer = new DeviceBuffer();
        
        int banks;
        Bank bank;
        BankMetadata meta;
        
        // inicializa bancos de programa
        
        if ( metadata.getProgram() == null) {
        
        } else {
            banks = metadata.getProgram().length;
    
            buffer.setProgram( new Bank[ banks]);
        
            for ( int i = 0; i < banks; ++i) {
                meta = metadata.getProgram()[i];
                bank = new Bank();
                buffer.getProgram()[i] = bank;
            
                bank.setLocations( new Integer[ meta.getLength()]);
                Arrays.fill( bank.getLocations(), 0);
            }
        }
        
        // inicializa bancos de datos
        
        if ( metadata.getData() == null) {
        
        } else {
            banks = metadata.getData().length;
    
            buffer.setData( new Bank[ banks]);
        
            for ( int i = 0; i < banks; ++i) {
                meta = metadata.getData()[i];
                bank = new Bank();
                buffer.getData()[i] = bank;
            
                bank.setLocations( new Integer[ meta.getLength()]);
                Arrays.fill( bank.getLocations(), 0);
            }
        }
        
        
        // inicializa localidades de configuracion
        if ( metadata.getConfig() == null) {
        
        } else {
            int locations = metadata.getConfig().length;
            buffer.setConfig( new Integer[ locations]);
            Arrays.fill( buffer.getConfig(), 0);
        }
        
        return buffer;
    }
    
    private static void updateBuffer( DeviceBuffer buffer, DeviceBufferMetadata metadata, RawDataPacket packet) {
        
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
                    idx = address - metadata.getConfig()[0].getAddress();
                    
                    locations[idx] = (int) UtilBinary.createWord( packet.getRawData()[j], packet.getRawData()[j +1]);
                    
                    address++;
                }                
        } 
        
    }

    private static EnumMemoryArea determinaAreaMemoria( int address, DeviceBufferMetadata metadata) {
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
        
        for( LocationMetadata meta : metadata.getConfig()) {
            if( address == meta.getAddress()) {
                return EnumMemoryArea.CONFIGURATION;
            }
        }
        
        throw new IllegalArgumentException( "La dirección esta fuera del alcance del dispositivo: " + address);
    }
    
    private static Integer[] obtenerLocalidades( int address, DeviceBuffer buffer, DeviceBufferMetadata metadata) {
        int min, max, banks;
        BankMetadata meta;
        
        //
        banks = metadata.getProgram().length;
        
        for( int i = 0; i < banks; ++i) {
            meta = metadata.getProgram()[i];
            
            min = meta.getStartAddress();
            max = min + meta.getLength();
            
            if( address >= min && address < max) {
                return buffer.getProgram()[i].getLocations();
            }
        }
        
        //
        banks = metadata.getData().length;
        
        for( int i = 0; i < banks; ++i) {
            meta = metadata.getData()[i];
            
            min = meta.getStartAddress();
            max = min + meta.getLength();
            
            if( address >= min && address < max) {
                return buffer.getData()[i].getLocations();
            }
        }
        
        //
        for( LocationMetadata locationMeta : metadata.getConfig()) {
            if( address == locationMeta.getAddress()) {
                return buffer.getConfig();
            }
        }
        
        throw new IllegalArgumentException( "La dirección esta fuera del alcance del dispositivo: " +address); 
        
    }
    
    
    private static BankMetadata obtenerBankMetadata( int address, BankMetadata[] banks) {
        
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
