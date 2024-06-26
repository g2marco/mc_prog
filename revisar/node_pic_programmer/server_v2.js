const http     = require( 'http');
const fs       = require( 'fs');
const {execSync} = require( 'child_process');

const REQUEST_FILE_PATH  = '/tmp/pic_prog_request.txt';
const RESPONSE_FILE_PATH = '/tmp/pic_prog_response.txt';
	
const server = http.createServer( callback_server);
server.listen( 8081);

function callback_server( request, response) {
    
    request.setEncoding( 'utf8');
    let json = '';
    
    request.on( 'data', function( chunck) {
        json += chunck;
    });
    
    request.on( 'end', function() {
        response.writeHead( 200, {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
        });
        
        response.write( atender_peticion( JSON.parse(json)));
        
        response.end();
    });
}

function atender_peticion( request) {
	save_request( request);
	
	let buffer = execSync( '/usr/local/pic_programmer/pic16fxxx');
	
	let resultado = parse_resultado();

	let response = {codigo: 200, clave: 'operation.success', item: resultado};
	
	return JSON.stringify( response);
} 

function save_request( request) {
	let info = 'o=' + request.operation.charAt( 0);
	
	let opciones = request.options;
	
	info += '\na=' + opciones.areas.map( function( str) { 
		return str.charAt( 0) + request.buffer[str].length; 
	}).join( ',');
	
	info += '\nv=' + opciones.voltages.map( function(str) { return str.charAt( 0); }).join( ',');
		
	let bancos = request.buffer.program;
	let banco = null;
	
	for( let i = 0; i < bancos.length; ++i) {
		banco = bancos[i];
		info += '\np' + i + 'i=' + banco.startAddress;
		info += '\np' + i + 'l=' + banco.length;
		info += '\np' + i + 'v=' + banco.values.join( ',');
	}
	
	bancos = request.buffer.data;
	
	for( let i = 0; i < bancos.length; ++i) {
		banco = bancos[i];
		info += '\nd' + i + 'i=' + banco.startAddress;
		info += '\nd' + i + 'l=' + banco.length;
		info += '\nd' + i + 'v=' + banco.values.join( ',');
	}
	
	let localidades = request.buffer.configuration;
	let localidad = null;
	
	for( let i = 0; i < localidades.length; ++i) {
		localidad = localidades[i];
		info += '\nc' + i + 'a=' + localidad.address;
		info += '\nc' + i + 'i=' + localidad.id;
		if ( typeof(localidad.value) != 'undefined') {
			info += '\nc' + i + 'v=' + parseInt( localidad.value.replace( / /g , ''), 2);
		}
		info += '\nc' + i + 'r=' + (localidad.read? 't': 'f');
		info += '\nc' + i + 'w=' + (localidad.write? 't': 'f');
	}
	
	fs.writeFileSync( REQUEST_FILE_PATH, info);
}

function parse_resultado() {
	let data = fs.readFileSync( RESPONSE_FILE_PATH, 'utf8');
	
	let resultado = { 
		operation	: null, 
		buffer		: {program: [], data: [], configuration: []},
		options		: {areas: null, voltages: null}
	};
	
	let lineas = data.split( '\n');
	let linea = null;

	let idx		= null;
	let campo	= null;
	let valor   = null;
	let bancos	= null;
	
	for( let i = 0; i < lineas.length; ++i) {
		linea = lineas[ i];
		
		switch( linea.charAt(0)) {
		
		case 'a':
			resultado.options.areas = linea.substring( 2).split( ',').map( function( str) {
				let letra = str.charAt(0);
				if( letra == 'c') { 		return 'configuration'; }
				else if( letra == 'd') { 	return 'data'; }
				else { 						return 'program'; }
			});
			
			break;
		
		case 'c':
			let localidades = resultado.buffer.configuration;
			
			idx		= parseInt( linea.charAt( 1), 10);
			campo	= linea.charAt( 2);
			valor   = linea.substring( 4);
			
			if( campo == 'a') {
				localidades.push({});
				localidades[ idx].address = valor;
			} else if( campo == 'i') {
				localidades[ idx].id = valor;				
			} else if( campo == 'r') {
				localidades[ idx].read = (valor == 't');
			} else if( campo == 'w') {
				localidades[ idx].write = (valor == 't');
			} else {
				localidades[ idx].value = parseInt( valor, 10).toString( 2);
			}
			
			break;
			
		case 'd':
			idx		= parseInt( linea.charAt( 1), 10);
			campo	= linea.charAt( 2);
			bancos	= resultado.buffer.data;
			
			if( campo == 'i') {
				bancos.push({});
				bancos[ idx].starAddress = parseInt( linea.substring( 4), 10);
			} else if( campo == 'l') {
				bancos[ idx].length = parseInt( linea.substring( 4), 10);
			} else {
				bancos[ idx].values = linea.substring( 4).split( ',').map( function( str) { return parseInt(str, 10);});
			}
				
			break;
			
		case 'o': 
			resultado.operation =  (linea.charAt(2) == 'r')? 'read' : 'program';
			break;
		
		case 'p':
			idx		= parseInt( linea.charAt( 1), 10);		
			campo	= linea.charAt( 2);			
			bancos	= resultado.buffer.program;
			
			if( campo == 'i') {
				bancos.push({});
				bancos[ idx].starAddress = parseInt( linea.substring( 4), 10);
			} else if( campo == 'l') {
				bancos[ idx].length = parseInt( linea.substring( 4), 10);
			} else {
				bancos[ idx].values = linea.substring( 4).split( ',').map( function( str) { return parseInt(str, 10);});
			}
			
			break;		
		
		case 'v':
			resultado.options.voltages = linea.substring( 2).split( ',').map( function( letra) {
				if( letra == 'h') { return 'high'; }
				else if( letra == 'l') { return 'low'; }
				else { return 'normal'; }
			});
		
			break;
		}
	}
	
	return resultado;
}