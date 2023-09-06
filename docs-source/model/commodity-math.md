
## Global commodity extraction

--8<-- "model/math.md"
![[model/math.md]]

The total amount of commodities extracted globally, $q_t^\gg$, follows a
long-run supply trend, $qq_t^\gg$, and responds to demand fluctuations; the
gap between the actual amount (demand) and the long-run supply trend is
referred to as global excess demand, $q^\mathrm{exc}_t$.

## Long-run sustainable supply trend

$$
\log qq_t^\gg = \rho_{qq}\cdot \log \left(
\kappa_1 \cdot qq_{t-1}^\gg
\right)
+ (1 - \rho_{qq}) \cdot
\log \left( \kappa_2 \cdot a_t{}^\gg \cdot \mathit{nn}_t^\gg \right)
+ \epsilon_{qq, t}
$$

where

* $\kappa_1 \equiv \roc{a}{}_\ss^\gg \cdot \roc{nn}{}_\ss^\gg$

* $\kappa_2$ is reverse engineered so that $qq_\ss = q_\ss$ (global
demand equals long-run supply trend)


## Actual global demand

* Actual commodity production is completey demand driven in the short run

* Oil producers are able to satisfy short-term demand peak from inventories

$$
q_t^\gg = \sum\nolimits_a \, mq_t^a
$$


## Geographical distribution of global production (endowment)

$$
\begin{gathered}
q_t^a = \lambda^a \cdot q_t \\[10pt]
\sum\nolimits_a \, \lambda^a = 1
\end{gathered}
$$


## Excess demand

* Excess demand is defined by the extent to which actual commodity production
exceeds its long-run sustainable trend

$$
\log q^\mathrm{exc}_t \equiv \log q_t^\gg - \log q^\mathrm{trend}_t
$$

## Global commodity price relative to noncommodity export price

$$
\log \mathit{pq}_t =
\log \mathit{pq}^\mathrm{aut}
+\ \log \mathit{pxx}_t
+\ \iota^\gg \cdot \log q^\mathrm{exc}_t 
$$


