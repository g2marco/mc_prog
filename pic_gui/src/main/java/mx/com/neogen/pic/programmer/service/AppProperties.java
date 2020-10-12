package mx.com.neogen.pic.programmer.service;

import java.io.*;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

public final class AppProperties {

    private static AppProperties instancia;
    private static String XMLPATH;

    private final Properties props;

    public static final String APP_VERSION = "v. 2020_10_11";

    public static final Charset APP_CHARSET = StandardCharsets.UTF_8;
    public static final String APP_CHARSET_NAME = APP_CHARSET.name();


    private AppProperties( String xmlPath) throws IOException {
        super();
        XMLPATH = xmlPath;
        props = createFromXML();
    }


    private Properties createFromXML() throws IOException {
        final Properties properties = new Properties();

        InputStream is = null;

        try {
            is = new FileInputStream( XMLPATH);
            properties.loadFromXML( is);

            return properties;

        } finally {
            if ( is != null) {
                try { is.close(); } catch ( Exception ex) {}
            }
        }
    }

    public static synchronized AppProperties load( String xmlPath) {
        if ( instancia == null) {
            try {
                instancia = new AppProperties( xmlPath);

            } catch ( Exception ex) {
                throw new RuntimeException( "Error al leer archivo de propiedades externo", ex);
            }
        }

        return instancia;
    }

    public static String getProperty( String name) {
        if ( !instancia.props.containsKey( name)) {
            throw new IllegalArgumentException( "Configuration property [" + name + "] doesn't exist in configuration file");
        }
        return instancia.props.getProperty(name);
    }

    public static void setProperty(  String name, String value) {
        instancia.props.setProperty( name, value);
    }

    public static void update() throws IOException {
        final String fechaHora = new SimpleDateFormat( "dd/MM/yyyy HH:mm:SSS").format( new Date());

        Properties properties = instancia.props;
        OutputStream os = null;

        try {
            os = new FileOutputStream( XMLPATH);
            properties.storeToXML( os, "Propiedades de aplicacion [" + fechaHora + "]");

        } finally {
            if ( os != null) {
                try { os.close(); } catch ( Exception ex) {}
            }
        }
    }


}