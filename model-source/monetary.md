# GEES Monetary policy module 


## Declare quantities

```matlab

!variables

    "Nominal short-term rate, LCY" r
    "Unconstrained nominal short-term rate, LCY" unc_r


!log-variables !all-but


!parameters

    "S/S Price of private consumption, Rate of change" ss_roc_pc

    "A/R in policy rate" rho_r 
    "Monetary policy reaction to CPI" psi_pc 
    "Monetary policy reaction to nominal exchange rate" psi_e
    "Switch for lower bound on short-term rate" floor


!shocks

    "Shock to monetary policy reaction function" shk_r

```

## Define equations

```matlab

!equations

    "Monetary policy reaction function"
    log(unc_r) ...
        = rho_r * log(unc_r{-1}) ...
        + (1-rho_r) * [ ...
            + log(&unc_r) ...
            + psi_pc * (log(roc_pc{+1}) - log(ss_roc_pc)) ...
            + psi_e * (log(roc_e) - log(&roc_e)) ...
        ] ...
        + shk_r ...
    !! pc = pc{-1} * ss_roc_pc;


    "Zero floor constraint on policy rate"
    r = floor*max(1, unc_r) + (1-floor)*unc_r;

```

