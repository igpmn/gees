---
title: Households
---

# :fontawesome-solid-house:  Households

--8<-- "docs-source/model/math.md"


## Overview

Each area's household sector is modeled as a single representative
household with an exogenous time-varying number of household members,
$nn_t$. The household enters a net position in debt instruments (e.g.
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


=== ":fontawesome-solid-square-root-variable:  Algebra"

    --8<-- "docs-source/model/households-math.md"


=== ":fontawesome-solid-file-code:  Model source code"

    --8<-- "model-source/households.md"



