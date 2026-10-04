#include "StrategyLevel.mqh"
#include "StrategySetup.mqh"

class CFailedBreakoutDetector
{
public:
    bool Evaluate(const MqlRates &completedBar, const SStrategyLevel &levels[],
                  SStrategySetup &setup, bool &hasConflictingSignals)
    {
        ResetResult(setup, hasConflictingSignals);
        FindLevelFailures(completedBar, levels, setup, hasConflictingSignals);
        return setup.isActive && !hasConflictingSignals;
    }

private:
    void ResetResult(SStrategySetup &setup, bool &hasConflictingSignals)
    {
        setup.isActive = false;
        setup.direction = STRATEGY_DIRECTION_NONE;
        setup.setupId = "";
        setup.levelName = "";
        setup.levelPrice = 0.0;
        setup.failedBreakExtreme = 0.0;
        setup.failedBreakBarTime = 0;
        setup.completedBarsAfterFailure = 0;
        hasConflictingSignals = false;
    }

    void FindLevelFailures(const MqlRates &completedBar, const SStrategyLevel &levels[],
                           SStrategySetup &setup, bool &hasConflictingSignals)
    {
        for (int levelIndex = 0; levelIndex < ArraySize(levels); levelIndex++)
        {
            if (hasConflictingSignals)
            {
                return;
            }
            const EStrategyDirection failedBreakDirection = DetectFailure(completedBar, levels[levelIndex]);
            if (failedBreakDirection != STRATEGY_DIRECTION_NONE)
            {
                SaveFailure(completedBar, levels[levelIndex], failedBreakDirection,
                            setup, hasConflictingSignals);
            }
        }
    }

    EStrategyDirection DetectFailure(const MqlRates &bar, const SStrategyLevel &level)
    {
        if (IsLongFailedBreak(bar, level))
        {
            return STRATEGY_DIRECTION_LONG;
        }
        if (IsShortFailedBreak(bar, level))
        {
            return STRATEGY_DIRECTION_SHORT;
        }
        return STRATEGY_DIRECTION_NONE;
    }

    bool IsLongFailedBreak(const MqlRates &bar, const SStrategyLevel &level)
    {
        return level.supportsLong && bar.low < level.price && bar.close > level.price;
    }

    bool IsShortFailedBreak(const MqlRates &bar, const SStrategyLevel &level)
    {
        return level.supportsShort && bar.high > level.price && bar.close < level.price;
    }

    void SaveFailure(const MqlRates &bar, const SStrategyLevel &level,
                     const EStrategyDirection direction, SStrategySetup &setup,
                     bool &hasConflictingSignals)
    {
        if (setup.isActive && setup.direction != direction)
        {
            hasConflictingSignals = true;
            setup.isActive = false;
            return;
        }
        if (setup.isActive)
        {
            return;
        }

        setup.isActive = true;
        setup.direction = direction;
        setup.setupId = level.name + "_" + IntegerToString((int)bar.time);
        setup.levelName = level.name;
        setup.levelPrice = level.price;
        setup.failedBreakExtreme = direction == STRATEGY_DIRECTION_LONG ? bar.low : bar.high;
        setup.failedBreakBarTime = bar.time;
        setup.completedBarsAfterFailure = 0;
    }
};
