package mx.com.neogen.code.impls;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import mx.com.neogen.code.TemplateEngine;
import mx.com.neogen.code.beans.BeanProgram;

public class ProyectGenerator {
    
    private File source;
    private TemplateEngine templates;
    
    public ProyectGenerator( String sourcePath) {
        super();
        
        this.source = new File( sourcePath);                
        this.templates = new TemplateEngine( "file", source);
    }
    
    
    public void createProyect( String targetPath, BeanProgram bean) {
        try {
            copyOrFill( source, new File( targetPath), bean);
        } catch( Exception ex) {
            throw new RuntimeException( "Error when generating proyect", ex);
        }
    }
    
    private void copyOrFill( File sourceFile, File targetBaseDir, BeanProgram bean) throws IOException {
        if ( sourceFile.isDirectory()) {
            if( "templates".equals (sourceFile.getName())) {
                return;
            }
            
            createDirectory( sourceFile, targetBaseDir);
            
            for( File file : sourceFile.listFiles()) {
                copyOrFill( file, targetBaseDir, bean);
            }
            
        } else if( sourceFile.isFile() && !sourceFile.isHidden()) {
            if( isTemplate( sourceFile)) {
                fillTemplate( sourceFile, targetBaseDir, bean);
            } else { 
                copyFile( sourceFile, targetBaseDir);
            }
        }
    }
    
    private boolean isTemplate( File file) {
        return file.getName().toLowerCase().endsWith( ".vm");
    }
    
    private void createDirectory( File sourceDir, File targetBaseDir) {
        var targetDir = new File( targetBaseDir, getRelativePath( sourceDir));
        targetDir.mkdirs();
    }

    private void copyFile( File sourceFile, File targetBaseDir) {
        var targetFile = new File( targetBaseDir, getRelativePath( sourceFile));
        
        try (
            InputStream input = new FileInputStream( sourceFile);
            OutputStream output = new FileOutputStream( targetFile);
        ) {
            byte[] buffer = new byte[4096];
            int leidos;
            while( (leidos = input.read( buffer)) != -1 ) {
                output.write( buffer, 0, leidos);
            }
            
            output.flush();
            
        } catch( Exception ex) {
            throw new RuntimeException( "Error when copying files", ex);
        }
        
    }
    
    private void fillTemplate( File sourceFile, File targetBaseDir, BeanProgram bean) throws IOException {
        String template = getRelativePath( sourceFile);
        var output = new FileWriter( new File( targetBaseDir, template.replace( ".vm", "")));
        
        templates.fillTemplate( template, output, bean);
    }
    
    private String getRelativePath( File sourceFile) {
        return sourceFile.getAbsolutePath().replace( this.source.getAbsolutePath(), "");
    }
    
}
