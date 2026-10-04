#include "StrategyLevel.mqh"

class CReferenceLevelCalculator
{
public:
    bool Calculate(const string symbol, SStrategyLevel &levels[])
    {
        ArrayResize(levels, 0);
        return AppendPeriodLevels(symbol, PERIOD_D1, "Previous day", levels) &&
               AppendPeriodLevels(symbol, PERIOD_W1, "Previous week", levels);
    }

private:
    bool AppendPeriodLevels(const string symbol, const ENUM_TIMEFRAMES timeframe,
                            const string levelGroupName, SStrategyLevel &levels[])
    {
        MqlRates previousPeriod[1];
        if (CopyRates(symbol, timeframe, 1, 1, previousPeriod) != 1)
        {
            return false;
        }

        AppendLevel(levels, levelGroupName + " low", previousPeriod[0].low, true, false);
        AppendLevel(levels, levelGroupName + " high", previousPeriod[0].high, false, true);
        return true;
    }

    void AppendLevel(SStrategyLevel &levels[], const string name, const double price,
                     const bool supportsLong, const bool supportsShort)
    {
        const int levelCount = ArraySize(levels);
        ArrayResize(levels, levelCount + 1);
        levels[levelCount].name = name;
        levels[levelCount].price = price;
        levels[levelCount].supportsLong = supportsLong;
        levels[levelCount].supportsShort = supportsShort;
    }
};
