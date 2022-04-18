# GEES Households module

## Define quantities

```matlab

!variables

    "Private consumption" ch
    "Per-capita private consumption" ch_to_nn
    "Private consumption, Point of reference" ref_ch
    "Real discount factor" rdf
    "Per-worker labor supply" nh
    "Private investment" ih
    "Uncertainty discount factor on capital" zk
    "Uncertainty discount factor on production cash flows" zy
    "Ex-post return on capital" rk
    "Production capital" k
    "Production capital services" uk
    "Portfolio of claims on production capital" kk
    "Household net worth" netw
    "Nominal wage rate" w

    "Price of production capital" pk
    "Price of production capital services" pu
    "Real consumer wage rate" w_to_pc
    "Nominal wage rate absent labor market rigidities" ww

    "Nominal wage rate, Rate of change" roc_w
    "Household investment, Rate of change" roc_ih
    "Production capital, Rate of change" roc_k


!log-variables !all-but


!parameters

    "S/S Uncertainty discount factor on capital" ss_zk
    "S/S Uncertainty discount factor on production cash flows" ss_zy
    "Household discount factor" beta
    "Depreciation of production capital" delta
    "Inverse elasticity of labor supply" eta
    "Utility location parameter of labor supply" eta0

    "Autoregression in real wage rate" rho_w
    "Autoregression in uncertainty discount factor on capital" rho_zk
    "Autoregression in uncertainty discount factor on production cash flows" rho_zy

    "Point of reference in consuptions switch" chi
    "Past consumption in reference consumption parameter" chi_ch
    "Current income in reference consumption parameter" chi_curr
    "Intercept in current wealth utility" nu_0
    "Slope of current wealth utility" nu_1
    "Type 1 investment adjustment cost parameter" xi_ih1
    "Type 2 investment adjustment cost parameter" xi_ih2
    "Level parameter in cost of utilization of production capital" upsilon_0
    "Inverse elasticity of cost of utilization of production capital" upsilon_1
    "Pressure relief valve for interest rate lower bound" theta_3


!shocks

    "Shock to wage rate" shk_w
    "Shock to current income" shk_curr
    "Shock to uncertainty discount factor on capital" shk_zk
    "Shock to uncertainty discount factor on production cash flows" shk_zy

```


## Define substitutions


```matlab

!substitutions

    % Current income definition
    curr := (w*nh*nf - txls2_to_nc*pc*ch);

    % Investment adjustment marginal cost
    ref_ih := (&ih/&k*&roc_k)*k{-1};
    adj_ih1 := log(ih) - log($ref_ih$);
    adj_ih2 := log(ih/ih{-1}/&roc_ih) - beta*log(ih{+1}/ih/&roc_ih);

```


## Define equations


```matlab

!equations

%% Household consumption-saving choice 

    "Optimal choice of household consumption"
    vh*pc*(ch - chi*ref_ch) = nn*(1 - chi*&ref_ch/&ch) ...
    !! vh*pc*ch = nn;

    "Point of reference in household consumption" 
    ref_ch = chi_curr*($curr$)/pc + chi_ch*ch{-1};

    "Optimal choice of net position with local financial sector"
    vh = beta*vh{+1}*rh + nn/(pc*ch)*[nu_1*(pc*ch/netw - nu_0) - gg_nu] ...
    !! 1 = beta*rh/gg_ss_roc_a/ss_roc_pc + nu_1*nch_to_netw_minus_nu_0 - gg_nu;

    "Auxiliary equation for steady-state calibration of nu_0"
    nch_to_netw_minus_nu_0 = pc * ch / netw - nu_0;

    rdf = beta*vh{+1}*pc{+1}/(vh*pc);

    "Risk adjusted household rate"
    rh = r + theta_3*(unc_r - r) + zh;

    "Current net worth of households"
    netw = kk + dg_to_ngdp*ngdp + nfa_to_ngdp*ngdp;

    "Uncertainty discount factor on capital"
    log(zk) = rho_zk*log(zk{-1}) + (1-rho_zk)*log(ss_zk) + shk_zk ...
    !! zk = ss_zk;

    "Uncertainty discount factor on production cash flows"
    log(zy) = rho_zy*log(zy{-1}) + (1-rho_zy)*log(ss_zy) + shk_zy ...
    !! zy = ss_zy;


%% Labor supply 

    "Optimal choice of per-worker hours worked"
    vh * ww = eta0 * nh^eta;

    "Real consumer wage rate"
    w_to_pc = w / pc;

    "Real wage rigidities"
    log(w_to_pc) = ...
        + rho_w * [log(w_to_pc{-1}) + log(&roc_w/&roc_pc)] ... 
        + (1-rho_w) * log(ww/pc) ...
        + shk_w ...
    !! w = ww;


%% Supply of production capital 

    "Optimal choice of investment in local production capital"
    pk = pih*[ 1 + xi_ih1*($adj_ih1$) + xi_ih2*($adj_ih2$) ] ...
    !! pk = pih;

    "Accumulation of production capital"
    k = (1-delta)*k{-1} + ih;

    "Definition of utilized production capital"
    uk = u * k;

    "Optimal choice of utilization rate of production capital"
    py * upsilon_0 * u^upsilon_1 = pu;

    "Auxiliary equation for steady-state calibration of upsilon_0"
    upsilon_1_py_to_pu = upsilon_0 * py / pu;

    "Ex-post return on capital"
    rk*pk{-1} = u{-1}*pu{-1}*rh{-1} + (1-delta)*pk;


    !for w, ih, k !do
        roc_? = ? / ?{-1};
    !end

```

