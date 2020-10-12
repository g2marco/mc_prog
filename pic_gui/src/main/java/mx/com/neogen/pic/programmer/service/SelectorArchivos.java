package mx.com.neogen.pic.programmer.service;

import com.eurk.core.util.UtilBean;
import com.eurk.core.util.UtilStream;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JTextField;
import javax.swing.filechooser.FileFilter;
import mx.com.neogen.commons.messages.AppLogger;
import mx.com.neogen.pic.beans.DeviceBuffer;
import mx.com.neogen.pic.beans.metadata.DeviceBufferMetadata;
import mx.com.neogen.pic.hexfile.RawDataToBuffer;

public class SelectorArchivos extends BaseListener implements ActionListener {

	public SelectorArchivos( Map<String, Object> modelo) {
		super( modelo);
	}


    @Override
	public void actionPerformed(ActionEvent e) {
		JFileChooser browser = new JFileChooser();
		
        browser.setCurrentDirectory( new File( "D:\\home\\work\\electronics"));
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
                ((JTextField) modelo.get( e.getActionCommand())).setText( selectedFile.getAbsolutePath());
            
                final RawDataToBuffer data = new RawDataToBuffer();
                
                final DeviceBuffer buffer = data.initDeviceBuffer( selectedFile, metadata);
                
                LOG.info( data.createRequest( metadata, buffer));
                
            } catch( Exception ex) {
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
