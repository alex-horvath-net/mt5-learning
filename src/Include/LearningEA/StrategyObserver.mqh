#include "MarketContextSnapshot.mqh"
#include "StrategySetup.mqh"
#include "StrategyTradePlan.mqh"

class CStrategyObserver
{
public:
    void RecordEvent(const string eventName, const string symbol, const datetime barTime,
                     const SMarketContextSnapshot &context, const string state,
                     const string reason, const SStrategySetup &setup,
                     const SStrategyTradePlan &plan)
    {
        PrintFormat("STRATEGY event=%s symbol=%s bar=%s H1=%s H4=%s alignment=%s state=%s reason=%s setup=%s entry=%g stop=%g target=%g",
                    eventName, symbol, TimeToString(barTime, TIME_DATE | TIME_MINUTES),
                    context.h1Structure, context.h4Structure, context.alignment,
                    state, reason, setup.setupId, plan.entryPrice,
                    plan.stopLossPrice, plan.takeProfitPrice);
    }
};
