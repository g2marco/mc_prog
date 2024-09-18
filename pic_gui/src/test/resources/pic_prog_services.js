/* global Handlebars */

const _templates = (function() {
	const items = {};
    
    function fill( id, bean) {
        let template = _get_template( id);
			
		if ( template) {
			return template( bean);
		}
        
		console.error( 'Template no encontrado: [' + id + ']');
        
		return null;
	}
    
    function _get_template( id) {
		let template = items[ id];
		
        if ( template) {
            return template;
        }
        
		let source = document.getElementById( id);
		if ( source === null) {
            return null;
        }
		
		return items[ id] = template = Handlebars.compile( source.innerHTML.trim());
	}
	
	return {
		fill: fill
	};
})();

Handlebars.registerHelper( 'format', function( value, frmt, bits) {
	return new Handlebars.SafeString( _frmt.format( value, frmt, bits));
});

/**
 * Executes a block if modulo operation returns 0.
 *
 * @param  {mixed}  num    The dividend
 * @param  {mixed}  mod    The divisor
 * @param  {html}   block  html block to evaluate if true
 */
Handlebars.registerHelper( 'moduloIf', function( num, mod, block) {
    if ( parseInt( num, 10) % parseInt( mod, 10) === 0) {
        return block.fn( this);
    } else {
        return block.inverse(this);
    }
});

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




const component = (function() {
    const env = {};
    
    const resource_device = '/_data_/manage/device/{pic}?action={action}'; 
    const resource_ticket = '/_data_/get/ticket/{ticket}';
    
    function set_params( server, device, action) {
        env.server = server;
        env.device = device;
        env.action = action;
    }
    
    function invoke_service() {
        console.log( "invoking device action: " + env.action);
        
        let resource = resource_device.replace( '{pic}', env.device).replace( '{action}', env.action);
        
        popup.init();
        
        jQuery.ajax({
            url        : env.server + resource,
            method     : 'POST',
            crossDomain: true  ,
            contentType: false ,
            cache      : false ,                
            processData: false ,
            success: device_callback,
            error: function (xhr, status) {
                popup.stop( {codigo: 600, clave: 'error.desconocido', mensajes: [ {mensaje: "local server not avalilable or misconfigured"}]});
            }
        });
    }
    
    function device_callback( rsp) {
        env.ticket  = rsp.ticket; 
        env.handler = setInterval( ticket_callback, 3000);
    }
    
    function ticket_callback() {
        console.log( "invoking ticket estatus: " + env.ticket);
        
        let resource = resource_ticket.replace( '{ticket}', env.ticket);
        
        jQuery.ajax({
            url        : env.server + resource,
            method     : 'GET',
            crossDomain: true ,
            contentType: false,
            cache      : false,                
            processData: false,
            success: ticket_done_callback,
            error: function (xhr, status) {
                console.info( xhr);
                console.info( status);
            }
        });
    }
    
    function ticket_done_callback( rsp) {
        console.info( rsp);
        
        if ( rsp.codigo !== 200) {
            clearTimeout( env.handler);
            popup.stop( rsp);
            
            return;
        }
        
        if ( rsp.item.done) {
            clearTimeout( env.handler);
            popup.stop();
            
            card.update( rsp.item);
        }
    }
    
    return {
        setParams: set_params,
        invoke   : invoke_service        
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


const card = (function() {
    
    function update( item) {
        init_container();
        
        let values;
        
        if ( item.metadata && item.data.config) {
            let config   = item.data.config;
            let metadata = JSON.parse( item.metadata);
            
            fill_device_id( 'device_id', {name: metadata.device, value: '--' + _frmt.format( config[6], 'bin', 14)});
            
            values = [
                '--' + _frmt.format( config[0], 'bin', 14), '--' + _frmt.format( config[1], 'bin', 14),
                '--' + _frmt.format( config[2], 'bin', 14), '--' + _frmt.format( config[3], 'bin', 14)
            ];
            
            fill_serial_words( 'serial', values);
        
            values = set_config_bits( config[7], metadata);
            fill_config_word( 'config_word', values);
            
            values = set_config_values( config[7], metadata);
            fill_config_desc( 'config_desc', values);
        }
              
        //
            
        values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 11, 12, 13, 14, 15, 16, 17, 18, 19, 110, 111, 112, 113, 114, 115, 116, 21, 22, 23, 24, 25, 26, 27, 28, 29, 210, 211, 212, 213, 214, 215, 216];
        
        fill_memory_bank( 'prog_mem', 32, 14, 14, values);
        fill_memory_bank( 'data_mem',  0, 10,  8, values);
    }
    
    function fill_device_id( idTable, deviceId) {
        let ctnr = jQuery( '#' + idTable);
    
        ctnr.append( _templates.fill( '_nibles_line_', {values: deviceId.value.split( '')}));
        ctnr.append( '<tr><td colspan="20" style="font-size: 1.2em;"><b>' + deviceId.name + '</b></td></tr>');
    }
    
    function fill_serial_words( idTable, values) {
        let ctnr = jQuery( '#' + idTable);
    
        for ( let value of values) {
            ctnr.append( _templates.fill( '_nibles_line_', {values: value.split( '')}));
        }
    }
       
    function fill_config_word( idTable, values) {
        let ctnr = jQuery( '#' + idTable);
        ctnr.append( _templates.fill( '_cfgw_tbl_', {values: values}));
    }
    
    function fill_config_desc( idTable, values) {
        let ctnr = jQuery( '#' + idTable);
    
        ctnr.append( _templates.fill( '_cfgd_header_', {}));
        ctnr.append( _templates.fill( '_cfgd_line_', {values: values}));
    }

    /**
     *  Inicializa los datos de un banco de memoria, usando 16 datos por linea
     * 
     * @param {type} idTable        id de la tabla
     * @param {type} startAddr      direccion inicial del banco de memoria
     * @param {type} addrBits       bits para representar las direcciones
     * @param {type} bits           bits para representar los datos 
     * @param {type} values         valores 
     * 
     * @returns  nothing
     */
    function fill_memory_bank( idTable, startAddr, addrBits, bits, values) {
        let ctnr = jQuery( '#' + idTable);
    
        ctnr.append( _templates.fill( '_bank_header_', {}));
        
        let size    = 16;
        let packets = values.length / size;
        
        let ctx = {addrBits: addrBits, bits: bits};
        
        for ( let i = 0 ; i < packets; i++) {
            ctx.addr   = startAddr + (i * size);
            ctx.values = values.slice( i * size, (i + 1) * size);
        
            ctnr.append( _templates.fill( '_prog_line_', ctx));
        }
    }

    function init_container() {
        let ctnr = jQuery( '#container');
        
        ctnr.empty();
        
        append_item( ctnr, {title: 'Device ID'          , values: [{name: 'device_id'  }]});
        append_item( ctnr, {title: 'Serial Number'      , values: [{name: 'serial'     }]});
        append_item( ctnr, {title: 'Configuration Word' , values: [{name: 'config_word'}, {name: 'config_desc', className: 'normal'}]});
        append_item( ctnr, {title: 'Program Memory'     , values: [{name: 'prog_mem'   }]});
        append_item( ctnr, {title: 'Data Memory'        , values: [{name: 'data_mem'   }]});
    }
    
    function set_config_bits( value, metadata) {
        let items = [
            {name: '-'     , value: '-'}, {name: '-', value: '-'}, {name: '-', value: '-'}, {name: '-', value: '-'},
            {name: '-'     , value: '-'}, {name: '-', value: '-'}, {name: '-', value: '-'}, {name: '-', value: '-'},
            {name: '-'     , value: '-'}, {name: '-', value: '-'}, {name: '-', value: '-'}, {name: '-', value: '-'},
            {name: '-'     , value: '-'}, {name: '-', value: '-'}, {name: '-', value: '-'}, {name: '-', value: '-'}
        ];
        
        let txt = _frmt.format( value, 'bin', 16);
        
        //  0  1  2  3   4   5  6  7    8  9 10 11   12 13 14 15  items[idx], txt[idx]  idx = (15 - bit)
        // __ __ __ __   __ __ __ __   __ __ __ __   __ __ __ __
        // 15 14 13 12   11 10  9  8    7  6  5  4    3  2  1  0   bit
        
        let bits, idx;
        
        for ( let entry of metadata.items) {  // item {name, value}
            bits = entry.bits;
            
            for ( let bit of bits) {
                idx = 15 - bit;
                
                items[ idx].name  = entry.id;
                items[ idx].value = txt[ idx];
            }
        }
        
        return items;
    }
    
    function set_config_values( value, metadata) {
        let txt = _frmt.format( value, 'bin', 16);    
        let bits, idx, setting, option;
        
        let items = [];
        
        for ( let entry of metadata.items) { 
            bits = entry.bits;
            setting = '';
            
            for ( let bit of bits) {
                idx = 15 - bit;
                setting += txt[ idx];
            }
            
            // {name: 'WDTE', desc: 'watch dog timer enable', value: '1', meaning: 'OFF'}
            option = entry.options[ entry.options.findIndex( i => i.value === setting)];
            items.push({ name: entry.id, desc: entry.prompt, value: setting, meaning: option.label});
        }
        
        return items;
    }
    
    function append_item( ctnr, ctx) {
        ctnr.append( _templates.fill( '_card_item_', ctx));
    }
    
    return {
        update: update
    };
})();
