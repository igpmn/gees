# Nonlinear Simulations

---

## System of Nonlinear Equations with Model-Consistent Expectations



$$
\newcommand{\Et}{\mathrm{E}_t}
\Et \left[ f_1\left( x_{t-1}, x_t, x_{t+1}, \epsilon_t \ \middle| \ \theta \right) \right] = 0 \\[10pt]
\vdots \\[10pt]
\Et \left[ f_k\left( x_{t-1}, x_t, x_{t+1}, \epsilon_t \ \middle| \ \theta \right) \right] = 0 \\[40pt]
\mathrm E \ \epsilon_t \epsilon_t' = \Omega
$$

---

## Methods for Nonlinear Simulations

Characteristics | Local Approximation | Global Approximation | Stacked Time 
---|---|---|---
Solution form | Function | Function | Sequence of Numbers
Terminal condition problem | No | No | Yes
Global nonlinearity | No | Yes | Yes
Stochastic uncertainty | Yes | Yes | No
Fully automated design | Yes | No | Yes
Large scale models | Yes | No | Yes 

---

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

<br/>

<br/>

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

<br/>
<br/>

The function $g$ is a parameterized global approximation of the true
function, e.g.

* parameterized sum of polynominals
* function over a discrete grid of points

---

## Stacked Time

Find a sequence of numbers, $x_1, \dots, x_T$ that comply with the original
system of equations stacked $T$ times underneath each other, dropping the
expectations operator

<br/>

$$
f_1\left( x_{-1}, x_1, x_{2}, \epsilon_1 \ \middle| \ \theta \right) = 0 \\[10pt]
\vdots \\[10pt]
f_k\left( x_{t-1}, x_t, x_{2}, \epsilon_1 \ \middle| \ \theta \right) = 0 \\[10pt]
\vdots \\[10pt]
\vdots \\[10pt]
f_1\left( x_{T-1}, x_T, x_{T+1}, \epsilon_T \ \middle| \ \theta \right) = 0 \\[10pt]
\vdots \\[10pt]
f_k\left( x_{T-1}, x_T, x_{T+1}, \epsilon_T \ \middle| \ \theta \right) = 0 \\[40pt]
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


Quasi-Newton where the Jacobina is regularized using the steepest descent
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

---

## . 

