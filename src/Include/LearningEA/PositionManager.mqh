class CPositionManager
{
public:
    bool HasStrategyPosition(const string symbol, const ulong magicNumber)
    {
        for (int positionIndex = 0; positionIndex < PositionsTotal(); positionIndex++)
        {
            if (IsStrategyPositionAtIndex(positionIndex, symbol, magicNumber))
            {
                return true;
            }
        }
        return false;
    }

    bool ValidateDailyLimits(const string symbol, const ulong magicNumber,
                             const int maximumTradesPerDay, const double maximumDailyLossPercent,
                             string &reason)
    {
        int todaysTradeCount = 0;
        double todaysClosedProfit = 0.0;
        if (!LoadTodaysPerformance(symbol, magicNumber, todaysTradeCount, todaysClosedProfit))
        {
            reason = "HISTORY_NOT_READY";
            return false;
        }
        if (todaysTradeCount >= maximumTradesPerDay)
        {
            reason = "MAX_TRADES_PER_DAY";
            return false;
        }
        return IsWithinDailyLossLimit(symbol, magicNumber, todaysClosedProfit,
                                      maximumDailyLossPercent, reason);
    }

private:
    bool IsStrategyPositionAtIndex(const int positionIndex, const string symbol, const ulong magicNumber)
    {
        const ulong ticket = PositionGetTicket(positionIndex);
        return ticket > 0 && PositionGetString(POSITION_SYMBOL) == symbol &&
               (ulong)PositionGetInteger(POSITION_MAGIC) == magicNumber;
    }

    bool LoadTodaysPerformance(const string symbol, const ulong magicNumber,
                               int &tradeCount, double &closedProfit)
    {
        tradeCount = 0;
        closedProfit = 0.0;
        if (!HistorySelect(GetStartOfBrokerDay(), TimeCurrent()))
        {
            return false;
        }
        AccumulateTodaysDeals(symbol, magicNumber, tradeCount, closedProfit);
        return true;
    }

    datetime GetStartOfBrokerDay()
    {
        MqlDateTime brokerDate;
        TimeToStruct(TimeCurrent(), brokerDate);
        brokerDate.hour = 0;
        brokerDate.min = 0;
        brokerDate.sec = 0;
        return StructToTime(brokerDate);
    }

    void AccumulateTodaysDeals(const string symbol, const ulong magicNumber,
                               int &tradeCount, double &closedProfit)
    {
        for (int dealIndex = 0; dealIndex < HistoryDealsTotal(); dealIndex++)
        {
            const ulong dealTicket = HistoryDealGetTicket(dealIndex);
            if (IsStrategyDeal(dealTicket, symbol, magicNumber))
            {
                AccumulateDeal(dealTicket, tradeCount, closedProfit);
            }
        }
    }

    bool IsStrategyDeal(const ulong dealTicket, const string symbol, const ulong magicNumber)
    {
        return dealTicket > 0 && HistoryDealGetString(dealTicket, DEAL_SYMBOL) == symbol &&
               (ulong)HistoryDealGetInteger(dealTicket, DEAL_MAGIC) == magicNumber;
    }

    void AccumulateDeal(const ulong dealTicket, int &tradeCount, double &closedProfit)
    {
        const ENUM_DEAL_ENTRY dealEntry = (ENUM_DEAL_ENTRY)HistoryDealGetInteger(dealTicket, DEAL_ENTRY);
        if (dealEntry == DEAL_ENTRY_IN || dealEntry == DEAL_ENTRY_INOUT)
        {
            tradeCount++;
        }
        closedProfit += HistoryDealGetDouble(dealTicket, DEAL_PROFIT) +
                        HistoryDealGetDouble(dealTicket, DEAL_SWAP) +
                        HistoryDealGetDouble(dealTicket, DEAL_COMMISSION);
    }

    bool IsWithinDailyLossLimit(const string symbol, const ulong magicNumber,
                                const double todaysClosedProfit, const double maximumDailyLossPercent,
                                string &reason)
    {
        const double accountBalance = AccountInfoDouble(ACCOUNT_BALANCE);
        const double dailyLossLimit = accountBalance * maximumDailyLossPercent / 100.0;
        const double currentStrategyProfit = todaysClosedProfit + GetOpenStrategyProfit(symbol, magicNumber);
        if (currentStrategyProfit <= -dailyLossLimit)
        {
            reason = "DAILY_LOSS_LIMIT";
            return false;
        }
        return true;
    }

    double GetOpenStrategyProfit(const string symbol, const ulong magicNumber)
    {
        double openProfit = 0.0;
        for (int positionIndex = 0; positionIndex < PositionsTotal(); positionIndex++)
        {
            const ulong ticket = PositionGetTicket(positionIndex);
            if (ticket > 0 && PositionGetString(POSITION_SYMBOL) == symbol &&
                (ulong)PositionGetInteger(POSITION_MAGIC) == magicNumber)
            {
                openProfit += PositionGetDouble(POSITION_PROFIT) + PositionGetDouble(POSITION_SWAP);
            }
        }
        return openProfit;
    }
};
