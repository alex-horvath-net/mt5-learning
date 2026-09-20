#include <LearningEA/Strategy.mqh>
#include <LearningEA/RiskManagement.mqh>

bool firstTickLogged = false;

int OnInit()
{
    firstTickLogged = false;
    Print("LearningEA started");
    return INIT_SUCCEEDED;
}

void OnTick()
{
    if (!firstTickLogged)
    {
        Print("LearningEA received first tick");
        firstTickLogged = true;
    }
}
