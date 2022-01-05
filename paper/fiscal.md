<div style="page-break-after: always;"></div>

# Fiscal

In the basic model version, there are few simplifying assumptions regarding: 

* Government consumption and investment
* Government debt placed locally
* Lump-sum taxes
* Crowding in/out effects

---

## Fiscal Budget Constraint

Government constraint is very simple
$$
dg_t = rg_{t-1} \cdot dg_{t-1}
+ pcg_t \cdot cg_t + pig_t \cdot ig_t
- trl1_t - trl2_t
$$

accounting for the government debt $dg_t$, two types of expenditures (consumption $cg_t$ and public investment $ig_t$) and two types of lump-sum taxies levied on households ($txl1_t$ and $txl2_t$). 



The difference between these two types of lump-sum taxes is that $txl2_t$ affects also the current income of the household, while $txl1_t$ does not. However, both $txl1_t$ and $txl2_t$ enter the household budget constraint. It could be interpreted as that the lump-sum tax of type 1 is affecting rather wealthier (or financially unconstrainted) people (as it does not affect their current income). However. changing $txl2_t$ will affect poorer (or financially constrained) people and drive their current-income-linked part of the consumption.

---

<div style="page-break-after: always;"></div>

## Public Capital

Public capital is included in a simplest possible way, mostly in order to allow to run the scenarios for example the country's government spending money on improving the infrastructure and increasing the debt.

Public capital
$$
kg_t = (1-\delta) \ kg_{t-1} + ig_t
$$

Target level for the public capital is a proportion to the private capital
$$
kg_t^\mathrm{tar} = \psi \cdot kh_t
$$

with the investment rule
$$
\Delta \log ig_t = \log \kappa_{ig} + \tau_{ig} \left( \log 
kg_t - kg_t^\mathrm{tar} \right)
$$
$$
\kappa_{ig} = \frac{ig_\ss}{ig_\ss}
$$

---

## Government Consumption and Taxes

The model also includes stabilizing mechanism in order to keep debt at a target level as a ratio to nominal GDP
$$
\frac{dg_t}{ngdp_t}
$$

* A wide range of mechanisms to stabilize debt

---

## Crowding in/out effects

Crowding in effect occurs in the short run, crowding out in the longer run.

*Crowding in*:

- If government expenditures go up, the economy expands. The mechanism, through which this is achieved, is the current income channel - if the government spends more, it increases the production, the current income, leading to households spending more.

*Crowding out*:

- If government expenditures lead to a permanent increase in government debt (as a ratio to GDP), then (through the net worth channel) it leads to an increase in the real interest rates and decrease of the levels of private investment, consumption and production capacities.

