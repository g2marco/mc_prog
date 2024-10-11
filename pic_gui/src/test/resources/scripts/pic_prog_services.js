
/* global hex_file_form */

"use strict";

/**
 *   ----------------- --------------------------- ----------------------------------------------
 *  |  action         |  source card              |  target card                                 |
 *  |-----------------|---------------------------|----------------------------------------------|
 *  | read            |                           | request device ( 'read' , null   ) [ticket]  |
 *  | reset           |                           | request device ( 'reset', null   ) [ticket]  |
 *  | read  / verify  | request buffer( hexfile)  | request device ( 'read' , null   ) [ticket]  |
 *  | write / verify  | request buffer( hexfile)  | request device ( 'write', hexfile) [ticket]  |
 *   ----------------- --------------------------- ----------------------------------------------
 */
const component = (function() {
    const env = {};
    
    const resource_buffer = '/_data_/get/buffer/{pic}?action={action}';
    const resource_device = '/_data_/manage/device/{pic}?action={action}';
    const resource_ticket = '/_data_/get/ticket/{ticket}';
    
    function set_params( server, device, action) {
        env.server = server;
        env.device = device;
        env.action = get_action( action);
        env.option = get_option( action);
    }
    
    function invoke_service() {
        console.log( "[service invocation] action: " + env.action + ", option: " + env.option);
        
        popup.init();
        card.clean();
        
        if ( env.option) {
            exec_request( resource_buffer, buffer_done_callback, env.option === 'verify');
        }
        
        let includeHexFile = env.action === 'write';
        
        exec_request( resource_device, device_callback, includeHexFile);
    }
    
    function exec_request( template, callback, includeHexFile) {
        let resource = template.replace( '{pic}', env.device).replace( '{action}', env.action);
        let options  = {
            method: 'POST',
            body  : includeHexFile? new FormData( hex_file_form) : undefined
        };
        
        fetch( env.server + resource, options).then( rsp => rsp.json()).then( callback).
        catch( function( error) {
            popup.stop( {codigo: 600, clave: 'error.desconocido', mensajes: [ {mensaje: "local server not avalilable or misconfigured: [" + error + "]"}]});
        });
    }
    
    function device_callback( rsp) {
        env.ticket  = rsp.ticket;
        env.handler = setInterval( ticket_callback, 3000);
    }
    
    function ticket_callback() {
        console.log( "invoking ticket estatus: " + env.ticket);
        
        let resource = resource_ticket.replace( '{ticket}', env.ticket);
        
        fetch( env.server + resource).then( rsp => rsp.json()).then( ticket_done_callback).
        catch( function( error) {
            popup.stop( {codigo: 600, clave: 'error.desconocido', mensajes: [ {mensaje: "local server not avalilable or misconfigured: [" + error + "]"}]});
        });
    }
    
    function buffer_done_callback( rsp) {
        if ( rsp.codigo !== 200) {
            popup.stop( rsp);
            return;
        }
        
        card.update( 'source', rsp.item);
    }
    
    function ticket_done_callback( rsp) {
        if ( rsp.codigo !== 200) {
            clearTimeout( env.handler);
            popup.stop( rsp);
            
            return;
        }
        
        if ( rsp.item.done) {
            clearTimeout( env.handler);
            popup.stop();
            
            card.update( 'target', rsp.item);
        }
    }
    
    function get_action( txt) {
        return txt.split( '_')[0];
    }
    
    function get_option( txt) {
        let tokens = txt.split( '_');
        return tokens.length > 1? tokens[1] : null;
    }
    
    return {
        setParams: set_params,
        invoke   : invoke_service        
    };
    
})();

