#include "PositionManager.mqh"
#include "StrategySettings.mqh"
#include "StrategyTradePlan.mqh"

class CRiskGate
{
private:
    CPositionManager positionManager;

public:
    bool Validate(const string symbol, const SStrategySettings &settings,
                  const SStrategyTradePlan &plan, const MqlTick &quote, double &volume, string &reason)
    {
        volume = 0.0;
        if (!ValidateConfiguration(settings, reason) || !ValidateDemoPermissions(settings, reason) ||
            !ValidateQuoteAndSpread(symbol, settings, quote, reason) ||
            !ValidateSymbolTradeMode(symbol, plan.direction, reason) ||
            !ValidatePositionAndDailyLimits(symbol, settings, reason))
        {
            return false;
        }
        return CalculateRiskBasedVolume(symbol, settings, plan, volume, reason);
    }

private:
    bool ValidateConfiguration(const SStrategySettings &settings, string &reason)
    {
        if (!settings.demoTradingEnabled)
        {
            reason = "DEMO_TRADING_DISABLED";
            return false;
        }
        if (settings.riskPercentPerTrade <= 0.0 || settings.riskPercentPerTrade > 1.0 ||
            settings.maximumDailyLossPercent <= 0.0 || settings.maximumDailyLossPercent > 5.0 ||
            settings.maximumTradesPerDay <= 0 || settings.maximumSpreadPoints <= 0)
        {
            reason = "RISK_SETTINGS_INVALID";
            return false;
        }
        if (settings.safetyShutdown)
        {
            reason = "SAFETY_SHUTDOWN";
            return false;
        }
        return true;
    }

    bool ValidateDemoPermissions(const SStrategySettings &settings, string &reason)
    {
        if ((ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE) != ACCOUNT_TRADE_MODE_DEMO)
        {
            reason = "DEMO_ACCOUNT_REQUIRED";
            return false;
        }
        if (!IsTradingPermitted())
        {
            reason = "TRADING_NOT_PERMITTED";
            return false;
        }
        return settings.demoTradingEnabled;
    }

    bool IsTradingPermitted()
    {
        return (bool)TerminalInfoInteger(TERMINAL_CONNECTED) &&
               (bool)TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) &&
               (bool)MQLInfoInteger(MQL_TRADE_ALLOWED) &&
               (bool)AccountInfoInteger(ACCOUNT_TRADE_EXPERT);
    }

    bool ValidateQuoteAndSpread(const string symbol, const SStrategySettings &settings,
                                const MqlTick &quote, string &reason)
    {
        if (quote.bid <= 0.0 || quote.ask <= quote.bid)
        {
            reason = "STALE_QUOTE";
            return false;
        }
        const double pointSize = SymbolInfoDouble(symbol, SYMBOL_POINT);
        if (pointSize <= 0.0)
        {
            reason = "SYMBOL_POINT_INVALID";
            return false;
        }
        const double spreadPoints = (quote.ask - quote.bid) / pointSize;
        if (spreadPoints > settings.maximumSpreadPoints)
        {
            reason = "SPREAD_BLOCKED";
            return false;
        }
        return true;
    }

    bool ValidatePositionAndDailyLimits(const string symbol, const SStrategySettings &settings,
                                        string &reason)
    {
        if (positionManager.HasStrategyPosition(symbol, settings.magicNumber))
        {
            reason = "POSITION_EXISTS";
            return false;
        }
        return positionManager.ValidateDailyLimits(symbol, settings.magicNumber,
                                                   settings.maximumTradesPerDay,
                                                   settings.maximumDailyLossPercent, reason);
    }

    bool ValidateSymbolTradeMode(const string symbol, const EStrategyDirection direction, string &reason)
    {
        const ENUM_SYMBOL_TRADE_MODE tradeMode =
            (ENUM_SYMBOL_TRADE_MODE)SymbolInfoInteger(symbol, SYMBOL_TRADE_MODE);
        if (tradeMode == SYMBOL_TRADE_MODE_DISABLED || tradeMode == SYMBOL_TRADE_MODE_CLOSEONLY)
        {
            reason = "SYMBOL_TRADING_DISABLED";
            return false;
        }
        if (tradeMode == SYMBOL_TRADE_MODE_LONGONLY && direction == STRATEGY_DIRECTION_SHORT)
        {
            reason = "SYMBOL_SHORTS_DISABLED";
            return false;
        }
        if (tradeMode == SYMBOL_TRADE_MODE_SHORTONLY && direction == STRATEGY_DIRECTION_LONG)
        {
            reason = "SYMBOL_LONGS_DISABLED";
            return false;
        }
        return true;
    }

    bool CalculateRiskBasedVolume(const string symbol, const SStrategySettings &settings,
                                  const SStrategyTradePlan &plan, double &volume, string &reason)
    {
        const ENUM_ORDER_TYPE orderType = plan.direction == STRATEGY_DIRECTION_LONG ? ORDER_TYPE_BUY : ORDER_TYPE_SELL;
        double oneLotProfitAtStop = 0.0;
        if (!OrderCalcProfit(orderType, symbol, 1.0, plan.entryPrice, plan.stopLossPrice, oneLotProfitAtStop) ||
            oneLotProfitAtStop >= 0.0)
        {
            reason = "POSITION_SIZE_CALCULATION_FAILED";
            return false;
        }

        const double riskBudget = AccountInfoDouble(ACCOUNT_BALANCE) * settings.riskPercentPerTrade / 100.0;
        const double volumeStep = SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP);
        const double minimumVolume = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN);
        const double maximumVolume = SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX);
        if (!HasValidVolumeSpecification(volumeStep, minimumVolume, maximumVolume))
        {
            reason = "SYMBOL_VOLUME_SPEC_INVALID";
            return false;
        }

        volume = NormalizeVolumeDown(riskBudget / MathAbs(oneLotProfitAtStop), volumeStep);
        if (volume < minimumVolume)
        {
            reason = "RISK_BUDGET_BELOW_MINIMUM_VOLUME";
            return false;
        }
        volume = MathMin(volume, maximumVolume);
        reason = "RISK_APPROVED";
        return true;
    }

    bool HasValidVolumeSpecification(const double step, const double minimum, const double maximum)
    {
        return step > 0.0 && minimum > 0.0 && maximum >= minimum;
    }

    double NormalizeVolumeDown(const double requestedVolume, const double volumeStep)
    {
        const double stepCount = MathFloor(requestedVolume / volumeStep);
        return NormalizeDouble(stepCount * volumeStep, GetVolumeDigits(volumeStep));
    }

    int GetVolumeDigits(const double volumeStep)
    {
        for (int decimalPlaces = 0; decimalPlaces <= 8; decimalPlaces++)
        {
            if (MathAbs(NormalizeDouble(volumeStep, decimalPlaces) - volumeStep) < 0.00000001)
            {
                return decimalPlaces;
            }
        }
        return 8;
    }
};
