# Free-Data Price-Only Strategy Design

## Purpose and limits

This is a testable demo strategy inspired by Chris Creamer's process: context, location, failed auction, confirmation, then risk-defined execution. It uses only the OHLC price bars and broker quote data available for US500 in the MetaQuotes demo account. It does not reproduce Chris's options gamma, volume profile, footprint, bid/ask order flow, or MNQ futures strategy. A failed breakout is inferred from price; participant positions are not observable.

No profitability is assumed. The EA must remain demo-only while the rules and implementation are evaluated.

## Strategy rules

### Market and data

- Instrument: `US500` on the MetaQuotes demo feed.
- Context: completed H1 and H4 candles; use the existing two-bars-on-each-side confirmed swing definition.
- Setup and confirmation: completed M5 candles only.
- Levels: previous completed broker-day high/low and previous completed broker-week high/low. Use broker timestamps consistently; never mix local London time with server time.
- Do not use the currently forming candle to confirm a swing, reclaim, or breakout.

### Deterministic setup

Evaluate each level independently, once per completed M5 candle.

1. **Context gate:** Do not take a long when both H1 and H4 are `FALLING`. Do not take a short when both are `RISING`. `MIXED` or insufficient context is recorded and produces no trade until both timeframes have enough history to classify.
2. **Location:** Price must reach a previous-day or previous-week high/low.
3. **Failed break:** For a long, an M5 candle must trade below a prior low and close back above that level. For a short, it must trade above a prior high and close back below it. The candle's extreme is the failed-break extreme.
4. **Confirmation window:** Within the next six completed M5 candles, price must close beyond a confirmed M5 swing in the reversal direction. The swing must form after the failed-break candle and use two completed candles on each side. If confirmation does not occur in six bars, expire the setup.
5. **Entry:** At the first available quote after the confirmation candle closes, request one demo market order in the reversal direction, but only if all data, quote, spread, and risk checks pass. Never enter twice for the same level and failed-break event.
6. **Stop and target:** Put the stop one symbol tick beyond the failed-break extreme. Target the nearest opposing previous-day/week level beyond entry. Skip the trade if no such target exists or projected reward is less than 1.5 times the stop distance. No averaging down, widening stops, or adding to a position.
7. **Exit:** Close on stop, target, or a configured safety shutdown. Do not invent a trailing rule in this version.

Long and short rules are mirror images. Conflicting simultaneous signals mean no trade. One open strategy position per symbol is allowed; position sizing, daily loss limit, and spread ceiling must be explicitly configured and validated before order submission. Missing or invalid risk settings block trading.

## Signal lifecycle

```text
STARTUP_CHECK
  -> WAIT_FOR_COMPLETE_DATA
  -> WAIT_FOR_LEVEL_TOUCH
  -> WAIT_FOR_FAILED_BREAK_RECLAIM
  -> WAIT_FOR_M5_SWING_CONFIRMATION (maximum 6 completed bars)
  -> RISK_AND_EXECUTION_CHECK
  -> POSITION_OPEN
  -> CLOSED
```

Any failed data, quote, trading-permission, or risk check returns to a safe no-entry state with a reason. Expired or invalidated setup state is cleared. A restart must inspect existing strategy positions and recent bars before deciding whether a setup is still valid; it must never duplicate an existing position or stale signal.

## Architecture and ownership

Each class owns one responsibility and lives in its own header. Public methods orchestrate private single-purpose methods. Strategy calculations do not submit orders or draw chart objects.

| Class | Owns | Public orchestration |
|---|---|---|
| `CLearningEA` | MT5 event lifecycle and component wiring | `Initialize`, `ProcessIncomingTick`, `ProcessTimerEvent`, `Shutdown` |
| `CMarketDataService` | Rates, quotes, time boundaries, synchronization and freshness checks | `LoadContext`, `LoadCompletedBars`, `GetCurrentQuote` |
| `CMarketContextAnalyzer` | H1/H4 confirmed swings and directional context | `Analyze` |
| `CReferenceLevelCalculator` | Previous completed day/week highs and lows | `Calculate` |
| `CFailedBreakoutDetector` | M5 level sweep and close-back-through detection | `Evaluate` |
| `CM5StructureConfirmation` | Post-sweep confirmed swing break and six-bar expiry | `Evaluate` |
| `CSetupStateMachine` | Per-level lifecycle, expiry, deduplication and reset | `ProcessBar` |
| `CTradePlanBuilder` | Entry, stop, target and projected reward/risk | `BuildPlan` |
| `CRiskGate` | Demo mode, settings, position count, sizing, daily limits and quote/spread checks | `Validate` |
| `COrderExecution` | Submit, verify, reconcile and close MT5 positions | `Open`, `Reconcile`, `Close` |
| `CPositionManager` | Stop/target monitoring and safety shutdown | `ProcessOpenPosition` |
| `CStrategyObserver` | Structured logs, chart status and event counters | `RecordEvent`, `PublishStatus` |
| `CPriceStructureVisualizer` | Draw/update/remove chart objects only | `Render`, `Clear` |

Suggested source layout:

```text
src/Include/LearningEA/
  LearningEAController.mqh
  MarketDataService.mqh
  MarketContextAnalyzer.mqh
  ReferenceLevelCalculator.mqh
  FailedBreakoutDetector.mqh
  M5StructureConfirmation.mqh
  SetupStateMachine.mqh
  TradePlanBuilder.mqh
  RiskGate.mqh
  OrderExecution.mqh
  PositionManager.mqh
  StrategyObserver.mqh
  PriceStructureVisualizer.mqh
  structures/  # one data structure per file
```

Dependencies flow from the controller to services and domain components. Detectors and plan builders receive data and return results; they do not call MT5 order functions. Only `COrderExecution` may submit or close orders, and it accepts a plan only after `CRiskGate` approves it.

## Observability requirements

Every M5 evaluation produces one concise structured event with server timestamp, symbol, bar time, context, active level, state, and outcome/reason code. Log transitions and failures, not every tick. Required reason codes include `HISTORY_NOT_READY`, `STALE_QUOTE`, `CONTEXT_BLOCKED`, `NO_LEVEL`, `NO_RECLAIM`, `CONFIRMATION_EXPIRED`, `CONFLICTING_SIGNALS`, `RISK_SETTINGS_INVALID`, `SPREAD_BLOCKED`, `POSITION_EXISTS`, `ORDER_REJECTED`, and `TRADE_OPENED`.

The chart status must show data readiness, H1/H4 context, active setup state, last decision/reason, and whether demo trading is enabled. Mark levels, failed-break candle, confirmation swing, planned entry/stop/target, and actual fills with distinct objects. If a draw call fails, log the object name and MT5 error code. Visual failure must not change the strategy decision.

## Resilience requirements

- On startup, verify demo account, symbol availability, timeframe history, broker sessions, quote freshness, and risk settings. Any failed check means observe-only mode.
- Treat `CopyRates`/`CopyTicks` short or failed reads as unavailable data; retry on timer and do not interpret missing data as a signal.
- Process each completed M5 bar once. Use bar timestamps and stable event identifiers to prevent duplicate setup transitions and orders.
- Check every trade request result and reconcile the resulting position from terminal state; a successful request call alone is not proof of a filled order.
- On disconnect, invalid prices, changed symbol settings, or restart, pause new entries, retain protective stops, reconcile open positions, then resume only after checks pass.
- Keep strategy state separate from display state so deleting/redrawing chart objects cannot create, erase, or alter a trade signal.

## Implementation sequence

1. Extract current H1/H4 analysis and four-week visualizer behind the data/context/visualizer responsibilities; add readiness and reason status. No entries.
2. Calculate and draw prior-day/week levels; verify timestamps and levels against MT5 bars.
3. Implement the failed-breakout state machine and confirmation; log and visualize signals only.
4. Replay/backtest the signal logic with completed-bar data and inspect false signals, duplicates, and restart behavior.
5. Add trade-plan and risk validation; reject any plan with missing settings or invalid stop/target.
6. Add demo-only order execution and position reconciliation, then test disconnects, rejections, spread changes, and restarts.

The current EA implements higher-timeframe swing context and its chart display only. The remaining classes and trading rules above are design, not implemented behavior.
