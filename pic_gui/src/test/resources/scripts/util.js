"use strict";

function j( id) {
    return new _(id);
}

function _( id) {
    this.item = dom.getById( id);
}

_.prototype = (function() {
    
    function empty() {
        this.item.innerHTML = '';
        return this;
    }
    
    function append( html) {
        let items = this.item.children;
        
        if ( items.length > 0 && items[0].tagName === 'TBODY') {
            items[0].innerHTML += html;
        } else {
            this.item.innerHTML += html;
        }
        
        return this;
    }
    
    function hide() {
        this.item.style.display = 'none';
        return this;
    }
    
    function show() {
        this.item.style.display = 'block';
        return this;
    }
    
    function add_class( name) {
        this.item.classList.remove( name);
        this.item.classList.add( name);
        return this;
    }
    
    function remove_class( name) {
        this.item.classList.remove( name);
        return this;
    }
    
    return {
        empty   : empty,
        append  : append, 
        hide    : hide,
        show    : show, 
        addClass: add_class,
        removeClass: remove_class
    };
})();


const dom = (function() {
    
    function get_by_id( id) {
        return document.getElementById( id);
    }
    
    function on_event( id, event, callback) {
        get_by_id( id).addEventListener( event, callback);
    }
    
    function dispatch_change( id) {
        get_by_id( id).dispatchEvent( new Event( 'change'));
    }
    
    return {
        getById : get_by_id,
        on      : on_event ,
        change  : dispatch_change
    };
})();

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
        j( 'container').empty().append( _templates.fill( '_message_', {message: 'Esperando respuesta del servidor'}));
        j( 'loader').show().addClass( 'loading');
    },
    
    stop: rsp => {
        let ctnr = j( 'container').empty();
        
        if ( rsp && rsp.codigo) {
            let ctx = {message: '[error code: '+ rsp.codigo + '] ' +  rsp.clave + ': ' + rsp.mensajes[0].mensaje.replaceAll( '\n', '<br/>')};   
            ctnr.append( _templates.fill( '_message_', ctx));
        }
        
        j( 'loader').hide().removeClass('loading');
    }
};

const dialog = {
    open: function( ) {
        dom.getById( 'dialog_box').showModal();
    },
    
    submit: ( callback ) => {
        dom.getById( 'dialog_box').close();

        callback();        
    }
};
