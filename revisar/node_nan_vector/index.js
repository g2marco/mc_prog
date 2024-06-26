/**
 *  uso de la clase nativa Vector
 */
 
const m = require( './');

const vec1 = new m.Vector( 20, 10, 0);
console.log( vec1);

const vec2 = new m.Vector( 0, 0, 0);
vec2.x = 30;
vec2.z = 100;
console.log( vec2);

const vecSum = vec1.add( vec2);
console.log( vecSum);
