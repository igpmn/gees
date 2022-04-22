# GEES Global trends module
!ra
log-variables !all-but




## Declare quantities

```matlab

!variables(:globals)

    "Global productivity trend component" gg_a
    "Global population trend component" gg_nt
    "Global uncertainty discount factor on capital" gg_zk
    "Global uncertainty discount factor on production cash flows" gg_zy
    "Global disruption to non-commodity trade" gg_dmm


!shocks(:globals)

    "Shock to global productivity trend" gg_shk_a
    "Shock to global population trend" gg_shk_nn
    "Shock to global uncertainty discount factor on capital" gg_shk_zk
    "Shock to global uncertainty discount factor on production cash flows" gg_shk_zy
    "Shock to global disruption to non-commodity trade" gg_shk_dmm


!parameters(:globals :steady)

    "S/S Global productivity trend, Rate of change" gg_ss_roc_a
    "S/S Global population trend, Rate of change" gg_ss_roc_nt
    "S/S Global uncertainty discount factor on capital" gg_ss_zk
    "S/S Global uncertainty discount factor on production cash flows" gg_ss_zy
    "S/S Global disruption to non-commodity trade" gg_ss_dmm

    "Global intercept in Euler equation" gg_nu


!parameters(:globals :transitory)

    "A/R in global productivity trend" gg_rho_a
    "A/R in global population trend" gg_rho_nt
    "A/R in uncertainty discount factor on capital" gg_rho_zk
    "A/R in uncertainty discount factor on production cash flows" gg_rho_zy
    "A/R Global disruption to non-commodity trade" gg_rho_dmm

```


## Control log-status of variables


```matlab

!log-variables !all-but

```


## Define equations


```matlab

!equations(:globals)

    "Global productivity trend"
    difflog(gg_a) = ...
        + gg_rho_a*difflog(gg_a{-1}) ...
        + (1-gg_rho_a)*(log(gg_ss_roc_a) + gg_shk_a) ...
    !! gg_a = gg_a{-1}*gg_ss_roc_a;


    "Global population trend"
    difflog(gg_nt) = ...
        + gg_rho_a * difflog(gg_nt{-1}) ...
        + (1-gg_rho_a) * (log(gg_ss_roc_nt) + gg_shk_nn) ...
    !! gg_nt = gg_nt{-1} * gg_ss_roc_nt;


    "Global uncertainty discount factor on capital"
    log(gg_zk) = gg_rho_zk*log(gg_zk{-1}) + (1-gg_rho_zk)*log(gg_ss_zk) + gg_shk_zk ...
    !! gg_zk = gg_ss_zk;


    "Global uncertainty discount factor on production cash flows"
    log(gg_zy) = gg_rho_zy*log(gg_zy{-1}) + (1-gg_rho_zy)*log(gg_ss_zy) + gg_shk_zy ...
    !! gg_zy = gg_ss_zy;


    "Global disruption to non-commodity trade"
    log(gg_dmm) = ...
        + gg_rho_dmm * log(gg_dmm{-1}) ...
        + (1 - gg_rho_dmm) * log(gg_ss_dmm) ...
        + gg_shk_dmm ...
    !! gg_dmm = gg_ss_dmm;

```

