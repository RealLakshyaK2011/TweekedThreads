#ifndef __FunctionDefinitions__
#define __FunctionDefinitions__

#include "ThreadManager.h"

//Function types
typedef void* (printStdout)(char* str, ...) ;

typedef void* (entrypoint)(void);

typedef void* (coreStartFunction)(entrypoint ep);


#endif