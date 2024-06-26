#include <nan.h>

class PicProgrammer : public Nan::ObjectWrap {
public:
    double x;
    double y;
    double z;
    
    static NAN_MODULE_INIT( Init);
    static NAN_METHOD( New);
    static NAN_METHOD( Add);
    static NAN_METHOD( Hello);
    
    static NAN_GETTER( HandleGetters);
    static NAN_SETTER( HandleSetters);
    
    static Nan::Persistent<v8::FunctionTemplate> constructor;
};
