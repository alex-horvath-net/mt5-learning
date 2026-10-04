#include "HigherTimeframeMarketContext.mqh"
#include "HigherTimeframeStructureVisualizer.mqh"

class CLearningEA
{
private:
    CHigherTimeframeMarketContext higherTimeframeMarketContext;
    CHigherTimeframeStructureVisualizer higherTimeframeStructureVisualizer;
    bool hasLoggedFirstTick;
    bool hasDrawnInitialPriceContext;
    datetime lastLoggedChartBarTime;
    datetime lastLoggedH1BarTime;

public:
    void Initialize()
    {
        ResetLoggedState();
        LogStarted();
        DrawInitialPriceContextOnce();
    }

    void ProcessIncomingTick()
    {
        LogFirstTickOnce();
        DrawInitialPriceContextOnce();
        ProcessNewlyClosedChartBar();
    }

    void ProcessTimerEvent()
    {
        DrawInitialPriceContextOnce();
    }

    void Shutdown()
    {
        higherTimeframeStructureVisualizer.RemoveChartObjects(_Symbol);
    }

private:
    void ResetLoggedState()
    {
        hasLoggedFirstTick = false;
        hasDrawnInitialPriceContext = false;
        lastLoggedChartBarTime = 0;
        lastLoggedH1BarTime = 0;
        higherTimeframeStructureVisualizer.RemoveChartObjects(_Symbol);
    }

    void LogStarted()
    {
        Print("LearningEA started");
    }

    void DrawInitialPriceContextOnce()
    {
        if (hasDrawnInitialPriceContext)
        {
            return;
        }

        hasDrawnInitialPriceContext = UpdateAndDrawH1H4PriceContext();
    }

    void ProcessNewlyClosedChartBar()
    {
        MqlRates latestClosedChartBar[1];
        if (!LoadClosedBar(_Symbol, _Period, latestClosedChartBar) ||
            !HasNewBarTime(latestClosedChartBar[0], lastLoggedChartBarTime))
        {
            return;
        }

        lastLoggedChartBarTime = latestClosedChartBar[0].time;
        LogBarSummary(latestClosedChartBar[0], _Period);
        UpdateAndDrawH1H4PriceContext();
        LogNewlyClosedH1Bar();
    }

    void LogFirstTickOnce()
    {
        if (hasLoggedFirstTick)
        {
            return;
        }

        Print("LearningEA received first tick");
        hasLoggedFirstTick = true;
    }

    bool LoadClosedBar(const string symbol, const ENUM_TIMEFRAMES timeframe, MqlRates &closedBar[])
    {
        return CopyRates(symbol, timeframe, 1, 1, closedBar) == 1;
    }

    bool HasNewBarTime(const MqlRates &closedBar, const datetime previouslyLoggedBarTime)
    {
        return closedBar.time != previouslyLoggedBarTime;
    }

    void LogBarSummary(const MqlRates &closedBar, const ENUM_TIMEFRAMES timeframe)
    {
        PrintFormat("%s completed %s bar %s: Open=%g High=%g Low=%g Close=%g TickVolume=%I64d",
                    _Symbol,
                    EnumToString(timeframe),
                    TimeToString(closedBar.time, TIME_DATE | TIME_MINUTES),
                    closedBar.open,
                    closedBar.high,
                    closedBar.low,
                    closedBar.close,
                    closedBar.tick_volume);
    }

    bool UpdateAndDrawH1H4PriceContext()
    {
        const SRecentConfirmedSwingPoints h1SwingPoints = higherTimeframeMarketContext.GetConfirmedSwingPoints(_Symbol, PERIOD_H1);
        const SRecentConfirmedSwingPoints h4SwingPoints = higherTimeframeMarketContext.GetConfirmedSwingPoints(_Symbol, PERIOD_H4);
        const string h1PriceStructure = higherTimeframeMarketContext.GetPriceStructure(h1SwingPoints);
        const string h4PriceStructure = higherTimeframeMarketContext.GetPriceStructure(h4SwingPoints);
        const string h1H4Alignment = higherTimeframeMarketContext.GetH1H4Alignment(h1PriceStructure, h4PriceStructure);
        SConfirmedSwingBar h1SwingHistory[];
        SConfirmedSwingBar h4SwingHistory[];
        const int h1SwingCount = higherTimeframeMarketContext.GetLastFourWeeksSwingHistory(_Symbol, PERIOD_H1, h1SwingHistory);
        const int h4SwingCount = higherTimeframeMarketContext.GetLastFourWeeksSwingHistory(_Symbol, PERIOD_H4, h4SwingHistory);

        PrintFormat("%s price context: H1=%s H4=%s Alignment=%s; value, order flow, and GEX unavailable",
                    _Symbol,
                    h1PriceStructure,
                    h4PriceStructure,
                    h1H4Alignment);

        higherTimeframeStructureVisualizer.DrawMarketStructure(_Symbol,
                                                               h1SwingHistory, h1PriceStructure,
                                                               h4SwingHistory, h4PriceStructure,
                                                               h1H4Alignment);

        return h1SwingCount > 0 && h4SwingCount > 0;
    }

    void LogNewlyClosedH1Bar()
    {
        MqlRates newlyClosedH1Bar[1];
        if (!LoadClosedBar(_Symbol, PERIOD_H1, newlyClosedH1Bar) ||
            !HasNewBarTime(newlyClosedH1Bar[0], lastLoggedH1BarTime))
        {
            return;
        }

        lastLoggedH1BarTime = newlyClosedH1Bar[0].time;
        LogBarSummary(newlyClosedH1Bar[0], PERIOD_H1);
    }
};
