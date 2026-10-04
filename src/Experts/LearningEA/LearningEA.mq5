#include "..\..\Include\LearningEA\LearningEAController.mqh"

CLearningEA learningEA;

int OnInit()
{
    learningEA.Initialize();
    EventSetTimer(1);
    return INIT_SUCCEEDED;
}

void OnTick()
{
    learningEA.ProcessIncomingTick();
}

void OnTimer()
{
    learningEA.ProcessTimerEvent();
}

void OnDeinit(const int reason)
{
    EventKillTimer();
    learningEA.Shutdown();
}
