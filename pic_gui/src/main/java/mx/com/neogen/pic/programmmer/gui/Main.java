package mx.com.neogen.pic.programmmer.gui;

import mx.com.neogen.pic.programmmer.gui.listeners.SelectorArchivos;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionListener;
import java.util.HashMap;
import java.util.Map;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;
import mx.com.neogen.pic.programmmer.gui.listeners.ClienteFirmaElectronica;


public class Main {
	
    public static void main(String[] args) {
        javax.swing.SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() { createAndShowGUI(); }
        });
    }
    
    private static void createAndShowGUI() {
    	final Map<String, Object> modelo = new HashMap<String, Object>();

        final ActionListener FILE_BROWSER_ACTION_LISTENER      = new SelectorArchivos( modelo);
    	final ActionListener FIRMA_ELECTRONICA_ACTION_LISTENER = new ClienteFirmaElectronica( modelo);
    	
        JFrame frame = new JFrame("Programador de PIC");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        Container pane = frame.getContentPane();
        
        // Crea los componentes gráficos
        JPanel labelPanel = new JPanel(new GridLayout(3, 1));
        labelPanel.setBorder( new EmptyBorder(10, 10, 10, 0));
        
        JPanel fieldPanel = new JPanel(new GridLayout(3, 1));
        fieldPanel.setBorder( new EmptyBorder(10, 0, 10, 10));
        
        pane.add(labelPanel, BorderLayout.WEST);
        pane.add(fieldPanel, BorderLayout.CENTER);
        
       
        JTextField pathArchivo = new JTextField();
        pathArchivo.setColumns( 20);
        pathArchivo.setToolTipText( "ruta archivo *.hex");
        pathArchivo.setEditable( false);
        
        JButton browseArchivo = new JButton( "Buscar");
        browseArchivo.setSize( browseArchivo.getSize().width,(int)(0.8 * browseArchivo.getSize().height));
        browseArchivo.setActionCommand( "archivo");
        modelo.put( "archivo", pathArchivo);
        browseArchivo.addActionListener( FILE_BROWSER_ACTION_LISTENER);
        
        JLabel etiqueta = new JLabel( "Documento: ", JLabel.RIGHT);
        etiqueta.setLabelFor( pathArchivo);
           
        labelPanel.add( etiqueta);
        JPanel p = new JPanel( new FlowLayout(FlowLayout.LEFT));
        p.add( pathArchivo);
        p.add( browseArchivo);
        fieldPanel.add(p);
        
        //---
        
        JTextField cadenaTexto = new JTextField();
        cadenaTexto.setColumns( 20);
        cadenaTexto.setText( "192.168.1.79");
        cadenaTexto.setToolTipText( "Ingrese una cadena de texto para generar su firma electrónica");
        
        modelo.put( "cadena", cadenaTexto);
        
        etiqueta = new JLabel( "Cadena Texto: ", JLabel.RIGHT);
        etiqueta.setLabelFor( cadenaTexto);
           
        labelPanel.add(etiqueta);
        p = new JPanel( new FlowLayout(FlowLayout.LEFT));
        p.add( cadenaTexto);
        fieldPanel.add(p);
               
        JButton executar = new JButton( "Firma");
        executar.setToolTipText( "Invoca al servidor");
        executar.setActionCommand( "ejecutar" );
        executar.addActionListener( FIRMA_ELECTRONICA_ACTION_LISTENER);
        
        labelPanel.add( new JLabel(""));
        p = new JPanel( new FlowLayout(FlowLayout.LEFT));
        p.add( executar);
        fieldPanel.add(p);
              
        
        JPanel firmaPanel = new JPanel();
        firmaPanel.setBorder( new EmptyBorder(10, 0, 10, 10));
        
        pane.add(firmaPanel, BorderLayout.SOUTH);
        
        JTextArea firma = new JTextArea( 20, 60);
        firma.setBorder(BorderFactory.createLineBorder(Color.black));
        modelo.put( "consola", firma);
        
        firmaPanel.add(new JScrollPane( firma));
        
        
        frame.pack();
        frame.setVisible(true);
        frame.setResizable( false);
    }

}
