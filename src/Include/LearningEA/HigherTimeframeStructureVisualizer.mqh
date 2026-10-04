#include "ConfirmedSwingBar.mqh"

class CHigherTimeframeStructureVisualizer
{
public:
    void DrawMarketStructure(const string symbol,
                             const SConfirmedSwingBar &h1SwingHistory[],
                             const string h1PriceStructure,
                             const SConfirmedSwingBar &h4SwingHistory[],
                             const string h4PriceStructure,
                             const string h1H4Alignment)
    {
        DrawTimeframeSwingHistory(symbol, "H1", h1SwingHistory, clrDeepSkyBlue);
        DrawTimeframeSwingHistory(symbol, "H4", h4SwingHistory, clrOrange);
        DrawPriceStructureSummary(symbol, h1PriceStructure, h4PriceStructure, h1H4Alignment);
        ChartRedraw(0);
    }

    void RemoveChartObjects(const string symbol)
    {
        ObjectsDeleteAll(0, GetObjectPrefix(symbol));
    }

private:
    void DrawTimeframeSwingHistory(const string symbol, const string timeframeName,
                                   const SConfirmedSwingBar &swingHistory[], const color timeframeColor)
    {
        const string objectPrefix = GetObjectPrefix(symbol) + timeframeName + "_";
        ObjectsDeleteAll(0, objectPrefix);
        DrawSwingHistoryPoints(objectPrefix, swingHistory, timeframeName, timeframeColor);
        DrawSwingHistoryConnections(objectPrefix, swingHistory, timeframeColor);
    }

    void DrawSwingHistoryPoints(const string objectPrefix, const SConfirmedSwingBar &swingHistory[],
                                const string timeframeName, const color timeframeColor)
    {
        datetime latestSwingHighTime = 0;
        double latestSwingHighPrice = 0.0;
        datetime latestSwingLowTime = 0;
        double latestSwingLowPrice = 0.0;

        for (int swingIndex = 0; swingIndex < ArraySize(swingHistory); swingIndex++)
        {
            if (swingHistory[swingIndex].hasSwingHigh)
            {
                DrawSwingMarker(objectPrefix + "High_" + IntegerToString(swingIndex),
                                swingHistory[swingIndex].time, swingHistory[swingIndex].swingHighPrice,
                                timeframeColor);
                latestSwingHighTime = swingHistory[swingIndex].time;
                latestSwingHighPrice = swingHistory[swingIndex].swingHighPrice;
            }
            if (swingHistory[swingIndex].hasSwingLow)
            {
                DrawSwingMarker(objectPrefix + "Low_" + IntegerToString(swingIndex),
                                swingHistory[swingIndex].time, swingHistory[swingIndex].swingLowPrice,
                                timeframeColor);
                latestSwingLowTime = swingHistory[swingIndex].time;
                latestSwingLowPrice = swingHistory[swingIndex].swingLowPrice;
            }
        }

        if (latestSwingHighTime > 0)
        {
            DrawSwingLabel(objectPrefix + "LatestHighLabel", latestSwingHighTime, latestSwingHighPrice,
                           timeframeName + " latest swing high", timeframeColor);
        }
        if (latestSwingLowTime > 0)
        {
            DrawSwingLabel(objectPrefix + "LatestLowLabel", latestSwingLowTime, latestSwingLowPrice,
                           timeframeName + " latest swing low", timeframeColor);
        }
    }

    void DrawSwingHistoryConnections(const string objectPrefix, const SConfirmedSwingBar &swingHistory[],
                                     const color timeframeColor)
    {
        bool hasPreviousSwingHigh = false;
        datetime previousSwingHighTime = 0;
        double previousSwingHighPrice = 0.0;
        bool hasPreviousSwingLow = false;
        datetime previousSwingLowTime = 0;
        double previousSwingLowPrice = 0.0;

        for (int swingIndex = 0; swingIndex < ArraySize(swingHistory); swingIndex++)
        {
            if (swingHistory[swingIndex].hasSwingHigh)
            {
                if (hasPreviousSwingHigh)
                {
                    DrawSwingConnection(objectPrefix + "HighStructure_" + IntegerToString(swingIndex),
                                        previousSwingHighTime, previousSwingHighPrice,
                                        swingHistory[swingIndex].time, swingHistory[swingIndex].swingHighPrice,
                                        timeframeColor);
                }
                previousSwingHighTime = swingHistory[swingIndex].time;
                previousSwingHighPrice = swingHistory[swingIndex].swingHighPrice;
                hasPreviousSwingHigh = true;
            }

            if (swingHistory[swingIndex].hasSwingLow)
            {
                if (hasPreviousSwingLow)
                {
                    DrawSwingConnection(objectPrefix + "LowStructure_" + IntegerToString(swingIndex),
                                        previousSwingLowTime, previousSwingLowPrice,
                                        swingHistory[swingIndex].time, swingHistory[swingIndex].swingLowPrice,
                                        timeframeColor);
                }
                previousSwingLowTime = swingHistory[swingIndex].time;
                previousSwingLowPrice = swingHistory[swingIndex].swingLowPrice;
                hasPreviousSwingLow = true;
            }
        }
    }

    void DrawSwingConnection(const string objectName, const datetime previousTime, const double previousPrice,
                             const datetime latestTime, const double latestPrice, const color lineColor)
    {
        if (ObjectFind(0, objectName) < 0)
        {
            ObjectCreate(0, objectName, OBJ_TREND, 0, previousTime, previousPrice, latestTime, latestPrice);
        }
        else
        {
            ObjectMove(0, objectName, 0, previousTime, previousPrice);
            ObjectMove(0, objectName, 1, latestTime, latestPrice);
        }

        ObjectSetInteger(0, objectName, OBJPROP_COLOR, lineColor);
        ObjectSetInteger(0, objectName, OBJPROP_STYLE, STYLE_DASH);
        ObjectSetInteger(0, objectName, OBJPROP_WIDTH, 2);
        ObjectSetInteger(0, objectName, OBJPROP_RAY_RIGHT, false);
        ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);
    }

    void DrawSwingMarker(const string objectName, const datetime swingTime, const double swingPrice,
                         const color markerColor)
    {
        if (ObjectFind(0, objectName) < 0)
        {
            ObjectCreate(0, objectName, OBJ_ARROW, 0, swingTime, swingPrice);
        }
        else
        {
            ObjectMove(0, objectName, 0, swingTime, swingPrice);
        }

        ObjectSetInteger(0, objectName, OBJPROP_ARROWCODE, 159);
        ObjectSetInteger(0, objectName, OBJPROP_COLOR, markerColor);
        ObjectSetInteger(0, objectName, OBJPROP_WIDTH, 2);
        ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);
    }

    void DrawSwingLabel(const string objectName, const datetime swingTime, const double swingPrice,
                        const string label, const color labelColor)
    {
        if (ObjectFind(0, objectName) < 0)
        {
            ObjectCreate(0, objectName, OBJ_TEXT, 0, swingTime, swingPrice);
        }
        else
        {
            ObjectMove(0, objectName, 0, swingTime, swingPrice);
        }

        ObjectSetString(0, objectName, OBJPROP_TEXT, label);
        ObjectSetString(0, objectName, OBJPROP_FONT, "Arial");
        ObjectSetInteger(0, objectName, OBJPROP_FONTSIZE, 8);
        ObjectSetInteger(0, objectName, OBJPROP_COLOR, labelColor);
        ObjectSetInteger(0, objectName, OBJPROP_ANCHOR, ANCHOR_RIGHT);
        ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);
    }

    void DrawPriceStructureSummary(const string symbol, const string h1PriceStructure,
                                   const string h4PriceStructure, const string h1H4Alignment)
    {
        DrawSummaryLine(symbol, "Title", "Price Structure", 18, clrWhite, 10);
        DrawSummaryLine(symbol, "H1", "H1: " + h1PriceStructure, 36, clrDeepSkyBlue, 9);
        DrawSummaryLine(symbol, "H4", "H4: " + h4PriceStructure, 54, clrOrange, 9);
        DrawSummaryLine(symbol, "Alignment", "Alignment: " + h1H4Alignment, 72, clrWhite, 9);
        DrawSummaryLine(symbol, "Legend", "Blue: H1  Orange: H4", 90, clrWhite, 8);
    }

    void DrawSummaryLine(const string symbol, const string lineName, const string lineText,
                         const int verticalOffset, const color textColor, const int fontSize)
    {
        const string objectName = GetObjectPrefix(symbol) + "Summary_" + lineName;
        if (ObjectFind(0, objectName) < 0)
        {
            ObjectCreate(0, objectName, OBJ_LABEL, 0, 0, 0);
        }

        ObjectSetInteger(0, objectName, OBJPROP_CORNER, CORNER_LEFT_UPPER);
        ObjectSetInteger(0, objectName, OBJPROP_XDISTANCE, 12);
        ObjectSetInteger(0, objectName, OBJPROP_YDISTANCE, verticalOffset);
        ObjectSetInteger(0, objectName, OBJPROP_FONTSIZE, fontSize);
        ObjectSetInteger(0, objectName, OBJPROP_COLOR, textColor);
        ObjectSetString(0, objectName, OBJPROP_FONT, "Arial");
        ObjectSetString(0, objectName, OBJPROP_TEXT, lineText);
        ObjectSetInteger(0, objectName, OBJPROP_SELECTABLE, false);
    }

    string GetObjectPrefix(const string symbol)
    {
        return "LearningEA_" + symbol + "_";
    }
};
