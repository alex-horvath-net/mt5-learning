#include "StrategyDirection.mqh"

struct SStrategyTradePlan
{
    bool isValid;
    EStrategyDirection direction;
    string setupId;
    string targetLevelName;
    double entryPrice;
    double stopLossPrice;
    double takeProfitPrice;
    double riskDistance;
    double rewardDistance;
};
