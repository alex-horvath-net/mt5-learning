#include "StrategyTradePlan.mqh"
#include "StrategyLevel.mqh"
#include "StrategySetup.mqh"

class CTradePlanBuilder
{
public:
    bool BuildPlan(const string symbol, const SStrategySetup &setup,
                   const SStrategyLevel &levels[], const MqlTick &quote,
                   const double tickSize, const int priceDigits, SStrategyTradePlan &plan, string &reason)
    {
        ResetPlan(plan);
        if (!SetPlanPrices(symbol, setup, levels, quote, tickSize, priceDigits, plan, reason))
        {
            return false;
        }
        return ValidateRewardRisk(plan, reason);
    }

private:
    bool SetPlanPrices(const string symbol, const SStrategySetup &setup,
                       const SStrategyLevel &levels[], const MqlTick &quote,
                       const double tickSize, const int priceDigits, SStrategyTradePlan &plan, string &reason)
    {
        plan.direction = setup.direction;
        plan.setupId = setup.setupId;
        plan.entryPrice = GetEntryPrice(setup.direction, quote);
        plan.stopLossPrice = GetStopLossPrice(setup, tickSize, priceDigits);
        if (!SetTargetPrice(setup.direction, levels, plan.entryPrice, plan, priceDigits))
        {
            reason = "NO_TARGET_LEVEL";
            return false;
        }
        plan.riskDistance = MathAbs(plan.entryPrice - plan.stopLossPrice);
        plan.rewardDistance = MathAbs(plan.takeProfitPrice - plan.entryPrice);
        if (!HasValidDirectionalPrices(plan))
        {
            reason = "INVALID_TRADE_PRICES";
            return false;
        }
        if (!HasBrokerValidStopDistances(symbol, setup.direction, quote, plan, reason))
        {
            return false;
        }
        return true;
    }

    bool HasBrokerValidStopDistances(const string symbol, const EStrategyDirection direction,
                                     const MqlTick &quote, const SStrategyTradePlan &plan,
                                     string &reason)
    {
        const double pointSize = SymbolInfoDouble(symbol, SYMBOL_POINT);
        const long stopLevelPoints = SymbolInfoInteger(symbol, SYMBOL_TRADE_STOPS_LEVEL);
        if (pointSize <= 0.0 || stopLevelPoints < 0)
        {
            reason = "SYMBOL_STOP_SPEC_INVALID";
            return false;
        }
        const double minimumStopDistance = pointSize * stopLevelPoints;
        const double stopDistance = direction == STRATEGY_DIRECTION_LONG
                                        ? quote.bid - plan.stopLossPrice
                                        : plan.stopLossPrice - quote.ask;
        const double targetDistance = direction == STRATEGY_DIRECTION_LONG
                                          ? plan.takeProfitPrice - quote.bid
                                          : quote.ask - plan.takeProfitPrice;
        if (stopDistance < minimumStopDistance)
        {
            reason = "STOP_DISTANCE_TOO_SMALL";
            return false;
        }
        if (targetDistance < minimumStopDistance)
        {
            reason = "TARGET_DISTANCE_TOO_SMALL";
            return false;
        }
        return true;
    }

    double GetEntryPrice(const EStrategyDirection direction, const MqlTick &quote)
    {
        return direction == STRATEGY_DIRECTION_LONG ? quote.ask : quote.bid;
    }

    double GetStopLossPrice(const SStrategySetup &setup, const double tickSize, const int priceDigits)
    {
        const double stopPrice = setup.direction == STRATEGY_DIRECTION_LONG
                                     ? setup.failedBreakExtreme - tickSize
                                     : setup.failedBreakExtreme + tickSize;
        return NormalizeDouble(stopPrice, priceDigits);
    }

    bool SetTargetPrice(const EStrategyDirection direction, const SStrategyLevel &levels[],
                        const double entryPrice, SStrategyTradePlan &plan, const int priceDigits)
    {
        double nearestTargetDistance = DBL_MAX;
        for (int levelIndex = 0; levelIndex < ArraySize(levels); levelIndex++)
        {
            if (IsEligibleTarget(direction, levels[levelIndex], entryPrice))
            {
                SaveNearestTarget(levels[levelIndex], entryPrice, nearestTargetDistance, plan);
            }
        }
        plan.takeProfitPrice = NormalizeDouble(plan.takeProfitPrice, priceDigits);
        return nearestTargetDistance < DBL_MAX;
    }

    bool IsEligibleTarget(const EStrategyDirection direction, const SStrategyLevel &level,
                          const double entryPrice)
    {
        if (direction == STRATEGY_DIRECTION_LONG)
        {
            return level.supportsShort && level.price > entryPrice;
        }
        return level.supportsLong && level.price < entryPrice;
    }

    void SaveNearestTarget(const SStrategyLevel &level, const double entryPrice,
                           double &nearestTargetDistance, SStrategyTradePlan &plan)
    {
        const double targetDistance = MathAbs(level.price - entryPrice);
        if (targetDistance < nearestTargetDistance)
        {
            nearestTargetDistance = targetDistance;
            plan.takeProfitPrice = level.price;
            plan.targetLevelName = level.name;
        }
    }

    bool HasValidDirectionalPrices(const SStrategyTradePlan &plan)
    {
        if (plan.riskDistance <= 0.0 || plan.rewardDistance <= 0.0)
        {
            return false;
        }
        if (plan.direction == STRATEGY_DIRECTION_LONG)
        {
            return plan.stopLossPrice < plan.entryPrice && plan.takeProfitPrice > plan.entryPrice;
        }
        return plan.stopLossPrice > plan.entryPrice && plan.takeProfitPrice < plan.entryPrice;
    }

    bool ValidateRewardRisk(SStrategyTradePlan &plan, string &reason)
    {
        const double minimumRewardRiskRatio = 1.5;
        if (plan.rewardDistance / plan.riskDistance < minimumRewardRiskRatio)
        {
            reason = "REWARD_RISK_BELOW_MINIMUM";
            return false;
        }
        plan.isValid = true;
        reason = "TRADE_PLAN_VALID";
        return true;
    }

    void ResetPlan(SStrategyTradePlan &plan)
    {
        plan.isValid = false;
        plan.direction = STRATEGY_DIRECTION_NONE;
        plan.setupId = "";
        plan.targetLevelName = "";
        plan.entryPrice = 0.0;
        plan.stopLossPrice = 0.0;
        plan.takeProfitPrice = 0.0;
        plan.riskDistance = 0.0;
        plan.rewardDistance = 0.0;
    }
};
