package mx.com.neogen.pic.programmer.service;

import com.eurk.core.util.UtilBean;
import com.eurk.core.util.UtilStream;
import mx.com.neogen.pic.beans.DeviceBuffer;
import mx.com.neogen.pic.beans.metadata.DeviceBufferMetadata;
import mx.com.neogen.pic.hexfile.RawDataToBuffer;

import javax.swing.*;
import javax.swing.filechooser.FileFilter;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

public class SelectorArchivos extends BaseListener implements ActionListener {

	public SelectorArchivos( Map<String, ? super Object> modelo) {
		super( modelo);
	}


    @Override
	public void actionPerformed( ActionEvent e) {
	    init();

		final JFileChooser browser = new JFileChooser();
		
        browser.setCurrentDirectory( new File( AppProperties.getProperty( "path")));
        browser.setFileFilter( new FileFilter() {
            @Override
            public boolean accept(File file) {
                if (file.isDirectory()) {
                    return true;
                }        
                return file.getName().toLowerCase().endsWith( ".hex");
            }

            @Override
            public String getDescription() {
                return "Archivo *.hex";
            }
        });
        
		int returnValue = browser.showOpenDialog( null);
        
        if (returnValue == JFileChooser.APPROVE_OPTION) {
            try {
                
                final DeviceBufferMetadata metadata = obtenerMetadata();
                LOG.info( metadata);
            
                File selectedFile = browser.getSelectedFile();
                String path = selectedFile.getAbsolutePath();

                AppProperties.setProperty( "path", path);
                AppProperties.update();

                setText( "archivo", path);
            
                final RawDataToBuffer data = new RawDataToBuffer();
                final DeviceBuffer buffer = data.initDeviceBuffer( selectedFile, metadata);

                final Object request = data.createRequest( metadata, buffer);
                setPropiedad( "request", request);

                LOG.info( request);
                
            } catch( Exception ex) {
                ex.printStackTrace();
                LOG.error( "Imposible crear buffer de dispositivo", ex);
            }
        }
	}
    
    private DeviceBufferMetadata obtenerMetadata() throws IOException {
        final String dispositivo = (String) ((JComboBox) getPropiedad("dispositivo")).getSelectedItem();
        
        try (
            InputStream inputStream = UtilStream.obtenerRecursoAsStream( dispositivo + "-device-buffer.json");
        ) {
            return UtilBean.parseBean(inputStream,  DeviceBufferMetadata.class);
        }
    }

}
