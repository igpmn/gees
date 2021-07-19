
$$
\newcommand{\tsum}{\textstyle\sum}
\newcommand{\extern}[1]{\mathrm{\mathbf{{#1}}}}
\newcommand{\local}{\mathrm{local}}
\newcommand{\roc}[1]{\hat{#1{}}}
\newcommand{\ss}{\mathrm{ss}}
\newcommand{\E}{\mathbf{E}}
\newcommand{\ref}{{\mathrm{ref}}}
\newcommand{\blog}{\mathbf{log}\ }
\newcommand{\bmax}{\mathbf{max}\ }
\newcommand{\bDelta}{\mathbf{\Delta}}
\newcommand{\bPi}{\mathbf{\Pi}}
\newcommand{\bU}{\mathbf{U}}
\newcommand{\newl}{\\[8pt]}
\notag
$$

## Notational conventions

We use the following conventions for naming and denoting variables,
parameters and function:

Notation | Description | Meaning
---|---|---
$x_t$ | Lowercase latin | Model variables
$\roc{x}_t$ | Dot | Gross rate of change, $\dot x_t = \left. x_t \middle/ x_{t-1} \right.$
$x_\mathrm{ss}$ | An $\mathrm{ss}$ subscript | Steady state of a model variable
$x^a_t$ | Lowercase latin | Model variables with an explicit area reference
$\extern{x_t}$ | Lowercase bold upright | Model variables externalized in the respective optimization problem
$\blog$ | Bold | Functions and function components
$\E_t$ | | Conditional model-consistent time-$t$ expectations
$\alpha$ | Lowercase Greek | Parameters
$\Pi_t$ | Uppercase Greek | Some of model nominal flows

We denote by $A$ the set of all areas included in the model. Currently,
$A=\{\mathrm{us}, \mathrm{ea}, \mathrm{ch}, \mathrm{rw}\}$. An additional
code, $\mathrm{GG}$, is used to index global common trends, such as the global
productivity trend or the global population trend.

Area code | Description
---|---
us | United States (global reference area)
ea | Euro Area
ch | China
rw | Rest of world
gg | Common global trends

In most of the text, we do not explicitly include thee reference area in
the names of variables for the ease of notation. Absent an explicit area
reference, the variable or parameter belongs simply to the respective local
area. 

In several places, we use the concept of a so-called global reference area
(GRA); for instance, the local nominal exchange rates are defined as the
rates between the respective local area's currency and the GRA's currency.
The convention is that the global reference area is always ordered first in
the list of areas. In the baseline setup of the model, the United States is
used as the GRA.


$$
\newcommand{\tsum}{\textstyle\sum}
\newcommand{\extern}[1]{\mathrm{\mathbf{{#1}}}}
\newcommand{\local}{\mathrm{local}}
\newcommand{\roc}[1]{\hat{#1{}}}
\newcommand{\ss}{\mathrm{ss}}
\newcommand{\E}{\mathbf{E}}
\newcommand{\ref}{{\mathrm{ref}}}
\newcommand{\blog}{\mathbf{log}\ }
\newcommand{\bmax}{\mathbf{max}\ }
\newcommand{\bDelta}{\mathbf{\Delta}}
\newcommand{\bPi}{\mathbf{\Pi}}
\newcommand{\bU}{\mathbf{U}}
\newcommand{\newl}{\\[8pt]}
\notag
$$

## Households

Each area's household sector is modeled as a single representative
household with an exogenous time-varying number of household members,
$nn_t$. The household enteres a net position in debt instruments (e.g.
loans, deposits, fixed-income securities, etc.) with the local financial
sector, $bh_t$, and holds a portfolio of claims on production capital in
all areas (including the local area), $\tsum_a s_{a,t} \, ex_{a,t}\, pk^a_t
\, k^a_t$; the latter is our way to mimic corporate equity holdings with
cross-border exposures. During each period, the household purchases
consumption goods, $ch_t$, supplies per-worker hours worked, $nh_t$, rents
production capital, $k^a_t$, out to producers in the respective area,
chooses the utilization rate of local production capital, $u_t$, invests in
creating addition local capital, $i_t$, pays lump-sum taxes (or receives
lump-sum transfers) of two types, $txls1_t$ and $txls2_t$, and collects
period profits from local producers, local exporters, and the local
financial sectors (of whom all the household is the ultimate owner). 

The household chooses the following quantities

* total consumption, $ch_t$,
* per-capita hours worked, $nh_t$,
* shares of claims on production capital possibly from all areas, $s_{a,t}\in[0,\,1]$, $a\in A$,
* the utilization rate of local production capital, $u_t$,
* investment in local production capital, $i_t$,
* net financial position with the local financial sector, $bh_t$,

to maximize its infinite lifetime utility function subject to a dynamic
budget constaint. The household derives utility from consumption,
disutility from work, and utility from its wealth (net worth).


---

### Household preferences

The household preferences are described by a time-separable utility
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
ch_t^\ref \equiv \chi \, \frac{curr_t}{pc_t}
$$

* $\kappa_{ch} \equiv 1 - ch^\ref_\ss\, ch_\ss{}^{-1}$ is a steady-state
  correction constant ensuring that the marginal utility of consumption
  equals $nn_t \, ch_\ss{}^{-1}$ in steady state, a feature of
  modeling convenience,

* $curr_t$ is current labor income net of  type 1 lump sum taxes (or transfers)

$$
curr_t \equiv w_t \, nh_t \, nl_t - txls1_t
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

### Dynamic budget constraint

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

* current receipts from labor income, $w_t \, nh_t \, nl_t$, 

* current receipts from selling newly installed capital, $pk_t\,i_t$, 

* profits from loccal producers, $\Pi_{y,t}$, exporters, $\Pi_{x,t}$, and the
financial sector, $\Pi_{b,t}$,

* current outlays on consumption goods, $-pc_t \, ch_t$,

* current outlays on investment goods, $-pi_t \, i_t$,


$$
\begin{gathered}
\tsum\nolimits_a s_{a,t} \, ex_{a,t} \, pk_{t}^a \, k_{t}^a - bh_t \ \cdots
\newl
=\ \tsum\nolimits_a s_{a,t-1}\, ex_{a,t} \Bigl[
pu_{t}^a \, u^a_t + \left(1-\delta^a\right) pk^a_{t} 
\Bigr] k^a_{t-1} 
- rh_{t-1} bh_{t-1} \ \cdots
\newl
+ \ w_t \, nh_t \, nl_t - pc_t \, ch_t + \left(pk_t - pi_t\right) i_t - txls1_t - txls2_t \ \cdots
\newl
+ \ \bPi_{y,t} + \bPi_{x,t} + \bPi_{b,t} - \Xi_{i,t} - \Xi_{k,t} - \Xi_{u,t} + \extern{\Xi}_{h,t}
\end{gathered}
$$

Lagrange multiplier associated with the budget constraint is denoted by
$vh_t$ (shadow value of nominal household wealth)


---

### Real wage rigidities

The labor market exhibits real wage rigidities. These rigidities do not
derive from explicit microfoundations in our model; they are introduced as
an ad-hoc correction to the law of motion for the real wage rate in the
following way. The household makes its choices as though the wage rate was
fully flexible; we denote this hypothetical level of the nominal wage rate
by $ww_t$, and use this hypothetical wage in the household Lagrangian, in
place of the actual wage rate. Once the hypothetical flexible optimum wage
rate is determined, the actual wage rate follows an autoregressive process
with asymptotic convergence to the flexible optimum

$$
\blog \frac{w_t}{pc_t} 
= \rho_{w} \ \blog \frac{\kappa_w\, w_{t-1}}{pc_{t-1}}
+ \left(1-\rho_w\right) \ \blog \frac{ww_t}{pc_t}
+ \epsilon_{w,t}
$$

where the past real wage is indexed by a steady-state adjustment constant,
$\kappa_w$, given by the gross rate of change in the steady-state real wage
rate

$$
\kappa_w \equiv \roc{w}_\ss \ \roc{pc}_\ss{}^{-1}
$$

and $\rho_w\in[0,\,1)$ is an autoregression parameter.

---

### Costs of short-term adjustment processes

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

### Capital accumulation

The household purchases investment goods, converts them to newly installed
production capital (paying the adjustment/installation cost in the process)
and adds these to the existing stock of capital

$$
k_t = (1-\delta)\ k_{t-1} + i_t
$$


---

### Lagragian for the household optimization problem

The Lagrangian for the contrained optimization problem facing
the representative household consists of the lifetime utility function and a
sequence of dynamic budget constraints for each time from now until
infinity, $t=0, \dots, \infty$. Note that we use $ww_t$ in place of $w_t$ in
the Lagrangian.

$$
\bmax_{\{ch_t, bh_t, s_{a,t}, i_{t}, nh_t, u_t \}} 
\newl
\begin{multline}
\sum\nolimits_{t} \beta^t \Bigl[
\Uch + \Unh + \Unetw \Bigr] \, nn_t \ \cdots
\newl
+\ \sum\nolimits_t \beta^t vh_t\, \Bigl\{
- \tsum\nolimits_{a} s_{a,t} \, ex_{a,t} \, pk_{t}^a \, k_{t}^a + bh_t
\Bigr. \ \cdots
\newl
+\ \tsum\nolimits_{a} s_{a,t-1}\, ex_{a,t} \Bigl[
pu_{t}^a \, u^a_t + \left(1-\delta^a\right) pk^a_{t} 
\Bigr] k^a_{t-1} 
- rh_{t-1} bh_{t-1} \ \cdots
\newl
+ \ ww_t \, nh_t \, nl_t 
- pc_t \, ch_t + \left(pk_t - pi_t\right) i_t - txls1_t - txls2_t \ \cdots
\newl
+ \bPi_{y,t} + \bPi_{x,t} + \bPi_{b,t} -\ \Xi_{i,t} - \Xi_{k,t} - \Xi_{u,t} + \extern{\Xi}_{h,t}
\Bigr. \Bigr\} 
\end{multline}
$$

where $vh_t$ is the Lagrange multiplier on time-$t$ budget constraint.

---

### Optimality conditions

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
- \xi_{i2} \, \beta\, \bigl(\bDelta \blog i_{t+1} - \kappa_i\bigr)
\Bigr]
$$

* Claims on area $a$'s production capital, $s_{a,t}$

$$
vh_t \, pk^a_t 
= vh_t \, pu^a_t \, u^a_t 
+ \beta \, vh_{t+1} \left(1-\delta^a\right) pk_{t+1}, \quad \forall a \in A
$$

The last set of equations defines arbitrage-free conditions (AFCs) for a
corporate equity portfolio choice. We need to further address the following
two characteristics of these NACs: 

1. As is common in macro models, the AFCs themselves do not determine the
   actual portfolio shares, $s_{a,t}$, only the relationship between the
   price of production capital, the cash flows it generates, and the
   houseshold discount factor. The actual shares are then calibrated and
   kept fixed in the baseline version of the model.

1. Since we allow for cross-border holdings, each area's capital is subject
   to muliple AFCs, each relating to the household residing in a different
   area and exhibiting, in general, different preferences. We therefore
   create aggregate AFCs by taking the weighted average with the weights
   equal the portfolio shares. The aggregate AFCs for the capital markets
   are described in the Global equilibrium section.



## Glossary of model quantities

### Glossary of variables

Variable | Source code name | Description
---|---|---
$bh_t$ | `xxx` | Net claims of the financial sector on the household
$ch_t$ | `xxx` | Household consumption
$ch_t^\ref$ | `xxx` | Point of reference in household consumption
$curr_t$ | `xxx` | Nominal current income of households
$i_t$ | `xxx` | Investment in private production capital
$k_t$ | `xxx` | Private production capital
$netw_t$ | `xxx` | Nominal net worth of households
$nh_t$ | `xxx` | Per-worker labor supply (e.g. per-worker hours worked)
$nl_t$ | `xxx` | Labor force
$pc_t$ | `xxx` | Price of consumption goods
$pi_t$ | `xxx` | Price of investment goods
$pu_t$ | `xxx` | Rental price (user cost) of capital services
$u_t$ | `u` | Rate of production capital utilization
$s_{a,t}$ | `xxx` | Share of claims on private production capital in area $a$
$txls1_t$ | `xxx` | Type 1 net lump-sum taxes+/transfers–
$txls2_t$ | `xxx` | Type 2 net lump-sum taxes+/transfers–
$w_t$ | `xxx` | Nominal wage rate
$ww_t$ | `xxx` | Hypothetical nominal wage rate absent labor market ridigities
$e_t$ | `e` | Nominal exchange rate against the global reference area's currency
$ex_{a,t}$ | `xxx` | Nominal cross rate between local currency and area $a$'s currency
$rh_t$ | `rh` | Gross rate of interest on financial claims on the household sector
$rg_t$ | `rg` | Gross rate of interest on financial claims on the government
$\Pi_{y,t}$ | `xxx` | Profits from local producers
$\Pi_{x,t}$ | `xxx` | Profits from local exporters
$\Pi_{b,t}$ | `xxx` | Profits from the local financial sector
$\Xi_{i,t}$ | `xxx` | Investment adjustment cost 
$\Xi_{k,t}$ | `xxx` | Cost of deviations from capital reference point
$\Xi_{u,t}$ | `xxx` | Capital utilization cost 
$\Xi_{h,t}$ | `xxx` | All private costs paid to the household


### Glossary of steady-state parameters 

Parameter | Source code name | Description
---|---|---
$\beta$ | `beta` | Household discount factor 
$\delta$ | `delta` | Depreciation rate of production capital
$\nu_0$ | `nu_0` | Level parameter in utility from net worth
$\nu_1$ | `nu_1` | Elasticity parameter in utility from net worth
$\upsilon_0$ | `upsilon_0` | Level parameter in capital utilization cost function
$\upsilon_1$ | `upsilon_1` | Elasticity parameter in capital utilization cost function


### Glossary of transitory parameters 

Parameter | Source code name | Description
---|---|---
$\chi$ | `chi` | Parameter in point of reference in consumption
$\rho_w$ | `rho_w` | Autoregression in real wage
