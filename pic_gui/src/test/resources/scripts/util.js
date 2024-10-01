"use strict";

const _frmt = (function() {
    function format( value, frmt, bits) {
        switch( frmt) {
            case 'bin': return frmt_bin( value, bits);
            case 'hex': return frmt_hex( value, bits);
            default:
                console.error( '[_frmt] fomato desconocido: ' + frmt);
        }
    }
    
    //
    //  decimal to hexadecimal using x bits
    //
    function frmt_hex( value, bits) {
        let digits = Math.ceil( bits / 4);
        let mask   = 2**bits - 1;
    
        return ((value >>> 0) & mask).toString( 16).toUpperCase().padStart( digits, '0') + 'H';
    }

    //
    //  decimal to binary, using x bits
    //
    function frmt_bin( value, bits) {
        let digits = bits;
        let mask   = 2**bits - 1;
    
        return ((value >>> 0) & mask).toString( 2).toUpperCase().padStart( digits, '0');
    }
    
    return {
        format: format
    };
})();

const popup = {
    init: () => {
        jQuery( '#container').empty().append( _templates.fill( '_message_', {message: 'Esperando respuesta del servidor'}));
        jQuery( '#loader').show().addClass( 'loading');
    },
    
    stop: rsp => {
        if ( rsp && rsp.codigo) {
            let ctx = {message: '[error code: '+ rsp.codigo + '] ' +  rsp.clave + ': ' + rsp.mensajes[0].mensaje.replaceAll( '\n', '<br/>')};
            jQuery( '#container').empty().append( _templates.fill( '_message_', ctx));
        }
        
        jQuery( '#loader').hide().removeClass( 'loading');
    }
};

const dialog = {
    open: device => {
        document.getElementsByName( 'device').value = 'PIC16F';
        document.getElementById( 'dialog_box').showModal();
    },
    
    submit: () => {
        console.log( '[dialog submit]');
        
        document.getElementById( 'dialog_box').close();
    }
};
