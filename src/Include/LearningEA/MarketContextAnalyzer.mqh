#include "HigherTimeframeMarketContext.mqh"
#include "MarketContextSnapshot.mqh"
#include "StrategyDirection.mqh"

class CMarketContextAnalyzer
{
private:
    CHigherTimeframeMarketContext marketContext;

public:
    void Analyze(const string symbol, SMarketContextSnapshot &snapshot)
    {
        SetTimeframeStructures(symbol, snapshot);
        SetContextReadiness(snapshot);
    }

    bool AllowsDirection(const EStrategyDirection direction, const SMarketContextSnapshot &snapshot)
    {
        return HasReadyContext(snapshot) && !IsAgainstAlignedTrend(direction, snapshot) &&
               !HasMixedContext(snapshot);
    }

private:
    void SetTimeframeStructures(const string symbol, SMarketContextSnapshot &snapshot)
    {
        snapshot.h1Structure = marketContext.GetPriceStructure(symbol, PERIOD_H1);
        snapshot.h4Structure = marketContext.GetPriceStructure(symbol, PERIOD_H4);
        snapshot.alignment = marketContext.GetH1H4Alignment(snapshot.h1Structure, snapshot.h4Structure);
    }

    void SetContextReadiness(SMarketContextSnapshot &snapshot)
    {
        snapshot.isReady = !IsInsufficientStructure(snapshot.h1Structure) &&
                           !IsInsufficientStructure(snapshot.h4Structure);
    }

    bool HasReadyContext(const SMarketContextSnapshot &snapshot)
    {
        return snapshot.isReady;
    }

    bool IsAgainstAlignedTrend(const EStrategyDirection direction, const SMarketContextSnapshot &snapshot)
    {
        return (direction == STRATEGY_DIRECTION_LONG && snapshot.alignment == "ALIGNED_DOWN") ||
               (direction == STRATEGY_DIRECTION_SHORT && snapshot.alignment == "ALIGNED_UP");
    }

    bool HasMixedContext(const SMarketContextSnapshot &snapshot)
    {
        return snapshot.alignment == "MIXED";
    }

    bool IsInsufficientStructure(const string structure)
    {
        return structure == "INSUFFICIENT_DATA" || structure == "INSUFFICIENT_SWINGS";
    }
};
