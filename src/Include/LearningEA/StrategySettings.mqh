struct SStrategySettings
{
    bool demoTradingEnabled;
    bool safetyShutdown;
    double riskPercentPerTrade;
    double maximumDailyLossPercent;
    int maximumTradesPerDay;
    int maximumSpreadPoints;
    ulong magicNumber;
};
