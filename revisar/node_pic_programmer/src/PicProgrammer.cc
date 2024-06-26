#include "PicProgrammer.h"

#include "05_common.h"
#include <ctype.h>

Nan::Persistent<v8::FunctionTemplate> PicProgrammer::constructor;

NAN_MODULE_INIT( PicProgrammer::Init) {
    v8::Local<v8::FunctionTemplate> ctor = Nan::New<v8::FunctionTemplate>( PicProgrammer::New);
    constructor.Reset( ctor);
    
    ctor->InstanceTemplate()->SetInternalFieldCount( 1);
    ctor->SetClassName( Nan::New( "PicProgrammer").ToLocalChecked());
    
    // link getters, setters to object property
    
    Nan::SetAccessor( ctor->InstanceTemplate(), Nan::New( "x").ToLocalChecked(), PicProgrammer::HandleGetters, PicProgrammer::HandleSetters);
    Nan::SetAccessor( ctor->InstanceTemplate(), Nan::New( "y").ToLocalChecked(), PicProgrammer::HandleGetters, PicProgrammer::HandleSetters);
    Nan::SetAccessor( ctor->InstanceTemplate(), Nan::New( "z").ToLocalChecked(), PicProgrammer::HandleGetters, PicProgrammer::HandleSetters);
    
    // link methods
    Nan::SetPrototypeMethod( ctor, "add", Add);
    Nan::SetPrototypeMethod( ctor, "hello", Hello);
    
    target->Set( Nan::New( "PicProgrammer").ToLocalChecked(), ctor->GetFunction());
}

NAN_METHOD( PicProgrammer::New) {
    // arroja error si el constructor es llamado sin 'new'
    if( !info.IsConstructCall()) {
        return Nan::ThrowError( Nan::New( "PicProgrammer::New - invocado sin la palabra reservada 'new'").ToLocalChecked());
    }
    
    if( info.Length() != 3) {
        return Nan::ThrowError( Nan::New( "PicProgrammer::New - expected arguments x, y, z").ToLocalChecked());
    }
   
    if( !info[0]->IsNumber() || !info[1]->IsNumber() || !info[2]->IsNumber()) {
        return Nan::ThrowError( Nan::New( "PicProgrammer::New - los argumentos deben ser númericos").ToLocalChecked());
    }
    
    // crea la nueva instancia
    PicProgrammer* vec = new PicProgrammer();
    vec->Wrap( info.Holder());
    
    // inicializa sus valores
    vec->x = info[0]->NumberValue();
    vec->y = info[1]->NumberValue();
    vec->z = info[2]->NumberValue();
    
    // regresa la instancia
    info.GetReturnValue().Set( info.Holder());
}

NAN_METHOD( PicProgrammer::Add) {
    PicProgrammer* self = Nan::ObjectWrap::Unwrap<PicProgrammer>( info.This());

    if( !Nan::New( PicProgrammer::constructor)->HasInstance( info[0])) {
        return Nan::ThrowError( Nan::New( "PicProgrammer::Add - el argumento deber ser una instancia de PicProgrammer").ToLocalChecked());
    }
    
    PicProgrammer* otherVec = Nan::ObjectWrap::Unwrap<PicProgrammer>( info[0]->ToObject());

    const int argc = 3;
    v8::Local<v8::Value> argv[argc] = {
        Nan::New( self->x + otherVec->x),
        Nan::New( self->y + otherVec->y),
        Nan::New( self->z + otherVec->z)
    };

    //  handler local a la función constructor
    v8::Local<v8::Function> constructorFunc = Nan::New( PicProgrammer::constructor)->GetFunction();
    
    v8::Local<v8::Object> jsSumVec = Nan::NewInstance( constructorFunc, argc, argv).ToLocalChecked();
   
    info.GetReturnValue().Set( jsSumVec);
}


NAN_METHOD( PicProgrammer::Hello) {
    auto message = Nan::New("Hello from C++!").ToLocalChecked();


    // ---------------------------------------------------- //

    	if ( mkfifo( CLIENT_FIFO_NAME, 0777) == -1) {
    		fprintf( stderr, "Sorry, can't make %s\n", CLIENT_FIFO_NAME);
    		info.GetReturnValue().Set(message);
    		return;
    	}

    	struct data_to_pass_st my_data;
    	my_data.client_pid = getpid();

    	int client_fifo_fd, server_fifo_fd;
    	int times_to_send;

    	printf( "\n\tclient: init");

    	for (times_to_send = 0; times_to_send < 5; times_to_send++) {

           // prepara informacion para enviar
           sprintf( my_data.some_data, "Hello from %d", my_data.client_pid);


           // espera servidor listo
           server_fifo_fd = open( SERVER_FIFO_NAME, O_WRONLY);
           if ( server_fifo_fd == -1) {
               fprintf(stderr, "\n\tLa FIFO del servidor no esta disponible.\n");

               info.GetReturnValue().Set(message);
               return;
           }

           write(server_fifo_fd, &my_data, sizeof(my_data));
           close(server_fifo_fd);

           printf( "\n\tclient %d sent '%s'", my_data.client_pid, my_data.some_data);
           printf( "\n\tclient waiting response");

           // espera respuesta del servidor
           client_fifo_fd = open( CLIENT_FIFO_NAME, O_RDONLY);
           if ( client_fifo_fd == -1) {
               fprintf(stderr, "\n\tLa FIFO de cliente no esta disponible.\n");

               info.GetReturnValue().Set(message);
               return;
           }

           if ( read( client_fifo_fd, &my_data, sizeof(my_data)) > 0) {
               printf( "\n\tcliente: info recibida: '%s'\n", my_data.some_data);
           } else {
               printf( "\n\tcliente: bytes recibidos = 0");
               break;
           }
           close(client_fifo_fd);
       }

       unlink( CLIENT_FIFO_NAME);



    // ---------------------------------------------------- //

    info.GetReturnValue().Set(message);
}


NAN_GETTER( PicProgrammer::HandleGetters) {
    PicProgrammer* self = Nan::ObjectWrap::Unwrap<PicProgrammer>( info.This());
    
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

NAN_SETTER( PicProgrammer::HandleSetters) {
    PicProgrammer* self = Nan::ObjectWrap::Unwrap<PicProgrammer>( info.This());
    
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
