#include "FailedBreakoutDetector.mqh"

class CSetupStateMachine
{
private:
    CFailedBreakoutDetector failedBreakoutDetector;
    SStrategySetup activeSetup;

public:
    void Reset()
    {
        ClearActiveSetup();
    }

    bool ProcessCompletedBar(const MqlRates &completedBar, const SStrategyLevel &levels[], string &reason)
    {
        reason = "WAIT_FOR_LEVEL";
        if (activeSetup.isActive && !AdvanceActiveSetup(completedBar, reason))
        {
            return false;
        }
        if (activeSetup.isActive)
        {
            reason = "WAIT_FOR_CONFIRMATION";
            return true;
        }
        return DetectNewSetup(completedBar, levels, reason);
    }

    void GetActiveSetup(SStrategySetup &setup)
    {
        setup = activeSetup;
    }

    void CompleteActiveSetup()
    {
        ClearActiveSetup();
    }

private:
    bool AdvanceActiveSetup(const MqlRates &bar, string &reason)
    {
        if (bar.time <= activeSetup.failedBreakBarTime)
        {
            reason = "WAIT_FOR_CONFIRMATION";
            return true;
        }
        if (HasFailedBreakInvalidated(bar))
        {
            ClearActiveSetup();
            reason = "FAILED_BREAK_INVALIDATED";
            return false;
        }
        activeSetup.completedBarsAfterFailure++;
        if (HasConfirmationWindowExpired())
        {
            ClearActiveSetup();
            reason = "CONFIRMATION_EXPIRED";
            return false;
        }
        return true;
    }

    bool HasFailedBreakInvalidated(const MqlRates &bar)
    {
        if (activeSetup.direction == STRATEGY_DIRECTION_LONG)
        {
            return bar.close < activeSetup.levelPrice;
        }
        return bar.close > activeSetup.levelPrice;
    }

    bool HasConfirmationWindowExpired()
    {
        const int maximumConfirmationBars = 6;
        return activeSetup.completedBarsAfterFailure > maximumConfirmationBars;
    }

    bool DetectNewSetup(const MqlRates &bar, const SStrategyLevel &levels[], string &reason)
    {
        bool hasConflictingSignals = false;
        if (failedBreakoutDetector.Evaluate(bar, levels, activeSetup, hasConflictingSignals))
        {
            reason = "FAILED_BREAK_RECLAIMED";
            return true;
        }
        reason = hasConflictingSignals ? "CONFLICTING_SIGNALS" : "NO_RECLAIM";
        return false;
    }

    void ClearActiveSetup()
    {
        activeSetup.isActive = false;
        activeSetup.direction = STRATEGY_DIRECTION_NONE;
        activeSetup.setupId = "";
        activeSetup.levelName = "";
        activeSetup.levelPrice = 0.0;
        activeSetup.failedBreakExtreme = 0.0;
        activeSetup.failedBreakBarTime = 0;
        activeSetup.completedBarsAfterFailure = 0;
    }
};
