
# GEES: International finance linkages module

## Declare quantities

```matlab

!parameters(:finance :steady)

    !for ?H=<areas> !do
        !for ?K=<areas> !do
            "Corporate equity portfolio share !! $\phi_\mathrm{?K}$" ?H_phi_?K
        !end
    !end

!parameters(:finance :dynamic)

    !for ?H=<areas> !do
        "Forward capital adjustment cost parameter !! $\xi_k$" ?H_xi_k
    !end

```

## Define equations

```matlab

!equations

    !for ?K=<areas> !do
        "Average arbitrage-free condition"
        !for ?H=<areas> !do
            + ?H_phi_?K * ( ...
                - ?H_beta * ?H_vh{+1} * ?H_rh * ?K_pk * ?H_e / ?K_e ...
                - ?H_vh * ?K_xi_k * ?K_pk * [ log(?K_k) - log(?K_k{+1}/&?K_roc_k) ] ...
                + ?H_vh * ?K_pu * ?K_u * ?H_e / ?K_e ...
                + gg_zk * ?H_zk * ?H_beta * ?H_vh{+1} * (1-?K_delta) * ?K_pk{+1} * ?H_e{+1} / ?K_e{+1} ...
            ) ...
        !end
        ;
    !end


    !for ?H=<areas> !do
        "BOP FA corporate equity transactions to GDP ratio"
        ?H_bpfeq_to_ngdp * ?H_ngdp = ...
        !for ?K=<areas> !do
            + ?H_phi_?K * ?H_e / ?K_e * ( ...
                + (1 - ?K_delta) * ?K_pk * ?K_k{-1} ...
                - ?K_pk * ?K_k ...
            ) ...
            - ?K_phi_?H * ( ...
                + (1 - ?H_delta) * ?H_pk * ?H_k{-1} ...
                - ?H_pk * ?H_k ...
            ) ...
        !end
        ;

        "BOP CA corporate equity primary income to GDP ratio"
        ?H_bpceq_to_ngdp * ?H_ngdp = ...
        !for ?K=<areas> !do
            + ?H_phi_?K * ?H_e / ?K_e * ( ...
                + ?K_pu * ?K_uk ...
            ) ...
            - ?K_phi_?H * ( ...
                + ?H_pu * ?H_uk ...
            ) ...
        !end
        ;
    !end


    !for ?H=<areas> !do
        "Value of corporate equity portfolio"
        ?H_kk = !for ?K=<areas> !do + ?H_phi_?K * ?H_e / ?K_e * (?K_pk * ?K_k) !end;
    !end

```

