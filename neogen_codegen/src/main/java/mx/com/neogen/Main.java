package mx.com.neogen;

import mx.com.neogen.code.Preprocessor;
import mx.com.neogen.code.SentenceParser;
import mx.com.neogen.code.impls.ProyectGenerator;

import java.io.IOException;
import mx.com.neogen.code.ExpressionParser;
import mx.com.neogen.code.beans.Operator;
import mx.com.neogen.code.enums.OperatorTypeEnum;
import mx.com.neogen.code.impls.CLikeTranslator;
import mx.com.neogen.code.interfaces.Parser;
import mx.com.neogen.code.interfaces.Translator;

public class Main {
    private final static String BASE_PATH_DIR = "D:\\home\\ework\\microcontrollers\\pic12f683\\10_neogen_codegen\\";
    
    private final static String TEMPLATE_PROYECT_PATH = BASE_PATH_DIR + "template";
    private final static String TARGET_PROYECT_PATH   = BASE_PATH_DIR + "target";
    
    //private final static String PROGRAM_PATH = BASE_PATH_DIR + "examples\\001_simple_assignment.ggma";
    //private final static String PROGRAM_PATH = BASE_PATH_DIR + "examples\\002_two_inputs.ggma";
    //private final static String PROGRAM_PATH = BASE_PATH_DIR + "examples\\003_turn_on_turn_off.ggma";
    //private final static String PROGRAM_PATH = BASE_PATH_DIR + "examples\\004_turn_on_turn_off_Xms.ggma";
    //private final static String PROGRAM_PATH = BASE_PATH_DIR + "examples\\005_turn_on_while.ggma";
    //private final static String PROGRAM_PATH = BASE_PATH_DIR + "examples\\006_toggle_every.ggma";
    //private final static String PROGRAM_PATH = BASE_PATH_DIR + "examples\\007_toggle_every_when.ggma";
    private final static String PROGRAM_PATH = BASE_PATH_DIR + "examples\\008_toggle_every_when_while.ggma";
    
    private final Parser         expressionParser;
    private final Translator expressionTranslator;
    
    
    public Main() {
        super();
        
        this.expressionParser     = createExpressionParser();
        this.expressionTranslator = createExpressionTranslator();
    }
    
   
    public static void main(String[] args) throws IOException {
        var main = new Main();
        
        main.generateProject( PROGRAM_PATH, TEMPLATE_PROYECT_PATH, TARGET_PROYECT_PATH);
    }
    
    public void generateProject( String programPath, String templatePath, String targetPath) throws IOException {
         // obtain instrucion lines
        var preprocessor = new Preprocessor();
        var sentences    = preprocessor.readSentences( programPath);

        // parses each instruction
        var sentenceParser = new SentenceParser( expressionParser, expressionTranslator);
        var programa  = sentenceParser.parse( sentences);
        
        System.out.println( programa);
        
        // generates low-level code
        var generator = new ProyectGenerator( templatePath);
        generator.createProyect( targetPath, programa);
    }
    
    private Parser createExpressionParser() {
        var operators = new Operator[] {
            new Operator( OperatorTypeEnum.UNARY ,          "not",  "!", 1),
            new Operator( OperatorTypeEnum.UNARY ,            "!",  "!", 1),
            new Operator( OperatorTypeEnum.BINARY,         " or ", "||", 3),
            new Operator( OperatorTypeEnum.BINARY,        " and ", "&&", 4),
            new Operator( OperatorTypeEnum.BINARY,           "==",       8),
            new Operator( OperatorTypeEnum.BINARY,     " equals ", "==", 8),
            new Operator( OperatorTypeEnum.BINARY,           "!=",       8),
            new Operator( OperatorTypeEnum.BINARY, " not equals ", "!=", 8),
        };
        
        return new ExpressionParser( operators, false);
    }
    
    private Translator createExpressionTranslator() {
        return new CLikeTranslator();
    }
    
}
