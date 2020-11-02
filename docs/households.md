
# Households

* Representative household with a growing number of members

* Current income effect

* Net worth effect

---

## Choices Made by Households

* Demand consumption goods

* Demand for investment goods and capital accumulation

* Utilization of capital

* Labor supply

* Demand for (bank) deposits

* Demand for (bank) loans 

---


## Lifetime Utility Function

Representative household with a growing number of members

$$
\E_0 \sum_{t=0}^{\infty} \left( \log \frac{ch_t - ch_t^\ref}{nn_t} - \frac{1}{1+\eta}\cdot nh_t{}^\eta + \nu_1\cdot \log \frac{netw_t}{pch_t \cdot nn_t} \right) nn_t 
$$

<br/>

Nominal net worth

$$
netw_t = pkh_t \cdot kh_t + bd_t - bl_t
$$

<br/>

Point of reference in household consumption

$$
ch_t^\ref = \chi \cdot \frac{curr_t}{pch_t}
$$

$$
curr_t = w_t \cdot nh_t \cdot \xnf_t - txl1_t
$$

<br />

Variable | Description
---|---
$ch_t$ | Household consumption
$ch_t^\ref$ | Point of reference in household consumption
$\xnf_t$ | Labor force
$nh_t$ | Per-worker labor supply (e.g. per-worker hours worked)
$netw_t$ | Nominal net worth of households
$curr_t$ | Nominal current income of households
$txl1_t$ | Net lump-sum taxes (transfers) of type 1


--- 

## Budget Constraint

$$
\begin{gathered}
bd_t - bl_t = rbd_{t-1} \cdot bd_{t-1} - rbl_{t-1} \cdot bl_{t-1} \\[5pt]
+ \ w_t \cdot nh_t \cdot \xnf_t + puk_t \cdot u_t \cdot k_t + zy_t + zb_t \\[5pt]
- \ pch_t \cdot ch_t - pih_t \cdot ih_t \\[5pt]
-\ txl1_t - txl2_t - adj_t
\end{gathered}
$$

Lagrange multiplier associated with the budget constraint is denoted by
$vh_t$ (shadow value of nominal household wealth)

<br/>

Variable | Description
---|---
$bd_t$ | Bank deposits
$bl_t$ | Bank loans
$w_t$ | Nominal wage rate
$zy_t$ | Profits from producers
$zb_t$ | Profits from financial sector
$jh_t$ | Adjustment costs faced by households
$txl1_t$ | Type 1 net lump-sum taxes (transfers)
$txl2_t$ | Type 2 net lump-sum taxes (transfers) 

---

## Household Adjustment Costs

* Investment adjustment costs

* Reference point in capital accumulation

* Cost of utilization of capital

$$
\begin{gathered}
jh_t 
= \frac{1}{2} \ \xi_{ih} \cdot pih_t \cdot ih_t \ \left( \Delta \log ih_t - \log \kappa_{ih} \right)^2 \\[5pt]
+\ \frac{1}{2} \ \xi_k \cdot pkh_t \cdot kh_t \ \left( \log kh_t - \log kh_t^\ref \right)^2 \\[5pt]
+\  py_t \cdot kh_t \cdot \left( \upsilon_0 \cdot u_t \right)^{\upsilon_1}
\end{gathered}
$$

<br/>

Point of reference in capital accumulation

$$
kh_t^\ref = \E_t \Bigl[ kh_{t+1} \cdot \kappa_{kh}{}^{-1} \Bigr]
$$

Steady-state adjustment constants

$$
\kappa_{ih} = \frac{ih\ss}{ih\ssm} \qquad \qquad
\kappa_{kh} = \frac{kh\ss}{kh\ssm}
$$

---

## Capital Accumulation

$$
kh_t = (1-\delta)\ kh_{t-1} + ih_t
$$

Lagrange multiplier associated with the capital accumulation constraint is
denoted by $pkh_t$ (shadow price of capital)

<br/>

Variable | Description
---|---
$kh_t$ | Stock of production capital
$ih_t$ | Investment in production capital

---

## Finance Contraint

Sufficient amount of means of payment needs to be held proportional to
gross expenditures (consumption, investment, trade in capital)

$$
bd_t = \phi \Bigl( pch_t \cdot ch_t + pih_t \cdot ih_t + \phi_{k} \cdot pkh_t \cdot kh_t \Bigr)
$$

---

## Real Wage Rigidities

Real wages are sluggish in their response to changes in optimal flexible
wage rate; no expliciti microfoundations 

$$
\log \frac{w_t}{pch_t} 
= \rho_{w} \ \log \Bigl( \kappa_w \cdot \frac{w_{t-1}}{pch_{t-1}} \Bigr)
+ (1-\rho_w) \ \log \frac{w0_t}{pch_t}
+ \epsilon_{w,t}
$$

<br/>

Steady-state adjustment constant

$$
\kappa_w = \frac{ w\ss \cdot pch\ssm } { w\ssm \cdot pch\ss }
$$

<br/>

Variable | Description
---|---
$w0_t$ | Optimal flexible nominal wage rate as if optimized by households
$w_t$ | Actual nominal wage rate

---


