
## Total Population

--8<-- "model/math.md"

![[math]]
{ .hide }

Global population trend, $nn_t$, is a unit root process common to all areas. The
level of the global population trend does not correspond to any particular demographic
indicator; rather, we can think of $nn$ as a driving force for population *growth*  

$$
\begin{gathered}
\log \roc{nn}{}^\gg_t
= \rho_{nn}^\gg\, \log \roc{nn}{}^\gg_{t-1} 
+ (1-\rho_{nn}^\gg)\, \log \roc{nn}{}^\gg_\ss \\[10pt]
\end{gathered}
$$

<br />

Area's total population

$$
nn_t = nr_t \cdot nn_t^\gg
$$

$$
\log(nr_t) 
= \rho_{nr} \log nr_{t-1}
+ (1-\rho_{nr}) \log nr_\ss
$$


---

## Labor Market Population


Area's working age population

$$
\frac{nw_t}{nn_t} = 
\rho_{nw} \, \frac{nw_{t-1}}{nn_{t-1}}
+ (1-\rho_{nw}) \, \ratio{nw}{nn}_\ss
+ \epsilon_{nw,t}
$$

<br/>

Area's labor force (participation)

$$
\frac{\xnf_t}{nw_t} = 
\rho_{\xnf} \, \frac{\xnf_{t-1}}{nw_{t-1}}
+ (1-\rho_{\xnf}) \, \ratio{\xnf}{nw}_\ss
+ \epsilon_{\xnf,t}
$$

