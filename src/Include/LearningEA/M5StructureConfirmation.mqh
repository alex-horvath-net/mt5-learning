#include "StrategySetup.mqh"

class CM5StructureConfirmation
{
public:
    bool Evaluate(const SStrategySetup &setup, const MqlRates &completedBars[],
                  double &confirmedSwingPrice, datetime &confirmedSwingTime)
    {
        confirmedSwingPrice = 0.0;
        confirmedSwingTime = 0;
        return FindBrokenPostFailureSwing(setup, completedBars, confirmedSwingPrice, confirmedSwingTime);
    }

private:
    bool FindBrokenPostFailureSwing(const SStrategySetup &setup, const MqlRates &completedBars[],
                                    double &confirmedSwingPrice, datetime &confirmedSwingTime)
    {
        const int completedBarCount = ArraySize(completedBars);
        for (int swingIndex = 2; swingIndex < completedBarCount - 2; swingIndex++)
        {
            if (completedBars[swingIndex].time <= setup.failedBreakBarTime)
            {
                continue;
            }
            if (IsBrokenConfirmedSwing(setup.direction, completedBars, swingIndex))
            {
                confirmedSwingPrice = GetSwingPrice(setup.direction, completedBars[swingIndex]);
                confirmedSwingTime = completedBars[swingIndex].time;
                return true;
            }
        }
        return false;
    }

    bool IsBrokenConfirmedSwing(const EStrategyDirection direction, const MqlRates &bars[],
                                const int swingIndex)
    {
        if (direction == STRATEGY_DIRECTION_LONG)
        {
            return IsConfirmedSwingHigh(bars, swingIndex) && bars[0].close > bars[swingIndex].high;
        }
        return IsConfirmedSwingLow(bars, swingIndex) && bars[0].close < bars[swingIndex].low;
    }

    bool IsConfirmedSwingHigh(const MqlRates &bars[], const int swingIndex)
    {
        for (int distance = 1; distance <= 2; distance++)
        {
            if (bars[swingIndex].high <= bars[swingIndex - distance].high ||
                bars[swingIndex].high <= bars[swingIndex + distance].high)
            {
                return false;
            }
        }
        return true;
    }

    bool IsConfirmedSwingLow(const MqlRates &bars[], const int swingIndex)
    {
        for (int distance = 1; distance <= 2; distance++)
        {
            if (bars[swingIndex].low >= bars[swingIndex - distance].low ||
                bars[swingIndex].low >= bars[swingIndex + distance].low)
            {
                return false;
            }
        }
        return true;
    }

    double GetSwingPrice(const EStrategyDirection direction, const MqlRates &swingBar)
    {
        return direction == STRATEGY_DIRECTION_LONG ? swingBar.high : swingBar.low;
    }
};
