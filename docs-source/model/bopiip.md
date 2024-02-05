---
title: IIP and BOP
---

# International investment position and financial account of balance of payments

* IIP: value of assets and liabilities (transactions plus valuation)

* BOP-FA: value of transactions (when money changing hands)

* Everything expressed in local currency units


## Net IIP (stocks)

$$
\newcommand{\xnetf}{\mathit{netf}}
\newcommand{\xrf}{\mathit{rf}}
\newcommand{\xnetfh}{\mathit{netfh}}
\newcommand{\xnetfg}{\mathit{netfg}}
\newcommand{\xnetiip}{\mathit{netiip}}
\newcommand{\xnetb}{\mathit{netb}}
\newcommand{\xtrans}{\mathrm{trans}}
\newcommand{\xpinc}{\mathrm{pinc}}
\newcommand{\xval}{\mathrm{val}}
\xnetiip_t \equiv \xnetf_t + \xnetb_t
$$

* Net fixed-income asset position $\xnetf_t \equiv \xnetfh_t + \xnetfg_t$

* Net equity asset position $\xnetb_t$ consists of corporate assets and
  corporate liabilities


#### Net fixed-income asset position

* One-period fixed-income (debt) instrument recorded at orgination book value

* Any change in the value of debt is a transaction (IIP and BOP)

$$
\xnetf_t - \xnetf_{t-1}
$$


#### Equity assets and liabilities

$$
\xnetb_t^h = \sum_{a\ne h} \phi_{a,t}^h \ \frac{e_t^h}{e_t^a} \ pk_t^a \ k_t^a
- \sum_{a\ne h} \phi_{h,t}^a \ pk_t^h \ k_t^h
$$

* A change in $\xnetb_t$ is the results of new transactions  and valuation
  (including depreciation, variations in exchange rates, and variations in equity prices)

* Example 

$$
\begin{gathered}
e_t \ pk_t \ k_t - e_{t-1}\ pk_{t-1} \ k_{t-1} = \\[10pt]
= e_t \ pk_t \ \left( k_t - k_{t-1} \right) + \left( e_t\ pk_t - e_{t-1} \ pk_{t-1} \right) \ k_{t-1} = \\[10pt]
= \underbrace{e_t\ pk_t \ \left[ k_t - (1-\delta) k_{t-1} \right]}_{\text{Transactions}}
\ \underbrace{-\ \delta\ e_t \ pk_t\ k_{t-1} + \left( e_t\ pk_t - e_{t-1}\ pk_{t-1} \right) \ k_{t-1}}_{\text{Valuation}} \\[10pt]
\end{gathered}
$$

* Change in equity assets owing to transactions $\xnetb_t^\xtrans$

* Change in equity assets owing to valuation $\xnetb_t^\xval$


#### Net primary income on equity

$$
\xnetb_t^{\xpinc, h} = \sum_{a\ne h} \phi_{a,t}^h \ \frac{e_t^h}{e_t^a} \ pu_t^a \ uk_t^a
- \sum_{a\ne h} \phi_{h,t}^a \ pu_t^h \ uk_t^h
$$

* Rental price of capital services, $pu_t$

* Capital services (capital times utilization), $uk_t$


## Balance of payments (flows of transactions)


Description | Formula
---|---
Financial account | $\Delta \xnetf_t + \xnetb^\xtrans_t = \cdots$
Current account: Primary income | $=\ \xrf_t \cdot \xnetf_{t-1} + \xnetb_t^\xpinc \ \cdots$
Current account: Trade balance | $+\ \mathit{pxx}_t \cdot xx_t - pmm_t^{\mathrm{fob}} \, mm_t + pq_t \, (xq_t - mq_t)$



