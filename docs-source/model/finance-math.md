
## Debt and equity finance

The total net consolidated foreign asset position (investment position) of
each area consists of a net debt position (fixed income instruments) and
the net equity position (shares in capital)

$$
\mathit{netiip}_t = \mathit{netf}_t + \mathit{netb}_t
$$

There are several fundamental differences between how debt positions versus
equity positions are modeled in GEES.

* International equity has explicit gross positions (households holding
  equity placed in another area, while their own area's capital shares
  being held by nonresidents), international debt is only modeled through
  the implied net positions.

* Equity is held and handled directly by households while
  debt is held and handled by a simple financial system (an agent on
  on behalf of households as principals).

* Behaviorally, both equity and debt give rise to no-arbitrage conditions
  in their respective markets. Optimal equity pricing leads to household
  capital pricing equations. Optimal debt pricing leads to interest parity
  in forex markets.

* Their respective non-arbitrage conditions are insufficient to determine
  the actual volumes of equity or debt held and traded (typical of DSGE
  models). Equity is assumed to be held and shared in fixed real
  proportions (i.e. an area's households claims on another area's real
  capital is fixed). The volume of debt is, on the other hand, determined
  as the result of stock-flow relationships between the current and
  financial accounts of the BOP, together with a global net zero supply
  (clearing) condition.

* Absent any physical investment, changes in the nominal value of equity
  are purely the result of capital price gains or losses (valuation
  effects); this means that changes in the value of equity is not
  associated with any transactions (no equity being actually traded).
  Valuation does not enter the BOP, only the IIP accounts. The only
  equity-related transactions on the BOP is the physical investment
  (additions to physical capital). Increases or reductions in debt, on the
  other hand, consist of both transactions (new debt created, old debt paid down)
  and valuation (through forex, depending on the currency of denomination).

The behavioral foundations of international equity is part of the
description of households, its accounting implications for the IIP are
described in the IIP/BOP section.

The behavioral and accounting foundations of international debt is
described here.

## International debt and the financial system

Each area has a simple financial system connecting three parties: local
households, the local government, and the rest of the world. At the end of
each period, the financial system has zero net worth, balancing exactly its
positions with the three parties:

$$
\mathit{bh}_t + \mathit{bg}_t + \mathit{netf}_t = 0
$$

where

* $\mathit{bh}_t$ is the net claims of the financial system on local
  households,

* $\mathit{bg}_t$ is the net claims of the financial system on the local
  government,

* $\mathit{netf}_t \equiv \mathit{netf}_t^\mathrm{lcy} +
  \mathit{netf}_t^\mathrm{fcy}$ is the net claims of the financial system on the
  financial systems of all other areas, consisting of local currency and
  foreign currency denominations, in general.

All debt positions are assumed of one-period duration. Then, the ex-post
profits of the local financial systems at the beginning of each period
(after settling all obligations) are given by

$$
\Pi_{b,t} \equiv
\left( \mathit{rh}_{t-1} - \mathit{zh}_t \right) \; \mathit{bh}_{t-1}
+ \mathit{r}_{t-1} \; \mathit{bg}_{t-1}
+ \mathit{r}_{t-1} \; \mathit{netf}_{t-1}^\mathrm{lcy}
+ \tfrac{\mathit{ex}_{t}}{\mathit{ex}_{t-1}} \; \mathit{r}_{t-1}^\mathrm{fcy} \; \mathit{netf}_{t-1}^\mathrm{fcy}
$$

where

* $r_t$ and $r_t^\mathrm{fcy}$ are risk-free gross rates of interest traded
  between the financial sectors of the individual areas, or between the
  financial sector and the local government;

* $\mathit{rh}_t$ is the gross rate of interest charged on the positions
  between the financial sector and local households;

* $\mathit{zh}_t$ is the cost of maintaining the positions with households,
  including intermediation costs and credit risk expectations; this cost
  function is detailed below.


The financial system acts as an agent of the households, maximizing its
expected profits. There being no intertemporal connections between the
positions at two consecutive times, the optimization problem is quasi
static

$$
\max\nolimits_{\{
\mathit{bh}_t, \, \mathit{bg}_t, \, \mathit{netf}_t^\mathrm{lcy}
\}}
\mathrm E_t \left[ \beta \; \mathit{vh}_{t+1} \; \Pi_{b,t+1} \right]
$$


## Optimal behavior and no-arbitrage conditions

The first-order optimality conditions effectively imply no-arbitrage conditions.

1. An interest parity between local currency and foreign currency interest
   rates effectively describes the currency risk component in the
   relationship between two risk-free rates:

$$
r_t = \mathrm E_t \left[ \tfrac{\mathit{ex}_{t+1}}{\mathit{ex}_t} r_t^\mathrm{fcy} \right] 
$$


2. The local household interest rate is marked up over the risk-free rate,
   with the sprad determined by the intermediation cost and credit risk:

$$
\mathit{rh}_t = r_t + zh_t
$$


## International debt clearing and underlying assumptions

Net global debt position is zero at all times, a natural constraint in a
fully closed macroeconomic system:

$$
\sum\nolimits_{a} \; \mathit{netf}_t^a = 0
$$

Furthermore, in the baseline version of the model, we assume that all
international debt positions are always denominated in the so-called
reference currency, specifically in the US dollars.

An immediate implication of this assumption is that the US economy is the
only area that is not exposed to the forex valuation effects from its debt
positions.

Finally, the cost function for household positions, $\mathit{zh}_t$ is
driven by the net debt position of the country as a whole as a fraction of
the value of production capital:

$$
\mathit{zh}_t =
\mathit{zh}_t^\mathrm{aut}
+ \theta_1 \; \tfrac{1}{\theta_2} \;
\left[
\exp -\theta_2 \; \frac{\mathit{netf}_t}{\mathit{pk}_t \; k_t}
\right]
+ \varepsilon_{\mathit{zh}, t}
$$


