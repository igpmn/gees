# GEES Fiscal policy module


## Define quantities

```matlab

!variables

    "Government debt interest rate" rg
    "Government consumption" cg
    "Government debt to GDP ratio" dg_to_ngdp
    "Net lump-sum tax on wealthy consumers to consumption ratio" txls1_to_nc
    "Net lump-sum tax on poor consumers to consumption ratio" txls2_to_nc
    "Government consumption, Rate of Change" roc_cg
    "Import tariff rate" trm


!log-variables !all-but

    txls1_to_nc, txls2_to_nc, dg_to_ngdp, trm


!parameters

    "S/S Government debt to GDP ratio" ss_dg_to_ngdp
    "S/S Government consumption to GDP ratio" ss_ncg_to_ngdp
    "S/S General import tariff rate" ss_trm

    "Response in government consumption to government debt" tau_cg
    "Response in type 1 lump-sum tax rate to government debt" tau_txls1
    "Autoregression in government consumption" rho_cg
    "Autoregression in type 1 lump-sum tax rate" rho_txls2
    "Autoregression in type 2 lump-sum tax rate" rho_txls1
    "Autoregression in generate import tariff rate" rho_trm


!shocks

    "Shock to government consumption" shk_cg
    "Shock to type 1 lump-sum taxes" shk_txls1
    "Shock to type 2 lump-sum taxes" shk_txls2
    "Shock to general import tariff rate" shk_trm

```

## Define equations


```matlab

!equations

    rg = r;

    
    "Dynamic fiscal budget constraint"
    dg_to_ngdp*ngdp = ...
        + rg{-1}*dg_to_ngdp{-1}*ngdp{-1} ...
        + pc*cg ...
        - (txls1_to_nc + txls2_to_nc) * pc*ch ...
        - (pmm - fob_pmm) * mm;


    "Fiscal reaction function for government consumption"
    log(cg) = ...
        + rho_cg * log(cg{-1}*&roc_cg) ...
        + (1 - rho_cg) * log(ss_ncg_to_ngdp*ngdp/pc) ...
        - tau_cg * (dg_to_ngdp{+1} - ss_dg_to_ngdp) ...
        + shk_cg ...
    !! pc*cg = ss_ncg_to_ngdp*ngdp;


    "Fiscal reaction function for type 1 net lump-sum taxes"
    txls1_to_nc = ...
        + rho_txls1 * txls1_to_nc{-1} ...
        + (1-rho_txls1) * &txls1_to_nc ...
        + tau_txls1 * (dg_to_ngdp{+1} - ss_dg_to_ngdp) ...
        + shk_txls1 ...
    !! dg_to_ngdp = ss_dg_to_ngdp;


    "Fiscal reaction function for type 2 net lump-sum taxes"
    txls2_to_nc = ...
        + rho_txls2*txls2_to_nc{-1} ...
        + shk_txls2 ...
    !! txls2_to_nc = 0;


    "Fiscal reaction function for import tariffs rate"
    trm = ...
        + rho_trm * trm{-1} ...
        + (1 - rho_trm) * ss_trm ...
        + shk_trm ...
    !! trm = ss_trm;

```

