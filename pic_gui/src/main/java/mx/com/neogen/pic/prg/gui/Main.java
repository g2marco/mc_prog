package mx.com.neogen.pic.prg.gui;

import java.awt.*;
import java.awt.event.AdjustmentEvent;
import java.awt.event.AdjustmentListener;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.swing.*;
import javax.swing.border.EmptyBorder;
import mx.com.neogen.commons.messages.Logger;
import mx.com.neogen.pic.prg.components.ServerDetector;
import mx.com.neogen.pic.prg.components.SmartScroller;
import mx.com.neogen.pic.prg.components.TicketManager;
import mx.com.neogen.pic.prg.services.TicketRequestServlet;
import mx.com.neogen.pic.prg.services.TicketResponseServlet;
import mx.com.neogen.server.enums.HttpMethodEnum;
import mx.com.neogen.server.thread.ServerThread;
import mx.com.neogen.server.util.AppProperties;


public class Main {
    
    private static final Map<String, Object> modelo = new HashMap<>();
    private static Logger LOG;
    
    
    public static void main(String[] args) {
        javax.swing.SwingUtilities.invokeLater( new Runnable() {
            @Override
            public void run() {
                createAndShowGUI();
                AppProperties.load( obtenerPathConfigFile( args));
                
                searchServer();
                
                standAloneServer();
            }
        });
    }
    
    private static void createAndShowGUI() {

        var frame = new JFrame("Programador de PIC");
        frame.setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE);
        
        var pane = frame.getContentPane();
        
        //  layout , dos columnas de 4 renglones ( label panel, field panel)
        
        var labelPanel = new JPanel(new GridLayout( 2, 1));
        labelPanel.setBorder( new EmptyBorder(10, 10, 10, 0));
        
        var fieldPanel = new JPanel(new GridLayout( 2, 1));
        fieldPanel.setBorder( new EmptyBorder(10, 0, 10, 10));
        
        pane.add( labelPanel, BorderLayout.WEST);
        pane.add( fieldPanel, BorderLayout.CENTER);

        JPanel panel;
        JLabel etiqueta;
        JTextField field;
        
        //  --
        
        field = new JTextField();
        field.setColumns( 20);
        field.setEditable( false);
        
        etiqueta = new JLabel( "IP Servidor Remoto: ", JLabel.RIGHT);
        etiqueta.setLabelFor( field);
        
        labelPanel.add( etiqueta);
        panel = new JPanel( new FlowLayout(FlowLayout.LEFT));
        panel.add( field);
        fieldPanel.add( panel);
        
        modelo.put( "ipServer", field);
        
        //  --
        
        field = new JTextField();
        field.setColumns( 20);
        field.setEditable( false);
        
        etiqueta = new JLabel( "Servidor Local: ", JLabel.RIGHT);
        etiqueta.setLabelFor( field);
        
        labelPanel.add( etiqueta);
        panel = new JPanel( new FlowLayout(FlowLayout.LEFT));
        panel.add( field);
        fieldPanel.add( panel);
        
        modelo.put( "localhost", field);
        
        //  --
        
        panel = new JPanel();
        panel.setBorder( new EmptyBorder(10, 0, 10, 10));
        
        pane.add( panel, BorderLayout.SOUTH);
        
        var console = new JTextArea( 20, 60);
        console.setBorder( BorderFactory.createLineBorder(Color.black));
        console.setEditable( false);
        
        JScrollPane scroll = new JScrollPane( console);
        scroll.setVerticalScrollBarPolicy( ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);

        new SmartScroller( scroll, SmartScroller.VERTICAL, SmartScroller.END);
        
        panel.add( scroll);
        //setAutomaticScroolDown( scrollPane);

        LOG = new GUILogger( console);
        
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

    private static Thread searchServer() {
        modelo.put( "remote.server.found", null);
        
        Runnable search = () -> {
            
            ServerDetector detector = new ServerDetector( LOG);
            var field = ((JTextField) modelo.get( "ipServer"));
            
            var servidor = detector.find();
            
            if ( servidor.isPresent()) {
                field.setText( servidor.get());
                modelo.put( "remote.server.found", true);
                
                AppProperties.setProperty( "serverHost", servidor.get());
                
                try {
                    AppProperties.update();
                    
                } catch ( IOException ex) {
                    LOG.println( "[Cuidado] No fue posible actualizar archivo de propiedades");
                }

            } else {
                field.setText( "[not found]");
                modelo.put( "remote.server.found", false);
                
                LOG.error( "No fue posible ubicar al servidor remoto");
            }
        };
        
        var thread = new Thread( search);
        thread.start();
        
        return thread;
    }
    
    private static Thread standAloneServer() {
        
        Runnable worker = () -> {
            Boolean serverFound;
        
            //wait for search server found
            while ( (serverFound = (Boolean) modelo.get( "remote.server.found")) == null) {
                try {
                    Thread.sleep( 1000);
                } catch( InterruptedException ex) {
                     
                }
            }
            
            if ( serverFound) {
                try {
                    var server = new ServerThread( LOG);
                    
                    server.addRoute( HttpMethodEnum.POST, "/_data_/manage/device/{id}", new TicketRequestServlet( LOG) );
                    server.addRoute( HttpMethodEnum.GET , "/_data_/get/ticket/{id}"   , new TicketResponseServlet());
                    
                    TicketManager.init();
                    
                    server.start();
                    
                } catch( Exception ex) {
                    ex.printStackTrace();
                }
            }
        };
        
        var thread = new Thread( worker);
        thread.start();
        
        return thread;
    }
    

    static void setAutomaticScroolDown( JScrollPane scrollPane) {
        final JScrollBar bar = scrollPane.getVerticalScrollBar();

        bar.addAdjustmentListener( new AdjustmentListener() {
            private final BoundedRangeModel brm = bar.getModel();
            private boolean wasAtBottom = true;

            @Override
            public void adjustmentValueChanged( AdjustmentEvent e) {
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
