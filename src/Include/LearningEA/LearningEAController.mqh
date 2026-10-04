#include "HigherTimeframeMarketContext.mqh"
#include "HigherTimeframeStructureVisualizer.mqh"
#include "MarketContextAnalyzer.mqh"
#include "MarketDataService.mqh"
#include "ReferenceLevelCalculator.mqh"
#include "SetupStateMachine.mqh"
#include "M5StructureConfirmation.mqh"
#include "TradePlanBuilder.mqh"
#include "RiskGate.mqh"
#include "OrderExecution.mqh"
#include "PositionManager.mqh"
#include "StrategyObserver.mqh"
#include "PriceOnlyStrategyVisualizer.mqh"
#include "StrategySettings.mqh"

class CLearningEA
{
private:
    CHigherTimeframeMarketContext higherTimeframeMarketContext;
    CHigherTimeframeStructureVisualizer higherTimeframeStructureVisualizer;
    CMarketContextAnalyzer marketContextAnalyzer;
    CMarketDataService marketDataService;
    CReferenceLevelCalculator referenceLevelCalculator;
    CSetupStateMachine setupStateMachine;
    CM5StructureConfirmation m5StructureConfirmation;
    CTradePlanBuilder tradePlanBuilder;
    CRiskGate riskGate;
    COrderExecution orderExecution;
    CPositionManager positionManager;
    CStrategyObserver strategyObserver;
    CPriceOnlyStrategyVisualizer priceOnlyStrategyVisualizer;
    SStrategySettings settings;
    SMarketContextSnapshot marketContext;
    SStrategyLevel referenceLevels[];
    SStrategySetup activeSetup;
    SStrategyTradePlan currentTradePlan;
    datetime lastProcessedM5BarTime;
    datetime lastLoggedEventBarTime;
    bool hasEstablishedM5Baseline;
    bool hasLoggedFirstTick;
    string currentState;
    string currentReason;

public:
    void Initialize(const bool demoTradingEnabled, const bool safetyShutdown,
                    const double riskPercentPerTrade, const double maximumDailyLossPercent,
                    const int maximumTradesPerDay, const int maximumSpreadPoints,
                    const ulong magicNumber)
    {
        ConfigureSettings(demoTradingEnabled, safetyShutdown, riskPercentPerTrade,
                          maximumDailyLossPercent, maximumTradesPerDay,
                          maximumSpreadPoints, magicNumber);
        ResetStrategyState();
        orderExecution.Configure(settings.magicNumber);
        LogStarted();
        RefreshMarketContextAndDraw();
        PublishCurrentStatus();
    }

    void ProcessIncomingTick()
    {
        LogFirstTickOnce();
        if (!ProcessExistingPosition())
        {
            return;
        }
        ProcessLatestCompletedM5Bar();
    }

    void ProcessTimerEvent()
    {
        if (!ProcessExistingPosition())
        {
            return;
        }
        ProcessLatestCompletedM5Bar();
    }

    void Shutdown()
    {
        priceOnlyStrategyVisualizer.Clear(_Symbol);
        higherTimeframeStructureVisualizer.RemoveChartObjects(_Symbol);
    }

private:
    void ConfigureSettings(const bool demoTradingEnabled, const bool safetyShutdown,
                           const double riskPercentPerTrade, const double maximumDailyLossPercent,
                           const int maximumTradesPerDay, const int maximumSpreadPoints,
                           const ulong magicNumber)
    {
        settings.demoTradingEnabled = demoTradingEnabled;
        settings.safetyShutdown = safetyShutdown;
        settings.riskPercentPerTrade = riskPercentPerTrade;
        settings.maximumDailyLossPercent = maximumDailyLossPercent;
        settings.maximumTradesPerDay = maximumTradesPerDay;
        settings.maximumSpreadPoints = maximumSpreadPoints;
        settings.magicNumber = magicNumber;
    }

    void ResetStrategyState()
    {
        lastProcessedM5BarTime = 0;
        lastLoggedEventBarTime = 0;
        hasEstablishedM5Baseline = false;
        hasLoggedFirstTick = false;
        currentState = "STARTUP_CHECK";
        currentReason = GetStartupReason();
        setupStateMachine.Reset();
        ResetCurrentPlan();
        ArrayResize(referenceLevels, 0);
    }

    string GetStartupReason()
    {
        if (_Symbol != "US500")
        {
            return "UNSUPPORTED_SYMBOL";
        }
        if ((ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE) != ACCOUNT_TRADE_MODE_DEMO)
        {
            return "DEMO_ACCOUNT_REQUIRED";
        }
        if (!settings.demoTradingEnabled)
        {
            return "DEMO_TRADING_DISABLED";
        }
        if (settings.safetyShutdown)
        {
            return "SAFETY_SHUTDOWN";
        }
        if (settings.demoTradingEnabled && !AreRiskSettingsValid())
        {
            return "RISK_SETTINGS_INVALID";
        }
        return "OBSERVE_ONLY_UNTIL_DATA_READY";
    }

    bool AreRiskSettingsValid()
    {
        return settings.riskPercentPerTrade > 0.0 && settings.riskPercentPerTrade <= 1.0 &&
               settings.maximumDailyLossPercent > 0.0 && settings.maximumDailyLossPercent <= 5.0 &&
               settings.maximumTradesPerDay > 0 && settings.maximumSpreadPoints > 0;
    }

    void LogStarted()
    {
        PrintFormat("STRATEGY event=STARTUP symbol=%s demo=%s risk_percent=%g daily_loss_percent=%g max_trades=%d max_spread_points=%d reason=%s",
                    _Symbol, settings.demoTradingEnabled ? "true" : "false",
                    settings.riskPercentPerTrade, settings.maximumDailyLossPercent,
                    settings.maximumTradesPerDay, settings.maximumSpreadPoints,
                    currentReason);
    }

    void RefreshMarketContextAndDraw()
    {
        marketContextAnalyzer.Analyze(_Symbol, marketContext);
        DrawFourWeekSwingHistory();
    }

    void DrawFourWeekSwingHistory()
    {
        SConfirmedSwingBar h1SwingHistory[];
        SConfirmedSwingBar h4SwingHistory[];
        higherTimeframeMarketContext.GetLastFourWeeksSwingHistory(_Symbol, PERIOD_H1, h1SwingHistory);
        higherTimeframeMarketContext.GetLastFourWeeksSwingHistory(_Symbol, PERIOD_H4, h4SwingHistory);
        higherTimeframeStructureVisualizer.DrawMarketStructure(_Symbol,
                                                               h1SwingHistory, marketContext.h1Structure,
                                                               h4SwingHistory, marketContext.h4Structure,
                                                               marketContext.alignment);
    }

    void PublishCurrentStatus()
    {
        priceOnlyStrategyVisualizer.Render(_Symbol, marketContext, referenceLevels,
                                           activeSetup, currentTradePlan,
                                           currentConfirmationTime, currentConfirmationPrice,
                                           currentFillTime, currentFillPrice,
                                           currentState, currentReason,
                                           settings.demoTradingEnabled);
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

    bool ProcessExistingPosition()
    {
        if ((ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE) != ACCOUNT_TRADE_MODE_DEMO)
        {
            currentReason = "DEMO_ACCOUNT_REQUIRED";
            currentState = "OBSERVE_ONLY";
            PublishCurrentStatus();
            return false;
        }
        string positionReason = "";
        if (settings.safetyShutdown)
        {
            orderExecution.CloseForSafetyShutdown(_Symbol, settings.magicNumber, positionReason);
            if (positionReason != "NO_STRATEGY_POSITION")
            {
                currentReason = positionReason;
                currentState = "SAFETY_SHUTDOWN";
                PublishCurrentStatus();
            }
            return false;
        }
        if (!orderExecution.Reconcile(_Symbol, settings.magicNumber, positionReason))
        {
            currentReason = positionReason;
            currentState = "POSITION_RECOVERY";
            PublishCurrentStatus();
            return false;
        }
        return true;
    }

    void ProcessLatestCompletedM5Bar()
    {
        if (_Symbol != "US500")
        {
            currentState = "OBSERVE_ONLY";
            currentReason = "UNSUPPORTED_SYMBOL";
            PublishCurrentStatus();
            return;
        }
        if (!HasReadyM5History())
        {
            SetWaitingForHistory();
            return;
        }

        MqlRates completedM5Bars[];
        if (!LoadRequiredCompletedBars(completedM5Bars))
        {
            SetWaitingForHistory();
            return;
        }
        if (!EstablishBaselineOrFindNewBar(completedM5Bars[0]))
        {
            return;
        }

        lastProcessedM5BarTime = completedM5Bars[0].time;
        RefreshMarketContextAndDraw();
        EvaluateCompletedM5Bar(completedM5Bars);
        PublishCurrentStatus();
        RecordCompletedBarDecision(completedM5Bars[0].time);
    }

    bool HasReadyM5History()
    {
        return marketDataService.IsHistoryReady(_Symbol, PERIOD_M5) &&
               marketDataService.IsHistoryReady(_Symbol, PERIOD_H1) &&
               marketDataService.IsHistoryReady(_Symbol, PERIOD_H4) &&
               marketDataService.IsHistoryReady(_Symbol, PERIOD_D1) &&
               marketDataService.IsHistoryReady(_Symbol, PERIOD_W1);
    }

    bool LoadRequiredCompletedBars(MqlRates &completedM5Bars[])
    {
        const int requestedM5BarCount = 128;
        const int minimumM5BarCount = 5;
        const int loadedM5BarCount = marketDataService.LoadCompletedBars(_Symbol, PERIOD_M5,
                                                                          requestedM5BarCount,
                                                                          completedM5Bars);
        return loadedM5BarCount >= minimumM5BarCount &&
               referenceLevelCalculator.Calculate(_Symbol, referenceLevels);
    }

    bool EstablishBaselineOrFindNewBar(const MqlRates &latestCompletedBar)
    {
        if (!hasEstablishedM5Baseline)
        {
            lastProcessedM5BarTime = latestCompletedBar.time;
            hasEstablishedM5Baseline = true;
            currentState = "WAIT_FOR_LEVEL";
            currentReason = "STARTUP_BASELINE_SET_NO_STALE_SIGNAL";
            PublishCurrentStatus();
            return false;
        }
        return latestCompletedBar.time != lastProcessedM5BarTime;
    }

    void EvaluateCompletedM5Bar(const MqlRates &completedM5Bars[])
    {
        ResetCurrentPlan();
        const MqlRates latestCompletedBar = completedM5Bars[0];
        if (!marketContext.isReady || marketContext.alignment == "MIXED")
        {
            setupStateMachine.Reset();
            setupStateMachine.GetActiveSetup(activeSetup);
            currentState = "WAIT_FOR_CONTEXT";
            currentReason = marketContext.isReady ? "CONTEXT_MIXED" : "CONTEXT_INSUFFICIENT";
            return;
        }
        if (positionManager.HasStrategyPosition(_Symbol, settings.magicNumber))
        {
            setupStateMachine.Reset();
            setupStateMachine.GetActiveSetup(activeSetup);
            currentState = "POSITION_OPEN";
            currentReason = "POSITION_EXISTS";
            return;
        }

        currentState = setupStateMachine.ProcessCompletedBar(latestCompletedBar,
                                                             referenceLevels, currentReason)
                           ? "WAIT_FOR_CONFIRMATION"
                           : "WAIT_FOR_LEVEL";
        setupStateMachine.GetActiveSetup(activeSetup);
        if (!activeSetup.isActive)
        {
            return;
        }
        if (!marketContextAnalyzer.AllowsDirection(activeSetup.direction, marketContext))
        {
            setupStateMachine.CompleteActiveSetup();
            activeSetup.isActive = false;
            currentState = "WAIT_FOR_LEVEL";
            currentReason = "CONTEXT_BLOCKED";
            return;
        }
        TryConfirmAndExecute(completedM5Bars);
    }

    void TryConfirmAndExecute(const MqlRates &completedM5Bars[])
    {
        double confirmedSwingPrice = 0.0;
        datetime confirmedSwingTime = 0;
        if (!m5StructureConfirmation.Evaluate(activeSetup, completedM5Bars,
                                              confirmedSwingPrice, confirmedSwingTime))
        {
            currentState = "WAIT_FOR_CONFIRMATION";
            currentReason = "WAITING_FOR_M5_SWING_BREAK";
            return;
        }

        string tradeAttemptReason = BuildAndSubmitTrade();
        currentReason = tradeAttemptReason;
        currentState = tradeAttemptReason == "TRADE_OPENED" ? "POSITION_OPEN" : "SIGNAL_CONSUMED";
        setupStateMachine.CompleteActiveSetup();
        activeSetup.isActive = false;
        currentConfirmationTime = confirmedSwingTime;
        currentConfirmationPrice = confirmedSwingPrice;
    }

    string BuildAndSubmitTrade()
    {
        MqlTick currentQuote;
        if (!marketDataService.GetCurrentQuote(_Symbol, currentQuote))
        {
            return "STALE_QUOTE";
        }
        double tickSize = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);
        int priceDigits = (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);
        if (tickSize <= 0.0)
        {
            return "SYMBOL_TICK_SIZE_INVALID";
        }
        string planReason = "";
        if (!tradePlanBuilder.BuildPlan(_Symbol, activeSetup, referenceLevels, currentQuote,
                                        tickSize, priceDigits, currentTradePlan, planReason))
        {
            return planReason;
        }
        double volume = 0.0;
        string riskReason = "";
        if (!riskGate.Validate(_Symbol, settings, currentTradePlan, currentQuote,
                               volume, riskReason))
        {
            return riskReason;
        }
        string executionReason = "";
        if (!orderExecution.Open(_Symbol, currentTradePlan, volume,
                                 currentFillPrice, executionReason))
        {
            return executionReason;
        }
        currentFillTime = TimeCurrent();
        return executionReason;
    }

    void SetWaitingForHistory()
    {
        currentState = "WAIT_FOR_COMPLETE_DATA";
        currentReason = "HISTORY_NOT_READY";
        marketContextAnalyzer.Analyze(_Symbol, marketContext);
        PublishCurrentStatus();
    }

    void RecordCompletedBarDecision(const datetime barTime)
    {
        if (lastLoggedEventBarTime == barTime)
        {
            return;
        }
        strategyObserver.RecordEvent("M5_EVALUATION", _Symbol, barTime,
                                     marketContext, currentState, currentReason,
                                     activeSetup, currentTradePlan);
        lastLoggedEventBarTime = barTime;
    }

    void ResetCurrentPlan()
    {
        currentTradePlan.isValid = false;
        currentTradePlan.direction = STRATEGY_DIRECTION_NONE;
        currentTradePlan.setupId = "";
        currentTradePlan.targetLevelName = "";
        currentTradePlan.entryPrice = 0.0;
        currentTradePlan.stopLossPrice = 0.0;
        currentTradePlan.takeProfitPrice = 0.0;
        currentTradePlan.riskDistance = 0.0;
        currentTradePlan.rewardDistance = 0.0;
        currentConfirmationTime = 0;
        currentConfirmationPrice = 0.0;
    }

    datetime currentConfirmationTime;
    double currentConfirmationPrice;
    datetime currentFillTime;
    double currentFillPrice;
};
