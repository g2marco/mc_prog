var pic_programmer;

if ( process.env.DEBUG) {
    pic_programmer = require( './build/Debug/pic_programmer.node');
} else {
    pic_programmer = require( './build/Release/pic_programmer.node');
}

module.exports = pic_programmer;