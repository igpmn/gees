# Baseline calibration of global parameters

$$
\newcommand{\ss}{\mathrm{ss}}
\newcommand{\gg}{\mathrm{gg}}
\newcommand{\tratio}[2]{\left[{#1}\,\middle/{#2}\right]}
\newcommand{\roc}[1]{\overset{\scriptsize\Delta}{#1{}}}
$$
{ .math-definitions }


## Global trends: Steady-state parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `gg_ss_roc_a` | $\roc{a}^\gg_\ss$ | 1.02 | S/S Global productivity trend, Rate of change |
| `gg_ss_roc_nt` | $\roc{\mathit{nt}}^\gg_\ss$ | 1.01 | S/S Global population trend, Rate of change |
| `gg_ss_zk` | $\mathit{zk}^\gg_\ss$ | 0.9 | S/S Global uncertainty discount factor on capital |
| `gg_ss_zy` | $\mathit{zy}^\gg_\ss$ | 1 | S/S Global uncertainty discount factor on production cash flows |
| `gg_ss_dmm` | $\mathit{dmm}^\gg_\ss$ | 1 | S/S Global disruption to non-commodity trade |
| `gg_nu` | $\nu^\gg$ | -0.0505425 | Global intercept in Euler equation |


## Global trends: Dynamic parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `gg_rho_a` | $\rho_a^\gg$ | 0.5 | A/R in global productivity trend |
| `gg_rho_nt` | $\rho_\mathit{nt}^\gg$ | 0.9 | A/R in global population trend |
| `gg_rho_zk` | $\rho_\mathit{zk}^\gg$ | 0.9 | A/R in uncertainty discount factor on capital |
| `gg_rho_zy` | $\rho_\mathit{zy}^\gg$ | 0.9 | A/R in uncertainty discount factor on production cash flows |
| `gg_rho_dmm` | $\rho_\mathit{dmm}^\gg$ | 0.5 | A/R Global disruption to non-commodity trade |


## Global commodity supply: Dynamic parameters

| Name | Math | Value | Description  |
|:---|:---|---:|:---|
| `gg_iota_1` | $\iota_1^\gg$ | 0.2 | Excess demand elasticity of commodity prices |
| `gg_rho_qq` | $\rho_\mathit{qq}^\gg$ | 0.8 | A/R Long-run trend in commodity supply |

