const http = require( 'http');
const fs = require('fs');


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
	
	// invoca procesamiento
	
	let resultado = parse_resultado();
	let response = {codigo: 200, clave: 'operation.success', item: resultado};
	
	return JSON.stringify( response);
} 

function save_request( request) {
	let info = 'o=' + request.operation.charAt( 0);
	
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
		info += '\nc' + i + 'v=' + localidad.value;
		info += '\nc' + i + 'r=' + localidad.read;
		info += '\nc' + i + 'w=' + localidad.write;
	}
	
	let opciones = request.options;
	
	info += '\na=' + opciones.areas.map( function( str) { return str.charAt( 0); }).join( ',');
	info += '\nv=' + opciones.voltages.map( function(str) { return str.charAt( 0); }).join( ',');
	
	let filePath = '/tmp/pic_prog_request.txt';
	
	//fs.unlink( filePath);
	
	fs.writeFileSync( filePath, info);
}


function parse_resultado() {
	let filePath = '/tmp/pic_prog_request.txt';
	
	let data = fs.readFileSync( filePath, 'utf8');
	//fs.unlink( filePath);
	
	let resultado = { 
		operation	: null, 
		buffer		: {program: [], data: [], configuration: []},
		options		: {areas: null, voltajes: null}
	};
	
	let lineas = data.split( '\r\n');
	let linea = null;

	let idx		= null;
	let campo	= null;
	let bancos	= null;
	
	for( let i = 0; i < lineas.length; ++i) {
		linea = lineas[ i];
		
		console.info( linea);
		
		switch( linea.charAt(0)) {
		
		case 'a':
			resultado.options.areas = linea.substring( 2).split( ',').map( function( letra) {
				if( letra == 'c') { return 'configuration'; }
				else if( letra == 'd') { return 'data'; }
				else { return 'program'; }
			});
			
			break;
		
		case 'c':
			let localidades = resultado.buffer.configuration;
			let localidad = null;
			
			for( let i = 0; i < localidades.length; ++i) {
				localidad = localidades[i];
				info += '\nc' + i + 'v=' + localidad.value;
				info += '\nc' + i + 'r=' + localidad.read;
				info += '\nc' + i + 'w=' + localidad.write;
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
			console.info( )
			
			break;
			
		case 'o': 
			resultado.operation =  (linea.charAt(2) == 'r')? 'read' : 'program';
			break;
		
		case 'p':
			
			idx		= parseInt( linea.charAt( 1), 10);
			console.log( idx);
			
			campo	= linea.charAt( 2);
			console.log( campo);
			
			bancos	= resultado.buffer.program;
			
			if( campo == 'i') {
				bancos.push({});
				bancos[ idx].starAddress = parseInt( linea.substring( 4), 10);
			} else if( campo == 'l') {
				bancos[ idx].length = parseInt( linea.substring( 4), 10);
			} else {
				bancos[ idx].values = linea.substring( 4).split( ',').map( function( str) { return parseInt(str, 10);});
			}
			console.log( bancos);
			
			break;
		
		
		case 'v':
			resultado.options.areas = linea.substring( 2).split( ',').map( function( letra) {
				if( letra == 'h') { return 'high'; }
				else if( letra == 'l') { return 'low'; }
				else { return 'normal'; }
			});
		
			break;
		}
	}
	
	return resultado;
	
}