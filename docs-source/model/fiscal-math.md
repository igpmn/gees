$$
\newcommand{\xnetf}{\mathit{netf}}
\newcommand{\xnetfg}{\mathit{netfg}}
\newcommand{\xdg}{\mathit{dg}}
\newcommand{\xrg}{\mathit{rg}}
$$


## Dynamic fiscal budget

Government debt issued in local-currency, $\xdg_t$

$$
\begin{aligned}
\xdg_t &=  \xdg_{t-1} & \text{Rollover} \\[10pt]
&+\ (\xrg_{t-1}-1) \ \xdg_{t-1} &\text{Interest} \\[10pt]
&-\ tx1_t - tx2_t - txm_t &\text{Receipts} \\[10pt]
&+\ pc_t \cdot cg_t &\text{Outlays} \\[10pt]
\end{aligned}
$$


## Government expenditures on goods and services

Real government consumption, $cg_t$

$$
\begin{aligned}
\log cg_t &= \rho_{cg} \cdot \log\left( cg_{t-1}\cdot  \roc{cg}_\ss \right) &\text{Autoregressive} \\[15pt]
&+\ \left(1-\rho_{cg}\right) \, \log \Bigl( \ratio{ngdp}{pc}_t \cdot \ratio{ncg}{ngdp}_\ss \Bigr) &\text{Govt consumption target} \\[15pt]
&+\ \tau_{cg} \, \left( \ratio{dg}{ngdp}_{t+1} - \ratio{dg}{ngdp}_\ss \right) &\text{Debt target} \\[15pt]
&+\ \epsilon_{cg,t} &\text{Govt consumption shock}
\end{aligned}
$$


## Government type 1 lump-sum taxes

Type 1 lump-sum taxes, $\mathit{tx}1_t$


$$
\begin{aligned}
\ratio{tx1}{nch}_{t} &= \rho_{tx1} \ \ratio{tx1}{nch}_{t-1} &\text{Autoregressive}\\[15pt]
&+\ \left(1-\rho_{tx1}\right)\, \ratio{tx1}{nch}_\ss  &\text{Type 1 tax target} \\[15pt]
&+\ \tau_{tx1} \ \left( \ratio{dg}{ngdp}_{t+1} - \ratio{dg}{ngdp}_\ss \right) &\text{Govt debt target} \\[15pt]
&+\ \epsilon_{tx1,t} &\text{Type 1 tax shock}
\end{aligned}
$$


## Government type 2 lump-sum taxes

Type 2 lump-sum taxes, $\mathit{tx}2_t$


$$
\begin{aligned}
\ratio{tx2}{nch}_{t} &= \rho_{tx2} \ \ratio{tx2}{nch}_{t-1} &\text{Autoregressive}\\[15pt]
&+\ \left(1-\rho_{tx2}\right)\, \ratio{tx2}{nch}_\ss  &\text{Type 2 tax target} \\[15pt]
&+\ \epsilon_{tx2,t} &\text{Type 2 tax shock}
\end{aligned}
$$


## Import tariffs

Import tariff rate, $trm_t$


$$
\begin{aligned}
trm_t &= \rho_{trm} \ trm_{t-1} &\text{Autoregressive}\\[15pt]
&+\ \left(1-\rho_{trm}\right)\, trm_\ss  &\text{Tariff target} \\[15pt]
&+\ \epsilon_{trm,t} &\text{Tariff shock}
\end{aligned}
$$