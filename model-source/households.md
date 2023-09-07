
# GEES Households module

## Define quantities


```matlab

!variables(:households)

    "Private consumption" ch
    "Per-capita private consumption" ch_to_nn
    "Private consumption reference level" ref_ch_to_ch
    "Real discount factor" rdf
    "Per-worker labor supply" nh
    "Private investment" ih
    "Uncertainty in capital" zk
    "Uncertainty in profits" zy
    "Ex-post return on capital" rk
    "Production capital" k
    "Production capital services" uk
    "Portfolio of claims on production capital" kk
    "Household net worth" netw
    "Nominal wage rate" w
    "Real labor income" rli

    "Price of production capital" pk
    "Price of production capital services" pu
    "Real consumer wage rate" w_to_pc
    "Target nominal wage rate" ww

    "Nominal wage rate, Y/Y" roc_w
    "Household investment, Y/Y" roc_ih
    "Production capital, Y/Y" roc_k


!log-variables !all-but

    ref_ch_to_ch


!parameters(:households :steady)

    "S/S Uncertainty discount factor on capital !! $\mathit{zk}_\mathrm{ss}$" ss_zk
    "S/S Uncertainty discount factor on production cash flows !! $\mathit{zy}_\mathrm{ss}$" ss_zy
    "Household discount factor !! $\beta$" beta
    "Depreciation of production capital !! $\delta$" delta
    "Inverse elasticity of labor supply !! $\eta$" eta
    "Utility location parameter of labor supply !! $\eta_0$" eta0
    "Intercept in current wealth utility !! $\nu_0$" nu_0
    "Slope of current wealth utility !! $\nu_1$" nu_1
    "Level parameter in cost of utilization of production capital !! $\upsilon_0$" upsilon_0
    "Inverse elasticity of cost of utilization of production capital !! $\upsilon_1$" upsilon_1


!parameters(:households :dynamic)

    "A/R in uncertainty discount factor on capital !! $\rho_\mathit{zk}$" rho_zk
    "A/R in uncertainty discount factor on production cash flows !! $\rho_\mathit{zy}$" rho_zy
    "Point of reference in consuptions switch !! $\chi$" chi
    "Past consumption in reference consumption parameter !! $\chi_\mathit{ch}$" chi_ch
    "Current income in reference consumption parameter !! $\chi_\mathit{curr}$" chi_curr
    "Type 1 investment adjustment cost parameter !! $\xi_\mathit{ih,1}$" xi_ih1
    "Type 2 investment adjustment cost parameter !! $\xi_\mathit{ih,2}$" xi_ih2
    "Pressure relief valve for interest rate lower bound !! $\theta_\mathir{rh}$" theta_rh
    "Adjustment cost in wage setting" xi_w


!shocks(:households)

    "Shock to intertemporal preferences" shk_beta
    "Shock to private consumption" shk_ch
    "Shock to private investment" shk_ih
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

!equations(:households)

%% Household consumption-saving choice 

    "Optimal choice of household consumption"
    vh*pc*(ch - chi*ref_ch_to_ch*ch)*exp(-shk_ch) = nn*(1 - chi*&ref_ch_to_ch) ...
    !! vh*pc*ch = nn;

    "Point of reference in household consumption" 
    ref_ch_to_ch = [ chi_curr*($curr$)/pc + chi_ch*ch{-1}*gg_ss_roc_a ] / ch;

    "Optimal choice of net position with local financial sector"
    vh = beta*vh{+1}*rh + nn/(pc*ch)*[ nu_1*(pc*ch/netw - nu_0) - gg_nu ] * exp(shk_beta) ...
    !! 1 = beta*rh/gg_ss_roc_a/ss_roc_pc + nu_1*nch_to_netw_minus_nu_0 - gg_nu;

    "Auxiliary equation for steady-state calibration of nu_0"
    nch_to_netw_minus_nu_0 = pc * ch / netw - nu_0;

    rdf = beta*vh{+1}*pc{+1}/(vh*pc);

    "Risk adjusted household rate"
    rh = r + theta_rh*(unc_r - r) + zh;

    "Current net worth of households"
    netw = kk + dg_to_ngdp*ngdp + nfa_to_ngdp*ngdp;

    "Uncertainty discount factor on capital"
    log(zk) = rho_zk*log(zk{-1}) + (1-rho_zk)*log(ss_zk) + shk_zk ...
    !! zk = ss_zk;

    "Uncertainty discount factor on production cash flows"
    log(zy) = rho_zy*log(zy{-1}) + (1-rho_zy)*log(ss_zy) + shk_zy ...
    !! zy = ss_zy;

    "Real labor income"
    rli = w*nh*nf / pc; 


%% Labor supply 

    "Optimal choice of per-worker hours worked"
    vh * ww = eta0 * nh^eta;

    "Real consumer wage rate"
    w_to_pc = w / pc;

    "Wage rigidities"
    log(ww) - log(w) = ...
        + xi_w*(log(roc_w) - log(roc_w{-1})) ...
        - beta/&roc_w*xi_w*(log(roc_w{+1}) - log(roc_w)) ...
        + shk_w ...
    !! w = ww;

%     log(w_to_pc) = ...
%         + 0.5 * [log(w_to_pc{-1}) + log(&roc_w/&roc_pc)] ... 
%         + (1-0.5) * log(ww/pc) ...

%% Supply of production capital 

    "Optimal choice of investment in local production capital"
    pk * exp(shk_ih) = pih*[ 1 + xi_ih1*($adj_ih1$) + xi_ih2*($adj_ih2$) ] ...
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


%% Rates of change

    !for w, ih, k !do
        roc_? = ? / ?{-1};
    !end

```

