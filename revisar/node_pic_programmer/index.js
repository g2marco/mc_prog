/**
 *  uso de la clase nativa PicProgrammer
 */
 
const modulo = require( './');

const programmer = new modulo.PicProgrammer();
console.log( programmer);


const vec2 = new modulo.PicProgrammer( 0, 0, 0);
vec2.x = 30;
vec2.z = 100;
console.log( vec2);

const vecSum = vec1.add( vec2);
console.log( vecSum);

console.log( vec1.hello());
