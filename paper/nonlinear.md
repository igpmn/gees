<div style="page-break-after: always;"></div>

# Nonlinear Simulations

---

## System of Nonlinear Equations with Model-Consistent Expectations



$$
\begin{gathered}
\textbf{E}_t \left[ f_1\left( x_{t-1}, x_t, x_{t+1}, \epsilon_t \ \middle| \ \theta \right) \right] = 0 \\
\vdots \\
\textbf{E}_t \left[ f_k\left( x_{t-1}, x_t, x_{t+1}, \epsilon_t \ \middle| \ \theta \right) \right] = 0 \\
\\
\\
\\
\mathrm E \ \epsilon_t \epsilon_t' = \Omega
\end{gathered}
$$

---

## Methods for Nonlinear Simulations

| Characteristics            | Local Approximation | Global Approximation | Stacked Time        |
| -------------------------- | ------------------- | -------------------- | ------------------- |
| Solution form              | Function            | Function             | Sequence of Numbers |
| Terminal condition problem | No                  | No                   | Yes                 |
| Global nonlinearity        | No                  | Yes                  | Yes                 |
| Stochastic uncertainty     | Yes                 | Yes                  | No                  |
| Fully automated design     | Yes                 | No                   | Yes                 |
| Large scale models         | Yes                 | No                   | Yes                 |

---
<div style="page-break-after: always;"></div>

## Local Approximation

Deviations from non-stochastic steady state

$$
\hat x_t = x_t - \bar x \qquad \text{or} \qquad \hat x_t = \log x_t - \log \bar x
$$

Find a function approximated around the nonstochastic steady state by terms
up to a desired order, with coefficient matrices (solution matrices) $A_1^k$, $A_2^k$, $\dots$,
$B^k$

$$
\hat x_t^k = A_1^k\ \hat x_{t-1} + \hat x_{t-1}' \ A_2^k\ \hat x_{t-1} + \ \cdots\ 
+ B_1^k \ \epsilon_t  +  \epsilon_t' \ B_2^k\ \epsilon_t
$$

that are consistent with the original system of equations up to a desired
order



The coefficient matrices $A^k_1, \ A_2^k,\ A_3^k, \ \dots, B^k_1, B^k_2,\ \dots$   dependent on

* the Taylor expansions of the original functions $f_1,\ \dots,\ f_k$
* model parameters $\theta$


and the higher-order coefficient matrices $A_2^k, A_3^k, \dots, B^k_2, B^k_3 \ \dots$ also dependent on

* the covariance matrix of shocks, $\Omega$


---

## Global Approximation

Find a parametric function $g$

$$
x_t = g\left(x_{t-1}, \epsilon_t \ \middle|\ \theta, \Omega \right)
$$

that is consistent with the original system taking into account the
expectations operator



The function $g$ is a parameterized global approximation of the true
function, e.g.

* parameterized sum of polynominals
* function over a discrete grid of points

---

## Stacked Time

Find a sequence of numbers, $x_1, \dots, x_T$ that comply with the original
system of equations stacked $T$ times underneath each other, dropping the
expectations operator
$$
\begin{gathered}
f_1\left( x_{-1}, x_1, x_{2}, \epsilon_1 \ \middle| \ \theta \right) = 0 \\
\vdots \\
f_k\left( x_{t-1}, x_t, x_{2}, \epsilon_1 \ \middle| \ \theta \right) = 0 \\
\vdots \\
\vdots \\
f_1\left( x_{T-1}, x_T, x_{T+1}, \epsilon_T \ \middle| \ \theta \right) = 0 \\
\vdots \\
f_k\left( x_{T-1}, x_T, x_{T+1}, \epsilon_T \ \middle| \ \theta \right) = 0 \\
\end{gathered}
$$

Initial condition $x_{-1}$

Terminal condition $x_{T+1}$

---

## Combining Anticipated and Unanticipated Shocks in Stacked Time


By design, all shocks included within one particular simulation run are
known/seen/anticipated throughout the simulation range

Simulating a combination of anticipated and unanticipated shocks means

* split the simulation range into sub-ranges by the occurrence of unanticipated shocks
* run each sub-range as a separate simulation, taking the end-points of the previous sub-range simulation as initial condition
* make sure you run a sufficient number of periods in each sub-simulation

---

## IrisT Approach to Stacked Time

* Sequential block pre-analyzer (Blazer)

* (Quasi) Newton method

* Terminal condition derived from the first-order solution

* Analytical Jacobian

* Detection of sparse Jacobian pattern

* Detection of invariant Jacobian elements

* Frames: Automated handling of combined anticipated and unanticipated shocks (or exogenized data points)


---

## Curse of Dimensionality

Dimension of the problem: $K =$ number of equations $\times$ number of periods

Dimensions of the Jacobian: $K \times K$

The conventional ways of handling terminal condition require a larger number of
periods to be simulated (to discount the effect of the "wrong" terminal
condition)

Reduce the actual dimensionality and accelerate:

* Base terminal condition upon the first order solution dramatically
  reduces the number of periods needed

* Detect the sparse Jacobian pattern to avoid zero points

* Detect the Jacobian elements that need to be evaluated only once (at the beginning)

---

## (Quasi) Newton Method of Solving Nonlinear Equations

Plain-vanilla Newton with variable step size
for exactly determined systems (nonlinear simulations)

$$
x_k = x_{k-1} - s_k\ J_{k-1}^{-1} \ F_{k-1}
$$


Quasi-Newton where the Jacobian is regularized using the steepest descent
method for underdetermined systems (steady state solver for growth models
with "independent" degrees of freedeom, or steady state solver with
the ```"fixLevel"``` option)

$$
x_k = x_{k-1} - s_k\ \left( J_{k-1}^T\, J_{k-1} + \lambda_k \right)^{-1}\ J_{k-1} \ F_{k-1}
$$

where

* function evaluation $F_k = F(x_k)$

* Jacobian evaluation $J_k = J(x_k)$

---

## Frames

The simulation frames work in a following principle. Assume that you have a simulation for 6 periods combining both the anticipated and unanticipated shocks such that unanticipated shocks occur in periods 3 and 5.
![Frames 2|600](C:\Users\daniela.milucka\Documents\GEES_model\gees-model-codes\codes\docs\figures\frame_1.jpg)

In this case you need to run 3 simulations and final results will be assembled from these 3 simulations. Each additional simulation enriches the information set (by additional shocks). 
![Frames 2|600](C:\Users\daniela.milucka\Documents\GEES_model\gees-model-codes\codes\docs\figures\frame_2.jpg)

Initial conditions for simulation $n$ are taken from the simulation $n-1$. In this case, initial conditions for simulation 2 (which enriches the information set for an unexpected shock in period 3) are taken from the simulation 1 in period 2. Similarly, simulation 3 (which enriches the information set for unexpected shock in period 5) will use initial conditions from the period 4 in simulation 2. The final result is then an assembly from all three simulations such that

![Frames 2](C:\Users\daniela.milucka\Documents\GEES_model\gees-model-codes\codes\docs\figures\frame_3.jpg)

---

## The `simulate` Function

```
[s, info, frameDb] = simulate( ...
    m, d, range, ...
    "deviation",    true -or- false, ...
    "anticipate",   true -or false, ...
    "plan",         empty -or- Plan, ...
    "method",       "stacked", ...
    "blocks",       true -or- false, ...
    "terminal",     "firstOrder" -or- "data", ...
    "startIter",    "firstOrder" -or- "data", ...
    "successOnly",  false -or- true, ...
    "window",       @auto -or- numeric, ...
    "solver",       @auto -or- {"iris-newton", "optionName", value, "optionName", value, ...}, ...
);
```

The `solver` options:

```
{ "iris-newton", ...
    "skipJacobUpdate",          0 -or- numeric, ...
    "lastJacobUpdate",          Inf -or- numeric, ...
    "functionNorm",             2 -or- Inf, ...
    "maxIterations",            5000 -or- numeric, ...
    "maxFunctionEvaluation",    @auto -or- numeric, ...
    "functionTolerance",        1e-12 -or- numeric, ...
    "stepTolerance",            1e-12 -or- numeric, ...
}
```

---

## Practical Tricks

False slope (occasionally binding constraints)

* discontinuities pose relatively little difficulties
* the zero slope of the `max` or `min` functions is a more serious problem

Pressure relief valves (PRVs)

* mechanical
* structural

