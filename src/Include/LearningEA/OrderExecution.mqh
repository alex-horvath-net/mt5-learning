#include <Trade/Trade.mqh>
#include "StrategyTradePlan.mqh"

class COrderExecution
{
private:
    CTrade trade;
    ulong strategyMagicNumber;

public:
    void Configure(const ulong magicNumber)
    {
        strategyMagicNumber = magicNumber;
        trade.SetExpertMagicNumber(magicNumber);
        trade.SetAsyncMode(false);
    }

    bool Open(const string symbol, const SStrategyTradePlan &plan, const double volume,
              double &fillPrice, string &reason)
    {
        fillPrice = 0.0;
        const bool requestAccepted = SubmitMarketOrder(symbol, plan, volume);
        if (!requestAccepted || !HasSuccessfulFillRetcode())
        {
            reason = "ORDER_REJECTED_" + IntegerToString((int)trade.ResultRetcode());
            LogOrderResult(symbol, plan, volume, reason);
            return false;
        }
        if (!HasProtectedStrategyPosition(symbol))
        {
            reason = "FILLED_POSITION_NOT_RECONCILED";
            LogOrderResult(symbol, plan, volume, reason);
            return false;
        }
        fillPrice = trade.ResultPrice();
        reason = "TRADE_OPENED";
        LogOrderResult(symbol, plan, volume, reason);
        return true;
    }

    bool Reconcile(const string symbol, const ulong magicNumber, string &reason)
    {
        if (!SelectStrategyPosition(symbol, magicNumber))
        {
            return true;
        }
        if (HasProtectiveStops())
        {
            return true;
        }
        const ulong positionTicket = (ulong)PositionGetInteger(POSITION_TICKET);
        if (trade.PositionClose(positionTicket) && HasSuccessfulCloseRetcode())
        {
            reason = "POSITION_CLOSED_MISSING_PROTECTION";
            return false;
        }
        reason = "EMERGENCY_CLOSE_FAILED_" + IntegerToString((int)trade.ResultRetcode());
        return false;
    }

    bool CloseForSafetyShutdown(const string symbol, const ulong magicNumber, string &reason)
    {
        if (!SelectStrategyPosition(symbol, magicNumber))
        {
            reason = "NO_STRATEGY_POSITION";
            return true;
        }
        const ulong positionTicket = (ulong)PositionGetInteger(POSITION_TICKET);
        if (trade.PositionClose(positionTicket) && HasSuccessfulCloseRetcode())
        {
            reason = "SAFETY_SHUTDOWN_CLOSED_POSITION";
            return true;
        }
        reason = "SAFETY_SHUTDOWN_CLOSE_FAILED_" + IntegerToString((int)trade.ResultRetcode());
        return false;
    }

private:
    bool SubmitMarketOrder(const string symbol, const SStrategyTradePlan &plan, const double volume)
    {
        const string orderComment = StringSubstr(plan.setupId, 0, 30);
        if (plan.direction == STRATEGY_DIRECTION_LONG)
        {
            return trade.Buy(volume, symbol, 0.0, plan.stopLossPrice, plan.takeProfitPrice, orderComment);
        }
        return trade.Sell(volume, symbol, 0.0, plan.stopLossPrice, plan.takeProfitPrice, orderComment);
    }

    bool HasSuccessfulFillRetcode()
    {
        return trade.ResultRetcode() == TRADE_RETCODE_DONE ||
               trade.ResultRetcode() == TRADE_RETCODE_DONE_PARTIAL;
    }

    bool HasProtectedStrategyPosition(const string symbol)
    {
        return SelectStrategyPosition(symbol, strategyMagicNumber) && HasProtectiveStops();
    }

    bool SelectStrategyPosition(const string symbol, const ulong magicNumber)
    {
        for (int positionIndex = 0; positionIndex < PositionsTotal(); positionIndex++)
        {
            const ulong ticket = PositionGetTicket(positionIndex);
            if (ticket > 0 && PositionGetString(POSITION_SYMBOL) == symbol &&
                (ulong)PositionGetInteger(POSITION_MAGIC) == magicNumber)
            {
                return true;
            }
        }
        return false;
    }

    bool HasProtectiveStops()
    {
        return PositionGetDouble(POSITION_SL) > 0.0 && PositionGetDouble(POSITION_TP) > 0.0;
    }

    bool HasSuccessfulCloseRetcode()
    {
        return trade.ResultRetcode() == TRADE_RETCODE_DONE ||
               trade.ResultRetcode() == TRADE_RETCODE_DONE_PARTIAL;
    }

    void LogOrderResult(const string symbol, const SStrategyTradePlan &plan,
                        const double volume, const string reason)
    {
        PrintFormat("STRATEGY event=ORDER symbol=%s setup=%s direction=%s volume=%g planned_entry=%g fill=%g stop=%g target=%g retcode=%d reason=%s",
                    symbol, plan.setupId,
                    plan.direction == STRATEGY_DIRECTION_LONG ? "LONG" : "SHORT",
                    volume, plan.entryPrice, trade.ResultPrice(), plan.stopLossPrice,
                    plan.takeProfitPrice, (int)trade.ResultRetcode(), reason);
    }
};
