
# Beta simulations

## Model operation

#### Prepare model

* Create a model object based on model source files
* Calibrate parameters
* Calculate steady state
* Calculate first-order solution matrices


#### Comparative static simulation

* Create a copy of the model object
* Assign a different parameter value (or values) to one (or more)
  parameters
* Recalculate steady state
* Compare steady state values


#### Transition dynamics simulation

* Create an initial steady-state databank (corresponding to the pre-change
  economy)
* Simulate the post-change model starting from the pre-change databank
* Compare simulated paths


#### Transition dynamics with smooth parameter transition

* Introduce a time varying parameter as an autoregressive process
* Rebuild the model again


#### Repeat for different versions of the model: 

* Autarky
* Symmetric 2A
* Global 4A


---

<br/>

## Macro narrative

#### Model vs reality

* Always interpret the results first mechanically based on model assumptions
  and equations

* Only then challenge the results from a real-world point of view


#### Beta in an autarky economy

* Intertemporal (Euler) choice

$$
\mathrm E_t\! \left[ \frac{ch_{t+1}}{ch_t} \right]
= \beta \cdot rh_t
$$

* Marginal product of capital

$$
MPK_t = rrh_t - 1 + \delta
$$

$$
MPK_t \equiv \gamma \, \frac{py_t \cdot y_t}{pk_t \cdot k_t} 
$$

* Representative (infinitely lived) agent versus overlapping generations of
  agents with finite lives


#### Beta in a global economy

* Global finance equilibrium
* Debt-elastic country premium


