var hex_parser = (function () {
	
	function getTipoLinea( linea) {
		let type = linea.substring(7, 9);
		if( type == '00') {         return 'data';      // linea de datos
		} else if ( type == '01') { return 'eof';       // linea de fin de registro
		} else if( type == '04') {  return 'ext';       // registro de direccion extendida
		}
		return null;
	}

	function validarLinea( linea) {
		let line = linea.trim();

		if( line.charAt(0) != ':') {
			return 'Línea no inicia con el "start code"';
		}

		let numeroBytes = ((line.length - 1)/2) - 1; 
		let offset = suma = numero = 0;

		for ( let i = 0; i < numeroBytes; ++i) {
			offset = 1 + i*2;
			numero = parseInt( line.substring( offset, offset + 2) ,16)
			suma += ((numero ^ 0xFF) + 1);
		}

		suma &= 0x00FF;

		let longitud = line.length;
		let checksum = parseInt( line.substring( longitud-2, longitud), 16);

		return (suma == checksum)? null : 'Checksum no concuerda';
	}


	function parsearLinea( line) {
		let byteCount   = parseInt( line.substring(1, 3), 16);
		let addrX2      = parseInt( line.substring(3, 7), 16);

		let offset, lowByte, highByte;

		let values = [];

		for( let i = 0; i < byteCount/2; i++) {
			offset = 9 + i*4;
			lowByte = parseInt( line.substring( offset, offset + 2), 16);
			highByte= parseInt( line.substring( offset + 2, offset + 4), 16);

			values.push( ((highByte * 256) + lowByte));
		}

		return {
			addr    : addrX2 / 2,
			values  : values
		};
	}

	/**
	 * 	Parse el contenido de un archivo hexadecimal.
	 * 		- Agrega al buffer la información del archivo
	 * 		- Si hay algun error, devuelve un mensaje de error, de lo contrario devuelve 'null'
	 */
	function parsearArchivo( deviceBuffer, contenido) {
		let lineas = contenido.split( '\r\n');

		let longitud = lineas.length;
		
		let linea = null;
		let mensaje = null;
		
		let tipo    = null;
		let paquete = null;
		let address = null;
		let banco   = null;
		
		for ( let i = 0; i < longitud; ++i) {
			linea = lineas[i];

			if( !linea || linea.length == 0) {
				// linea vacia, termina
				break;
			}

			mensaje = validarLinea( linea);
			if ( mensaje) { return mensaje; }

			tipo = getTipoLinea( linea);

			if ( tipo == 'data') {
				paquete = parsearLinea( linea);
				address = paquete.addr;
				
				banco = obtenerBanco( buffer, address);
				
				for ( let j = 0; j < paquete.values.length; ++j) {
					banco.values[ address + j] = paquete.values[ j];
				}

			} else if (tipo == 'ext') {
				console.err( "No se ha definido que hacer con registros de tipo EXT")
		
			}
		}
		
		return null;
	}

	function obtenerBanco( buffer, direccion) {
		// memoria de programa
		
		let bancos = buffer.program;
		let banco  = null;
		let ini    = null;
		let end    = null;
		
		for( let i = 0; i < bancos.length; ++i) {
			banco = bancos[ i];
			ini = banco.startAddress;
			end = ini + (banco.length - 1);
			
			if ( direccion >= ini && direccion <= end) {
				return banco;
			} 
		}
		
		// memoria de datos 		?
		
		// memoria de configuracion	?
		
	}
	
	return {
		parse: parsearArchivo
	};
	
})();