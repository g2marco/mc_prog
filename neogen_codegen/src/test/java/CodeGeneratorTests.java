
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import mx.com.neogen.Main;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;


public class CodeGeneratorTests {
    private final static String BASE_PATH_DIR = "D:\\home\\ework\\microcontrollers\\pic12f683\\04_neogen_codegen\\";
  
    private final String BASE_PROGRAM_PATH_DIR = BASE_PATH_DIR + "examples\\";
    private final String TEMPLATE_PROYECT_PATH = BASE_PATH_DIR + "template";
    
    private final String TARGET_BASE_PATH = "D:\\tmp\\tests";
    private final String BASE_ESPERADO_PATH_DIR = "D:\\home\\ework\\microcontrollers\\neogen_codegen\\src\\test\\resources\\targets\\";
    
    
    private final Main instance;
    
    
    public CodeGeneratorTests() {
        super();    
        this.instance = new Main();
    }
        
    
    @DisplayName( "prueba 001: asignacion simple")
    @Test
    void test_001() {
        runTest(  "001_simple_assignment");
    }
    
    @DisplayName( "prueba 002: dos entradas")
    @Test
    void test_002() {
        runTest(  "002_two_inputs");
    }
    
    @DisplayName( "prueba 003: prender y apagar")
    @Test
    void test_003() {
        runTest(  "003_turn_on_turn_off");
    }
    
    @DisplayName( "prueba 004: prender y apagar por XXms")
    @Test
    void test_004() {
        runTest(  "004_turn_on_turn_off_Xms");
    }
    
    @DisplayName( "prueba 005: prender mientras")
    @Test
    void test_005() {
        runTest(  "005_turn_on_while");
    }
    
    @DisplayName( "prueba 006: prender por XXmx cada YY ms")
    @Test
    void test_006() {
        runTest(  "006_toggle_every");
    }
    
    @DisplayName( "prueba 007: prender por XXmx cada YY ms cuando inputA es activo")
    @Test
    void test_007() {
        runTest(  "007_toggle_every_when");
    }
    
    @DisplayName( "prueba 008: prender por XXmx cada YY ms cuando inputA es activo, mientras inputA es activo")
    @Test
    void test_008() {
        runTest(  "008_toggle_every_when_while");
    }
    
    
    private void runTest( String name) {        
        var programPath = BASE_PROGRAM_PATH_DIR + name + ".ggma";
        
        // generar codigo
        try {
            instance.generateProject( programPath, TEMPLATE_PROYECT_PATH, TARGET_BASE_PATH);
            
            var esperadoPath = BASE_ESPERADO_PATH_DIR + name;
        
            // comparar contra salida esperada: archivo por archivo, linea por linea
            compararDirectorios( new File( esperadoPath), new File( TARGET_BASE_PATH));
            
        } catch( Exception ex) {
            throw new RuntimeException( ex);
        }
    }
    
    private void compararDirectorios( File source, File target) throws IOException {
        
        // directories to ignore
        
        if ( "target".equals( source.getName())) {
            return;
        }
        
        // compare directory compoments
        
        File targetObject;
        
        for( File sourceObject : source.listFiles()) {
            targetObject = new File( target, sourceObject.getName());
            Assertions.assertTrue( target.exists());
            
            if ( sourceObject.isDirectory()) {
                compararDirectorios( sourceObject, targetObject);
            } else{
                compararArchivos( sourceObject, targetObject);
            }
        }
    }
    
    private void compararArchivos( File source, File target) throws IOException {
        try (
            BufferedReader s = new BufferedReader( new FileReader( source));
            BufferedReader t = new BufferedReader( new FileReader( target));
        ) {
            String line;
            String otherLine;
            
            while ( (line = s.readLine()) != null) {
                otherLine = t.readLine();
                if ( !line.isBlank() || !otherLine.isBlank()) {
                    Assertions.assertEquals( line.trim(), otherLine.trim());
                }
            }
        }
    }
}
