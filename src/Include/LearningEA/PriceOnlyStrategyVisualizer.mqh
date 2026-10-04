#include "MarketContextSnapshot.mqh"
#include "StrategyLevel.mqh"
#include "StrategySetup.mqh"
#include "StrategyTradePlan.mqh"

class CPriceOnlyStrategyVisualizer
{
public:
    void Render(const string symbol, const SMarketContextSnapshot &context,
                const SStrategyLevel &levels[], const SStrategySetup &setup,
                const SStrategyTradePlan &plan, const datetime confirmationTime,
                const double confirmationPrice, const datetime fillTime,
                const double fillPrice, const string state,
                const string reason, const bool demoTradingEnabled)
    {
        DrawStatus(symbol, context, state, reason, demoTradingEnabled);
        DrawReferenceLevels(symbol, levels);
        DrawSetup(symbol, setup);
        DrawConfirmation(symbol, confirmationTime, confirmationPrice);
        DrawActualFill(symbol, fillTime, fillPrice);
        DrawTradePlan(symbol, plan);
        ChartRedraw(0);
    }

    void Clear(const string symbol)
    {
        ObjectsDeleteAll(0, GetObjectPrefix(symbol));
        ChartRedraw(0);
    }

private:
    void DrawStatus(const string symbol, const SMarketContextSnapshot &context,
                    const string state, const string reason, const bool demoTradingEnabled)
    {
        DrawStatusLine(symbol, "Context", "Price strategy | H1 " + context.h1Structure +
                       " | H4 " + context.h4Structure, 108, clrWhite);
        DrawStatusLine(symbol, "State", "State: " + state + " | Last decision: " + reason,
                       126, clrWhite);
        DrawStatusLine(symbol, "Trading", "Demo orders: " + (demoTradingEnabled ? "enabled" : "disabled"),
                       144, demoTradingEnabled ? clrOrange : clrSilver);
    }

    void DrawReferenceLevels(const string symbol, const SStrategyLevel &levels[])
    {
        for (int levelIndex = 0; levelIndex < ArraySize(levels); levelIndex++)
        {
            DrawHorizontalLevel(symbol, levels[levelIndex]);
        }
        DeleteMissingLevels(symbol, ArraySize(levels));
    }

    void DrawHorizontalLevel(const string symbol, const SStrategyLevel &level)
    {
        const string objectName = GetObjectPrefix(symbol) + "Level_" + level.name;
        if (ObjectFind(0, objectName) < 0)
        {
            ObjectCreate(0, objectName, OBJ_HLINE, 0, 0, level.price);
        }
        ObjectSetDouble(0, objectName, OBJPROP_PRICE, level.price);
        ObjectSetInteger(0, objectName, OBJPROP_COLOR, level.supportsLong ? clrMediumSeaGreen : clrTomato);
        ObjectSetInteger(0, objectName, OBJPROP_STYLE, STYLE_DOT);
        ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);
        ObjectSetString(0, objectName, OBJPROP_TEXT, level.name);
    }

    void DeleteMissingLevels(const string symbol, const int levelCount)
    {
        const string prefix = GetObjectPrefix(symbol) + "Level_";
        const string names[4] = {"Previous day low", "Previous day high", "Previous week low", "Previous week high"};
        for (int levelIndex = levelCount; levelIndex < ArraySize(names); levelIndex++)
        {
            ObjectDelete(0, prefix + names[levelIndex]);
        }
    }

    void DrawSetup(const string symbol, const SStrategySetup &setup)
    {
        const string objectName = GetObjectPrefix(symbol) + "FailedBreak";
        if (!setup.isActive)
        {
            ObjectDelete(0, objectName);
            return;
        }
        DrawMarker(objectName, setup.failedBreakBarTime, setup.failedBreakExtreme,
                   setup.direction == STRATEGY_DIRECTION_LONG ? clrLime : clrRed);
    }

    void DrawTradePlan(const string symbol, const SStrategyTradePlan &plan)
    {
        DrawPlanLine(symbol, "Entry", plan.isValid, plan.entryPrice, clrDodgerBlue);
        DrawPlanLine(symbol, "Stop", plan.isValid, plan.stopLossPrice, clrRed);
        DrawPlanLine(symbol, "Target", plan.isValid, plan.takeProfitPrice, clrLimeGreen);
    }

    void DrawConfirmation(const string symbol, const datetime confirmationTime, const double confirmationPrice)
    {
        const string objectName = GetObjectPrefix(symbol) + "Confirmation";
        if (confirmationTime <= 0 || confirmationPrice <= 0.0)
        {
            ObjectDelete(0, objectName);
            return;
        }
        DrawMarker(objectName, confirmationTime, confirmationPrice, clrGold);
    }

    void DrawActualFill(const string symbol, const datetime fillTime, const double fillPrice)
    {
        const string objectName = GetObjectPrefix(symbol) + "ActualFill";
        if (fillTime <= 0 || fillPrice <= 0.0)
        {
            ObjectDelete(0, objectName);
            return;
        }
        DrawMarker(objectName, fillTime, fillPrice, clrMagenta);
    }

    void DrawPlanLine(const string symbol, const string lineName, const bool shouldDraw,
                      const double price, const color lineColor)
    {
        const string objectName = GetObjectPrefix(symbol) + "Plan_" + lineName;
        if (!shouldDraw)
        {
            ObjectDelete(0, objectName);
            return;
        }
        if (ObjectFind(0, objectName) < 0)
        {
            ObjectCreate(0, objectName, OBJ_HLINE, 0, 0, price);
        }
        ObjectSetDouble(0, objectName, OBJPROP_PRICE, price);
        ObjectSetInteger(0, objectName, OBJPROP_COLOR, lineColor);
        ObjectSetInteger(0, objectName, OBJPROP_STYLE, STYLE_DASH);
        ObjectSetInteger(0, objectName, OBJPROP_WIDTH, 2);
        ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);
    }

    void DrawMarker(const string objectName, const datetime markerTime,
                    const double markerPrice, const color markerColor)
    {
        if (ObjectFind(0, objectName) < 0)
        {
            ObjectCreate(0, objectName, OBJ_ARROW, 0, markerTime, markerPrice);
        }
        else
        {
            ObjectMove(0, objectName, 0, markerTime, markerPrice);
        }
        ObjectSetInteger(0, objectName, OBJPROP_ARROWCODE, 159);
        ObjectSetInteger(0, objectName, OBJPROP_COLOR, markerColor);
        ObjectSetInteger(0, objectName, OBJPROP_WIDTH, 3);
        ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);
    }

    void DrawStatusLine(const string symbol, const string lineName, const string text,
                        const int verticalOffset, const color textColor)
    {
        const string objectName = GetObjectPrefix(symbol) + "Status_" + lineName;
        if (ObjectFind(0, objectName) < 0)
        {
            ObjectCreate(0, objectName, OBJ_LABEL, 0, 0, 0);
        }
        ObjectSetInteger(0, objectName, OBJPROP_CORNER, CORNER_LEFT_UPPER);
        ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, 12);
        ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, verticalOffset);
        ObjectSetInteger(0, objectName, OBJPROP_FONTSIZE, 9);
        ObjectSetInteger(0, objectName, OBJPROP_COLOR, textColor);
        ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);
        ObjectSetString(0, objectName, OBJPROP_FONT, "Arial");
        ObjectSetString(0, objectName, OBJPROP_TEXT, text);
    }

    string GetObjectPrefix(const string symbol)
    {
        return "PriceOnly_" + symbol + "_";
    }
};
