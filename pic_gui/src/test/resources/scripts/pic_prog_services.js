
"use strict";

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

