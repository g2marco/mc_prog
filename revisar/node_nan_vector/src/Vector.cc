#include "Vector.h"

Nan::Persistent<v8::FunctionTemplate> Vector::constructor;

NAN_MODULE_INIT( Vector::Init) {
    v8::Local<v8::FunctionTemplate> ctor = Nan::New<v8::FunctionTemplate>( Vector::New);
    constructor.Reset( ctor);
    
    ctor->InstanceTemplate()->SetInternalFieldCount( 1);
    ctor->SetClassName( Nan::New( "Vector").ToLocalChecked());
    
    // link getters, setters to object property
    
    Nan::SetAccessor( ctor->InstanceTemplate(), Nan::New( "x").ToLocalChecked(), Vector::HandleGetters, Vector::HandleSetters);
    Nan::SetAccessor( ctor->InstanceTemplate(), Nan::New( "y").ToLocalChecked(), Vector::HandleGetters, Vector::HandleSetters);
    Nan::SetAccessor( ctor->InstanceTemplate(), Nan::New( "z").ToLocalChecked(), Vector::HandleGetters, Vector::HandleSetters);
    
    // link add method
    Nan::SetPrototypeMethod( ctor, "add", Add);
    
    target->Set( Nan::New( "Vector").ToLocalChecked(), ctor->GetFunction());
}

NAN_METHOD( Vector::New) {
    // arroja error si el constructor es llamado sin 'new'
    if( !info.IsConstructCall()) {
        return Nan::ThrowError( Nan::New( "Vector::New - invocado sin la palabra reservada 'new'").ToLocalChecked());
    }
    
    if( info.Length() != 3) {
        return Nan::ThrowError( Nan::New( "Vector::New - expected arguments x, y, z").ToLocalChecked());
    }
   
    if( !info[0]->IsNumber() || !info[1]->IsNumber() || !info[2]->IsNumber()) {
        return Nan::ThrowError( Nan::New( "Vector::New - los argumentos deben ser númericos").ToLocalChecked());
    }
    
    // crea la nueva instancia
    Vector* vec = new Vector();
    vec->Wrap( info.Holder());
    
    // inicializa sus valores
    vec->x = info[0]->NumberValue();
    vec->y = info[1]->NumberValue();
    vec->z = info[2]->NumberValue();
    
    // regresa la instancia
    info.GetReturnValue().Set( info.Holder());
}


NAN_METHOD( Vector::Add) {
    Vector* self = Nan::ObjectWrap::Unwrap<Vector>( info.This());

    if( !Nan::New( Vector::constructor)->HasInstance( info[0])) {
        return Nan::ThrowError( Nan::New( "Vector::Add - el argumento deber ser una instancia de Vector").ToLocalChecked());
    }
    
    Vector* otherVec = Nan::ObjectWrap::Unwrap<Vector>( info[0]->ToObject());

    const int argc = 3;
    v8::Local<v8::Value> argv[argc] = {
        Nan::New( self->x + otherVec->x),
        Nan::New( self->y + otherVec->y),
        Nan::New( self->z + otherVec->z)
    };

    //  handler local a la función constructor
    v8::Local<v8::Function> constructorFunc = Nan::New( Vector::constructor)->GetFunction();
    
    v8::Local<v8::Object> jsSumVec = Nan::NewInstance( constructorFunc, argc, argv).ToLocalChecked();
   
    info.GetReturnValue().Set( jsSumVec);
}


NAN_GETTER( Vector::HandleGetters) {
    Vector* self = Nan::ObjectWrap::Unwrap<Vector>( info.This());
    
    std::string propertyName = std::string( *Nan::Utf8String( property));
    
    if( propertyName == "x") {
        info.GetReturnValue().Set( self->x);
    
    } else if( propertyName == "y") {
        info.GetReturnValue().Set( self->y);
        
    } else if( propertyName == "z") {
        info.GetReturnValue().Set( self->z);
        
    } else {
        info.GetReturnValue().Set( Nan::Undefined());
    }
    
}

NAN_SETTER( Vector::HandleSetters) {
    Vector* self = Nan::ObjectWrap::Unwrap<Vector>( info.This());
    
    if( !value->IsNumber()) {
        return Nan::ThrowError( Nan::New( "se espera un número").ToLocalChecked());
    }
    
    std::string propertyName = std::string( *Nan::Utf8String( property));
    
    if( propertyName == "x") {
        self->x = value->NumberValue();
    
    } else if( propertyName == "y") {
        self->y = value->NumberValue();

    } else if( propertyName == "z") {
        self->z = value->NumberValue();
        
    }
}
