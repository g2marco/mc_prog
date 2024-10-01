package mx.com.neogen.code;

import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.Writer;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;
import org.apache.velocity.runtime.resource.loader.FileResourceLoader;

public class TemplateEngine {
    
    
    public TemplateEngine( String resourceLoader, File templateBase) {
        initEngine( resourceLoader, templateBase);
    }    
    
    
    public void fillTemplate( String pathTemplate, Writer output, Object data) {
        var template = getTemplate( pathTemplate);
        
        VelocityContext context = new VelocityContext();
        context.put( "data", data);
        
        try ( Writer writer = new BufferedWriter( output)) {
            template.merge( context, writer);
            
        } catch( IOException ex) {
            throw new RuntimeException( "Error al llenar template: " + pathTemplate, ex);
        }
    }
    
    private void initEngine( String resourceLoader, File templateBase) {
        switch (resourceLoader) {
            case "classpath":
                // template contenidos en el proyecto
                Velocity.setProperty( RuntimeConstants.RESOURCE_LOADER, "classpath");
                Velocity.setProperty( "classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
                break;
                
            case "file":
                // templates ubicados a partir de una ruta 
                Velocity.setProperty( RuntimeConstants.RESOURCE_LOADER, "file");
                Velocity.setProperty( RuntimeConstants.RESOURCE_LOADER_CLASS, FileResourceLoader.class.getName());
                Velocity.setProperty( RuntimeConstants.FILE_RESOURCE_LOADER_PATH, templateBase.getAbsolutePath());
                
                break;
                
            default: 
                throw new RuntimeException( "Unknown resource loader type: " + resourceLoader);
        }
        
        Velocity.init( );
    }
    
    private Template getTemplate( String path) {
        try {
            return Velocity.getTemplate( path);
        
        } catch( ResourceNotFoundException ex) {
            throw new RuntimeException( "Error when getting template: " + path, ex);
        }
    }
    
}
