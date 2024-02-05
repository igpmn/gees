# Monetary policy

--8<-- "model/math.md"

## Unconstrained monetary policy reaction function

The reaction function is given by

$$
\log r_t^\unc = \rho_r \, \log r_{t-1}
+ \left(1-\rho_r\right) \bigl[\log r_\ss + \mathit{react}_t \bigr]
+ \epsilon_{r,t}
$$

with the following composition of the reaction term

$$
react_{t}=
\psi_{pc} \, \bigl( \log \roc{pc}_{t+1} - \log \roc{pc}_\ss\bigr)
+ \psi_{e} \, \bigl( \log \roc{e}_{t+1} - \log \roc{e}_\ss\bigr)
+ \psi_{nh} \, \bigl( \log {nh}_{t+1} - \log {nh}_\ss\bigr)
$$

## Zero lower bound

The zero lower bound (floor) constraint chooses the higher of the unconstrained rate and 1 (i.e. a zero net rate of interest) but can be turned off by setting a $\mathit{floor}$ parameter to 0.


$$
r_t = \mathit{floor} \, \max\{r_t^\unc, \, 1\}
+ \left(1-\mathit{floor}\right)\, r_t^\unc
$$

