# GEES Demography module

## Declare quantities

```matlab

!variables

    "Total population" nn
    "Total population, Rate of change" roc_nn
    "Total population relative to global population component" nr
    "Working age population" nw
    "Labor force" nf


!log-variables !all-but


!parameters

    "S/S Population, Relative to Global Population Component" ss_nr
    "S/S Share of Working Age Population in Total Population" ss_nw_to_nn
    "S/S Labor Participation Rate" ss_nf_to_nw

    "A/R Total Population Relative to Global Population Component" rho_nr
    "A/R Share of Working Age Population in Total Population" rho_nw
    "A/R Labor Participation Rate" rho_nf


!shocks

    "Shock to relative population component" shk_nr
    "Shock to share of working age population" shk_nw_to_nn
    "Shock to labor participation rate" shk_nf_to_nw

```

## Define equations


```matlab

!equations

    "Total population relative to global population component"
    log(nr) = rho_nr * log(nr{-1}) + (1-rho_nr) * log(ss_nr) + shk_nr ...
    !! nr = ss_nr;


    "Total population"
    nn = nr * gg_nt;


    "Total population, Rate of change"
    roc_nn = nn / nn{-1} ...
    !! roc_nn = gg_ss_roc_nt;


    "Share of working age population"
    nw/nn = ...
        + rho_nw * nw{-1}/nn{-1} ...
        + (1-rho_nw) * ss_nw_to_nn ...
        + shk_nw_to_nn ...
    !! nw = ss_nw_to_nn * nn;


    "Labor participation rate"
    nf/nw = ...
        + rho_nf * nf{-1}/nw{-1} ...
        + (1-rho_nf) * ss_nf_to_nw ...
        + shk_nf_to_nw ...
    !! nf = ss_nf_to_nw * nw;

```

