# GEES Wrapper for autarky economy 


## Declare quantities

    !variables

        "Global population" gg_nn
        "Global population, Y/Y" gg_roc_nn
        "Global index of non-commodity export prices" gg_pxx
        "Global nominal GDP" gg_ngdp
        "Global real GDP index, Y/Y" gg_roc_gdp
        "Global per-capita real GDP index, Y/Y" gg_roc_gdp_to_nn


    !substitutions

        ref_k = k{+1}/&roc_k;


    !parameters

        "Forward capital adjustment cost parameter" xi_k
        "Forex market functioning" zeta_r


## Specify equations

    !equations

        nfa_to_ngdp = 0;

        nfa_to_ngdp_checksum = 0;

        pmm = fob_pmm * (1 + trm);

        fob_pmm = pxx;

        e = 1;

        rnfa = r{-1};

        "Global population"
        gg_nn = nn;

        "Global population, Y/Y" 
        gg_roc_nn = nn / nn{-1};

        - beta*vh{+1}*rh*pk - vh*xi_k*pk*log(k/($ref_k$)) ...
            + vh*pu*u + gg_zk*zk*beta*vh{+1}*(1-delta)*pk{+1} ...
        !! - beta*vh{+1}*rh*pk + vh*pu*u + gg_zk*zk*beta*vh{+1}*(1-delta)*pk{+1};
        % !! -vh*pk + vh*pu*u + gg_zk*zk*beta*vh{+1}*(1-delta)*pk{+1} + (vh - beta*vh{+1}*rh)*pk;

        "BOP FA corporate equity transactions to GDP ratio"
        bpfeq_to_ngdp = 0;

        "BOP CA corporate equity primary income to GDP ratio"
        bpceq_to_ngdp = 0;

        "Corporate equity portfolio"
        kk = pk * k;

        "Global index of non-commodity export prices"
        gg_pxx = pxx_rcy;

        "Global demand for commodities"
        gg_q = mq;

    %


    %% Global GDP 

        "Global real GDP, Y/Y"
        gg_roc_gdp = roc_gdp;

        "Global per-capita real GDP, Y/Y"
        gg_roc_gdp_to_nn = roc_gdp_to_nn;

        "Global nominal GDP"
        gg_ngdp = ngdp;

    %

