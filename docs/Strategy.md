# Chris Creamer's Trading Process

> Based on the original IQ Capital transcript in `docs/IQCapital.md`.

## Core idea

Chris does not start with an entry setup.

He first builds context around the trade idea, then uses the entry setup only to confirm or deny whether that idea is valid.

Practical sequence:

```text
Environment / context
        ↓
Location
        ↓
Confirmation
        ↓
Entry
        ↓
Trade management / exit
```

The entry is only the final part of the decision.

---

# A. Mental model

## A.1 Market as an auction

- The market is an auction.
- Buyers and sellers build positions while the market searches for the value of the asset.
- When buyers and sellers are comfortable:
  - A defined range can form.
  - Positions are built inside the range.
  - Value is being built.
  - Nobody is necessarily being forced to participate.

![3/240 — Balanced range can form](images/strategy-step-003-balanced-range.png)
- Chris is generally not interested in trading the balanced condition itself.
- He becomes interested when one side becomes more aggressive and starts forcing participation.

## A.2 Forced participation

- A trader whose position moves against them has limited choices:
  - Defend or add to the position.
  - Exit.
- To exit a long position:
  - The trader must sell.
- To exit a short position:
  - The trader must buy.
- Chris looks for participation near the edges of the auction that fails.
- Failed participants can become trapped / offside.
- Their exits can accelerate price in the opposite direction.

## A.3 Effort versus result

Chris keeps asking:

- Where is value being built?
- How is price moving out of it?
- Which side is making the effort?
- Is that effort producing price progression?
- Who is succeeding?
- Who is failing?

Core idea:

```text
Strong effort + expected price progression
= that side is succeeding

Strong effort + little price progression
= that side may be failing
```

## A.4 Different participants

The market contains participants with different:

- Goals.
- Sizes.
- Constraints.
- Behaviours.

Examples Chris mentions:

- Retail traders.
- Large institutions / participants that need to fill large size.

> Learning note: Liquidity means enough opposite-side orders are available to execute size without moving price too much. This definition is included for clarity; Chris does not explicitly define liquidity this way in the podcast.

---

# B. Trading process

# 1. Environment — before the market opens

Chris does this work before the market opens.

He wants scenarios prepared before price is moving quickly.

## 1.1 Classify value structure

Determine whether the market is:

- Value up.
- Value down.
- Sideways.

## 1.2 Read higher-timeframe structure

Use higher timeframes to understand what the market has been doing.

Chris specifically mentions:

- 1-hour.
- 4-hour.

He asks:

- What has the current week been doing?
- What did the previous week do?
- Are we making higher highs?
- Are we making higher lows?
- Where is value being created?
- Is value being created higher and higher?

## 1.3 Understand the gamma environment

Chris uses GEX to understand the volatility regime.

He specifically says he uses:

- Naive GEX.

For NQ-related analysis he refers to:

- QQQ.
- NDX.

Do not interpret:

- Positive gamma = bullish.
- Negative gamma = bearish.

### Positive gamma

Typical dealer behaviour:

- Sell into rips.
- Buy into dips.

Effect:

- Volatility can be dampened.
- Breakouts can fail more often.

### Negative gamma

Typical dealer behaviour:

- Buy into rips.
- Sell into dips.

Effect:

- Volatility can be amplified.
- Moves can be bigger and faster.

Negative gamma does **not** mean price must go down.

## 1.4 Mark GEX reference levels

Chris also wants to know:

- Call wall.
- Put wall.
- Gamma flip zone.

The gamma flip is the line where the environment begins moving between positive and negative gamma territory.

He does **not** primarily use these levels as automatic bounce signals.

He uses them to understand the environment.

## 1.5 Build scenarios before execution

Chris does not want to build the whole trade idea while price is moving quickly.

He wants:

> Structure before clicking buttons.

---

# 2. Location — where do I want to do business?

The second part of Chris's process is location.

His question is:

> Where do I want to do business?

## 2.1 Follow the larger structure

If the market is in a value-up structure:

- Chris generally does not want to fight that structure.
- He does not want to buy at an expensive upper edge.
- He waits for a pullback.

He also does not want to:

- Call the top.
- Call the bottom.

## 2.2 Premium and discount

Using the value area:

- Below value area = discount.
- Above value area = premium.

In a value-up structure:

- Chris prefers waiting for price to move into discount.

## 2.3 Inefficient areas

If price moved through an area very quickly:

- Little time was spent there.
- Little business was conducted there.

Chris treats this as a relatively inefficient part of the move.

## 2.4 Low-volume nodes

A low-volume node means:

- Not much volume traded there.
- Not much business was transacted there.

Chris can use this together with location.

## 2.5 Fibonacci discount zone

In the long example, Chris draws Fibonacci:

```text
Swing low
   ↓
Swing high
```

He watches:

- 0.705.
- 0.788.
- 0.886.

Together these form the zone he is interested in.

## 2.6 Fibonacci must be outside value

Chris does not want the Fibonacci zone sitting inside value.

He wants it:

- Outside the value area.
- In discount for the long example.

## 2.7 Internal structure

Chris wants a recognizable swing point before the move into discount.

He does not require something complex.

He simply wants:

- A swing point.
- Normal pullback / breathing structure.

## 2.8 0.886 invalidation

Chris treats 0.886 as very important.

If the long setup is going to work in the way he trades it:

- Buyers should regain dominance before price moves beyond 0.886.

If price goes below 0.886 and buyers cannot shift dominance back upward:

- He does not take the trade.

Chris connects this to the expected failed auction lower out of value.

## 2.9 Location is not enough

A box or level on the chart does not mean price must respect it.

Location only tells Chris:

> This is where I may want to do business.

He still needs confirmation.

---

# 3. Wait for price to reach location

Do not enter just because the setup exists conceptually.

Wait for price to reach the planned area.

At that point:

- Move from location analysis to confirmation.

---

# 4. Confirmation — order flow

Chris becomes granular only after price reaches location.

## 4.1 Execution timeframes

Chris says:

- He trades mainly on 5-minute candles.
- He looks at the hourly.
- He looks at the 15-minute.
- Sometimes he uses the 1-minute.

His order-flow confirmation is mainly described using 5-minute candles.

## 4.2 What normal candles show

A normal candlestick shows:

- Open.
- High.
- Low.
- Close.

Chris calls this the:

> Scoreboard.

It shows the result of the auction.

## 4.3 What order flow adds

Chris wants to see how that result was created.

He uses:

- Volume profile candles.
- Delta / bid-by-ask candles.

## 4.4 Long example — seller participation in discount

When price enters discount, Chris looks for seller participation at the extreme.

He wants to see things such as:

- Volume concentrated near the lower extreme / wick.
- POC at the extreme.
- Negative delta.
- Aggressive sellers.

Negative delta means:

- More aggressive sellers than aggressive buyers.

## 4.5 Seller aggression without price progression

The important question is not simply:

> Are there sellers?

The question is:

> Are aggressive sellers getting a result?

If sellers are very aggressive but price does not progress lower:

- Their effort is failing.
- This can indicate absorption.

## 4.6 Absorption is not a reversal signal by itself

Chris explicitly says:

> Absorption does not mean automatic reversal.

Absorption happens frequently.

So he waits for:

- A shift of dominance.

---

# 5. Shift of dominance

In the long example:

1. Price enters discount.
2. Aggressive sellers appear.
3. Sellers fail to create meaningful downward price progression.
4. The candle flips and closes bullish.
5. The next candle opens.
6. The next candle pulls back.
7. Sellers become aggressive again.
8. That second seller attempt fails higher.
9. Buyer aggression starts appearing.
10. Dominance shifts back toward buyers.

Only then is Chris interested in going long.

The structure is:

```text
Discount
  ↓
Aggressive sellers
  ↓
Sellers fail
  ↓
Bullish recovery
  ↓
Sellers try again
  ↓
Second failure higher
  ↓
Buyer aggression
  ↓
Shift of dominance
```

---

# 6. Footprint imbalance

Chris uses a bid-by-ask footprint.

His chart highlights an imbalance at approximately:

- 400% or more.

He explains the footprint as:

- Right side = aggressive buyers.
- Left side = aggressive sellers.

When the numbers begin lighting up strongly in the opposite direction:

- Buyer aggression is returning in the long example.

But:

- He does not enter only because the imbalance appears.
- He waits for the market to try again.
- He wants the second failure.

---

# 7. Entry

In the long example, Chris enters when:

- Price reached the correct discount location.
- Aggressive sellers appeared.
- Seller effort failed.
- Absorption was visible.
- Dominance shifted toward buyers.
- Sellers tried again.
- The second seller attempt failed higher.
- Buyer aggression returned.
- Price flipped bullish again.

The entry is only the final confirmation.

The trade idea already existed before the entry trigger.

---

# 8. Stop loss / invalidation

Chris places the stop on the other side of the failed sellers.

Reason:

- Sellers previously failed to push through the area.
- If they later push through it successfully, the trade premise is invalidated.

Mental model:

```text
Seller failure
      ↓
If sellers later succeed through that area
      ↓
Trade idea is invalid
```

---

# 9. Trapped participants after entry

If sellers entered short near the bottom and price starts rising:

- They become offside.
- They are forced to make a decision.
- To exit the short, they must buy.

That buying can accelerate the upward move.

## 9.1 Negative gamma can amplify the move

In the long example:

- Trapped shorts may be buying to exit.
- In negative gamma, dealers may also be buying into the rip.

These forces can combine and make the move faster.

---

# 10. Reclaim value

After entering the long, one of the first things Chris wants is:

- Buyers reclaim the value area.

If buyers are aggressive but cannot get back into value:

- That is a warning.

Chris may:

- Cut the trade.
- Move the stop to breakeven.

Again:

> Effort versus result.

---

# 11. Trade management

Chris keeps reading order flow while the position is open.

In a long:

- Buyer aggression should create actual upward price progression.

When buyer effort continues producing progress:

- Chris begins trailing behind that aggression.

If buyer aggression is strong but price stops progressing:

- That is a red flag.
- Price may pull back.

The same order-flow information used for entry is also used for trade management.

---

# 12. Targets

Chris usually targets swing points.

For longs:

- Previous swing highs.

For shorts:

- Previous swing lows.

He may also consider:

- POC.
- Call wall.
- Psychological levels.
- Orders clustering in the book.

He may keep a larger swing target while:

- Trailing the stop as price approaches important areas.

---

# C. Participation filters

## C.1 Selective participation

Chris considers selective participation one of the trader's biggest advantages.

You do not have to trade.

Order flow caused him to take fewer trades because he mainly uses it to filter trades out.

A typical day may contain:

- 0 trades.
- 1 trade.
- 2 trades.

He does not want to make constant back-to-back decisions because it wears down:

- Focus.
- Mental capacity.

## C.2 Volume participation filter

Chris primarily trades:

- MNQ.

He watches:

- MNQ order flow.
- 5-minute candles.

He uses approximately:

- 20,000 contracts per 5-minute candle.

When volume drops below that:

- Participation is dying.
- The environment becomes less attractive for the move he wants.

He avoids:

- Slow grinds.
- Tapering volume.
- Periods where little business is being conducted.

He says this is part of the reason he mainly trades:

- The first 1.5 hours of the New York open.

He sometimes trades:

- Asia session.

## C.3 MNQ versus NQ

Chris acknowledges that some traders tell him to use NQ order flow.

He says:

- He uses MNQ.
- It works for him.

## C.4 News filter

Chris says he would normally take his valid setup, unless something exceptional is happening.

One example he gives:

- News coming out right before price reaches the area.

So important nearby news can be a reason not to take an otherwise valid setup.

---

# D. Risk and performance characteristics

## D.1 Typical risk-to-reward

Chris says his trades often end around:

- 1.5R–2R.

He does not focus on:

- Bottom-tick entries.
- Tiny stops for screenshots.
- 10R trades.
- 20R trades.

His view:

> He wants to be right, not look cool.

Extra confirmation may reduce theoretical R, but he accepts that.

## D.2 Reported performance

Chris reports that his results typically fluctuate around:

- Win rate: 60–65%.
- Profit factor: approximately 1.8.

These are his reported results, not guarantees.

## D.3 Prop-firm context

Chris explains that 1.5R can fit prop-firm constraints.

His example:

- $2,000 drawdown.
- $3,000 profit target.

That relationship is approximately:

- 1.5R.

---

# E. Execution discipline

## E.1 A-game / B-game / C-game

Chris categorizes sessions as:

- A-game.
- B-game.
- C-game.

These categories are not based on P&L.

They are based on:

- How well he executed.

His central idea:

> Back-end optimization, not front-end optimization.

You cannot control:

- How many A+ setups appear.

You can control:

- Unnecessary losses.
- Bad decisions.
- Destructive C-game sessions.

## E.2 Good loss

A good loss means:

- The setup was valid.
- The process was followed.
- No hesitation.
- No chase.
- No FOMO.
- No premature entry.
- Execution was correct.

If the trade loses anyway:

- That is normal variance in a probabilistic environment.

## E.3 Bad trade / bad loss

A bad trade occurs when the process is bent because the trader wants to participate.

Chris's example:

- Price reaches discount.
- Seller absorption is missing.
- Dominance shift is missing.
- The trader buys anyway because they think price should rise.

That is:

- Anticipation instead of confirmation.

Even if the trade wins:

- Chris still considers it a bad trade.
- It reinforces bad behaviour.

## E.4 How C-game starts

The sequence can become:

```text
Bad trade
  ↓
Loss
  ↓
Frustration
  ↓
Trying to make money back
  ↓
More rule breaking
  ↓
Tilt
  ↓
Account damage
```

## E.5 Rules must have actions

Chris says rules such as:

- Don't overtrade.
- Don't oversize.

are not real rules by themselves.

A useful rule must be:

- Specific.
- Personal.
- Connected to an action.

## E.6 Find the breaking point

Every trader has a line where calculated decisions become emotional decisions.

Possible triggers Chris mentions:

- A certain P&L.
- Several losses.
- Several breakevens.
- Overconfidence from winning.

The trader must identify their own breaking point.

## E.7 Find what happened before tilt

The catastrophic trade is usually not where the problem started.

Something happened earlier.

Chris says to identify:

- The sequence of events that caused the behaviour.

Then:

- Build a solution before reaching that point again.

## E.8 Chris's hard limits

Chris found from his own data:

- His trades become dramatically worse after about 1.5 hours after the open.
  - He uses a hard shut-off time.

He also found:

- Three consecutive losses makes bad decision-making much more likely.

So he does not wait for the third.

His rule:

- Stop after two consecutive losses.

## E.9 Self-control

If Chris notices himself:

- Entering prematurely.
- Chasing.
- Assuming instead of observing.
- Increasing size because of frustration.

He shuts the session down.

---

# F. Learning process

## F.1 Focus on execution instead of money

Chris says his turning point came when he realized he was too focused on money.

He shifted the focus toward:

- Execution.

## F.2 Size down dramatically

Chris reduced size to:

- One micro in a prop account.

The purpose was not:

- Passing accounts.
- Getting payouts.

The purpose was:

- Getting repetitions.
- Executing correctly.

Later he describes the learning size as:

> So small it almost feels insulting.

## F.3 Proper execution makes money the byproduct

Chris's sequence:

```text
Proper execution
        ↓
Repetition
        ↓
Money becomes a byproduct
```

Not:

```text
Money target
        ↓
Emotional decisions
        ↓
Poor execution
```

## F.4 Learn market mechanics

A beginner should understand:

- The market is an auction.
- Participants have different goals.
- Participants have different sizes.
- Participants have different constraints.
- Participants behave differently.

Chris recommends learning:

- Auction market theory.
- Order flow.
- How to read the relevant charts.

## F.5 Practice with replay

Chris mentions platforms such as:

- ATAS.
- Deep Charts.

He recommends:

- Replay.
- Repetitions / reps.

## F.6 Choose one strategy

Choose a strategy that fits:

- Your strengths.
- Your weaknesses.
- Your ability to make repeated decisions.

A strategy with many setups may suit one trader and harm another.

## F.7 Stop strategy hopping

Do not move constantly from:

- One setup.
- To another setup.
- To another strategy.

Focus on one process and execute it properly.

If the strategy does not work:

- Consistent execution will reveal that.

## F.8 Adjust to regime changes

Once execution becomes consistent repetition, Chris says the next job is to keep paying attention to:

- Regime changes.
- Changes in volatility.
- Changes in market conditions.

Then:

- Adjust.

---

# G. Final operating principle

Do not focus primarily on:

> How much money did I make today?

Focus primarily on:

> How well did I trade?

Priorities:

- Execution.
- Process.
- Protecting yourself from bad behaviour.
- Repeating the correct actions.

---

# Complete process

```text
MENTAL MODEL

Market = auction
        ↓
Buyers / sellers build positions
        ↓
Aggressive participation
        ↓
Effort versus result
        ↓
Failure can create trapped participants


BEFORE MARKET OPEN

ENVIRONMENT
        ↓
Value up / value down / sideways
        ↓
1H / 4H structure
        ↓
Current week / previous week
        ↓
Naive GEX
        ↓
Positive / negative gamma volatility regime
        ↓
Call wall / put wall / gamma flip
        ↓
Build scenarios


LOCATION

Where do I want to do business?
        ↓
Premium / discount
        ↓
Inefficient area
        ↓
Low-volume node
        ↓
Fib 0.705 / 0.788 / 0.886
        ↓
Fib outside value
        ↓
Internal swing structure
        ↓
0.886 invalidation


MARKET OPENS / PRICE REACHES LOCATION

CONFIRMATION
        ↓
5-minute order flow
        ↓
Volume profile + delta / bid-by-ask
        ↓
Participation at the extreme
        ↓
Negative delta / aggressive sellers
        ↓
Seller effort fails
        ↓
Absorption
        ↓
Do not enter yet
        ↓
Shift of dominance
        ↓
Second seller failure higher
        ↓
Buyer aggression
        ↓
400%+ footprint imbalance
        ↓
Second failure confirmed
        ↓
Bullish flip


ENTRY

Enter long
        ↓
Stop beyond failed sellers


AFTER ENTRY

Watch trapped shorts
        ↓
Negative gamma may amplify squeeze
        ↓
Reclaim value
        ↓
Continue reading effort versus result
        ↓
Trail behind successful aggression
        ↓
Swing-point target
        ↓
Manage around POC / call wall / psychological levels


PARTICIPATION FILTERS

Selective participation
        ↓
MNQ 5-minute volume
        ↓
~20,000 contracts threshold
        ↓
Avoid low-participation slow grinds
        ↓
Avoid / reconsider around important nearby news


AFTER SESSION

Judge execution, not only P&L
        ↓
Good loss / bad trade
        ↓
Reduce C-game
        ↓
Rules require actions
        ↓
Find personal breaking points
        ↓
Apply hard limits
        ↓
Protect yourself from yourself


LEARNING LOOP

Very small size
        ↓
Repetitions
        ↓
Proper execution
        ↓
One strategy
        ↓
Stop strategy hopping
        ↓
Watch regime / volatility changes
        ↓
Adjust
```
