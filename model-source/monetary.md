# GEES Monetary policy module 


## Declare quantities


```matlab

!variables(:monetary)

    "Nominal short-term rate, LCY" r
    "Monetary policy reaction term" react
    "Unconstrained nominal short-term rate, LCY" unc_r
    "Nominal short-term rate for interest parity, LCY" rip 


!parameters(:monetary :steady)

    "S/S Price of private consumption, Y/Y !! $\roc{\mathit{pc}}_\ss$" ss_roc_pc
    "Switch for lower bound on short-term rate !! $\mathit{floor}$" floor


!parameters(:monetary :dynamic)

    "A/R in policy rate !! $\rho_r$" rho_r 
    "Monetary policy reaction to CPI !! $\psi_\mathit{pc}$" psi_pc 
    "Monetary policy reaction to nominal exchange rate !! $\psi_e$" psi_e
    "Monetary policy reaction to real economic activity !! $\psi_\mathit{nh}$" psi_nh
    "Pressure relief valve for interest rate lower bound !! $\theta_\mathir{rip}$" theta_rip


!shocks(:monetary)

    "Shock to monetary policy reaction function" shk_r

```

## Control log-status of variables


```matlab

!log-variables !all-but

    react


```


## Define equations


```matlab

!equations(:monetary)

    "Monetary policy reaction function"
    log(unc_r) = ...
        + rho_r * log(r{-1}) ...
        + (1 - rho_r) * [ log(&unc_r) + react ] ...
        + shk_r ...
    !! pc = pc{-1} * ss_roc_pc;


    "Monetary policy reaction term"
    react = ...
        + psi_pc * (log(roc_pc{+1}) - log(ss_roc_pc)) ...
        + psi_e * (log(roc_e) - log(&roc_e)) ...
        + psi_nh * (log(nh{+1}) - log(&nh)) ...
    !! react = 0;


    "Zero floor constraint on policy rate"
    r = floor*max(1, unc_r) + (1-floor)*unc_r ...
    !! r = unc_r;

    rip = r + theta_rip*(unc_r - r) ...
    !! rip = r;
```

