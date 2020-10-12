package mx.com.neogen.pic.programmer.service;

public interface Logger {

    void info( Object data);

    void error( String message, Throwable causa);
}
