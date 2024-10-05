"use strict";

const card = (function() {
    const env = {metadata: null};
    
    function set_metadata ( metadata) {
        env.metadata = metadata;
    }
    
    function update( item) {
        init_container();
        
        if ( item.data.config) {
            let values;
            let config = item.data.config;
            
            fill_device_id( 'device_id', {name: item.device, value: '--' + _frmt.format( config[ 6], 'bin', 14)});
            
            values = [
                '--' + _frmt.format( config[0], 'bin', 14), '--' + _frmt.format( config[1], 'bin', 14),
                '--' + _frmt.format( config[2], 'bin', 14), '--' + _frmt.format( config[3], 'bin', 14)
            ];
            
            fill_serial_words( 'serial', values);
        
            values = set_config_bits( config[7], env.metadata);
            fill_config_word( 'config_word', values);
            
            values = set_config_values( config[7], env.metadata);
            fill_config_desc( 'config_desc', values);
        }
        
        fill_memory_bank( 'prog_mem', 0, 14, 14, item.data.program[0].locations);
        fill_memory_bank( 'data_mem', 0, 10,  8, item.data.data[0].locations   );
    }
    
    function fill_device_id( idTable, deviceId) {
        let ctnr = j( idTable);
    
        ctnr.append( _templates.fill( '_nibles_line_', {values: deviceId.value.split( '')}));
        ctnr.append( '<tr><td colspan="20" style="font-size: 1.2em;"><b>' + deviceId.name + '</b></td></tr>');
    }
    
    function fill_serial_words( idTable, values) {
        let ctnr = j( idTable);
    
        for ( let value of values) {
            ctnr.append( _templates.fill( '_nibles_line_', {values: value.split( '')}));
        }
    }
       
    function fill_config_word( idTable, values) {
        let ctnr = j( idTable);
        ctnr.append( _templates.fill( '_cfgw_tbl_', {values: values}));
    }
    
    function fill_config_desc( idTable, values) {
        let ctnr = j( idTable);
    
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
        let ctnr = j( idTable);
    
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
        let ctnr = j( 'container');
        
        ctnr.empty();
        
        append_item( ctnr, {title: 'Device ID'          , values: [{name: 'device_id'  }]});
        append_item( ctnr, {title: 'Serial Number'      , values: [{name: 'serial'     }]});
        append_item( ctnr, {title: 'Configuration Word' , values: [{name: 'config_word'}, {name: 'config_desc', className: 'normal'}]});
        append_item( ctnr, {title: 'Program Memory'     , values: [{name: 'prog_mem'   }], className: 'bank'});
        append_item( ctnr, {title: 'Data Memory'        , values: [{name: 'data_mem'   }], className: 'bank'});
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
        update     : update      ,
        setMetadata: set_metadata
    };
})();
