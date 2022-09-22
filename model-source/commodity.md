# GEES Commodity extraction module


## Declare quantities


```matlab

!variables(:commodity)

    "Long-run level of commodity supply" gg_qq
    "Global commodity demand" gg_q
    "Global excess demand in commodity market" gg_qexc
    "Global price of commodities" gg_pq
    "Global real price of commodities" gg_pq_to_pxx


!log-variables !all-but


!parameters(:commodity :dynamic)

    "Excess demand elasticity of commodity prices !! $\iota_1^\gg$" gg_iota_1
    "A/R Long-run trend in commodity supply !! $\rho_\mathit{qq}^\gg$" gg_rho_qq


!shocks(:commodity)

    "Shock to long-run level in commodity supply" gg_shk_qq
    "Shock to price of commodities" gg_shk_pq

```


## Define equations


```matlab

!equations(:commodity)

    "Long-run level of global commodity production"
    log(gg_qq) = ...
        + gg_rho_qq * log(gg_ss_roc_a * gg_ss_roc_nt * gg_qq{-1}) ...
        + (1 - gg_rho_qq) * log(gg_a * gg_nn * (&gg_q / &gg_a / &gg_nn)) ...
        + gg_shk_qq ...
    !! gg_qq = gg_q;


    "Log excess demand in commodity market"
    gg_qexc = gg_q / gg_qq ...
    !! gg_qexc = 1;


    "Commodity supply curve"
    gg_pq = gg_pxx * gg_qexc^gg_iota_1 * exp(gg_shk_pq) ...
    !! gg_pq = gg_pxx;


    "Global real prices of commodities"
    gg_pq_to_pxx = gg_pq / gg_pxx;

```

