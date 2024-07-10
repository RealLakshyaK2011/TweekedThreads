#ifndef __ThreadManager__
#define __ThreadManager__

#include <stdint.h>

enum ThreadState
{
    Born, CanRun, Running, Yielding
};

struct ARMRegisterSave
{
    //General purpose registers
    uint32_t R01;
    uint32_t R02;
    uint32_t R03;
    uint32_t R04;
    uint32_t R05;
    uint32_t R06;
    uint32_t R07;
    uint32_t R08;
    uint32_t R09;
    uint32_t R10;
    uint32_t R11;
    uint32_t R12;

    //Pointer registers
    uint32_t SP;
    uint32_t LR;
};

struct Thread{
    uint16_t threadId;
    enum ThreadState threadState;
    uint16_t threadPriority;
    struct ARMRegisterSave registerSave;
};

#endif