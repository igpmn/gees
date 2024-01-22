
## Household preferences

The representative household preferences are described by a time-separable utility
function over an infinite life horizon, $t=0,\dots,\infty$. The period
utility function consists of a consumption utility component, $\bU^{ch}_t$,
a work disutility component, $\bU^{nh}_t$, and a current wealth (net worth)
utility component, $\bU^{netw}_t$. The individual utility function
components are each evaluated on a per-capita basis, and the overall period utility is multiplied by the
total number of household members 

$$
\begin{equation}
\E_0 \sum_{t=0}^{\infty} \beta^t \Bigl( \bU^{ch}_t - \bU^{nh}_t + \bU^{netw}_t \Bigr)\, nn_t 
\end{equation}
$$

The respective components of the utility function related to consumption,
work and wealth, respectively, are given as follows

$$
\newcommand{\Uch}{\kappa_{ch}\, \blog \frac{ch_t - \extern{ch}_t^\ref}{nn_t}}
\bU^{ch}_t \equiv \Uch
$$


$$
\newcommand{\Unh}{\frac{1}{1+\eta}\ nh_t{}^{1+\eta}}
\bU^{nh}_t \equiv \Unh
$$


$$
\newcommand{\Unetw}{\nu_1 \left( \blog \frac{netw_t}{pc_t\, \extern{ch}_t} - \nu_0  \frac{netw_t}{pc_t\, \extern{ch}_t}\right) }
\bU^{netw}_t \equiv \Unetw
$$

where 

* $ch_t^\ref$ is the reference point in household consumption
proportional to the level of real current labor income net of type 1
lump-sum taxes (or transfers) and externalized from the household
optimization

$$
ch_t^\ref \equiv \chi_{curr} \, \frac{curr_t}{pc_t} + \chi_c \, c_{t-1}
$$

* $\kappa_{ch} \equiv 1 - ch^\ref_\ss\, ch_\ss{}^{-1}$ is a steady-state
  correction constant ensuring that the marginal utility of consumption
  equals $nn_t \, ch_\ss{}^{-1}$ in steady state, a feature of
  modeling convenience,

* $curr_t$ is current labor income net of Type 1 lump sum taxes (or transfers)

$$
curr_t \equiv w_t \, nh_t \, nl_t - tx1_t
$$

* $netw_t$ is the nominal net worth given by the sum of the value of the
production capital portfolio, the net financial position of the household
to the local financial sector, $bh_t$ (a positive balance means net claims
of the financial sector on the household), and the net worth of the local
financial sector (whose ultimate owner the household is), $bb_t$, 

$$
netw_t \equiv \tsum\nolimits_a s_{a,t} \, ex_{a,t} \, pk_{a,t} \, k_{a,t} - bh_t + bb_t
$$

* $ex_{a,t}$ is the cross rate between local currency and area $a$'s currency
(with movements up meaning depreciation of local currency)

$$
ex_{a,t} = \frac{e_{\local, t}}{e_{a,t}}, \quad ex_{\local,t}=1
$$


---

## Dynamic budget constraint

The dynamic budget constraint facing the household sector describes a
stock-flow relationship between the household assets and liabilities
(stocks) on the one hand, and current receipts and current outlays (flows)
on the other hand. The household assets and liabilities consist of 

* a net position with the local financial sector, $-bh_t$ (a positive
  balance means net lending by the household from the financial sector, a
  negative balance means net lending by the financial sector from the
  household),

* claims on production capital (local and ccross-border capital),
  $\sum\nolimits_a s_{a,t} \, ex_{a,t}\, pk_{t}^a \, k_{t}^a$, and 

The change in the household assets and liabilities is equal to the revaluation
of capital claims, and the total amount of current receipts and outlays:

* revaluation of claims on production capital (both from the nominal
  exchange rate and the capital price),
  $\sum\nolimits_a s_{a,t-1} \, \bDelta\!\left( ex_{a,t} \, pk_{t}^a \right) \, k_{t-1}^a$,

* interest receipts or outlays on the net position with the local financial
  sector, $\left( rh_{t-1} -1 \right) bh_{t-1}$

* current receipts from capital rentals net of capital utilization costs, 
$\sum\nolimits_a s_{a,t} \,ex_{a,t}\,  pu_{t}^a \, k_{t}^a - \Xi_{u,t}$,

* current receipts from labor income, $w_t \, nh_t \, nf_t$, 

* current receipts from selling newly installed capital, $pk_t\,i_t$, 

* profits from loccal producers, $\Pi_{y,t}$, exporters, $\Pi_{x,t}$, and the
financial sector, $\Pi_{b,t}$,

* current outlays on consumption goods, $-pc_t \, ch_t$,

* current outlays on investment goods, $-pi_t \, i_t$,

$$
\begin{gathered}
\tsum\nolimits_a s_{a,t} \, ex_{a,t} \, pk_{t}^a \, k_{t}^a - bh_t \ \cdots
\newl
=\ 
\tsum\nolimits_a s_{a,t-1}\, ex_{a,t} \left(1-\delta^a\right) pk^a_{t}\, k^a_{t-1} 
- bh_{t-1}
\ \cdots \newl
+ \ \tsum\nolimits_a s_{a,t}\, ex_{a,t} \, pu_{t}^a \, u^a_t k^a_{t}
 - \left(rh_{t-1} - 1\right) bh_{t-1}
\ \cdots \newl
+ \ w_t^\mathrm{tar} \, nh_t \, nf_t + \left( w_t - w_t^\mathrm{tar} \right) \, \extern{nh_t} \, \extern{nf_t}
\ \cdots \newl
- \ pc_t \, ch_t + \left(pk_t - pi_t\right) i_t - tx1_t - tx2_t
\ \cdots \newl
+ \ \bPi_{y,t} + \bPi_{x,t} + \bPi_{b,t} - \Xi_{i,t} - \Xi_{k,t} - \Xi_{u,t} + \extern{\Xi}_{h,t}
\end{gathered}
$$

Lagrange multiplier associated with the budget constraint is denoted by
$vh_t$ (shadow value of nominal household wealth)


---

## Labor market

* The representative household delegates wage negotiation to a trade union
  agent

* Each period, the household tells the trade union its target level for
  nominal wage, $w^\mathrm{tar}$, 

* The union solves to following optimizing problem including a wage inflation adjustment cost:


$$
\min\nolimits_{\{w_t\}}
\mathrm E_t \, \sum_{t=0}^\infty
\beta^t\,\Lambda_t \, \left[
(\log w_t - \log w_t^\mathrm{tar} )^2
+ \tfrac{\xi_w}{2} \, (\log \roc{w}{}_t - \log \roc{w}{}_t^{\ref} )^2
\right]
$$

where 

* $\xi_w$ is an adjustment cost parameter

* $\roc{w}{}_t^{\ref} \equiv \roc{\extern{w}}_t$ is a reference rate of wage inflation representing
  the backward indexation present in wage negotiation

The resulting first-order condition (a wage setting equation) is given by

$$
\log w_t - \log w_t^\mathrm{tar} = 
\xi_w ( \log \roc{w}_t - \log {\roc{w}}{}^\ref_t )
- \xi_w \, \mathrm E_t \left[ \beta \tfrac{\Lambda_{t+1}\,w_t}{\Lambda_{t}\,w_{t+1}}
( \log \roc{w}_{t+1} - \log \roc{w}{}^\ref_t ) \right]
$$


---

## Short-term adjustment costs

The optimizing behavior of the representative household is subjected to
two types of costly short-term adjustment processes:

* an investment adjustment/installation cost
* a capital utilization cost.

The investment adjustment/installation cost comprises two components:
departures from a steady-state investment-to-capital ratio, and departures
from a steady-state rate of change in investment

$$
\Xi_{i,t}
\equiv 
\tfrac{1}{2} \, \xi_{i1} \, pi_t \, \extern{i}_t \, \Bigl( \blog i_t - \blog \extern{i}^\ref_t \Bigr)^2 
+ \tfrac{1}{2} \, \xi_{i2} \, pi_t \, \extern{i}_t \, \Bigl( \mathbf{\Delta log\ } i_t - \blog \kappa_{i} \Bigr)^2 \\[5pt]
$$

where
$i^\ref_t$ is a point of reference derived from the steady-state
investment-to-capital ratio applied to the stock of capital last period,

$$
i^\ref_t \equiv \frac{i_\ss}{k_\ss} \, k_{t-1} \, \roc{\imath}_\ss
$$

and $\kappa_{i} \equiv \roc{\imath}_\ss$
is a steady-state adjustment constant ensuring that the
cost term disappears in steady-state.



The cost of capital utilization give rise to a cyclical response in the
rate of utilization of the existing stock of capital. The cost function is
given by

$$
\Xi_{u,t}
\equiv s_{\local,t} \, py_t \, k_t \, \frac{\upsilon_0}{1+\upsilon_1} \, u_t{}^{1+\upsilon_1}
$$


---

## Capital accumulation

The household purchases investment goods, converts them to newly installed
production capital (paying the adjustment/installation cost in the process)
and adds these to the existing stock of capital

$$
k_t = (1-\delta)\ k_{t-1} + i_t
$$


---

## Lagragian 

The Lagrangian for the contrained optimization problem facing
the representative household consists of the lifetime utility function and a
sequence of dynamic budget constraints for each time from now until
infinity, $t=0, \dots, \infty$. Note that we use $ww_t$ in place of $w_t$ in
the Lagrangian.

$$
\begin{gathered}
\bmax_{\{ch_t, bh_t, s_{a,t}, i_{t}, nh_t, u_t \}} 
\newl
\sum\nolimits_{t} \beta^t \Bigl[
\Uch + \Unh + \Unetw \Bigr] \, nn_t \ \cdots
\end{gathered}
$$

$$
\begin{multline}
+\ \sum\nolimits_t \beta^t vh_t\, \Bigl\{
- \tsum\nolimits_{a} s_{a,t} \, ex_{a,t} \, pk_{t}^a \, k_{t}^a + bh_t
\Bigr.
\ \cdots \newl
+\ \tsum\nolimits_a s_{a,t-1}\, ex_{a,t} \left(1-\delta^a\right) pk^a_{t}\, k^a_{t-1} 
- bh_{t-1}
\ \cdots \newl
+ \ \left(\betak_{t-1}{}\right)^t \tsum\nolimits_a s_{a,t}\, ex_{a,t} \, pu_{t}^a \, u^a_t k^a_{t}
 - \left(rh_{t-1} - 1\right) bh_{t-1}
\ \cdots \newl
+ \ ww_t \, nh_t \, nl_t 
- pc_t \, ch_t + \left(pk_t - pi_t\right) i_t - tx1_t - tx2_t .
\ \cdots \newl
+ \bPi_{y,t} + \bPi_{x,t} + \bPi_{b,t} -\ \Xi_{i,t} - \Xi_{k,t} - \Xi_{u,t} + \extern{\Xi}_{h,t}
\Bigr. \Bigr\} 
\end{multline}
$$

where $vh_t$ is the Lagrange multiplier on time-$t$ budget constraint, and
$\betak$ is the additional discount factor applied to the value of
corporate equity holdings to compensate for the risk aversion of
households.

---

## Optimality conditions

The optimal (utility maximizing) choices of the representative household
are described by the following first-order conditions.

* Consumption, $ch_t$

$$
vh_t \, ph_t = \kappa_{ch}\, \frac{1}{ch_t - \extern{ch}^\ref_t} \, nn_t
$$

* Per-worker hours worked depending on the hypothetical flexible wage rate,
  $ww_t$

$$
vh_t \, ww_t = nh_t{}^\eta
$$

* Net position with the financial sector, $bh_t$ (an intertemporal no-arbitrage condition)

$$
vh_t = \beta \, vh_{t+1} \, rh_t 
+ \nu_1 \frac{1}{pc_t \, \extern{ch}_t} \left( \frac{pc_t \, \extern{ch}_t}{netw_t} - \nu_0 \right)
$$

* Utilization rate of production capital, $u_t$

$$
\upsilon_0 \, u_t{}^{\upsilon_1} \, py_t = pu_t
$$

* Investment in local production capital, $i_t$

$$
pk_t = pi_t \Bigl[
1 + \xi_{i1} \bigl( \blog i_t - \blog \extern{i}^\ref_t \bigr)
+ \xi_{i2} \bigl(\bDelta \blog i_t - \kappa_i\bigr) 
- \xi_{i2} \, \beta\, zk_t \, \bigl(\bDelta \blog i_{t+1} - \kappa_i\bigr)
\Bigr]
$$

* Claims on area $a$'s production capital, $s_{a,t}$, $\forall a \in A$

$$
\beta \, vh_{t+1} \, rh_t \, pk^a_t \, ex_t^a 
= vh_t \, pu^a_t \, ex_t^a \, u^a_t  
+ \beta \, \betak_{t} \, vh_{t+1} \left(1-\delta^a\right) pk^a_{t+1}\, ex_{t+1}^a
$$

The last set of equations defines arbitrage-free conditions (AFCs) for a
corporate equity portfolio choice. We need to further address the following
two characteristics of these NACs: 

1. As is common in macro models, the AFCs themselves do not determine the
   actual portfolio shares, $s_{a,t}$, only the relationship between the
   price of production capital, the cash flows it generates, and the
   houseshold discount factor. The actual shares are then calibrated and
   kept fixed in the baseline version of the model.

2. Since we allow for cross-border holdings, each area's capital is subject
   to muliple AFCs, each relating to the household residing in a different
   area and exhibiting, in general, different preferences. We therefore
   create aggregate AFCs by taking the weighted average with the weights
   equal the portfolio shares. The aggregate AFCs for the capital markets
   are described in the Global equilibrium section.



