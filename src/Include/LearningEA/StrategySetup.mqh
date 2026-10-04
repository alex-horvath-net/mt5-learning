#include "StrategyDirection.mqh"

struct SStrategySetup
{
    bool isActive;
    EStrategyDirection direction;
    string setupId;
    string levelName;
    double levelPrice;
    double failedBreakExtreme;
    datetime failedBreakBarTime;
    int completedBarsAfterFailure;
};
