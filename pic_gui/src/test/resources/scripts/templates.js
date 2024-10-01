/* global Handlebars */

"use strict";

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
