<!doctype html>

<html>
<head>
<script>
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


function parsearLinea( linea) {

    let byteCount   = parseInt( line~.substring(1, 3), 16);
    let addrX2      = parseInt( linea(3, 7), 16);
    let type        = parseInt( linea(7, 9), 16);
    
    let offset;
    let lowByte;
    let highByte;
    
    for( let i = 0; i < byteCount; i++) {
        offset = 9 + i*4;
        lowByte = parseInt( linea( offset, offset + 2), 16);
        highByte= parseInt( linea( offset + 2, offset + 4), 16);
    }


}

    console.info( parsearLinea());
    
</script>

<head>
<body>
    =O)
</body>
</html>