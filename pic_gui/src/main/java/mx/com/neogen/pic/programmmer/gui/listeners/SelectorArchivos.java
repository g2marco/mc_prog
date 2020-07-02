package mx.com.neogen.pic.programmmer.gui.listeners;

import com.mycompany.mavenproject1.RawDataToBuffer;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.util.Map;
import javax.swing.JFileChooser;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import mx.com.neogen.pic.hexfile.INHX8MFileReader;
import mx.com.neogen.pic.hexfile.RawDataPacket;

public class SelectorArchivos implements ActionListener {
	
	final Map<String, Object> modelo;
	
	public SelectorArchivos( Map<String, Object> modelo) {
		super();
		this.modelo = modelo;
	}


    @Override
	public void actionPerformed(ActionEvent e) {
		JFileChooser browser = new JFileChooser();
		
		int returnValue = browser.showOpenDialog( null);
        
        if (returnValue == JFileChooser.APPROVE_OPTION) {
            File selectedFile = browser.getSelectedFile();
            ((JTextField) modelo.get( e.getActionCommand())).setText( selectedFile.getAbsolutePath());
            
            INHX8MFileReader reader = new INHX8MFileReader( selectedFile.getAbsolutePath());
            
            JTextArea textArea = ((JTextArea) modelo.get( "consola"));
            StringBuilder strb;
            
            try {
                RawDataToBuffer data = new RawDataToBuffer();
                strb = data.createRequest(reader);
                
            } catch( Exception ex) {
                strb = new StringBuilder();
                
                printStackTrace( strb, ex);
            }
            
            textArea.setText( strb.toString());
        }
	}
    
    private void printStackTrace( StringBuilder strb, Throwable tirable) {
	
		if ( tirable != null) {
			strb.append( "\n - - - - - - - - - - - - - - - - - - - - - - - - - -");
			strb.append( "\n\t[CAUSA]: ").append( tirable.getMessage());
			strb.append( "\n - - - - - - - - - - - - - - - - - - - - - - - - - -");
			
			StackTraceElement[] stack = tirable.getStackTrace();
			
			if ( stack != null) {
				for ( int i = 0; i < stack.length; ++i) {
					strb.append( "\n").append( stack[i]);
				}
			}
			
			printStackTrace(strb, tirable.getCause());
		}
	}
}
