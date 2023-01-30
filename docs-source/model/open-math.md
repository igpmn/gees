
## Non-commodity import 


Combine imports from the rest of the world

$$
mm_t^h = \prod_{a \ne h} \ \left( \frac{mm_{a,t}^h}{\omega_a^h} \right)^{\omega_a^h} 
$$

Cost function

$$
\Gamma(mm_t^h) = \sum_{a \ne h} \ pmm_{a,t}^h \, mm_{a,t}^h
\left[1 - \frac{\xi}{2}\, \left( \log \frac{mm_{a,t}^h}{mm_{t}^h} - \log \frac{mm_{a,t-1}^h}{mm_{t-1}^h} \right)^2\, \right]
$$

## Non-commodity export production 

--8<-- "model/math.md"

Non-commodity export production function

* Transformation of domestic output
* Productivity improvements faster in exportable sectors
* Assembled with reexports 

$$
xx_t = \mathit{ar}_t{}^{\gamma_{\mathit{xx}}} \, 
  \left( \frac{\mathit{yxx_t}}{1-\alpha} \right)^{1-\alpha}
  \left( \frac{\mathit{mxx_t}}{\alpha} \right)^{\alpha}
$$

Demand for input factors (domestic components and re-exports,
respectively):

$$
\begin{gathered}
(1-\alpha) \, \mathit{pxx}_t \, \mathit{xx}_t = \mathit{py}_t \, \mathit{yxx}_t \\[5pt]
\alpha \, \mathit{pxx}_t \, \mathit{xx}_t = \left( \mathit{pmm}_t \, \mathit{dmm}^\gg_t \right) \, \mathit{mxx}_t
\end{gathered}
$$

where $\mathit{dmm}^\gg_t$ is an index of disruption to global trade.


## Commodity endowment

* Each area is endowed with a certain share of global commodity supply
  (this share can be zero)

$$
xq_t = \lambda \, q^\mathrm{gg}_t
$$


## Balance of payments

$$
\begin{gathered}
nfa_t = nfa_{t-1} \ \cdots \\[15pt]
+\ (\mathit{rnfa}_t - 1) \, \mathit{nfa}_{t-1}
+ \mathit{ceq}_t \ \cdots \\[15pt] 
+\ \mathit{pxx}_t \, xx_t
- pmm_t^{\mathrm{fob}} \, mm_t
+ pq_t^\gg (xq_t - mq_t)
\end{gathered}
$$

