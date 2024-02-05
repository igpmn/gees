<div style="page-break-after: always;"></div>

$$
\newcommand{\roc}[1]{\hat{#1{}}}
\newcommand{\E}{\mathbf{E}}
\newcommand{\blog}{\mathbf{log}\ }
\newcommand{\bmax}{\mathbf{max}\ }
\newcommand{\bDelta}{\mathbf{\Delta}}
\newcommand{\bPi}{\mathbf{\Pi}}
\newcommand{\newl}{\\[8pt]}
\newcommand{\betak}{\mathit{zk}}
\newcommand{\betay}{\mathit{zy}}
\notag
$$

# Production

* Several pairwise stages of production

* Input factors
    * Labor
    * Intermediate imports
    * Commodity inputs
    * Capital

* Real flexibilities to flatten the marginal cost schedule
    * Variable utilization of capital
    * Roundabout production

* Sticky prices


---

## Productivity

Productivity process is modeled using the same principle as population.

Global productivity trend component
$$
\bDelta \blog a_t^{gg} =
\rho_a \ \Delta \blog a_{t-1}^{gg} 
+ (1-\rho_a) \blog \roc{a}^{gg}_\ss
$$

Area-specific relative productivity component
$$
\blog ar_t = 
\rho_{ar} \ \blog ar_{t-1} 
+ (1-\rho_ar) \ \blog ar_\ss
$$

Total area productivity

$$
a_t = a^{gg}_t\, ar_t
$$

---
<div style="page-break-after: always;"></div>

## Production technology with time-varying elasticity

The firms determine the technology choice alongside the technology frontier. We differentiate between the short-run and long-run elasticity of substitution in the production sector. In particular, the response in the input factor demand to the changes in the input factor prices should be relatively inelastic in the very short run (one year), but much more elastic in the longer run (five-years). 

The model uses the Leontief-Cobb-Douglas technology combination. In the short run, the function, which describes how firms can combine the production inputs, is the *Leontief function* (with zero elasticity of substitution). The technology constraint, which is applied to the choice of technology, is the *Cobb-Douglas*. 

This optimization problem is perfectly equivalent (up to a scale constant) to the Cobb-Douglas, if there are no adjustment costs. However, the situation changes once  we introduce the cost of adjustment to the technology levels. If the cost of changing the proportion of technology levels is infinite, then we have zero elasticity substitution environment (Leontief case). If we allow for some finite adjustment costs, we can move alongside the technology frontier and eventually get to the Cobb-Douglas unit elasticity of substitution case - by changing the weight of adjustment costs, we can move from the Leontief to the Cobb-Douglas.

Production technology based on a unit-elasticity (Cobb-Douglas) production function

$$
y_t = F(a_t, b_t) = a_t{}^\gamma \  b_t{}^{1-\gamma}
$$

Period profits are given by

$$
\Pi_t \equiv py_t\, y_t - pa_t\, a_t - pb_t\,b_t - \Xi_{y,t}
$$

and include the cost of changing the input factor proportions

$$
\Xi_{y,t} \equiv 
\tfrac{1}{2} \xi_y \left[ 
pa_t \, \extern{a}_t
\left(
\bDelta \blog \frac{a_t}{\extern{y}_t} 
\right)^2
+ pb_t \, \extern{b}_t
\left(
\bDelta \blog \frac{b_t}{\extern{y}_t}
\right)^2
\right]
$$

<div style="page-break-after: always;"></div>

Optimization problem with a possibly heavier discounting, $\beta_y\in[0,1]$, to incorporate higher uncertainty of future profit flows

$$
\bmax_{\{a_t, b_t\}}\ 
\E_0 \sum_{t=0}^\infty \left( \beta\, \beta_{y} \right)^t \, vh_t \, \Pi_{y,t}
$$

Optimal choice of input factors (omitting higher-order terms from the adjustment costs)

$$
\gamma \, py_t \, y_t \approx pa_t \, a_t \left[
1 + \xi_t \left( \bDelta \blog \frac{a_t}{y_t}
- \beta \, \beta_{y} \, \bDelta \blog \frac{a_{t+1}}{y_{t+1}} \right) \right]
$$

$$
(1- \gamma) \, py_t \, y_t \approx pb_t \, b_t \left[
1 + \xi_t \left( \bDelta \blog \frac{b_t}{y_t}
- \beta \, \beta_{y} \, \bDelta \blog \frac{b_{t+1}}{y_{t+1}} \right) \right]
$$

---

## Production Stages

The whole production process is divided into stages (pair-wise) and assumption of time-varying elasticity is applied.

T-4: Combine (non-commodity) imports from other areas
$$
mm_t = F_4\left( mm_t^1, \dots, mm_t^A \right)
$$

$$
mm = my_t + mx_t
$$

where
* $my_t$ is the intermediate import inputs into local production
* $mx_t$ is the intermediate import inputs into export production (re-exports)

T-3: Combine non-commodity variable factors

$$
\begin{gathered}
y_{3,t} = F_3\bigl( mm_t, nv_t\bigr) \newl
nv_t \equiv \left( nh_t - \gamma_{nv} nh_\ss \right) \, \xnf_t
\end{gathered}
$$

where

* $nv_t$ is the variable labor input with $\gamma_{nv} nh_\ss$ being the
  overhead labor needed to maintain production regardless of the output
  actually produced

T-2: Combine variable factors with capital

$$
\begin{gathered}
y_{2,t} = F_2\bigl( uk_t\, y_{3,t} \bigr) \newl
uk_t = u_t \, k_t
\end{gathered}
$$

T-1: Add dependence on commodity inputs

$$
y_{1,t} = F_1\bigl( y_{2,t},\ mq_t \bigr)
$$

T-0: Add a roundabout production layer and sticky prices

$$
y_t = F_0\bigl(y_{1,t},\ yz_t\bigr) + yz_t
$$

---

## Sticky Prices

Downward sloping demand curve

$$
y_t 
= \extern{y}_t \, \left( \frac{py_t}{\extern{py}_t} \right)^{\left.-{\mu_{py}}\middle/\left(\mu_{py}-1\right)\right.} \,
$$

where
* $mu_{py}$ is the monopoly power of the representative producer in its own
  market, and ${\left.{\mu_{py}}\middle/\left(\mu_{py}-1\right)\right.}$ is the underlying elasticity of substitution of demand for the producer's
  output (which gives rise to the monopoly power)

Period profits

$$
\Pi_{y0,t} \equiv \left( py_t  - py_{0,t}\right)\, y_t - \Xi_{py,t}
$$

with the price adjustment costs given by
$$
\Xi_{py,t}
\equiv \tfrac{1}{2} \, \xi_{py} \, 
\extern{py}_t \, \extern{y_t}\,
\bigl( \Delta \blog py_t - j_t \bigr)^2
$$

where $j_t$ is a price indexation factor given by

$$
j \equiv  \zeta_{py}\ \blog \roc{\extern{py}}_{t-1} + (1-\zeta_{py})
\,\blog \roc{py}_\ss
$$

<div style="page-break-after: always;"></div>

Maximization problem

$$
\max\nolimits_{\{y_t, py_t\}}
\E_t \sum_t \left( \beta\, {\beta_{y}}_t\right)^t \, vh_t \, \Pi_{y0,t}
$$

where 
* $\beta_{y}$ is an additional discount factor to compensate for the
  uncertainty of cash flows generated by real economic activity

Optimal price setting with no adjustment cost (steady state) is a markup over the marginal cost

$$
p_{y,t} = \mu_{py} \, p_{y0,t}
$$

Optimal price setting with adjustment cost is a Phillips curve
$$
p_{y,t} \, \Bigl\{
1 + \left(\mu_{py}-1\right) \, \xi_{py} \Bigl[
\left(\bDelta \blog p_{y,t} - j_t \right)
- \beta \, \beta_{y} \left(\bDelta \blog p_{y,t+1} - j_{t+1} \right)
\Bigr] \Bigr\}
=
\mu_{py}\, p_{y0,t}
$$
---
## Production sector total profits

$$
\begin{gathered}
\Pi_{y,t}
\equiv py_t \, y_{0,t}
- pmm_t \, my_t 
- w_t \, nh_t \, \xnf_t
- pu_t \, u_t\, k_t 
\\
-\ \Xi_{y4,t} - \Xi_{y3,t} - \Xi_{y2,t} - \Xi_{y1,t} - \Xi{py,t}
\end{gathered}
$$

---

## Final Goods Assembly
Domestic production and directly imported goods are combined into the final goods
$$
y_t = ch_t + cg_t + ih_t + yx_t
$$

where

* $ch_t$ is private consumption (by households)
* $cg_t$ is government consumption
* $ih_t$ is private investment (by households)
* $yx_t$ is the local component in the export production

