#include <nan.h>
#include "PicProgrammer.h"

NAN_MODULE_INIT( InitModule) {
    PicProgrammer::Init( target);
}

NODE_MODULE( pic_programmer, InitModule);
