class CMarketDataService
{
public:
    int LoadCompletedBars(const string symbol, const ENUM_TIMEFRAMES timeframe,
                          const int requestedCount, MqlRates &completedBars[])
    {
        return CopyCompletedBars(symbol, timeframe, requestedCount, completedBars);
    }

    bool GetCurrentQuote(const string symbol, MqlTick &quote)
    {
        return LoadQuote(symbol, quote) && IsQuoteFresh(quote);
    }

    bool IsHistoryReady(const string symbol, const ENUM_TIMEFRAMES timeframe)
    {
        return IsSeriesSynchronized(symbol, timeframe);
    }

private:
    int CopyCompletedBars(const string symbol, const ENUM_TIMEFRAMES timeframe,
                          const int requestedCount, MqlRates &completedBars[])
    {
        ArraySetAsSeries(completedBars, true);
        return CopyRates(symbol, timeframe, 1, requestedCount, completedBars);
    }

    bool LoadQuote(const string symbol, MqlTick &quote)
    {
        return SymbolInfoTick(symbol, quote);
    }

    bool IsQuoteFresh(const MqlTick &quote)
    {
        const int maximumQuoteAgeSeconds = 60;
        return quote.time > 0 && TimeCurrent() - quote.time <= maximumQuoteAgeSeconds;
    }

    bool IsSeriesSynchronized(const string symbol, const ENUM_TIMEFRAMES timeframe)
    {
        long isSynchronized = false;
        return SeriesInfoInteger(symbol, timeframe, SERIES_SYNCHRONIZED, isSynchronized) && isSynchronized;
    }
};
