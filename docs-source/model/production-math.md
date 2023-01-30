
![[math.md]]
{ .math-definitions }

--8<-- "math.md"


## Productivity

Global productivity component

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

<br/>

Total area productivity

$$
a_t = a^{gg}_t\, ar_t
$$


## Production stages

#### $T-4$: Combine imports from the rest of the world

[Production function with time-varying elasticity of substitution](production-time-varying-elasticity.md)

$$
mm_t = F_4\left( mm_t^1, \dots, mm_t^A \right)
$$

$$
mm = my_t + mx_t
$$

where

* $my_t$ is the intermediate import inputs into local production

* $mx_t$ is the intermediate import inputs into export production (re-exports)


#### $T-3$: Combine non-commodity variable factors

[Production function with time-varying elasticity of substitution](production-time-varying-elasticity.md)

$$
\begin{gathered}
y_{3,t} = F_3\bigl( mm_t, nv_t\bigr) \newl
nv_t \equiv \left( nh_t - \gamma_{nv} nh_\ss \right) \, nl_t
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

#### $T-1$: Add dependence on commodity inputs

$$
y_{1,t} = F_1\bigl( y_{2,t},\ mq_t \bigr)
$$


#### $T-0$: Sticky prices

[Sticky price setting](production-sticky-prices.md)


## Total profits 

Total profits summed up across all production stages are given by

$$
\begin{multline}
\Pi_{y,t}
\equiv py_t \, y_{0,t}
- pmm_t \, my_t 
- w_t \, nh_t \, nl_t
- pu_t \, u_t\, k_t 
- pq_t \, mq_t \ \cdots \\[10pt]
\cdots -\ \Xi_{y4,t} - \Xi_{y3,t} - \Xi_{y2,t} - \Xi_{y1,t} - \Xi_{py,t}
\end{multline}
$$

## Final goods

The final goods produced domestically are demanded as one of the following
types of goods

* Private consumption, $ch_t$

* Government consumption, $cg_t$

* Private investment, $ih_t$

* Inputs into export production, $yx_t$

The market clearing conditions is therefore given by 

$$
y_t = ch_t + cg_t + ih_t + yx_t
$$

where

* $ch_t$ is private consumption (by households)
* $cg_t$ is government consumption
* $ih_t$ is private investment (by households)
* $yx_t$ is the local component in the export production

