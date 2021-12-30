
## Production technology with time-varying elasticity

Production technogy based on a unit-elasticity (Cobb-Douglas) production
function

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


Optimization problem with a possibly heavier discounting, $\beta_y\in[0,1]$, to incorporate
higher uncertainty of future profit flows

$$
\bmax_{\{a_t, b_t\}}\ 
\E_0 \sum_{t=0}^\infty \left( \beta\, \beta_{y} \right)^t \, vh_t \, \Pi_{y,t}
$$

Optimal choice of input factors (omitting higher-order terms from the
adjustment costs)

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

