#include "RecentConfirmedSwingPoints.mqh"
#include "ConfirmedSwingBar.mqh"

class CHigherTimeframeMarketContext
{
public:
    string GetPriceStructure(const string symbol, const ENUM_TIMEFRAMES timeframe)
    {
        return ClassifyPriceStructure(GetConfirmedSwingPoints(symbol, timeframe));
    }

    string GetPriceStructure(const SRecentConfirmedSwingPoints &swingPoints)
    {
        return ClassifyPriceStructure(swingPoints);
    }

    string GetH1H4Alignment(const string h1PriceStructure, const string h4PriceStructure)
    {
        return DetermineH1H4Alignment(h1PriceStructure, h4PriceStructure);
    }

    SRecentConfirmedSwingPoints GetConfirmedSwingPoints(const string symbol, const ENUM_TIMEFRAMES timeframe)
    {
        return LoadRecentConfirmedSwingPoints(symbol, timeframe);
    }

    int GetLastFourWeeksSwingHistory(const string symbol, const ENUM_TIMEFRAMES timeframe,
                                     SConfirmedSwingBar &swingHistory[])
    {
        MqlRates completedBars[];
        const int completedBarCount = LoadBarsFromLastFourWeeks(symbol, timeframe, completedBars);
        return CollectConfirmedSwingHistory(completedBars, completedBarCount, swingHistory);
    }

private:
    int LoadBarsFromLastFourWeeks(const string symbol, const ENUM_TIMEFRAMES timeframe,
                                  MqlRates &completedBars[])
    {
        ArraySetAsSeries(completedBars, true);
        return CopyRates(symbol, timeframe, GetFourWeekStartTime(), TimeCurrent(), completedBars);
    }

    datetime GetFourWeekStartTime()
    {
        MqlDateTime currentWeekStart;
        TimeToStruct(TimeCurrent(), currentWeekStart);
        currentWeekStart.day -= (currentWeekStart.day_of_week + 6) % 7 + 28;
        currentWeekStart.hour = 0;
        currentWeekStart.min = 0;
        currentWeekStart.sec = 0;
        return StructToTime(currentWeekStart);
    }

    int CollectConfirmedSwingHistory(const MqlRates &completedBars[], const int completedBarCount,
                                     SConfirmedSwingBar &swingHistory[])
    {
        ArrayResize(swingHistory, 0);
        const int completedBarsRequiredOnEachSide = 2;

        for (int barIndex = completedBarCount - completedBarsRequiredOnEachSide - 1;
             barIndex >= completedBarsRequiredOnEachSide + 1;
             barIndex--)
        {
            const bool hasConfirmedSwingHigh = IsConfirmedSwingHigh(completedBars, barIndex,
                                                                    completedBarsRequiredOnEachSide);
            const bool hasConfirmedSwingLow = IsConfirmedSwingLow(completedBars, barIndex,
                                                                  completedBarsRequiredOnEachSide);
            if (hasConfirmedSwingHigh || hasConfirmedSwingLow)
            {
                AppendConfirmedSwingBar(swingHistory, completedBars[barIndex],
                                        hasConfirmedSwingHigh, hasConfirmedSwingLow);
            }
        }

        return ArraySize(swingHistory);
    }

    void AppendConfirmedSwingBar(SConfirmedSwingBar &swingHistory[], const MqlRates &bar,
                                 const bool hasConfirmedSwingHigh, const bool hasConfirmedSwingLow)
    {
        const int newSwingIndex = ArraySize(swingHistory);
        ArrayResize(swingHistory, newSwingIndex + 1);
        swingHistory[newSwingIndex].time = bar.time;
        swingHistory[newSwingIndex].swingHighPrice = bar.high;
        swingHistory[newSwingIndex].swingLowPrice = bar.low;
        swingHistory[newSwingIndex].hasSwingHigh = hasConfirmedSwingHigh;
        swingHistory[newSwingIndex].hasSwingLow = hasConfirmedSwingLow;
    }

    string ClassifyPriceStructure(const SRecentConfirmedSwingPoints &swingPoints)
    {
        const int minimumBarsRequired = 20;
        if (swingPoints.completedBarsLoaded < minimumBarsRequired)
        {
            return "INSUFFICIENT_DATA";
        }
        if (!HasEnoughConfirmedSwingPoints(swingPoints))
        {
            return "INSUFFICIENT_SWINGS";
        }

        return ClassifySwingPointSequence(swingPoints);
    }

    SRecentConfirmedSwingPoints LoadRecentConfirmedSwingPoints(const string symbol,
                                                                 const ENUM_TIMEFRAMES timeframe)
    {
        MqlRates completedBars[];
        const int completedBarCount = LoadCompletedBars(symbol, timeframe, completedBars);
        SRecentConfirmedSwingPoints noSwingPoints = {completedBarCount, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0};
        if (!HasEnoughCompletedBars(completedBarCount))
        {
            return noSwingPoints;
        }
        SRecentConfirmedSwingPoints swingPoints = FindRecentConfirmedSwingPoints(completedBars, completedBarCount);
        swingPoints.completedBarsLoaded = completedBarCount;
        return swingPoints;
    }

    string DetermineH1H4Alignment(const string h1PriceStructure, const string h4PriceStructure)
    {
        if (AreBothTimeframesRising(h1PriceStructure, h4PriceStructure))
        {
            return "ALIGNED_UP";
        }
        if (AreBothTimeframesFalling(h1PriceStructure, h4PriceStructure))
        {
            return "ALIGNED_DOWN";
        }
        if (HasInsufficientPriceStructure(h1PriceStructure) || HasInsufficientPriceStructure(h4PriceStructure))
        {
            return "INSUFFICIENT_DATA";
        }
        return "MIXED";
    }

    int LoadCompletedBars(const string symbol, const ENUM_TIMEFRAMES timeframe, MqlRates &completedBars[])
    {
        ArraySetAsSeries(completedBars, true);
        const int maximumBarsToInspect = 100;
        return CopyRates(symbol, timeframe, 1, maximumBarsToInspect, completedBars);
    }

    bool HasEnoughCompletedBars(const int completedBarCount)
    {
        const int minimumBarsRequired = 20;
        return completedBarCount >= minimumBarsRequired;
    }

    bool HasEnoughConfirmedSwingPoints(const SRecentConfirmedSwingPoints &swingPoints)
    {
        const int minimumConfirmedSwingPointsRequired = 2;
        return swingPoints.confirmedSwingHighCount >= minimumConfirmedSwingPointsRequired &&
               swingPoints.confirmedSwingLowCount >= minimumConfirmedSwingPointsRequired;
    }

    string ClassifySwingPointSequence(const SRecentConfirmedSwingPoints &swingPoints)
    {
        if (AreLatestSwingPointsHigher(swingPoints))
        {
            return "RISING";
        }
        if (AreLatestSwingPointsLower(swingPoints))
        {
            return "FALLING";
        }
        return "MIXED";
    }

    bool AreLatestSwingPointsHigher(const SRecentConfirmedSwingPoints &swingPoints)
    {
        return swingPoints.latestSwingHighPrice > swingPoints.previousSwingHighPrice &&
               swingPoints.latestSwingLowPrice > swingPoints.previousSwingLowPrice;
    }

    bool AreLatestSwingPointsLower(const SRecentConfirmedSwingPoints &swingPoints)
    {
        return swingPoints.latestSwingHighPrice < swingPoints.previousSwingHighPrice &&
               swingPoints.latestSwingLowPrice < swingPoints.previousSwingLowPrice;
    }

    bool AreBothTimeframesRising(const string h1PriceStructure, const string h4PriceStructure)
    {
        return h1PriceStructure == "RISING" && h4PriceStructure == "RISING";
    }

    bool AreBothTimeframesFalling(const string h1PriceStructure, const string h4PriceStructure)
    {
        return h1PriceStructure == "FALLING" && h4PriceStructure == "FALLING";
    }

    SRecentConfirmedSwingPoints FindRecentConfirmedSwingPoints(const MqlRates &completedBars[],
                                                                const int completedBarCount)
    {
        SRecentConfirmedSwingPoints swingPoints = {completedBarCount, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0};
        const int completedBarsRequiredOnEachSide = 2;

        for (int barIndex = completedBarsRequiredOnEachSide;
             barIndex <= completedBarCount - completedBarsRequiredOnEachSide - 1 &&
             !HasEnoughConfirmedSwingPoints(swingPoints);
             barIndex++)
        {
            if (IsConfirmedSwingHigh(completedBars, barIndex, completedBarsRequiredOnEachSide))
            {
                SaveConfirmedSwingHigh(swingPoints, completedBars[barIndex]);
            }
            if (IsConfirmedSwingLow(completedBars, barIndex, completedBarsRequiredOnEachSide))
            {
                SaveConfirmedSwingLow(swingPoints, completedBars[barIndex]);
            }
        }

        return swingPoints;
    }

    bool IsConfirmedSwingHigh(const MqlRates &completedBars[], const int barIndex,
                              const int completedBarsRequiredOnEachSide)
    {
        for (int neighbourDistance = 1; neighbourDistance <= completedBarsRequiredOnEachSide; neighbourDistance++)
        {
            if (completedBars[barIndex].high <= completedBars[barIndex - neighbourDistance].high ||
                completedBars[barIndex].high <= completedBars[barIndex + neighbourDistance].high)
            {
                return false;
            }
        }
        return true;
    }

    bool IsConfirmedSwingLow(const MqlRates &completedBars[], const int barIndex,
                             const int completedBarsRequiredOnEachSide)
    {
        for (int neighbourDistance = 1; neighbourDistance <= completedBarsRequiredOnEachSide; neighbourDistance++)
        {
            if (completedBars[barIndex].low >= completedBars[barIndex - neighbourDistance].low ||
                completedBars[barIndex].low >= completedBars[barIndex + neighbourDistance].low)
            {
                return false;
            }
        }
        return true;
    }

    void SaveConfirmedSwingHigh(SRecentConfirmedSwingPoints &swingPoints, const MqlRates &swingHighBar)
    {
        if (swingPoints.confirmedSwingHighCount == 0)
        {
            swingPoints.latestSwingHighPrice = swingHighBar.high;
            swingPoints.latestSwingHighTime = swingHighBar.time;
        }
        else if (swingPoints.confirmedSwingHighCount == 1)
        {
            swingPoints.previousSwingHighPrice = swingHighBar.high;
            swingPoints.previousSwingHighTime = swingHighBar.time;
        }
        swingPoints.confirmedSwingHighCount++;
    }

    void SaveConfirmedSwingLow(SRecentConfirmedSwingPoints &swingPoints, const MqlRates &swingLowBar)
    {
        if (swingPoints.confirmedSwingLowCount == 0)
        {
            swingPoints.latestSwingLowPrice = swingLowBar.low;
            swingPoints.latestSwingLowTime = swingLowBar.time;
        }
        else if (swingPoints.confirmedSwingLowCount == 1)
        {
            swingPoints.previousSwingLowPrice = swingLowBar.low;
            swingPoints.previousSwingLowTime = swingLowBar.time;
        }
        swingPoints.confirmedSwingLowCount++;
    }

    bool HasInsufficientPriceStructure(const string priceStructure)
    {
        return priceStructure == "INSUFFICIENT_DATA" || priceStructure == "INSUFFICIENT_SWINGS";
    }
};
