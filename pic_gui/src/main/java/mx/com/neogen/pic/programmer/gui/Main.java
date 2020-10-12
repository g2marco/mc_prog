package mx.com.neogen.pic.programmer.gui;

import mx.com.neogen.pic.programmer.service.*;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.AdjustmentEvent;
import java.awt.event.AdjustmentListener;
import java.io.File;
import java.util.HashMap;
import java.util.Map;


public class Main {
    private static final Map<String, Object> modelo;
    private static final ActionListener FILE_BROWSER_ACTION_LISTENER;
    private static final ActionListener FIRMA_ELECTRONICA_ACTION_LISTENER;

    static {
        modelo = new HashMap<>();
        FILE_BROWSER_ACTION_LISTENER      = new SelectorArchivos( modelo);
        FIRMA_ELECTRONICA_ACTION_LISTENER = new ClienteProgramador( modelo);
    }


    public static void main(String[] args) {
        javax.swing.SwingUtilities.invokeLater( new Runnable() {
            @Override
            public void run() {
                createAndShowGUI();
                AppProperties.load( obtenerPathConfigFile( args));
                searchServer();
            }
        });
    }
    
    private static void createAndShowGUI() {

        final JFrame frame = new JFrame("Programador de PIC");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        
        final Container pane = frame.getContentPane();
        
        // Crea los componentes gráficos
        final JPanel labelPanel = new JPanel(new GridLayout(4, 1));
        labelPanel.setBorder( new EmptyBorder(10, 10, 10, 0));
        
        final JPanel fieldPanel = new JPanel(new GridLayout(4, 1));
        fieldPanel.setBorder( new EmptyBorder(10, 0, 10, 10));
        
        pane.add(labelPanel, BorderLayout.WEST);
        pane.add(fieldPanel, BorderLayout.CENTER);

        JPanel panel;
        JLabel etiqueta;
        //  --

        final JComboBox<String> inputControl = new JComboBox<>( new String[] { "PIC12F683", "PIC16F627A"});
        modelo.put( "dispositivo", inputControl);

        etiqueta = new JLabel( "Dispositivo: ", JLabel.RIGHT);
        etiqueta.setLabelFor( inputControl);
           
        labelPanel.add( etiqueta);
        panel = new JPanel( new FlowLayout(FlowLayout.LEFT));
        panel.add( inputControl);
        fieldPanel.add( panel);
               
        //  --
        
        final JTextField pathArchivo = new JTextField();
        pathArchivo.setColumns( 20);
        pathArchivo.setToolTipText( "ruta archivo *.hex");
        pathArchivo.setEditable( false);
        modelo.put( "archivo", pathArchivo);

        final JButton browseArchivo = new JButton( "Buscar");
        browseArchivo.setSize( browseArchivo.getSize().width,(int)(0.8 * browseArchivo.getSize().height));
        browseArchivo.setActionCommand( "archivo");
        browseArchivo.addActionListener( FILE_BROWSER_ACTION_LISTENER);
        
        etiqueta = new JLabel( "Archivo *.HEX: ", JLabel.RIGHT);
        etiqueta.setLabelFor( pathArchivo);
           
        labelPanel.add( etiqueta);
        panel = new JPanel( new FlowLayout(FlowLayout.LEFT));
        panel.add( pathArchivo);
        panel.add( browseArchivo);
        fieldPanel.add( panel);
        
        //  --
        
        final JTextField ipServidor = new JTextField();
        ipServidor.setColumns( 20);
        ipServidor.setToolTipText( "Ingrese la IP del servidor de programación");
        modelo.put( "ipServidor", ipServidor);
        
        etiqueta = new JLabel( "IP Servidor: ", JLabel.RIGHT);
        etiqueta.setLabelFor( ipServidor);
           
        labelPanel.add(etiqueta);
        panel = new JPanel( new FlowLayout(FlowLayout.LEFT));
        panel.add( ipServidor);
        fieldPanel.add( panel);
        
        //  ---
               
        JButton executar = new JButton( "Programar");
        executar.setToolTipText( "Programar Dispositivo");
        executar.setActionCommand( "ejecutar" );
        executar.addActionListener( FIRMA_ELECTRONICA_ACTION_LISTENER);
        executar.setEnabled( false);
        modelo.put( "action", executar);

        labelPanel.add( new JLabel(""));
        panel = new JPanel( new FlowLayout(FlowLayout.LEFT));
        panel.add( executar);
        fieldPanel.add( panel);

        panel = new JPanel();
        panel.setBorder( new EmptyBorder(10, 0, 10, 10));
        
        pane.add( panel, BorderLayout.SOUTH);
        
        final JTextArea console = new JTextArea( 20, 60);
        console.setBorder(BorderFactory.createLineBorder(Color.black));
        modelo.put( "consola", console);

        JScrollPane scrollPane = new JScrollPane( console);
        panel.add( scrollPane);
        setAutomaticScroolDown( scrollPane, executar);

        frame.pack();
        frame.setVisible(true);
        frame.setResizable( false);
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

    private static void searchServer() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                final Logger log = new GUILogger( (JTextArea) modelo.get( "consola"));

                ServerDetector detector = new ServerDetector( log);
                try {
                    final String servidor = detector.find( AppProperties.getProperty( "server"));
                    ((JTextField) modelo.get( "ipServidor")).setText( servidor);
                    AppProperties.setProperty( "server", servidor);
                    AppProperties.update();

                    ((JButton) modelo.get( "action")).setEnabled( true);

                } catch( Exception ex) {
                    log.error( "Error al buscar y establecer al servidor", ex);
                }
            }
        }).start();
    }

    static void setAutomaticScroolDown( JScrollPane scrollPane, final JButton btnAction) {
        final JScrollBar bar = scrollPane.getVerticalScrollBar();

        bar.addAdjustmentListener( new AdjustmentListener() {
            private final BoundedRangeModel brm = bar.getModel();
            private boolean wasAtBottom = true;

            @Override
            public void adjustmentValueChanged( AdjustmentEvent e) {
                if ( btnAction.isEnabled()) {
                    return;
                }

                if (!brm.getValueIsAdjusting()) {
                    if (wasAtBottom) {
                        brm.setValue( brm.getMaximum());
                    } else {
                        wasAtBottom = ((brm.getValue() + brm.getExtent()) == brm.getMaximum());
                    }
                }
            }
        });
    }
}
