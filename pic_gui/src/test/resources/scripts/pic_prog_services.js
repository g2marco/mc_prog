
"use strict";

const component = (function() {
    const env = {};
    
    const resource_buffer = '/_data_/get/buffer/{pic}?action={action}';
    const resource_device = '/_data_/manage/device/{pic}?action={action}';
    const resource_ticket = '/_data_/get/ticket/{ticket}';
    
    function set_params( server, device, action) {
        env.server = server;
        env.device = device;
        env.action = action;
    }
    
    function invoke_service() {
        console.log( "invoking device action: " + env.action);
        
        let action = env.action.split( '_')[0];
        let resource = action === 'write'? resource_buffer      : resource_device;
        let callback = action === 'write'? buffer_done_callback : device_callback;
        
        resource = resource.replace( '{pic}', env.device).replace( '{action}', env.action);
        
        popup.init();
        
        fetch( env.server + resource, requestOptions( env.action)).then( rsp => rsp.json()).then( callback).
        catch( function( error) {
            popup.stop( {codigo: 600, clave: 'error.desconocido', mensajes: [ {mensaje: "local server not avalilable or misconfigured: [" + error + "]"}]});
        });
    }
    
    function requestOptions( action) {
        return {
            method: 'POST',
            body  : action.split( '_')[0] === 'write'? new FormData( hex_file_form) : undefined
        };
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
            console.info( error);
        });
    }
    
    function buffer_done_callback( rsp) {
        if ( rsp.codigo !== 200) {
            popup.stop( rsp);
            return;
        }
        
        card.update( rsp.item);

        /*
        let resource = resource_device.replace( '{pic}', env.device).replace( '{action}', env.action);
        
        popup.init();
        
        fetch( env.server + resource, requestOptions( env.action)).then( rsp => rsp.json()).then( device_callback).
        catch( function( error) {
            popup.stop( {codigo: 600, clave: 'error.desconocido', mensajes: [ {mensaje: "local server not avalilable or misconfigured"}]});
        });
        */
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
            
            card.update( rsp.item);
        }
    }
    
    return {
        setParams: set_params,
        invoke   : invoke_service        
    };
    
})();

