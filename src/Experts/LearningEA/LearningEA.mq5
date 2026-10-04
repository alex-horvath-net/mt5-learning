#include "..\..\Include\LearningEA\LearningEAController.mqh"

CLearningEA learningEA;

input bool EnableDemoTrading = false;
input bool EmergencySafetyShutdown = false;
input double RiskPercentPerTrade = 0.0;
input double MaximumDailyLossPercent = 0.0;
input int MaximumTradesPerDay = 0;
input int MaximumSpreadPoints = 0;
input ulong StrategyMagicNumber = 90530001;

int OnInit()
{
    learningEA.Initialize(EnableDemoTrading, EmergencySafetyShutdown,
                          RiskPercentPerTrade, MaximumDailyLossPercent,
                          MaximumTradesPerDay, MaximumSpreadPoints,
                          StrategyMagicNumber);
    if (!EventSetTimer(1))
    {
        PrintFormat("STRATEGY event=TIMER_SETUP_FAILED error=%d", GetLastError());
    }
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
