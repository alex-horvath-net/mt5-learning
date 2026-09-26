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

<details>
<summary><strong>A. Mental model</strong></summary>

# A. Mental model

## A.1 Market as an auction

- The market is an auction.
- Buyers and sellers build positions while the market searches for the value of the asset.
- When buyers and sellers are comfortable:
  - A defined range can form.
  - Positions are built inside the range.
  - Value is being built.
  - Nobody is necessarily being forced to participate.

![alt text](<images/ChatGPT Image Sep 21, 2026, 07_22_38 PM.webp>)

![alt text](<images/ChatGPT Image Sep 21, 2026, 07_36_00 PM.webp>)
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
  ![alt text](<images/ChatGPT Image Sep 21, 2026, 09_24_25 PM.webp>)
  
  ![alt text](<images/ChatGPT Image Sep 21, 2026, 09_23_09 PM.webp>)

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
![alt text](<images/ChatGPT Image Sep 21, 2026, 09_36_00 PM.webp>)

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
![alt text](<images/ChatGPT Image Sep 21, 2026, 09_41_14 PM.webp>)


</details>

<details>
<summary><strong>B. Trading process</strong></summary>

# B. Trading process

<details>
<summary><strong>1. Environment , before the market opens</strong></summary>

# 1. Environment — before the market opens

Chris does this work **before the market opens**.

The goal is to arrive with a prepared view of the environment before price starts moving quickly.

He is not trying to predict the exact trade in advance. He is building context so that, once the market opens, he already knows the kinds of conditions and locations that would make sense.

Mental model:

```text
Before market open
      ↓
Classify value structure
      ↓
Read higher-timeframe structure
      ↓
Understand gamma environment
      ↓
Mark GEX reference levels
      ↓
Build scenarios
      ↓
Only then wait for execution conditions
```

## 1.1 Classify value structure

First determine whether the market is:

- **Value up.**
- **Value down.**
- **Sideways.**

This is about where the market is repeatedly accepting price and doing business.

### Value up

Value areas are being created progressively higher.

Mental picture:

```text
Value area 1
      ↓
      Value area 2
            ↓
            Value area 3
```

That tells Chris the market is accepting progressively higher prices.

### Value down

Value areas are being created progressively lower.

```text
            Value area 1
      ↓
      Value area 2
↓
Value area 3
```

That tells him the market is accepting progressively lower prices.

### Sideways

Value is staying broadly in the same horizontal area.

The important point is not simply whether the latest candle is green or red.

Chris wants to know:

> **Where is value being built over time?**

![alt text](<images/ChatGPT Image Sep 21, 2026, 09_48_57 PM.webp>)

## 1.2 Read higher-timeframe structure

Next, Chris zooms out.

He specifically mentions:

- **1-hour.**
- **4-hour.**

The purpose is to understand what the larger auction has been doing before making a lower-timeframe decision.

He asks:

- What has the current week been doing?
- What did the previous week do?
- Are we making higher highs?
- Are we making higher lows?
- Where is value being created?
- Is value being created higher and higher?

For example, a bullish higher-timeframe structure may look like:

```text
Higher high
     ↑
Higher low
     ↑
Higher high
     ↑
Higher low
```

The important combination is not just price making higher highs.

Chris also wants to see whether **value itself is being created higher**.

So the question becomes:

> **Is the larger market structure moving higher, lower, or remaining balanced, and where is value migrating?**

This higher-timeframe view gives context to the later location decision.

![alt text](<images/ChatGPT Image Sep 21, 2026, 09_49_42 PM.webp>)

## 1.3 Understand the gamma environment

Chris also uses **GEX — Gamma Exposure** to understand the volatility regime.

He specifically says he uses:

- **Naive GEX.**

For NQ-related analysis he refers to:

- **QQQ.**
- **NDX.**

The critical rule is:

> **Positive gamma does not mean bullish. Negative gamma does not mean bearish.**

Gamma here is being used as **environment context**, especially for understanding whether market moves are more likely to be dampened or amplified.

### Learning note — what gamma is

Gamma is one of the options Greeks.

- **Delta** measures approximately how much an option price changes when the underlying moves.
- **Gamma** measures how fast that delta changes when the underlying moves.
- **GEX** aggregates gamma exposure across options positions to describe the broader hedging environment.

The strategy does not require treating gamma as a directional prediction.

### Positive gamma

Typical dealer behaviour described in the strategy:

- **Sell into rips.**
- **Buy into dips.**

That means dealer hedging tends to act **against** the move already happening.

If price rises:

```text
Price rises
    ↓
Dealers tend to sell
    ↓
Upward movement can be dampened
```

If price falls:

```text
Price falls
    ↓
Dealers tend to buy
    ↓
Downward movement can be dampened
```

Possible effect:

- volatility can be dampened
- price can behave more mean-reverting
- breakouts can fail more often

Simple memory:

> **Positive gamma behaves more like a brake.**

### Negative gamma

Typical dealer behaviour described in the strategy:

- **Buy into rips.**
- **Sell into dips.**

That means dealer hedging can act **with** the move already happening.

If price rises:

```text
Price rises
    ↓
Dealers may buy
    ↓
Buying reinforces the rise
    ↓
Move can become larger / faster
```

If price falls:

```text
Price falls
    ↓
Dealers may sell
    ↓
Selling reinforces the fall
    ↓
Move can become larger / faster
```

Possible effect:

- volatility can be amplified
- moves can become larger
- moves can become faster

Simple memory:

> **Negative gamma behaves more like an accelerator.**

Again:

> **Negative gamma does not mean price must go down.**

It means the environment can amplify movement in **either direction**.

![alt text](<images/ChatGPT Image Sep 21, 2026, 09_52_54 PM.webp>)

## 1.4 Mark GEX reference levels

Chris also wants to know:

- **Call wall.**
- **Put wall.**
- **Gamma flip zone.**

These are reference levels for understanding the options-driven environment.

### Call wall

A call wall is a significant options-positioning level associated with concentrated call exposure around a strike.

### Put wall

A put wall is a significant options-positioning level associated with concentrated put exposure around a strike.

### Gamma flip zone

The gamma flip is the area where the gamma environment begins transitioning between:

```text
Positive gamma
      ↕
Gamma flip
      ↕
Negative gamma
```

The important rule is:

> **These are context levels, not automatic bounce signals.**

Chris does not simply see a call wall, put wall, or gamma flip and enter a trade.

He uses them to understand the environment in which price is operating.

![alt text](images/image-1.webp)

## 1.5 Build scenarios before execution

Finally, Chris prepares scenarios **before** the market begins moving quickly.

He does not want to invent the entire trade idea in real time while price is accelerating.

His principle is:

> **Structure before clicking buttons.**

The preparation sequence is:

```text
Environment
    ↓
Larger structure
    ↓
Gamma regime
    ↓
Important reference levels
    ↓
Possible scenarios
```

A scenario is not a prediction that price **must** do something.

It is preparation:

```text
IF the expected condition develops
THEN I know what I will look for next.

IF it does not develop
THEN I do not force the trade.
```

The goal is to arrive at the open with a plan instead of reacting impulsively to fast price movement.

![alt text](images/image-2.webp)
---


</details>

<details>
<summary><strong>2. Location , where do I want to do business?</strong></summary>

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

![alt text](images/image-3.webp)

## 2.2 Premium and discount

Using the value area:

- Below value area = discount.
- Above value area = premium.

In a value-up structure:

- Chris prefers waiting for price to move into discount.

![alt text](images/image-4.webp)

## 2.3 Inefficient areas

If price moved through an area very quickly:

- Little time was spent there.
- Little business was conducted there.

Chris treats this as a relatively inefficient part of the move.
It matters because you can use that area as part of location analysis later.

![alt text](images/image-5.webp)
## 2.4 Low-volume nodes

A low-volume node means:

- Not much volume traded there.
- Not much business was transacted there.

Chris can use this together with location.

![alt text](images/image-6.webp)

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

![alt text](images/image-7.webp)

## 2.7 Internal structure

Chris wants a recognizable swing point before the move into discount.

He does not require something complex.

He simply wants:

- A swing point.
- Normal pullback / breathing structure.

![alt text](images/image-8.webp)

## 2.8 0.886 invalidation

Chris treats 0.886 as very important.

If the long setup is going to work in the way he trades it:

- Buyers should regain dominance before price moves beyond 0.886.

If price goes below 0.886 and buyers cannot shift dominance back upward:

- He does not take the trade.

Chris connects this to the expected failed auction lower out of value.

![alt text](images/image-9.webp)

## 2.9 Location is not enough

A box or level on the chart does not mean price must respect it.

Location only tells Chris:

> This is where I may want to do business.

He still needs confirmation.
![alt text](images/image-10.webp)

---


</details>

<details>
<summary><strong>3. Wait for price to reach location</strong></summary>

# 3. Wait for price to reach location

Do not enter just because the setup exists conceptually.

Wait for price to reach the planned area.

At that point:

- Move from location analysis to confirmation.

![alt text](images/image-11.webp)

---


</details>

<details>
<summary><strong>4. Confirmation , order flow</strong></summary>

# 4. Confirmation — order flow

Chris becomes granular only after price reaches location.

## 4.1 Execution timeframes

Chris says:

- He trades mainly on 5-minute candles.
- He looks at the hourly.
- He looks at the 15-minute.
- Sometimes he uses the 1-minute.

His order-flow confirmation is mainly described using 5-minute candles.

![alt text](images/image-12.webp)

## 4.2 What normal candles show

A normal candlestick shows:

- Open.
- High.
- Low.
- Close.

Chris calls this the:

> Scoreboard.

It shows the result of the auction.

![alt text](images/image-13.webp)
## 4.3 What order flow adds

Chris wants to see how that result was created.

He uses:

- Volume profile candles.
- Delta / bid-by-ask candles.

![alt text](images/image-14.webp)

## 4.4 Long example — seller participation in discount

When price enters discount, Chris looks for seller participation at the extreme.

He wants to see things such as:

- Volume concentrated near the lower extreme / wick.
- POC at the extreme.
- Negative delta.
- Aggressive sellers.

Negative delta means:

- More aggressive sellers than aggressive buyers.

![alt text](images/image-15.webp)

## 4.5 Seller aggression without price progression

The important question is not simply:

> Are there sellers?

The question is:

> Are aggressive sellers getting a result?

If sellers are very aggressive but price does not progress lower:

- Their effort is failing.
- This can indicate absorption.

![alt text](images/image-16.webp)

## 4.6 Absorption is not a reversal signal by itself

Chris explicitly says:

> Absorption does not mean automatic reversal.

Absorption happens frequently.

So he waits for:

- A shift of dominance.

![alt text](images/image-17.webp)

---


TesmT

---


</details>

<details>
<summary><strong>6. Footprint imbalance</strong></summary>

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


![alt text](images/image-18.webp)

---


</details>

<details>
<summary><strong>7. Entry</strong></summary>

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

![alt text](images/image-19.webp)
---


</details>

<details>
<summary><strong>8. Stop loss / invalidation</strong></summary>

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
![alt text](images/image-24.webp)
---


</details>

<details>
<summary><strong>9. Trapped participants after entry</strong></summary>

# 9. Trapped participants after entry

If sellers entered short near the bottom and price starts rising:

- They become offside.
- They are forced to make a decision.
- To exit the short, they must buy.

That buying can accelerate the upward move.

![alt text](images/image-25.webp)

## 9.1 Negative gamma can amplify the move

In the long example:

- Trapped shorts may be buying to exit.
- In negative gamma, dealers may also be buying into the rip.

These forces can combine and make the move faster.
![alt text](images/image-26.webp)
---


</details>

<details>
<summary><strong>10. Reclaim value</strong></summary>

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
![alt text](images/image-21.webp)
---


</details>

<details>
<summary><strong>11. Trade management</strong></summary>

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
![alt text](images/image-23.webp)
---


</details>

<details>
<summary><strong>12. Targets</strong></summary>

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
![alt text](images/image-20.webp)
---


</details>


</details>

<details>
<summary><strong>C. Participation filters</strong></summary>

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
![alt text](images/image-27.webp)

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
![alt text](images/image-28.webp)

## C.3 MNQ versus NQ

Chris acknowledges that some traders tell him to use NQ order flow.

He says:

- He uses MNQ.
- It works for him.
![alt text](images/image-29.webp)

## C.4 News filter

Chris says he would normally take his valid setup, unless something exceptional is happening.

One example he gives:

- News coming out right before price reaches the area.

So important nearby news can be a reason not to take an otherwise valid setup.

![alt text](images/image-30.webp)
---


</details>

<details>
<summary><strong>D. Risk and performance characteristics</strong></summary>

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
![alt text](images/image-31.webp)

## D.2 Reported performance

Chris reports that his results typically fluctuate around:

- Win rate: 60–65%.
- Profit factor: approximately 1.8.

These are his reported results, not guarantees.
![alt text](images/image-32.webp)

## D.3 Prop-firm context

Chris explains that 1.5R can fit prop-firm constraints.

His example:

- $2,000 drawdown.
- $3,000 profit target.

That relationship is approximately:

- 1.5R.
![alt text](images/image-33.webp)
---


</details>

<details>
<summary><strong>E. Execution discipline</strong></summary>

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
![alt text](images/image-34.webp)

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
![alt text](images/image-35.webp)
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
![alt text](images/image-36.webp)

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
![alt text](images/image-37.webp)

## E.5 Rules must have actions

Chris says rules such as:

- Don't overtrade.
- Don't oversize.

are not real rules by themselves.

A useful rule must be:

- Specific.
- Personal.
- Connected to an action.

![alt text](images/image-38.webp)

## E.6 Find the breaking point

Every trader has a line where calculated decisions become emotional decisions.

Possible triggers Chris mentions:

- A certain P&L.
- Several losses.
- Several breakevens.
- Overconfidence from winning.

The trader must identify their own breaking point.

![alt text](images/image-39.webp)

## E.7 Find what happened before tilt

The catastrophic trade is usually not where the problem started.

Something happened earlier.

Chris says to identify:

- The sequence of events that caused the behaviour.

Then:

- Build a solution before reaching that point again.
![alt text](images/image-40.webp)

## E.8 Chris's hard limits

Chris found from his own data:

- His trades become dramatically worse after about 1.5 hours after the open.
  - He uses a hard shut-off time.

He also found:

- Three consecutive losses makes bad decision-making much more likely.

So he does not wait for the third.

His rule:

- Stop after two consecutive losses.
![alt text](images/image-41.webp)

## E.9 Self-control

If Chris notices himself:

- Entering prematurely.
- Chasing.
- Assuming instead of observing.
- Increasing size because of frustration.

He shuts the session down.

![alt text](images/image-42.webp)

---


</details>

<details>
<summary><strong>F. Learning process</strong></summary>

# F. Learning process

## F.1 Focus on execution instead of money

Chris says his turning point came when he realized he was too focused on money.

He shifted the focus toward:

- Execution.
![alt text](images/image-43.webp)

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

![alt text](images/image-44.webp)

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
![alt text](images/image-45.webp)

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
![alt text](images/image-46.webp)
## F.5 Practice with replay

Chris mentions platforms such as:

- ATAS.
- Deep Charts.

He recommends:

- Replay.
- Repetitions / reps.

![alt text](images/image-47.webp)

## F.6 Choose one strategy

Choose a strategy that fits:

- Your strengths.
- Your weaknesses.
- Your ability to make repeated decisions.

A strategy with many setups may suit one trader and harm another.

![alt text](images/image-48.webp)

## F.7 Stop strategy hopping

Do not move constantly from:

- One setup.
- To another setup.
- To another strategy.

Focus on one process and execute it properly.

If the strategy does not work:

- Consistent execution will reveal that.
![alt text](images/image-49.webp)

## F.8 Adjust to regime changes

Once execution becomes consistent repetition, Chris says the next job is to keep paying attention to:

- Regime changes.
- Changes in volatility.
- Changes in market conditions.

Then:

- Adjust.
![alt text](images/image-50.webp)
---


</details>

<details>
<summary><strong>G. Final operating principle</strong></summary>

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

![alt text](images/image-51.webp)
---


</details>

<details>
<summary><strong>Complete process</strong></summary>

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
![alt text](images/image-52.webp)

---


</details>

<details>
<summary><strong>Case Study 01</strong></summary>

# Case Study 01

## A complete simulated session: from preparation to review

This case study follows one trader through one continuous MNQ session on **24 September 2026**, from preparation at **08:30** to the **11:00** shut-off and subsequent review. Every market observation, price, candle, volume, footprint, news-calendar entry, fill, and personal journal entry below is **invented for teaching**. This is a worked simulation, not a historical trade, backtest, forecast, or instruction to trade a live account.

Read it chronologically. At each decision, the trader knows only what has already happened. A chart labelled “known at 09:45” contains no candles from after 09:45. Later charts are deliberately withheld until the relevant stage. Clearly labelled alternative branches explore conditions that cannot coexist with the main trade. Their results never enter the main account record.

The explanation uses the strategy's sequence: context, location, waiting, confirmation, entry, invalidation, management, exit, review, and repetition. The case-study steps below have their own numbering because the source jumps from section 4.6 to section 6, with a stray `TesmT` between them. The missing source section is not reconstructed as if it were known.

![A chronological plan for preparation, confirmation, execution, and review](images/case-study-01/01-process.svg)

*Figure 1. The planned workflow. This describes the decisions to make, without revealing the trade's outcome.*

### Reading the source faithfully

The full text and all **60 embedded images** informed this example. Some illustrations add useful teaching details; some contain inconsistencies. The original material above is preserved. This case study resolves those differences explicitly:

| Source issue | Treatment in this example |
|---|---|
| Image 3 describes a pullback “within value,” while sections 2.2 and 2.6 require the long location below value. | The worked long location is entirely below the established value area. |
| The final overview image includes 0.786, while section 2.5 and image 7 specify 0.788. | Calculations use **0.705, 0.788, and 0.886**, exactly as written in section 2.5. |
| Images 10 and 11 sketch recoveries after substantial penetration below the shaded zone. | Those drawings do not override section 2.8. The main setup regains buyer dominance above 0.886; a persistent breach is an explicit no-trade branch. |
| Some overview/replay illustrations label a long's context “downtrend.” | The example distinguishes the short-term falling pullback from the larger value-up structure. It does not invent permission to buy against an established larger downtrend. |
| Some teaching images suggest range trading, breakout trading, wider stops, a 1% risk example, fixed sample sizes, or optional partial exits. | These are illustrative extensions, not additional mandatory rules. We evaluate their relevance below without replacing the stated process. |
| Image 1 depicts positive gamma above the flip and negative gamma below it. | That is the supplied model's arrangement in this simulation, not a universal rule about every options market. |
| The document does not prescribe a value-area algorithm, exact imbalance comparison, numerical risk budget, order type, stop buffer, or detailed trailing algorithm. | These are labelled **case-study assumptions** where needed. They do not become repository trading requirements. |

Descriptions of absorption, dealer hedging, trapped traders, and accumulation are interpretations. Executed prices and volumes do not identify the owners of positions. A successful illustration also cannot establish that the strategy has a statistical edge.

<a id="cs01-step-0"></a>
## Step 0. 08:30, prepare the learning session and the boundaries

The trader opens a simulated workspace for **MNQZ6**, representing the December 2026 Micro E-mini Nasdaq-100 futures contract. They use a contract-specific simulated MNQ trade feed for the candles and footprints. They do not substitute an MT5 CFD quote or tick counter for exchange contract volume.

All times are **EDT, UTC-04:00**. The chosen observation window is 09:30-11:00 EDT, corresponding to the example's New York cash-open window, not the start of the futures contract's entire trading day. A candle labelled 09:40 covers **09:40:00 up to, but not including, 09:45:00**. Its final volume and close are available only at 09:45. Before that, it is unfinished.

The instrument's arithmetic is grounded in CME specifications: MNQ is **$2 per index point per contract**, with a **0.25-point tick**, worth **$0.50**. NQ is **$20 per point**, with the same price increment, worth **$5 per tick**. These are actual contract specifications; this case study's prices and fees are simulated. Sources: [CME MNQ specifications](https://www.cmegroup.com/markets/equities/nasdaq/micro-e-mini-nasdaq-100.contractSpecs.html), [CME NQ specifications](https://www.cmegroup.com/markets/equities/nasdaq/e-mini-nasdaq-100.contractSpecs.html).

For example, a 10-point move changes one MNQ position by `10 × $2 = $20` before costs, and one NQ position by `10 × $20 = $200`. That tenfold multiplier difference does **not** imply that MNQ volume, delta, or individual footprint cells equal one tenth of NQ's. They are separate traded contracts. Today's analysis follows Chris's stated choice: MNQ order flow.

The trader writes the following setup card before seeing the opening sequence:

| Item | Explicit case-study setting |
|---|---|
| Account | Simulated USD account, starting balance $50,000; sufficient simulated buying power assumed |
| Learning size | At most one MNQ contract; no live order routing |
| Per-trade budget | At most $50 including the stated cost and slippage allowance |
| Costs | $0.75 per contract per side, $1.50 round trip; illustrative all-in transaction fees |
| Execution allowance | One tick, 0.25 point, of adverse stop slippage for sizing; actual fills recorded separately |
| Session limit | Stop new participation at 11:00, 90 minutes after 09:30 |
| Loss limit | Stop after two consecutive losses, following Chris's stated personal limit |
| Behaviour limit | Shut down new participation upon premature entry, chasing, assumption replacing observation, or frustration-driven sizing |
| Goal | Complete the process correctly; no dollar-profit quota |

These settings make this simulation reproducible. They are not recommendations for the reader's account. One micro is not automatically small enough for every stop distance. A $50 planned budget is not a guarantee that a market order can never lose more, because gaps and slippage can exceed the allowance. Margin eligibility is also separate from the loss at a stop; this example assumes the simulator has sufficient buying power rather than claiming a current broker margin requirement.

The practical action is to set the simulator's quantity to one, disable live routing, display the session clock, and prepare a journal with columns for **time, observation, interpretation, action, invalidation, and emotional state**. The trader does not enter a price order yet. Neither the eventual entry nor the failed-seller low exists at 08:30.

The trader chooses this process because they can prepare before the open and make a small number of considered decisions, but tend to become impulsive when clicking repeatedly. That is the application of F.6, choosing something compatible with one's strengths, weaknesses, tools, and decision capacity. Breakout, range, news, and rapid scalping approaches are not added merely because an attractive-looking candle appears later.

<a id="cs01-step-1"></a>
## Step 1. 08:30-08:40, establish where value is being accepted

The trader first reviews completed-session profiles, not the colour of the latest candle. A **volume profile** distributes executed volume by price. A **value area** is a chosen region of concentrated trading; it is not an objective guarantee of fair value or future support. A **POC**, point of control, is the single price with the most traded volume within the specified profile.

For this example, the supplied completed-session profiles use a 70% value-area convention. The strategy does not prescribe that percentage or the boundary-selection algorithm. We therefore treat the boundaries as explicit inputs and check the supplied totals rather than pretend that OHLC candles determine them.

| Completed reference | Value-area low | Value-area high | POC | What is visible by 08:30 |
|---|---:|---:|---:|---|
| Previous week, 17 September | 19,910 | 19,940 | 19,924 | A horizontal area of accepted prices |
| Previous week, 18 September | 19,910 | 19,940 | 19,924 | The same area again, sideways value |
| Current week, 22 September | 19,950 | 19,982 | 19,968 | Acceptance has moved upward |
| Current week, 23 September | 20,036 | 20,072 | 20,044 | Acceptance has moved upward again |

The action is to mark **20,036 as VAL**, value-area low, **20,072 as VAH**, value-area high, and **20,044 as the prior-session POC**. The interpretation is value up on these selected completed references. The trader is not claiming every session in either week is represented, or that an entire weekly composite has been calculated. These are the actual inputs to today's preparation.

![Four completed value areas with their point-of-control levels](images/case-study-01/02-value-history.svg)

*Figure 2. The two previous-week profiles overlap. The two current-week profiles migrate higher. This is evidence about repeated acceptance, not simply a rising last price.*

The trader then checks the larger price structure. The following hourly extracts are separate date blocks, not a continuous tape across the overnight gaps:

| Date and hour start | Open | High | Low | Close |
|---|---:|---:|---:|---:|
| 22 Sep 08:00 | 19,930 | 19,955 | 19,920 | 19,950 |
| 22 Sep 09:00 | 19,950 | 19,980 | 19,945 | 19,970 |
| 22 Sep 10:00 | 19,970 | 19,975 | 19,950 | 19,960 |
| 22 Sep 11:00 | 19,960 | 20,010 | 19,955 | 19,995 |
| 23 Sep 08:00 | 20,008 | 20,030 | 20,000 | 20,025 |
| 23 Sep 09:00 | 20,025 | 20,060 | 20,022 | 20,054 |
| 23 Sep 10:00 | 20,054 | 20,056 | 20,040 | 20,048 |
| 23 Sep 11:00 | 20,048 | 20,100 | 20,046 | 20,088 |
| 24 Sep 04:00 | 20,080 | 20,090 | 20,074 | 20,084 |
| 24 Sep 05:00 | 20,084 | 20,094 | 20,076 | 20,088 |
| 24 Sep 06:00 | 20,088 | 20,096 | 20,080 | 20,090 |
| 24 Sep 07:00 | 20,090 | 20,094 | 20,078 | 20,082 |

The 23 September sequence provides recognizable internal structure: an advance to **20,060**, a pullback to **20,040**, then a further advance to **20,100**. The pullback is normal breathing within a larger advance. This is more informative than drawing a Fibonacci tool on an arbitrary straight drop.

Aggregating the first four hours of 22 September gives a 4-hour bar with `O 19,930; H 20,010; L 19,920; C 19,995`. The corresponding 23 September bar is `O 20,008; H 20,100; L 20,000; C 20,088`. Both the selected high and low move higher. The current day's completed 04:00-08:00 block is `O 20,080; H 20,096; L 20,074; C 20,082`: a compact overnight balance above the older value region.

At 08:30, the trader may inspect the developing 08:00 hourly candle, but cannot use its eventual 09:00 close. That unfinished hour is excluded from the table and figure here. This prevents a common replay error: using a finished higher-timeframe candle before it actually finished.

![Consistent hourly extracts and their four-hour aggregates](images/case-study-01/03-higher-timeframes.svg)

*Figure 3. At 08:40, the upper view contains only hourly extracts completed by 08:00. The lower view aggregates each complete group of four hours. Date gaps are explicit; the unfinished current 08:00-12:00 bar is not fabricated.*

The working conclusion is: **larger value is up, while the overnight auction is locally balanced**. Balance means that repeated business is occurring within a range. It does not mean that there are literally more buyers than sellers or that nobody is hedging. Every executed contract has both sides; the relevant question is which side demands immediate execution and whether that effort moves price.

The trader writes: “Prefer a long from a lower location if sellers fail. Do not buy an expensive upper edge. Do not short merely because price looks high.” They are not predicting the top or bottom. If value starts being accepted lower and the structure changes, this preparation must be reconsidered.

**Context branch, not today's data.** If the last three supplied value areas were instead `20,036-20,072`, then `19,980-20,020`, then `19,940-19,970`, the classification would be value down. The trader would reject today's value-up long plan. A short from premium with buyer failure would be a separate mirrored interpretation, not a fully specified short system secretly added here. If the last three areas all remained `20,036-20,072`, the classification would be sideways; the trader could stand aside instead of turning a balance into a compulsory range trade. Return now to the actual supplied value-up sequence.

<a id="cs01-step-2"></a>
## Step 2. 08:40, turn context into a precise location

The prior completed upward swing runs from **20,000 to 20,100**. Its range is:

```text
Swing range = swing high - swing low
            = 20,100 - 20,000
            = 100.00 index points

Retracement price = swing high - retracement fraction × swing range
0.705 price = 20,100 - 0.705 × 100 = 20,029.50
0.788 price = 20,100 - 0.788 × 100 = 20,021.20
0.886 price = 20,100 - 0.886 × 100 = 20,011.40
```

The trader shades **20,011.40-20,029.50** as the candidate long location. Those are analytical boundaries, not all executable order prices. MNQ trades in 0.25-point increments: **20,021.25** is the nearest tradable tick to 20,021.20, while **20,011.25** is the first tick below 20,011.40. The exact theoretical levels stay on the chart. Orders will use valid ticks when an actual trade exists.

The entire zone is below VAL **20,036**. Its upper edge is `20,036 - 20,029.50 = 6.50 points` below value. That establishes **discount relative to this particular prior-session profile**. It does not mean “cheap enough that price must rise.” Above **20,072** would be premium relative to the same profile. Inside **20,036-20,072** would be within value.

The volume-at-price input makes the location more concrete:

| Prior-session price bin, lower inclusive and upper exclusive | Executed contracts |
|---|---:|
| 20,000-20,012 | 6,000 |
| 20,012-20,024 | 2,000 |
| 20,024-20,036 | 4,000 |
| 20,036-20,044 | 18,000 |
| 20,044-20,052 | 24,000 |
| 20,052-20,060 | 16,000 |
| 20,060-20,072 | 12,000 |
| 20,072-20,084 | 10,000 |
| 20,084-20,100.25 | 8,000 |
| **Total** | **100,000** |

The four value bins total `18,000 + 24,000 + 16,000 + 12,000 = 70,000`, or **70%** of the supplied 100,000-contract profile. The **20,012-20,024** bin is a low-volume node relative to its equal-width neighbours: 2,000 versus 6,000 below and 4,000 above. The 20,044-20,052 bin is a high-volume region. Because bin widths vary, the trader does not mechanically compare every bar's total without considering its width.

The exact supplied POC is **20,044**, with **4,200 contracts at that tick**, greater than any other single tick in the supplied profile. It is distinct from the aggregated 24,000-contract bin containing it. We do not claim to have reconstructed every tick of the session from this summary.

An additional simulated prior-session tape observation says price travelled from **20,012 at 08:12:00 on 23 September to 20,024 at 08:12:20**. Twenty seconds of traversal, together with the sparse volume profile, supports describing that passage as relatively inefficient. Speed alone would not prove low volume: a fast candle can also contain substantial business. The trader uses both inputs, and does not assume every thin area must be revisited.

![Prior-session volume profile and the Fibonacci location below value](images/case-study-01/04-profile-location.svg)

*Figure 4. The candidate Fib zone overlaps a low-volume area and lies wholly below value. These observations identify where to watch; they do not authorize a buy.*

The trader records an alert at **20,029.50**, marks the three retracement levels, and notes the 20,011.40 invalidation reference. There is no resting buy limit in the shaded box. They still need to see seller participation fail, buyers gain control, and a second seller attempt fail higher.

**Location branch.** Keep the same swing, but suppose the selected profile instead had value from **20,010 to 20,050**. The entire candidate Fib zone would lie within value. That would fail section 2.6 even if the Fibonacci arithmetic were perfect. The trader would discard that combination of swing and profile rather than redraw the box until it looked attractive. In the main scenario VAL remains 20,036, so the location passes this check.

<a id="cs01-step-3"></a>
## Step 3. 08:50, read gamma and prepare conditional scenarios

The simulated Naive GEX panel reports **net gamma exposure of -120 normalized model units** at 08:50. These units are deliberately not labelled dollars of real exposure. The source does not specify the provider's calculation, position-sign assumptions, or complete options dataset, so this case uses a supplied model output rather than inventing a supposedly verified Naive GEX formula.

Gamma is about how option **delta changes** as the underlying changes. For a small hypothetical move, an option with delta 0.50 and gamma 0.02 per $1 of underlying movement would have approximate delta `0.50 + 0.02 × 1 = 0.52` after a $1 rise, holding other inputs fixed. The approximation is local; gamma itself can change. This is options delta, not the footprint delta we calculate later. See the [Options Industry Council's explanation of gamma](https://www.optionseducation.org/advancedconcepts/gamma).

Under the negative dealer-gamma interpretation described in the source, a rise can require dealers to buy more of their hedge, while a fall can require selling. Positive dealer gamma can produce the opposite response, selling rises and buying falls. Neither is a bullish or bearish prediction. The trader therefore writes “movement may be amplified” rather than “negative GEX means short.”

The original strategy mentions QQQ and NDX for NQ-related analysis. QQQ is an ETF, NDX is an index, and MNQ is a futures contract. Their raw numbers are not interchangeable. This simulation uses an **NDX-derived panel** and an explicit illustrative basis conversion:

```text
08:50 simulated NDX reference = 20,050
08:50 simulated MNQ quote     = 20,070
Observed basis               = 20,070 - 20,050 = +20 points

Mapped futures reference = NDX reference level + 20
Put wall:   19,980 + 20 = 20,000
Call wall:  20,035 + 20 = 20,055
Gamma flip: 20,060 + 20 = 20,080
```

The unusual-looking strike labels and constant 20-point basis are synthetic model inputs for this lesson. They are not real listed-strike observations or a claim that one fixed adjustment remains valid all day. The simulated exposure curve and its reference levels are assumed unchanged through 10:20. The -120 reading describes the 08:50 spot; it does not remain the gamma reading at every subsequent price. In this supplied curve, prices above the mapped 20,080 flip have positive gamma, and prices below it have negative gamma. A real workflow would need a current mapping and current exposure estimate; one would not paste QQQ dollar levels directly onto an MNQ chart.

![Negative and positive gamma responses with the session's supplied reference levels](images/case-study-01/05-gamma.svg)

*Figure 5. Gamma changes how movement may be reinforced or dampened. The put wall, call wall, and flip are contextual references, not automatic entry or bounce signals.*

The call wall at **20,055** can matter later as a place to observe price response. The put wall at **20,000** does not permit buying there if the 0.886 condition has already failed. The flip at **20,080** makes the trader watch for a regime change if price moves through that area; it is not a mandatory reversal line.

At 08:55, the trader writes these conditional scenarios:

| If this develops | Next action |
|---|---|
| Value-up context persists and price reaches 20,011.40-20,029.50 | Read the five-minute footprint for seller failure and the complete confirmation sequence. |
| Price rises above value without reaching the location | Stay flat. Do not buy the upper edge or call the top. |
| Price remains balanced inside value | Stay flat under this chosen process. |
| Price passes below 20,011.40 without buyers regaining dominance | Reject this long setup. Do not keep averaging down. |
| Location is reached just before exceptional news | Reconsider participation; in the news branch below, skip the setup. |
| Contract participation fades or personal execution deteriorates | Stop pursuing new trades and record the reason. |

The main simulated calendar contains **no exceptional scheduled event in the 09:30-11:00 window**. This is a teaching assumption, not a claim about the actual economic calendar on 24 September 2026. The trader checks it now and will check it again at location and entry.

**Gamma branch.** If a fresh panel instead reported +120 units and price repeatedly returned from 20,074 to 20,068 and back, the trader would record a dampened, more mean-reverting context. They would not label it bullish, and would not keep the expectation of a fast squeeze merely because the earlier plan mentioned negative gamma. Standing aside is an available adjustment. No new main-trade order results from this branch.

<a id="cs01-step-4"></a>
## Step 4. 09:00-09:40, wait while the auction approaches the location

At 09:00, the 08:00 hourly candle finally becomes available as `O 20,082; H 20,096; L 20,070; C 20,092`. Its close is above the mapped gamma flip of 20,080, so the supplied curve now indicates positive gamma at this price. The trader records the changed context without treating it as permission to enter. They then watch the following five-minute candles arrive one at a time:

| Start | Open | High | Low | Close | Contracts | Delta |
|---|---:|---:|---:|---:|---:|---:|
| 09:00 | 20,092 | 20,100 | 20,088 | 20,096 | 10,000 | +2,000 |
| 09:05 | 20,096 | 20,098 | 20,078 | 20,082 | 12,000 | -2,000 |
| 09:10 | 20,082 | 20,088 | 20,076 | 20,086 | 11,000 | +1,000 |
| 09:15 | 20,086 | 20,090 | 20,074 | 20,078 | 14,000 | -2,000 |
| 09:20 | 20,078 | 20,080 | 20,066 | 20,070 | 16,000 | -4,000 |
| 09:25 | 20,070 | 20,072 | 20,054 | 20,058 | 18,000 | -6,000 |
| 09:30 | 20,058 | 20,064 | 20,050 | 20,054 | 32,000 | -8,000 |
| 09:35 | 20,054 | 20,056 | 20,029 | 20,030 | 30,000 | -10,000 |

Before 09:30, volume is below the source's approximate **20,000 contracts per five-minute MNQ candle** reference, and price is not at the planned location. The trader has two independent reasons to avoid forcing participation. This is contracts transacted during each individual candle, not a cumulative session total, a count of people, or MT5 tick volume.

The red 09:05 candle is followed by a rebound at 09:10. By 09:20, the 09:15 high at **20,090** has also been followed by renewed selling. That gives the pullback recognizable internal movement rather than one featureless plunge. Its close of 20,078 is now below the mapped 20,080 flip. The supplied curve again indicates negative gamma, which can reinforce a decline as well as a later rise. The trader restores that conditional amplification context, without inventing a new numerical GEX reading. Meanwhile, they do not revise the larger value-up classification merely because execution-timeframe candles are falling. Different timeframes answer different questions.

At 09:35, the 09:30 candle is complete. Its 32,000 contracts show active participation, but its low of 20,050 has not reached the zone. A buy here would be early. At about 09:39 in the simulated path, price first trades **20,029.50**. The alert sounds. The trader moves attention from the broader chart to the footprint, but still sends no order.

At **09:40**, the 09:35 candle has closed at 20,030 after reaching 20,029. Sellers have moved its close down `20,054 - 20,030 = 24 points`. Negative delta accompanies actual downward progression. This is seller effort **succeeding**, not evidence that sellers have already failed.

![Price approaches the Fibonacci zone while five-minute participation rises at the open](images/case-study-01/06-wait.svg)

*Figure 6. Only candles completed by 09:40 are shown. The final candle touches the upper edge of the location. Its successful downward movement is a reason to observe, not an automatic reason to buy.*

The trader records: “Location reached; sellers still getting a result; no absorption confirmation yet; position zero.” The next permissible step is to observe whether aggressive selling stops achieving new lower prices. If it continues through the 0.886 boundary, the long idea is rejected.

**News branch at this exact decision.** Suppose the mock calendar instead displayed a major release at 09:39, one minute before the location candle completed. The trader would mark the setup “skipped, exceptional news” and leave the order ticket inactive, even if later candles looked attractive. The source supplies no universal five-minute or fifteen-minute blackout, so none is invented. This branch ends with no trade. In the main scenario there is no such event, and observation continues.

<a id="cs01-step-5"></a>
## Step 5. 09:40-09:45, distinguish a candle's result from the activity inside it

The next completed five-minute candle is:

| Start | Open | High | Low | Close | Contracts | Delta |
|---|---:|---:|---:|---:|---:|---:|
| 09:40 | 20,030 | 20,031 | 20,014 | 20,022 | 34,000 | -10,000 |

The normal candlestick shows four facts: where the interval began, its highest trade, its lowest trade, and where it ended. It has a red body from 20,030 to 20,022 and a lower wick down to 20,014. Its total range is `20,031 - 20,014 = 17 points`; its body is `20,030 - 20,022 = 8 points`; its lower wick is `20,022 - 20,014 = 8 points`.

The trader also checks the fifteen-minute context now available at 09:45. Combining the 09:30, 09:35, and 09:40 candles gives `O 20,058; H 20,064; L 20,014; C 20,022; V 96,000; delta -28,000`. That broader candle still describes a substantial decline. Its lower wick supplies context, but does not display a completed two-failure sequence. The trader therefore keeps the five-minute view for the entry decision instead of calling the larger wick a buy signal.

Those facts show rejection from the low, but do not tell us which side initiated the trades there. Calling the wick absorption from OHLC alone would skip the very order-flow evidence this strategy asks for.

![The first failure candle with its low above the 0.886 boundary](images/case-study-01/07-absorption-candle.svg)

*Figure 7. At 09:45, the first candidate seller failure is visible. The low remains 2.60 points above the theoretical 0.886 level, but there is still no completed entry sequence.*

The independent simulated footprint supplies the missing information. “Bid sells” are trades initiated by sellers hitting available bids; “ask buys” are trades initiated by buyers lifting available asks. Each trade still has a counterparty. Negative delta means more **aggressor-sell contract volume**, not necessarily a larger number of individual sellers.

| Executed price group | Bid sells | Ask buys | Total contracts | Ask minus bid |
|---|---:|---:|---:|---:|
| 20,014.00-20,015.00 | 11,000 | 3,000 | 14,000 | -8,000 |
| 20,015.25-20,018.00 | 5,000 | 2,500 | 7,500 | -2,500 |
| 20,018.25-20,022.00 | 3,000 | 2,500 | 5,500 | -500 |
| 20,022.25-20,026.00 | 1,500 | 2,000 | 3,500 | +500 |
| 20,026.25-20,031.00 | 1,500 | 2,000 | 3,500 | +500 |
| **Total** | **22,000** | **12,000** | **34,000** | **-10,000** |

The candle's exact supplied POC is **20,014.50**, where 4,500 bid-sell contracts and 1,500 ask-buy contracts total **6,000**, the largest individual tick total in this candle. That is a **candle POC** near the lower extreme, not the prior-session POC at 20,044.

```text
Candle volume = aggressive buys + aggressive sells
              = 12,000 + 22,000 = 34,000 contracts

Candle delta = aggressive buys - aggressive sells
             = 12,000 - 22,000 = -10,000 contracts

Lower-extreme share = 14,000 / 34,000 × 100 = 41.18%
Recovery from low = 20,022 - 20,014 = 8.00 points
Distance above 0.886 = 20,014 - 20,011.40 = 2.60 points
```

![Aggressor sells and buys grouped by price inside the first failure candle](images/case-study-01/08-absorption-profile.svg)

*Figure 8. A large concentration of executed selling sits near the low. The table's totals reconcile to the candle volume and delta; this evidence is supplied separately from the candlestick.*

The simulated event sequence adds temporal detail: price first reaches 20,014 at **09:42:10**, tests that low again at **09:43:05**, and tests it once more at **09:43:40**, with no trade below it before the interval closes. The 11,000 bid-sell contracts in the lowest group are spread across those visits. By 09:44:59, the final print is 20,022. These are supplied event observations, not a sequence deduced from the candle's high and low.

Now the distinction between effort and result is useful. Sellers did make progress during the first part of the candle. The trader does not deny that. But repeated selling **at the final extreme** stopped extending the low, and price recovered eight points. That is evidence consistent with passive buyers absorbing aggressive sells. It is not proof of the buyer's identity, inventory, or ability to defend the level indefinitely.

Consider the different participants behind the same prices. A one-micro learner can choose to do nothing. A larger participant wanting 500 contracts may need to split orders because only 80 are offered at one tick and 120 at the next in an illustrative book snapshot. A hedger may buy to offset another exposure; a short-term trader may buy because momentum changed; a liquidity provider may be willing to buy falling prices. Their goals and constraints differ. The footprint shows trades, not which story belongs to each participant.

The trader writes: “Absorption candidate at 20,014-20,015; POC near low; negative delta; no buy yet.” The next requirement is a shift toward buyers, followed by a second failed seller attempt. If the passive interest disappears, price can still fall.

**Invalidation branch A.** Replace the next candle with `09:45 O 20,022; H 20,023; L 20,010.75; C 20,011; V 30,000; delta -12,000`. Price has crossed the theoretical 20,011.40 boundary, sellers are still progressing, and buyers have not regained dominance. The trader cancels the candidate. There is no “cheap enough” rescue entry at the put wall. Return to the main timeline, where the next candle is different.

<a id="cs01-step-6"></a>
## Step 6. 09:45-09:55, buyers respond and sellers try again

At **09:50**, the 09:45 candle becomes complete:

| Start | Open | High | Low | Close | Contracts | Delta |
|---|---:|---:|---:|---:|---:|---:|
| 09:45 | 20,022 | 20,025 | 20,020 | 20,024 | 28,000 | +8,000 |

Its delta implies `ask buys = (28,000 + 8,000) / 2 = 18,000` and `bid sells = (28,000 - 8,000) / 2 = 10,000`. Buyer-initiated volume exceeds seller-initiated volume and the close advances. The low of 20,020 stays above the first low of 20,014.

Selected exact footprint cells add evidence of buyer imbalance: at **20,023.25**, 500 ask-buy contracts compare with 100 bid-sell contracts one tick lower at **20,023.00**, giving `500 / 100 = 5`, or **500%**. At **20,023.50**, 650 ask buys compare with 150 bid sells at 20,023.25, giving **433.33%**. Both exceed a 4:1 reference.

For this lesson, “400% imbalance” means a **diagonal ratio of at least 4.0**, not “400% more than,” which would imply a different ratio. The source does not specify the software's comparison mode, so diagonal comparison is an explicit case-study setting. The grouped profile in Step 5 must not be used as though each group were one tick.

![The first buyer response, with the second seller test still absent](images/case-study-01/09-first-shift.svg)

*Figure 9. At 09:50 there is a buyer response and imbalance, but the strategy's second-failure condition has not yet occurred.*

The trader's hand stays off the buy button. This is a concrete application of “imbalance alone is not an entry.” They record **20,025** as the first rebound high and wait to see whether sellers can regain control. The desired next observation is a renewed seller effort that fails above 20,014. If that test never occurs and price simply runs away, this particular entry sequence may never complete.

At **09:55**, the 09:50 candle finishes:

| Start | Open | High | Low | Close | Contracts | Delta |
|---|---:|---:|---:|---:|---:|---:|
| 09:50 | 20,024 | 20,024.75 | 20,018.25 | 20,020 | 26,000 | -6,000 |

Selling has returned: `bid sells = (26,000 + 6,000) / 2 = 16,000`; ask buys are 10,000. Yet the low stops at **20,018.25**, which is `20,018.25 - 20,014 = 4.25 points` above the first failure. A supplied selected tick at 20,018.50 contains 3,200 bid sells and 800 ask buys, evidence of renewed aggressive selling near the second low. Those contracts are a subset of the candle totals, not additional volume.

![The second seller attempt holds above the first low](images/case-study-01/10-second-test.svg)

*Figure 10. The second attempt has held higher by 09:55. The trader still needs buyers to return and price to flip upward again.*

The interpretation is narrower than “the market must rise.” Sellers have failed to reach their previous extreme despite a renewed attempt. The current candle still closed down. The trader therefore records a **candidate higher second failure**, not a completed buy signal.

The concrete next condition is renewed buyer aggression accompanied by a move through the rebound high at **20,025**. Using that level to make “bullish flip” observable is an interpretation of the source's sequence, not a claim that every valid trade must use this exact breakout rule.

**Second-test branch B.** If the 09:50 candle instead printed `O 20,024; H 20,024.75; L 20,013.50; C 20,015; V 32,000; delta -12,000`, it would make a lower low, not a higher failure. Even though 20,013.50 is still above the theoretical 0.886 boundary, this specific two-failure sequence would be incomplete. The trader would not enter it. A separate future setup would need a fresh assessment. The main timeline retains the actual supplied higher low of 20,018.25.

<a id="cs01-step-7"></a>
## Step 7. 09:55-10:00, complete confirmation without looking ahead

The trader now follows the next five one-minute candles. These are extra detail inside the five-minute execution candle, not five independent signals that permit bypassing the larger sequence.

| Start | Open | High | Low | Close | Contracts | Delta |
|---|---:|---:|---:|---:|---:|---:|
| 09:55 | 20,020 | 20,021 | 20,019.75 | 20,020.75 | 4,000 | -1,000 |
| 09:56 | 20,020.75 | 20,023 | 20,020.50 | 20,022.75 | 5,000 | +1,000 |
| 09:57 | 20,022.75 | 20,025.50 | 20,022.50 | 20,025.25 | 6,000 | +2,000 |
| 09:58 | 20,025.25 | 20,027.75 | 20,025 | 20,027.50 | 7,000 | +4,000 |
| 09:59 | 20,027.50 | 20,029 | 20,027.25 | 20,028 | 8,000 | +4,000 |

The 09:55 minute initially contains net selling, but does not revisit the second low. The next minute advances. The 09:57 minute then trades above **20,025**, the first rebound high, and closes at **20,025.25**. The following two minutes continue the upward progression. This is the observed bullish flip; it is not simply a green colour on an otherwise context-free candle.

For this case, the trader deliberately waits for the **five-minute close** before submitting an order. That is a timing assumption chosen to make the evidence and volume filter reproducible. The source describes five-minute execution but does not prescribe this exact close-only trigger for every implementation.

At **10:00**, the aggregate is:

```text
Open  = first one-minute open = 20,020
High  = maximum high         = 20,029
Low   = minimum low          = 20,019.75
Close = final minute close   = 20,028
Volume = 4,000 + 5,000 + 6,000 + 7,000 + 8,000 = 30,000
Delta  = -1,000 + 1,000 + 2,000 + 4,000 + 4,000 = +10,000
```

The candle's total ask buys are `(30,000 + 10,000) / 2 = 20,000`; bid sells are **10,000**. Its close has advanced eight points from its open, and is three points above the first rebound high. Participation remains above the approximate 20,000-contract reference.

The fifteen-minute interval starting at 09:45 also completes now: `O 20,022; H 20,029; L 20,018.25; C 20,028; V 84,000; delta +12,000`. Its low is 4.25 points above the preceding fifteen-minute low, and its close has recovered. That supports the recovery interpretation, while the five-minute sequence and one-minute detail explain how it developed. The still-open 09:00 hourly candle is not used until its completion at 10:00; its newly available full-hour summary can describe the larger decline, but cannot erase the actual lower-timeframe evidence.

![The entire confirmation sequence visible at 10:00, before any later candle](images/case-study-01/11-confirmation.svg)

*Figure 11. First failure at 20,014, buyer response, second failure at 20,018.25, and renewed buying through 20,025. None of the post-entry outcome is visible.*

Selected exact tick rows inside the 09:55 candle are:

| Price | Bid sells, left side | Ask buys, right side | Diagonal buy comparison |
|---|---:|---:|---|
| 20,028.00 | 250 | 900 | `900 / 200 = 4.50 = 450%` |
| 20,027.75 | 200 | 650 | `650 / 150 = 4.3333 = 433.33%` |
| 20,027.50 | 150 | 500 | `500 / 100 = 5.00 = 500%` |
| 20,027.25 | 100 | 300 | Lower comparison tick not shown |

Each numerator is ask-buy volume at the stated price. Each denominator is bid-sell volume **one tick lower**. The rows are only an excerpt: their bid total is 700 and their ask total is 2,350, leaving **9,300 bid sells and 17,650 ask buys** elsewhere in the candle. The excerpt does not pretend to be the entire 30,000-contract footprint.

![One-minute confirmation candles beside exact footprint cells and diagonal ratios](images/case-study-01/12-footprint-and-one-minute.svg)

*Figure 12. The one-minute candles reconcile exactly to the five-minute candle. The footprint supplies separate evidence of buyer aggression; the chart alone cannot supply those numbers.*

The trader now checks the complete sequence in order: value-up context; discount outside value; seller participation at the low; stalled seller progression; absorption evidence; initial buyer response; a second seller attempt; a higher second low; renewed buyer aggression; and a bullish flip. The news check remains clear in the simulation. The loss counter is zero. The clock is 10:00, within the chosen session window.

The decision is **eligible to enter, subject to risk and order checks**. Eligibility is not certainty. The same evidence could precede a loss, which is why the next step specifies exactly where this trade becomes wrong.

<a id="cs01-step-8"></a>
## Step 8. 10:00, calculate risk and submit one coherent order plan

Before sending the entry, the trader identifies the failed-seller extreme at **20,014**. For this example the protective stop trigger is one tick below it:

```text
Stop trigger = first failed-seller low - one tick
             = 20,014.00 - 0.25
             = 20,013.75
```

The one-tick buffer is a case-study choice, not a universal stop rule. The structural reason comes from the source: if sellers now succeed below the region where they failed, the trade premise has weakened. This stop is **above** the deeper theoretical 0.886 boundary of 20,011.40. The two levels serve different purposes: 0.886 filtered the setup before entry; the failed-seller structure locates the actual trade's protective stop. They need not be identical.

The completed confirmation candle last traded at **20,028.00**. The simulated quote at submission is **20,028.00 bid / 20,028.25 ask**, a one-tick spread. The trader uses an illustrative buy limit at the ask, 20,028.25, and the simulator fills one contract immediately at that price. This is a marketable limit in the stated quote, not a promise of a fill if the ask moves away. If it remained unfilled, the trader would reassess rather than chase it automatically.

Before submission, the trader's bracket specifies a one-contract protective sell stop at **20,013.75** and a one-contract profit-taking limit at the previously identified hourly swing **20,060**. The simulator attaches the exits to the filled entry and treats them as one-cancels-the-other. This order-handling behaviour is a simulation assumption; it is not an implementation claim about MT5 or a particular broker.

The sizing calculation uses the proposed fill price before the order is sent, then checks the actual fill:

```text
Price distance to stop = 20,028.25 - 20,013.75 = 14.50 points
Tick distance          = 14.50 / 0.25 = 58 ticks
Price risk per micro   = 14.50 × $2 = 58 × $0.50 = $29.00

Stop slippage allowance = 0.25 × $2 = $0.50
Round-trip fees          = $0.75 + $0.75 = $1.50
Stressed loss per micro  = $29.00 + $0.50 + $1.50 = $31.00

Budget-based quantity = floor($50 / $31.00)
                      = floor(1.6129) = 1 whole contract
Learning-size cap      = 1 contract
Submitted quantity     = min(1, 1) = 1
Unused planned budget  = $50 - $31 = $19
```

Rounding down matters. Two contracts would require `2 × $31 = $62`, exceeding the illustrative $50 budget. The trader does not tighten the structural stop to squeeze two contracts into the budget. They also do not change to NQ just to make the dollar result larger. At the same 14.50-point distance, one NQ would have **$290 price risk before costs**, which already exceeds this budget.

![Entry, structural stop, value-reclaim level, and the existing swing target](images/case-study-01/13-entry-risk.svg)

*Figure 13. The trade plan at entry, with no future candles. Risk is defined from the actual planned execution price, not from an imaginary fill at the bottom wick.*

The trader defines two denominators to avoid ambiguous R reporting:

- **Price-risk R:** `$29.00`, the initial entry-to-stop risk before fees and stop slippage.
- **Stressed cost-inclusive risk:** `$31.00`, the planned loss if the assumed one-tick stop slippage and round-trip fees occur.

Later performance will state which denominator is used. Neither denominator changes merely because the stop is trailed upward.

The planned structural target gives:

```text
Gross target distance = 20,060 - 20,028.25 = 31.75 points
Gross target profit   = 31.75 × $2 = $63.50
Gross reward / price risk = $63.50 / $29.00 = 2.1897R
Net target profit if filled there = $63.50 - $1.50 = $62.00
Net target profit / stressed risk = $62.00 / $31.00 = 2.0000
```

The prior-session POC at 20,044, round number at 20,050, and mapped call wall at 20,055 are intermediate references. They do not replace the structural target automatically. The source's typical 1.5R-2R outcomes are descriptions of reported results, not a command to place every target exactly two stops away.

Waiting has a visible numerical cost. An **unconfirmed hypothetical** buy at 20,021.25 with the same 20,013.75 stop and 20,060 target would show `(20,060 - 20,021.25) / (20,021.25 - 20,013.75) = 38.75 / 7.50 = 5.1667` gross reward-to-risk. That attractive fraction does not make the earlier entry valid. It lacked the completed second failure and bullish flip. The trader accepts less theoretical upside per unit of stop distance in exchange for following the required sequence; this example does not quantify any increase in win probability.

At **10:00:00**, the entry fills at **20,028.25**. The trader checks the fill notification, quantity one, stop acknowledgement, and target acknowledgement. The position is now real within the simulation. The protective order is active; there is no adding to the position, no widened stop, and no attempt to recoup a hypothetical earlier missed opportunity.

<a id="cs01-step-9"></a>
## Step 9. 10:00-10:05, demand evidence that buyers can reclaim value

The first post-entry candle finishes at 10:05:

| Start | Open | High | Low | Close | Contracts | Delta |
|---|---:|---:|---:|---:|---:|---:|
| 10:00 | 20,028 | 20,040 | 20,027.75 | 20,038 | 36,000 | +12,000 |

The candle opens one tick below the order's ask-side fill. That is not inconsistent: candle prices are executed trades, while the entry paid the available ask. In the supplied event sequence, the low of 20,027.75 occurs after the fill and before the advance. The trader's initial adverse movement is therefore only `20,028.25 - 20,027.75 = 0.50 point`, or **$1 before costs**. This fact is observed after it happens; it was not assumed during sizing.

At 10:05, buyers have lifted the close above VAL **20,036** to **20,038**. The reclaim is `20,038 - 20,036 = 2 points` above the lower edge of value. The candle's ask-buy volume is `(36,000 + 12,000) / 2 = 24,000`; bid sells are 12,000. Here buyer effort accompanies a ten-point rise from the candle's open. The required result is appearing.

![The first post-entry candle closes back inside the prior value area](images/case-study-01/14-reclaim.svg)

*Figure 14. At 10:05 the close is inside value, and participation remains active. A new stop is decided now, not retroactively applied to the preceding candle.*

The trader moves the stop to **20,027.50**, one tick below the completed successful candle's low of 20,027.75. The exact one-tick-below-completed-low trail is a case-study management convention used when buyer effort produces progress. It makes the discretionary phrase “trail behind successful aggression” reproducible; it is not claimed as Chris's universal algorithm.

The new stop becomes effective at **10:05**. It is still **0.75 point below the entry**, so the trader does not incorrectly call the position risk-free. At the trigger price the gross result would be `-0.75 × $2 = -$1.50`; with the assumed one-tick slippage and $1.50 fees, the possible realized result would be **-$3.50**. The target remains 20,060.

Why might the rally be fast? Suppose one hypothetical short sold at the first candle POC, **20,014.50**. At a price of 20,038, that short is `20,038 - 20,014.50 = 23.50 points` offside, or **-$47 per micro before costs**. To close the short, the participant must buy. They could instead keep holding or defend the position; the footprint does not prove that they have been forced out. If some shorts do cover while dealers also buy hedges in a negative-gamma environment, their buying can add to other demand.

![Observed buying separated from possible short covering and dealer hedging](images/case-study-01/15-participants.svg)

*Figure 15. The observed facts are volume, delta, and price progression. Short covering and dealer hedging are possible mechanisms, not participant identities revealed by the candles.*

The symmetric mechanism also matters. A hypothetical trader long from the earlier premium price **20,092** would be down `(20,038 - 20,092) × $2 = -$108` on one micro at this moment. Closing that long requires a **sell**. The same market can contain short covering, long liquidation, new speculation, and hedging simultaneously. The case-study trader does not need to identify every participant to compare observable effort with observable result.

**Failed-reclaim branch C.** Replace the 10:00 candle with `O 20,028; H 20,035.75; L 20,027.75; C 20,030; V 36,000; delta +12,000`. The same aggressive-buying total now fails to get even one tick into value at 20,036. At 10:05, the trader elects the source's discretionary “cut the trade” response. Assume a bid of 20,029.75 and an exit there: `(20,029.75 - 20,028.25) × $2 - $1.50 = +$1.50 net`. This modest result belongs only to the branch.

The source also mentions moving the stop to breakeven. A stop trigger at the entry price would be **price breakeven**, not cost breakeven. With a one-tick adverse fill and $1.50 fees, it would lose `$0.50 + $1.50 = $2.00`. Under these particular assumptions, a trigger one point above entry, **20,029.25**, followed by a fill at 20,029.00, would produce `$1.50 gross - $1.50 fees = $0 net`. That calculation is not an instruction to move a stop there without structural reason. Return to the main trade, where value was successfully reclaimed.

<a id="cs01-step-10"></a>
## Step 10. 10:05-10:15, manage progress rather than an arbitrary profit number

The next two candles arrive:

| Start | Open | High | Low | Close | Contracts | Delta |
|---|---:|---:|---:|---:|---:|---:|
| 10:05 | 20,038 | 20,046 | 20,036.50 | 20,044 | 32,000 | +10,000 |
| 10:10 | 20,044 | 20,054 | 20,043 | 20,053 | 30,000 | +8,000 |

At **10:10**, the first candle has held above VAL, with a low of **20,036.50**, and closed at the prior-session POC **20,044**. Buyer-initiated volume is 21,000 contracts and seller-initiated volume is 11,000. The close advances six points. This is continued success, so the trader trails the stop to `20,036.50 - 0.25 = 20,036.25`, effective now.

At **10:15**, the next candle has advanced nine points from 20,044 to 20,053. It traded through the psychological round number **20,050**, rather than automatically reversing there. The trader does not take that round number as proof of resistance. They check what price and executed volume actually did. Ask buys are 19,000 and bid sells are 11,000.

The completed candle's low is **20,043**, so the stop becomes **20,042.75**, effective at 10:15. The trader leaves the structural target at 20,060. The mapped call wall at 20,055 is now nearby, but it is still only a reason to pay attention.

![Successful buying moves through the POC and round number while the stop follows structure](images/case-study-01/16-management.svg)

*Figure 16. At 10:15, the trail is supported by completed candles that made upward progress. The future response to the call wall is not yet known.*

Notice what the trader does **not** do with the profit number. They do not move the stop downward to avoid a small loss earlier, or upward every tick simply because the unrealized balance feels exciting. The changes occur at specific completed evidence points. The protective orders are checked after each amendment, and quantity remains one.

The source's final overview mentions optional partial exits. With **one indivisible futures contract**, the trader cannot sell half a contract and retain a runner. They therefore keep the entire one-contract position under the same stop and target. A multi-contract scaling plan would require different sizing and explicit rules; it is not smuggled into this one-micro learning example.

A larger target can coexist with intermediate management. The trader can still intend 20,060 while protecting the trade below the successful buyers. A target is an intended exit opportunity, not a promise that the market must provide it.

<a id="cs01-step-11"></a>
## Step 11. 10:15-10:20, recognize buyer effort that stops producing the same result

At **10:20**, the next candle closes:

| Start | Open | High | Low | Close | Contracts | Delta |
|---|---:|---:|---:|---:|---:|---:|
| 10:15 | 20,053 | 20,055.25 | 20,053 | 20,054 | 34,000 | +12,000 |

Buyer delta has increased from +8,000 in the prior candle to **+12,000**, a `4,000 / 8,000 × 100 = 50%` increase. Yet the candle's close advances only **one point**, compared with nine points in the prior candle. Its high exceeds the previous high by only `20,055.25 - 20,054 = 1.25 points`. More aggressive buying is producing much less progression.

This is the same effort-versus-result question used at the low, now applied to the winning long. It is a warning about the current auction, not proof that a bearish reversal is inevitable. The trader does not need to call the top to respond to weakening progress.

At 10:19, the supplied order-book snapshot showed the following resting ask quantities:

| Ask price | Displayed contracts |
|---|---:|
| 20,054.75 | 180 |
| 20,055.00 | 900 |
| 20,055.25 | 1,100 |
| 20,055.50 | 220 |

The clustering around 20,055 overlaps the mapped call wall. Resting orders can be cancelled or replenished; displayed depth is not executed volume and does not prove that all those contracts traded. The completed candle and its delta are the separate evidence that considerable buying has just produced little additional progress.

![Price stalls near the mapped call wall despite increased positive delta](images/case-study-01/17-stall.svg)

*Figure 17. Known at 10:20: the structural target is still unreached, the latest low is 20,053, and upward progress has slowed. No future stop-out candle appears here.*

The trader's action is to tighten the trail to **20,052.75**, one tick below the latest completed low. The trailing convention remains the same; the stall explains why protecting this latest structure matters. The change is acknowledged at 10:20. The profit-taking limit at 20,060 remains in place.

If buyers resume successfully, the trade can continue. If price moves below 20,052.75, the stop exits. The trader does not widen the stop to “give it another chance,” cancel the target in anticipation of a huge squeeze, or add contracts because the trade is profitable.

<a id="cs01-step-12"></a>
## Step 12. 10:20-10:25, record the actual exit and reconcile every dollar

The next interval unfolds through these selected simulated prints:

| Time | Executed price | What happens |
|---|---:|---|
| 10:20:00 | 20,054.00 | Interval begins; stop 20,052.75 is already active. |
| 10:20:40 | 20,054.50 | A small attempted push fails to exceed the prior high. |
| 10:21:00 | 20,053.50 | Price retreats. |
| 10:21:19 | 20,052.75 | Stop trigger is reached. |
| 10:21:20 | 20,052.50 | One-contract sell fills one tick below the trigger. |
| 10:23:00 | 20,050.00 | Subsequent low, observed while flat. |
| 10:24:59 | 20,051.00 | Final print of the candle. |

These prints establish the order of events that OHLC alone could not establish. The simulator's stop is triggered by a trade at the specified price. The assumed fill follows at 20,052.50. A different real broker's trigger convention or execution conditions could differ; this is the convention used for this calculation.

![Selected exit prints showing the stop trigger followed by the actual fill](images/case-study-01/18-exit-tape.svg)

*Figure 18. Retrospective event detail. The fill is not assumed equal to the stop trigger, and no later candle is used to improve the recorded exit.*

After receiving the exit fill, the trader verifies **position zero** and cancellation of the paired 20,060 target. An orphaned target order would be a new risk; it is not left working after the position closes. The main trade is finished at 10:21:20.

The completed 10:20 candle is `O 20,054; H 20,054.50; L 20,050; C 20,051; V 24,000; delta -6,000`. The trader does not claim to have known its final low when they tightened the stop at 10:20.

```text
Actual entry                  = 20,028.25
Actual exit                   = 20,052.50
Points captured               = 20,052.50 - 20,028.25 = 24.25
Ticks captured                = 24.25 / 0.25 = 97
Gross profit                  = 24.25 × $2 × 1 = $48.50
Round-trip fees                = $1.50
Net profit                    = $48.50 - $1.50 = $47.00
Ending simulated balance      = $50,000 + $47 = $50,047.00

Net profit / initial price risk = $47 / $29 = 1.6207R
Net profit / stressed risk      = $47 / $31 = 1.5161
```

The spread and exit slippage must not be deducted twice. The entry already paid 20,028.25 rather than the bid of 20,028.00. The exit already received 20,052.50 rather than the stop trigger of 20,052.75. Those execution effects are embedded in the fill-to-fill calculation. Only the separate $1.50 fees remain to subtract.

For reconciliation, the hypothetical bid-reference-to-stop-trigger move is `(20,052.75 - 20,028.00) × $2 = $49.50`. The entry's extra tick costs $0.50 and the exit's adverse tick costs another $0.50, leaving **$48.50 gross**, then **$47 net**. This is a diagnostic comparison, not an alternative P&L to add to the account.

![The complete trade with entry, exit, and chronologically effective stop changes](images/case-study-01/19-trade-review.svg)

*Figure 19. Retrospective overview. The stop rises only after the relevant evidence becomes available. The 20,060 structural target was never reached during this trade.*

The full order record is:

| Effective time | Action | Price | Quantity | Reason |
|---|---|---:|---:|---|
| 10:00:00 | Buy filled | 20,028.25 | 1 | Full two-failure confirmation completed |
| On fill | Initial protective stop active | 20,013.75 | 1 | One tick beyond first failed sellers |
| On fill | Target limit active | 20,060.00 | 1 | Previously identified hourly swing |
| 10:05 | Stop amended | 20,027.50 | 1 | Successful value reclaim; low 20,027.75 |
| 10:10 | Stop amended | 20,036.25 | 1 | Value holds; low 20,036.50 |
| 10:15 | Stop amended | 20,042.75 | 1 | Successful advance; low 20,043 |
| 10:20 | Stop amended | 20,052.75 | 1 | Latest low 20,053; progress slowing |
| 10:21:20 | Sell filled | 20,052.50 | 1 | Trailing stop triggered, one tick slippage |
| Immediately after exit | Paired target cancelled; position checked flat | n/a | 0 | Trade complete |

The smallest post-entry traded price was 20,027.75. **Maximum adverse excursion**, MAE, was therefore 0.50 point or $1 before costs. The highest was 20,055.25. **Maximum favourable excursion**, MFE, was `20,055.25 - 20,028.25 = 27 points`, or **$54 before costs**. These review measurements describe this path; they are not new exit rules. The difference between gross MFE and actual gross profit is `$54 - $48.50 = $5.50`. Keeping every favourable tick would have required foresight the trader did not have.

<a id="cs01-step-13"></a>
## Step 13. 10:25-11:00, finish the session without manufacturing another trade

The trader remains flat and observes participation tapering:

| Start | Open | High | Low | Close | Contracts | Delta |
|---|---:|---:|---:|---:|---:|---:|
| 10:25 | 20,051 | 20,052 | 20,048 | 20,049 | 21,000 | -3,000 |
| 10:30 | 20,049 | 20,051 | 20,048.50 | 20,050 | 18,000 | +2,000 |
| 10:35 | 20,050 | 20,050.75 | 20,049 | 20,050.25 | 16,000 | +1,000 |
| 10:40 | 20,050.25 | 20,051 | 20,049.50 | 20,050 | 14,000 | -1,000 |
| 10:45 | 20,050 | 20,050.75 | 20,049.75 | 20,050.25 | 12,000 | +1,000 |
| 10:50 | 20,050.25 | 20,050.50 | 20,049.75 | 20,050 | 10,000 | 0 |
| 10:55 | 20,050 | 20,050.50 | 20,049.50 | 20,050.25 | 9,000 | +1,000 |

At 10:35, the first sub-20,000 candle is complete. By 10:45, the sequence has fallen from 21,000 to 18,000 to 16,000 to 14,000. Price is also moving sideways around 20,050 rather than presenting a new discount test. The trader records a **local transition from expansion to a low-participation balance**. That is not enough to declare that the entire higher-timeframe uptrend has reversed.

![Five-minute volume fades below the participation reference as price becomes balanced](images/case-study-01/20-volume-fades.svg)

*Figure 20. The trader adapts by withholding new entries. A quiet grind does not become an attractive setup merely because the session has produced only one trade.*

At 10:45, the trader notices the thought, “The first trade worked; perhaps I should use two contracts next time.” They record it as a potential **win-driven overconfidence trigger** and leave the quantity at one. An emotional urge is not itself a completed rule violation, but it is useful evidence for personal review. If they begin increasing size, chasing, or replacing observation with assumptions, the stated shutdown response applies.

At **11:00**, `09:30 + 90 minutes = 11:00`, the trader stops new participation and closes the simulated order-entry panel. They are already flat, so this case does not invent an unspecified rule for a position still open at the shut-off. Protective management should never be abandoned merely because new entries are disabled; the exact treatment of an existing position at that boundary would need its own explicit policy.

The main session contains **one executed trade**. Several moments were examined and rejected or deferred: premium prices, insufficient pre-open participation, first arrival without failure, absorption without the second test, imbalance without the second test, and the later low-volume balance. Zero trades would also have been a valid day if confirmation never completed. The source's zero, one, or two trades is descriptive, not a quota or mandatory maximum of two total trades.

Chris sometimes mentions trading Asia. That does not require this learner to reopen a second session to obtain more repetitions. The practical action today is to finish the journal and review this single session. More decisions are not automatically better practice.

<a id="cs01-step-14"></a>
## Step 14. After the session, test alternative outcomes and grade execution

### A valid trade could have lost

Return mentally to **10:00**, using exactly the information available at entry. The same context, location, two seller failures, and buyer confirmation existed. Now consider **branch D**, an alternative continuation that replaces the main 10:00 candle:

`O 20,028; H 20,029; L 20,013.50; C 20,014; V 38,000; delta -16,000`.

In this supplied alternative event path, price prints 20,029 at 10:00:20, then falls to the stop trigger **20,013.75 at 10:02:00** and fills the sell at **20,013.50 at 10:02:01**. No value reclaim or trailing amendment has yet occurred. The loss is:

```text
Gross loss = (20,013.50 - 20,028.25) × $2 = -$29.50
Net loss   = -$29.50 - $1.50 = -$31.00
Net loss / stressed initial risk = -$31 / $31 = -1.0000
Net loss / initial price risk    = -$31 / $29 = -1.0690R
```

That is a **good loss** in the source's sense if the trader entered without hesitation, used the planned size and stop, and accepted the invalidation. It is not “good” because losing money is desirable. It is correctly executed uncertainty. The loss does not retrospectively erase the evidence that existed at entry.

![Four separately labelled alternative continuations of the same decision points](images/case-study-01/21-alternative-branches.svg)

*Figure 21. Branches A-D replace specific candles; they are not additional main-session trades. A fails the 0.886 condition, B lacks the higher second failure, C fails to reclaim value, and D loses after a valid entry.*

### An invalid entry could have won

At the earlier **09:40** decision, an impulsive trader could have bought at an assumed **20,030.25** before absorption or buyer dominance was established. Suppose, purely to isolate decision quality, that this unapproved position later received the main scenario's exit price of 20,052.50. Its arithmetic would be `(20,052.50 - 20,030.25) × $2 - $1.50 = +$43.00`. The favourable outcome would not supply the missing entry evidence.

Conversely, if that premature buy used the later stop fill 20,013.50, it would lose `(20,013.50 - 20,030.25) × $2 - $1.50 = -$35.00`. Both alternatives begin with the same process violation. Neither belongs in the main record. Rewarding the profitable one as “good execution” would encourage taking the next unconfirmed entry.

### Turn discipline into actions

For this learner, “do not oversize” becomes: **if the ticket exceeds one contract, do not submit it; restore one and recheck the budget**. “Do not overtrade” becomes: **if the clock reaches 11:00 or two consecutive losses have closed, disable new entries**. These actions are observable. They are more useful than promising to be disciplined while leaving every click unconstrained.

The two-loss rule is also demonstrated without adding extra main trades. Suppose the simulated journal entering branch D already contained one earlier correctly executed **-$28** trade. Branch D's **-$31** result would make **two consecutive losses**, with session P&L `-$28 - $31 = -$59`. The trader stops at 10:02:01. The trigger is two losses, not reaching -$59 and not waiting for a third. These are an alternative starting journal and alternative outcome; the main day still began with zero losses and ended with one winner.

An escalation drill makes the breaking point concrete. After that second loss, imagine the trader thinks, “Three micros will recover $59 faster,” and changes a draft ticket from one to three. At the same $31 stressed loss per micro, three would expose **$93**, exceeding the $50 budget. The first useful intervention is the changed decision at the ticket, before another trade is sent. The trader cancels the draft and ends the session. If they instead submitted it and lost another $93, the hypothetical damage would become `-$59 - $93 = -$152`. That damage is an avoidable branch, not an inevitable consequence of taking a loss.

The same review searches for quieter triggers: several nominal breakevens that still incur costs, a particular P&L level, impatience after missing a move, or overconfidence after a win. There is no universal personal breaking-point dollar number in the source. The learner's 10:45 thought is recorded so later sessions can show whether it becomes a recurring pattern.

![Behavioural warning signs linked to concrete shutdown and review actions](images/case-study-01/22-discipline.svg)

*Figure 22. The intervention connects a recognizable behaviour to an action. Losses are not automatically C-game; abandoning the process is the problem.*

### Grade what was controllable

The main session receives an **illustrative A-game execution grade** because the plan was followed, not because it earned $47. The source gives the A/B/C distinction but no formal numerical grading rubric. Here is the evidence supporting the assessment:

| Review question | Main-session evidence | Assessment |
|---|---|---|
| Was context prepared first? | Completed value profiles and higher-timeframe extracts were reviewed before the open. | Followed |
| Was the long location outside value? | Zone upper edge 20,029.50 was below VAL 20,036. | Followed |
| Was entry premature? | No position at 09:40, 09:45, 09:50, or 09:55. | Followed |
| Was the complete confirmation observed? | Higher second low 20,018.25, renewed buying, break of 20,025, five-minute close. | Followed |
| Was size linked to the budget? | One contract, $31 stressed loss, within $50. | Followed |
| Was the stop widened? | Stop prices only increased after entry. | Followed |
| Did management use evidence? | Value reclaim, continued progression, then buyer effort with reduced result. | Followed |
| Were execution costs recorded honestly? | Ask-side entry, adverse exit tick, and $1.50 fees included once. | Followed |
| Were time and participation limits respected? | No new trade during fading volume; flat at 11:00. | Followed |
| Was emotional information recorded? | Win-driven size-increase thought noted at 10:45; no oversized order sent. | Followed |

A **B-game branch** would be hesitating after the complete 10:00 confirmation until price reaches 20,038, then missing the planned entry but refusing to chase. That contains an execution weakness even if another planned trade later wins. A **C-game branch** would be buying without confirmation or increasing size to recover losses, even if the resulting trade happened to profit. These labels describe behaviour, not a ranking of daily P&L.

What can improve? The journal should retain the footprint comparison setting alongside each screenshot, because “400%” without its denominator is ambiguous. The illustrative basis mapping should be replaced with a documented current mapping in any future real-data study. The trader should review whether the one-tick trail produces excessive exits over a broader sample; this single successful outcome cannot settle that question. These are recorded research tasks, not mid-session changes to the strategy.

<a id="cs01-step-15"></a>
## Step 15. Review performance without confusing a trade with a track record

The source reports a 60-65% win rate and profit factor near 1.8. This case study does not verify Chris's personal performance or transfer those figures to the learner. To demonstrate the arithmetic coherently, suppose the **same simulated learner's separate prior journal** held 99 earlier practice trades: 59 gross winners totalling **$7,151.50**, and 40 gross losers totalling **$4,000** in absolute losses. Those aggregate practice records are additional invented teaching inputs, not demonstrated market histories.

Adding today's **$48.50 gross winner** produces 100 trades, 60 winners, gross winning P&L of **$7,200**, and gross losing P&L of **$4,000**:

```text
Win rate = winning trades / total closed trades × 100
         = 60 / 100 × 100 = 60%

Average gross winner = $7,200 / 60 = $120
Average gross loser  = $4,000 / 40 = $100
Gross profit factor  = $7,200 / $4,000 = 1.80
Gross aggregate P&L  = $7,200 - $4,000 = $3,200
```

If all 100 records paid the same assumed $1.50 round-trip fees, total fees would be **$150** and net aggregate P&L **$3,050**. Assuming each winner remains positive after its fee, winning net P&L is `$7,200 - 60 × $1.50 = $7,110`; losing net P&L is `$4,000 + 40 × $1.50 = $4,060` in magnitude. The corresponding after-fee profit factor is `$7,110 / $4,060 = 1.7512`. State whether a reported metric includes costs before comparing it with another report.

Profit factor **1.8 does not mean each winner earns 1.8R**. It is an aggregate ratio. Win rate says how often a specified sample wins; it does not state the size of wins or losses. Today's 1.6207 price-risk R is a single trade measurement. Different initial risks, partial exits, costs, and trade sequences can change those relationships. A single winner cannot establish the probability of the next trade winning.

The main day's balance remains **$50,047**, because its starting $50,000 already represents the chosen start-of-day account state. The separate historical worksheet is not added again. Nor can its total wins and losses reveal maximum drawdown: that requires an ordered equity path, which the aggregate worksheet does not supply.

For the current trade only, a review convention that reserves both transaction fees throughout would mark peak liquidation equity at `$50,000 + $54 MFE - $1.50 = $50,052.50`. Final equity is $50,047, giving a peak-to-exit decline of **$5.50**. The early adverse move would mark $49,997.50 on the same convention. These local observations are not the maximum drawdown of the learner's 100-trade history.

### Apply the prop-firm example at the correct level

Now use the source's account-level comparison: a **$2,000 drawdown allowance** and **$3,000 profit target**. For arithmetic only, suppose this simulated $50,000 account had a **static** floor of $48,000 and an objective of $53,000. No actual firm's current rules are asserted.

```text
Account target / drawdown allowance = $3,000 / $2,000 = 1.5
Today's stressed trade risk / allowance = $31 / $2,000 = 1.55%
Remaining target after today = $3,000 - $47 = $2,953
Distance from ending balance to static floor = $50,047 - $48,000 = $2,047
```

The account-level 1.5 comparison does not make $2,000 the risk for one trade, and today's approximately 1.5 cost-inclusive result does not pass the account objective. A trailing floor, daily cap, payout condition, or other firm rule would require different calculations. Those mechanics are unspecified in the source and are not invented as live account rules here.

The trader leaves the learning size unchanged. One micro with $29 price risk was enough to practise the full decision sequence. Five identical micros would have **$145 price risk** and **$155 stressed loss**, five times the monetary exposure without adding any new evidence about the setup. Smaller size supports repetition; it does not justify accepting a lower-quality setup.

<a id="cs01-step-16"></a>
## Step 16. Make the next repetition useful and adapt without strategy hopping

The trader saves the pre-entry chart at 09:55, the confirmation chart at 10:00, the value-reclaim chart at 10:05, and the stall chart at 10:20 with their corresponding observations. They also save the skipped decisions. Reviewing only the filled trade would hide much of the selective participation that made this process coherent.

The next practice task is specific: **replay from 09:35 and explain aloud why there is no entry at 09:45 or 09:50**. At each stop, cover all later rows and write the available evidence before revealing the next candle. At 09:55, identify the higher second low, but do not borrow the coming positive footprint from 09:55-10:00. At 10:00, calculate size before revealing the first post-entry candle.

The source mentions ATAS and Deep Charts as replay examples. No platform installation or subscription is needed to work through the supplied tables. These synthetic CSVs are teaching exports, not promised import files for either platform, and the OHLC exports cannot recreate a real tick-by-tick footprint. Actual order-flow replay would require suitable recorded transaction data. The point of this exercise is honest sequential decision-making.

![A concrete replay, measurement, and adaptation loop for the next practice session](images/case-study-01/23-review-loop.svg)

*Figure 23. Replay has a defined purpose: practise the missing skill, record execution, and compare environments. Repetition does not guarantee profitability.*

The review also connects the broader market-mechanics vocabulary from image 46 to this same path. The prior value region shows **balance and position building**, sometimes described as accumulation, but no participant inventory is visible. The move from 20,000 toward 20,100 is an observed **markup**. The earlier premium region and subsequent selling are consistent with a possible distribution phase, but the chart cannot prove that institutions distributed inventory. The morning fall into discount is **markdown**. The held lows and renewed buying are consistent with **re-accumulation**. Those labels describe an interpretation of the sequence, not extra entry triggers.

Likewise, **absorption** describes substantial aggressive execution met by opposing passive interest with limited further progression; **imbalance** is a comparison of aggressor volumes; **exhaustion** suggests that an aggressive push is losing its ability or participation to continue. The low's absorption evidence, the later diagonal buyer ratios, and the final taper from 21,000 to 9,000 contracts are different observations. They should not be used as interchangeable names for any small candle.

For repeated learning, the trader keeps one process and a stable journal rather than changing from Fibonacci to breakout to news trading after each disappointing result. The image's illustrative 50-100 trades or three-month commitment is not a proven sample-size requirement. A concrete case-study learning plan is to review the next **20 eligible replay sessions**, log all no-trade decisions, and examine rule adherence before considering a change. Twenty is a practice assignment, not statistical proof of an edge. Replaying this known outcome repeatedly improves familiarity but does not create independent evidence of profitability.

Adapting to a regime change still matters. Today's local transition was visible in shrinking candle ranges, fading volume, and repeated returns to 20,050. The chosen adjustment was to stand aside. It was not to switch spontaneously to a new range-fading strategy. If a later study found a genuine larger value-down structure, the trader would revisit the long premise before another entry.

**Volatility branch.** If a future occurrence of the same structural setup required a 30-point entry-to-stop distance, one micro's stressed loss on the same cost assumptions would be `30 × $2 + $0.50 + $1.50 = $62`. With today's $50 budget, `floor(50 / 62) = 0 contracts`. Because a whole micro is the smallest chosen size, the action is no trade in this simulation. This demonstrates the image's “smaller size in volatility” idea without widening an already-open stop or forcing an unaffordable minimum position.

**Range and transition branch.** Suppose new completed profiles converged around 20,048-20,052, with alternating closes of 20,049 and 20,051. That would support balance rather than a continuing expansion expectation. The trader can reduce participation to zero while collecting further evidence. The teaching images discuss shorter targets, range extremes, and trading both sides, but the document does not fully specify those alternate systems. They are considered and explicitly not adopted here. A branch that cancels the long is a practical application, not a gap filled by invented trades.

The final journal sentence is concrete: “I waited for location and both failures, entered one micro within the planned budget, managed completed evidence, accepted the exit, and stopped participating when conditions and time no longer supported the process.” The $47 is the recorded financial outcome. The learning result is the documented sequence of decisions that can be examined again, including the branches where the correct action was no trade.

<a id="cs01-data"></a>
## Reproducible data and timeframe checks

The [source dataset](case-study-01/data.json) contains the simulated candles, profiles, selected footprints, reference levels, stops, and alternative candles. The [figure generator](case-study-01/generate.py) produces the 23 figures and CSV exports. It checks OHLC bounds, price increments, candle aggregation, volume and delta totals, chronological stop changes, and the final P&L. New numerical figures come from this data, not from AI-generated market screenshots.

The complete [five-minute export](case-study-01/five-minute.csv) contains every session candle from 09:00 through the interval ending 11:00. The [one-minute confirmation export](case-study-01/one-minute-confirmation.csv) covers the five minutes used for entry detail. The [fifteen-minute export](case-study-01/fifteen-minute.csv) and [hourly session export](case-study-01/hourly-session.csv) are aggregates of the five-minute data, not independent invented charts.

For example, the 09:45 fifteen-minute candle aggregates 09:45, 09:50, and 09:55:

```text
Open 20,022; high 20,029; low 20,018.25; close 20,028
Volume 28,000 + 26,000 + 30,000 = 84,000
Delta +8,000 - 6,000 + 10,000 = +12,000
Available only at 10:00.
```

The 09:30 fifteen-minute candle is `O 20,058; H 20,064; L 20,014; C 20,022; V 96,000; delta -28,000`, available at 09:45. Together these views show a falling leg followed by recovery, but the finer two-failure sequence still requires the five-minute view. The strategy uses different timeframes for different levels of detail, not as interchangeable entry signals.

The current 10:00 hourly bar ends at 11:00. Its final low or close must not be used to justify the 10:00 entry. The hourly context displayed earlier uses completed preceding intervals. This distinction is preserved in the figures' [information-cutoff manifest](case-study-01/figures.json).

To regenerate the assets from the repository root:

```powershell
python docs/case-study-01/generate.py
```

The generator requires Matplotlib. It writes temporary PNG previews outside the repository and compact SVG figures into `docs/images/case-study-01/`. It does not edit the original strategy text or images. Generated CSVs, figures, manifests, and validation output should be regenerated from the source data and script rather than edited manually.

<a id="cs01-coverage"></a>
## Source coverage audit

The table below inventories the source topics and identifies the concrete demonstration. “Main” means the single chronological session; “branch” means a separately labelled alternative; “review” means an explicit calculation or learning action after the session. Source image links identify the original illustrations inspected, not newly generated substitutes.

| Source topic | Source section and original image | Demonstration in this case study | Placement |
|---|---|---|---|
| Context before entry; complete process | Core idea; Complete process; [image 52](images/image-52.webp) | [Steps 0-16](#cs01-step-0), one continuous decision sequence | Main |
| Auction, balance, support/resistance, breakout from balance | A.1; [balanced range](<images/ChatGPT Image Sep 21, 2026, 07_22_38 PM.webp>); [defined range](<images/ChatGPT Image Sep 21, 2026, 07_36_00 PM.webp>) | [Step 1](#cs01-step-1), previous-week overlapping value and overnight range; no automatic breakout entry | Main |
| Forced participation; long exit sells; short exit buys | A.2; [forced participation](<images/ChatGPT Image Sep 21, 2026, 09_24_25 PM.webp>); [exit fuel](<images/ChatGPT Image Sep 21, 2026, 09_23_09 PM.webp>) | [Step 9](#cs01-step-9), offside short -$47 and offside long -$108; closing-order direction | Main interpretation |
| Effort with result; effort without result, both sides | A.3; [effort versus result](<images/ChatGPT Image Sep 21, 2026, 09_36_00 PM.webp>) | [Steps 4-5](#cs01-step-4), seller progress then absorption; [Steps 10-11](#cs01-step-10), buyer progress then stall | Main |
| Different goals, sizes, constraints, behaviours; liquidity | A.4; [participants](<images/ChatGPT Image Sep 21, 2026, 09_41_14 PM.webp>) | [Step 5](#cs01-step-5), one-micro choice versus larger order depth; hedgers and liquidity providers | Main explanation |
| Value up, down, and sideways | 1.1; [value structure](<images/ChatGPT Image Sep 21, 2026, 09_48_57 PM.webp>) | [Step 1](#cs01-step-1), numerical profiles and changed-context branches | Main + branch |
| Current/previous week; 1H/4H; higher highs/lows | 1.2; [higher timeframes](<images/ChatGPT Image Sep 21, 2026, 09_49_42 PM.webp>) | [Step 1](#cs01-step-1), dated extracts and exact four-hour aggregation | Main |
| Naive GEX; QQQ/NDX context; option delta and gamma | 1.3; [gamma environment](<images/ChatGPT Image Sep 21, 2026, 09_52_54 PM.webp>) | [Step 3](#cs01-step-3), supplied -120 model, basis mapping, local delta calculation | Main, assumptions labelled |
| Positive/negative gamma; damping/amplification; neither predicts direction | 1.3; same gamma image | [Steps 3 and 9](#cs01-step-3), alternative hedge responses and rally interpretation | Main + branch |
| Call wall, put wall, gamma flip; no automatic bounce | 1.4; [image 1](images/image-1.webp) | [Step 3](#cs01-step-3), 20,055 / 20,000 / 20,080; [Step 11](#cs01-step-11), observed response | Main |
| Scenarios before execution; preparation for alternatives | 1.5; [image 2](images/image-2.webp) | [Step 3](#cs01-step-3), explicit if/then plan; [Step 1](#cs01-step-1), down-context rejection | Main + branch |
| Follow larger structure; avoid top/bottom calling | 2.1; [image 3](images/image-3.webp) | [Steps 1 and 4](#cs01-step-1), reject premium entry; distinguish pullback from larger trend | Main |
| Premium, discount, established value | 2.2; [image 4](images/image-4.webp) | [Step 2](#cs01-step-2), exact VAL/VAH and zone distance | Main |
| Inefficient area, speed and little business | 2.3; [image 5](images/image-5.webp) | [Step 2](#cs01-step-2), 20-second prior traversal plus independent sparse volume | Main |
| LVN and HVN; profile interpretation | 2.4; [image 6](images/image-6.webp) | [Step 2](#cs01-step-2), 2,000-contract node and 24,000-contract high-volume bin | Main |
| Fib anchors; 0.705, 0.788, 0.886 | 2.5; [image 7](images/image-7.webp) | [Step 2](#cs01-step-2), complete arithmetic and tradable-tick distinction | Main |
| Fib outside value | 2.6; [image 7](images/image-7.webp) | [Step 2](#cs01-step-2), real comparison and inside-value rejection branch | Main + branch |
| Internal swing and breathing structure | 2.7; [image 8](images/image-8.webp) | [Steps 1 and 4](#cs01-step-1), 20,060/20,040 prior swing and morning rebound | Main |
| 0.886 invalidation; failed auction lower | 2.8; [image 9](images/image-9.webp) | [Step 5](#cs01-step-5), main low above boundary and branch A below it | Main + branch |
| Location is insufficient; no guarantee | 2.9; [image 10](images/image-10.webp) | [Steps 4-6](#cs01-step-4), repeated no-entry decisions despite location | Main |
| Wait for actual arrival; no chasing | 3; [image 11](images/image-11.webp) | [Step 4](#cs01-step-4), 09:39 alert; [Step 8](#cs01-step-8), unfilled-order handling | Main |
| 5M execution, 15M context, 1H and occasional 1M | 4.1; [image 12](images/image-12.webp) | [Steps 1 and 7](#cs01-step-7); [timeframe checks](#cs01-data) | Main |
| OHLC, candle body/wicks, scoreboard | 4.2; [image 13](images/image-13.webp) | [Step 5](#cs01-step-5), 17-point range, eight-point body and lower wick | Main |
| Volume-profile candles; delta/bid-by-ask | 4.3; [image 14](images/image-14.webp) | [Steps 5 and 7](#cs01-step-5), reconciled profile and exact tick excerpts | Main |
| Seller participation at extreme; candle POC; negative delta | 4.4; [image 15](images/image-15.webp) | [Step 5](#cs01-step-5), 41.18% lower-group concentration and 20,014.50 POC | Main |
| Seller effort without further progression | 4.5; [image 16](images/image-16.webp) | [Step 5](#cs01-step-5), three tests of 20,014 and recovery | Main |
| Absorption is not reversal; wait for dominance | 4.6; [image 17](images/image-17.webp) | [Steps 5-6](#cs01-step-5), no entry after absorption; invalidation branch | Main + branch |
| 400% footprint; bid left/ask right; second failure | 6; [image 18](images/image-18.webp) | [Steps 6-7](#cs01-step-6), declared diagonal formula and two buyer responses | Main |
| Complete long-entry sequence; bullish flip | 7; [image 19](images/image-19.webp) | [Step 7](#cs01-step-7), close through 20,025 after higher failure | Main |
| Stop beyond failed sellers; invalidate premise | 8; [image 24](images/image-24.webp) | [Step 8](#cs01-step-8), 20,013.75 structural stop; branch D | Main + branch |
| Trapped shorts after entry | 9; [image 25](images/image-25.webp) | [Step 9](#cs01-step-9), offside arithmetic and limits of inference | Main interpretation |
| Negative gamma may amplify short-covering move | 9.1; [image 26](images/image-26.webp) | [Step 9](#cs01-step-9), possible combined demand, no identity claim | Main interpretation |
| Reclaim value; warning if buying fails; cut/breakeven | 10; [image 21](images/image-21.webp) | [Step 9](#cs01-step-9), main reclaim, branch C, price versus cost breakeven | Main + branch |
| Trail successful aggression; red flag when progress stalls | 11; [image 23](images/image-23.webp) | [Steps 10-11](#cs01-step-10), timestamped amendments and stronger delta with weaker result | Main |
| Swing targets, POC, call wall, round numbers, order clusters | 12; [image 20](images/image-20.webp) | [Steps 8-12](#cs01-step-8), 20,060 target and intermediate references/book snapshot | Main |
| Selectivity; zero/one/two trades; mental capacity | C.1; [image 27](images/image-27.webp) | [Steps 0 and 13](#cs01-step-13), rejected moments, one trade, no quota | Main |
| Approx. 20,000 MNQ contracts; taper/grind; first 90 minutes; Asia | C.2; [image 28](images/image-28.webp) | [Steps 4 and 13](#cs01-step-4), candle-specific filter and session shutdown | Main |
| MNQ versus NQ; contract multiplier is not order-flow ratio | C.3; [image 29](images/image-29.webp) | [Steps 0 and 8](#cs01-step-0), specifications, dollar exposure, separate feeds | Main |
| Exceptional nearby news; no invented blackout rule | C.4; [image 30](images/image-30.webp) | [Steps 3-4](#cs01-step-3), mock calendar and 09:39 skip branch | Main + branch |
| R definition; typical 1.5R-2R; extra confirmation reduces theoretical R | D.1; [image 31](images/image-31.webp) | [Steps 8 and 12](#cs01-step-8), early-entry comparison and actual net R | Main + comparison |
| Reported win rate and profit factor; costs and uncertainty | D.2; [image 32](images/image-32.webp) | [Step 15](#cs01-step-15), explicit journal arithmetic; no claim of verified performance | Review |
| Prop drawdown/target relationship; separate account risk and trade R | D.3; [image 33](images/image-33.webp) | [Step 15](#cs01-step-15), static-floor arithmetic and $2,953 remaining target | Review |
| A/B/C execution grading; back-end improvement | E.1; [image 34](images/image-34.webp) | [Step 14](#cs01-step-14), evidence rubric, hesitation and rule-breaking branches | Review + branch |
| Good loss; uncertainty despite valid execution | E.2; [image 35](images/image-35.webp) | [Step 14](#cs01-step-14), valid-entry branch D loses $31 | Branch |
| Bad trade can win; anticipation versus confirmation | E.3; [image 36](images/image-36.webp) | [Step 14](#cs01-step-14), premature-entry +$43/-$35 alternatives | Branch |
| C-game escalation, frustration, recovery urge, tilt | E.4; [image 37](images/image-37.webp) | [Step 14](#cs01-step-14), two-loss branch and prevented three-micro escalation | Branch |
| Specific personal rules connected to actions | E.5; [image 38](images/image-38.webp) | [Steps 0 and 14](#cs01-step-14), quantity correction, clock/loss shutdown | Main + branch |
| Breaking point; losses, breakevens, P&L, overconfidence | E.6; [image 39](images/image-39.webp) | [Steps 13-14](#cs01-step-13), 10:45 thought and alternative recovery trigger | Main + review |
| Find events preceding tilt | E.7; [image 40](images/image-40.webp) | [Step 14](#cs01-step-14), trace draft size change before account damage | Branch |
| Hard time limit; stop after two losses, before third | E.8; [image 41](images/image-41.webp) | [Steps 13-14](#cs01-step-13), 11:00 action and two-loss -$59 branch | Main + branch |
| Shut down premature/chasing/assuming/oversizing behaviour | E.9; [image 42](images/image-42.webp) | [Steps 0, 13, 14](#cs01-step-14), trigger-to-action rules; retain protective management | Main + branch |
| Execution rather than money | F.1; [image 43](images/image-43.webp) | [Step 14](#cs01-step-14), same evidence can produce good loss or good win | Review |
| One micro for repetitions; size is account-dependent | F.2; [image 44](images/image-44.webp) | [Steps 0, 8, 15](#cs01-step-15), one-micro cap, budget and five-micro comparison | Main + review |
| Proper execution, repetition, money as outcome | F.3; [image 45](images/image-45.webp) | [Steps 13 and 16](#cs01-step-16), no profit quota; next replay task | Main + review |
| Auction mechanics; participant roles; accumulation/markup/distribution/markdown; exhaustion | F.4; [image 46](images/image-46.webp) | [Steps 5, 9, 16](#cs01-step-16), observable activity versus participant inference | Main + review |
| Replay; journal; pattern recognition; metrics; honest sequential practice | F.5; [image 47](images/image-47.webp) | [Step 16](#cs01-step-16), exact pause points; ATAS/Deep Charts context and data limits | Review |
| Strategy fit, tools, clarity, commitment; avoid unrelated setups | F.6; [image 48](images/image-48.webp) | [Steps 0 and 16](#cs01-step-0), learner fit and explicit alternatives not adopted | Main + review |
| Stop strategy hopping; consistent sample and review | F.7; [image 49](images/image-49.webp) | [Step 16](#cs01-step-16), 20-session practice assignment, no statistical guarantee | Review |
| Regimes: trend, range, volatile, transition; adaptation | F.8; [image 50](images/image-50.webp) | [Steps 1, 3, 13, 16](#cs01-step-16), main transition plus numeric volatility/range branches | Main + branch |
| Process over outcome; protect behaviour; repeat correct actions | G; [image 51](images/image-51.webp) | [Steps 14-16](#cs01-step-14), execution assessment and concrete learning loop | Review |
| Define risk before entry; do not widen stop; optional partials; runners | Complete process; [image 52](images/image-52.webp) | [Steps 8-12](#cs01-step-8), bracket, trail, one-contract no-partial decision, retained larger target | Main |

### Limits of what this case study demonstrates

Every inventoried source topic has a stated application, review exercise, or explicit branch above. This does **not** establish every implied claim in the teaching illustrations. In particular, the claimed profitability across regimes, exact participant identities, real-time Naive GEX methodology, broker execution behaviour, prop-firm rules, and statistical effectiveness cannot be verified from this synthetic example.

The source's quotations embedded in illustrations have not been authenticated against an external recording; the case study uses the concepts without adding invented quotations attributed to Chris. The source's missing section 5 remains missing. A complete tick-by-tick market reconstruction, real options chain, full order book, and full prior trading history are not supplied. Selected footprint cells and chronological event observations are labelled as such.

The numerical checks cover the supplied dataset and calculations. The main scenario and all branches are teaching constructions. They show how to make the documented process concrete, while leaving actual strategy validation and future automation decisions open.

Validation record: the original strategy wording and existing image assets are retained, with malformed image references repaired. All 60 original image references are represented in the coverage audit. The 23 new figures were inspected as rendered PNG previews; their numerical inputs, candle aggregation, stop chronology, costs, and P&L pass the generator checks. Markdown conversion produced 22 tables, and all new local links and internal anchors resolve. Full browser layout inspection could not be completed because the browser preview failed to initialize.

</details>
