# Baseline calibration of area parameters

$$
\newcommand{\ss}{\mathrm{ss}}
\newcommand{\gg}{\mathrm{gg}}
\newcommand{\tratio}[2]{\left[{#1}\,\middle/{#2}\right]}
\newcommand{\roc}[1]{\overset{\scriptsize\Delta}{#1{}}}
$$
{ .math-definitions }


## Demography: Steady-state parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `ss_nr` | $\mathit{nr}_\ss$ | 1 | S/S Population, Relative to global population component |
| `ss_nw_to_nn` | $\tratio{\mathit{nw}}{\mathit{nn}}_\ss$ | 0.65 | S/S Share of working age population in total population |
| `ss_nf_to_nw` | $\tratio{\mathit{nf}}{\mathit{nw}}_\ss$ | 0.7 | S/S Labor participation rate |


## Demography: Dynamic parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `rho_nr` | $\rho_\mathit{nr}$ | 0.9 | A/R Total population relative to global population component |
| `rho_nw` | $\rho_\mathit{nw}$ | 0.9 | A/R Share of working age population in total population |
| `rho_nf` | $\rho_\mathit{nf}$ | 0.5 | A/R Labor participation rate |


## Households: Steady-state parameters

| Name | Math | Value | Description  |
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

| Name | Math | Value | Description  |
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


## Local supply side: Steady-state parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `ss_ar` | $\mathit{ar}_\ss$ | 1 | S/S Area specific productivity component |
| `gamma_n0` | $\gamma_\mathit{n0}$ | 0.333333 | Share of overhead labor |
| `gamma_m` | $\gamma_m$ | 0.15 | Share of intermediate imports in stage T-3 production |
| `gamma_uk` | $\gamma_\mathit{uk}$ | 0.3 | Share of capital services in stage T-2 production |
| `gamma_q` | $\gamma_q$ | 0.05 | Share of commodity inputs in stage T-1 production |
| `gamma_yz` | $\gamma_\mathit{yz}$ | 0.6 | Share of roundabout intermediates in stage T-0 production |
| `mu_py` | $\mu_\mathit{py}$ | 1.1 | Monopoly power (markup) of local producers |
| `mu_y3` | $\mu_{y3}$ | 1.3 | Markup to cover overhead labor |


## Local supply side: Dynamic parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `rho_ar` | $\rho_\mathit{ar}$ | 0.5 | Autoregression in area specific productivity component |
| `zeta_py` | $\zeta_\mathit{py}$ | 0.5 | Weight on S/S inflation in inflation indexation |
| `xi_y2` | $\xi_{y2}$ | 0.5 | Stage T-2 input factor adjustment cost parameter |
| `xi_y1` | $\xi_{y1}$ | 2 | Stage T-1 input factor adjustment cost parameter |
| `xi_py` | $\xi_\mathit{py}$ | 25 | Price adjustment cost parameters |


## Monetary policy: Steady-state parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `ss_roc_pc` | $\roc{\mathit{pc}}_\ss$ | 1.03 | S/S Price of private consumption, Rate of change |
| `floor` | $\mathit{floor}$ | 1 | Switch for lower bound on short-term rate |


## Monetary policy: Dynamic parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `rho_r` | $\rho_r$ | 0.5 | A/R in policy rate |
| `psi_pc` | $\psi_\mathit{pc}$ | 2.5 | Monetary policy reaction to CPI |
| `psi_e` | $\psi_e$ | 0 | Monetary policy reaction to nominal exchange rate |
| `psi_nh` | $\psi_\mathit{nh}$ | 0 | Monetary policy reaction to real economic activity |


## Fiscal policy: Steady-state parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `ss_dg_to_ngdp` | $\tratio{\mathit{dg}}{\mathit{ngdp}}_\ss$ | 0.4 | S/S Government debt to GDP ratio |
| `ss_ncg_to_ngdp` | $\tratio{\mathit{ncg}}{\mathit{ngdp}}_\ss$ | 0.2 | S/S Government consumption to GDP ratio |
| `ss_trm` | $\mathit{trm}_\ss$ | 0 | S/S General import tariff rate |


## Fiscal policy: Dynamic parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `tau_cg` | $\tau_\mathit{cg}$ | 0 | Response in government consumption to government debt |
| `tau_txls1` | $\tau_{\mathit{txls},1}$ | 2.5 | Response in type 1 lump-sum tax rate to government debt |
| `rho_cg` | $\rho_\mathit{cg}$ | 0.5 | Autoregression in government consumption |
| `rho_txls1` | $\rho_{\mathit{txls},1}$ | 0.5 | Autoregression in type 1 lump-sum tax rate |
| `rho_txls2` | $\rho_{\mathit{txls},2}$ | 0.5 | Autoregression in type 2 lump-sum tax rate |
| `rho_trm` | $\rho_\mathit{trm}$ | 0 | Autoregression in generate import tariff rate |


## Open economy: Steady-state parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `alpha` | $\alpha$ | 0.4 | Import intensity of non-commodity exports |
| `gamma_xx` | $\gamma_\mathit{xx}$ | 0.5 | Acceleration in exportable productivity |
| `theta_1` | $\theta_1$ | 0.1 | Elasticity of household risk function wrt NFA |
| `theta_2` | $\theta_2$ | 1 | Curvature of household risk function wrt NFA |
| `lambda` | $\lambda$ | 0.5 | Share of local commodity production in world commodity production |
| `ss_zh_aut` | $\mathit{zh}^\mathrm{aut}_\ss$ | 0 | S/S Autonomous component in country credit risk |


## Open economy: Dynamic parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `rho_zh_aut` | $\rho_{\mathit{zh}}^\mathrm{aut}$ | 0.7 | A/R Autonomous component in country credit risk |
| `zeta_e` | $\zeta_e$ | 0.6 | Weight on model-consistent expectations in exchange rate |
| `xi_y3` | $\xi_{y3}$ | 0.85 | Adjustment cost parameter in stage t-3 production |


## Trade linkages: Steady-state parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `ss_trm_bb` | $\mathit{trm}_{\mathrm{bb},\ss}$ | 0 | S/S Area specific import tariff rate |


## Trade linkages: Dynamic parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `rho_trm_bb` | $\rho_{trm,\mathrm{bb}}$ | 0 | A/E Area specific import tariff rate |


## Finance linkages: Steady-state parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `phi_aa` | $\phi_\mathrm{aa}$ | 0.9 | Corporate equity portfolio share |
| `phi_bb` | $\phi_\mathrm{bb}$ | 0.1 | Corporate equity portfolio share |


## Finance linkages: Dynamic parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `xi_k` | $\xi_k$ | 0.5 | Forward capital adjustment cost parameter |

