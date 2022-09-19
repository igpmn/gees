# Baseline calibration of area parameters

## Demography: Steady-state parameters

| Name | Alias | SteadyLevel | Description  |
|:---|:---|---:|:---|
| `ss_nr` |  | 1 | S/S Population, Relative to Global Population Component |
| `ss_nw_to_nn` |  | 0.65 | S/S Share of Working Age Population in Total Population |
| `ss_nf_to_nw` |  | 0.7 | S/S Labor Participation Rate |


## Demography: Dynamic parameters

| Name | Alias | SteadyLevel | Description  |
|:---|:---|---:|:---|
| `rho_nr` |  | 0.9 | A/R Total Population Relative to Global Population Component |
| `rho_nw` |  | 0.9 | A/R Share of Working Age Population in Total Population |
| `rho_nf` |  | 0.5 | A/R Labor Participation Rate |


## Households: Steady-state parameters

| Name | Alias | SteadyLevel | Description  |
|:---|:---|---:|:---|
| `ss_zk` | $\mathit{zk}_\mathrm{ss}$ | 0.9 | S/S Uncertainty discount factor on capital |
| `ss_zy` | $\mathit{zy}_\mathrm{ss}$ | 1 | S/S Uncertainty discount factor on production cash flows |
| `beta` | $\beta$ | 0.95 | Household discount factor |
| `delta` | $\delta$ | 0.15 | Depreciation of production capital |
| `eta` | $\eta$ | 0.5 | Inverse elasticity of labor supply |
| `eta0` | $\eta_0$ | 2.24516 | Utility location parameter of labor supply |
| `nu_0` | $\nu_0$ | 0.481924 | Intercept in current wealth utility |
| `nu_1` | $\nu_1$ | 0.07 | Slope of current wealth utility |
| `upsilon_0` | $\upsilon_0$ | 0.308207 | Level parameter in cost of utilization of production capital |
| `upsilon_1` | $\upsilon_1$ | 5 | Inverse elasticity of cost of utilization of production capital |


## Households: Dynamic parameters

| Name | Alias | SteadyLevel | Description  |
|:---|:---|---:|:---|
| `rho_w` | $\rho_w$ | 0.5 | A/R in real wage rate |
| `rho_zk` | $\rho_\mathit{zk}$ | 0.9 | A/R in uncertainty discount factor on capital |
| `rho_zy` | $\rho_\mathit{zy}$ | 0.9 | A/R in uncertainty discount factor on production cash flows |
| `chi` | $\chi$ | 1 | Point of reference in consuptions switch |
| `chi_ch` | $\chi_\mathit{ch}$ | 0.3 | Past consumption in reference consumption parameter |
| `chi_curr` | $\chi_\mathit{curr}$ | 0.6 | Current income in reference consumption parameter |
| `xi_ih1` | $\xi_\mathit{ih,1}$ | 0 | Type 1 investment adjustment cost parameter |
| `xi_ih2` | $\xi_\mathit{ih,2}$ | 0.8 | Type 2 investment adjustment cost parameter |
| `theta_3` | $\theta_3$ | 0 | Pressure relief valve for interest rate lower bound |

