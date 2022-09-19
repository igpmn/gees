# GEES International trade linkages module 


## Declare quantities


```matlab

!variables
    !for ?M=<areas> !do
        !for ?X=<setdiff(areas, "?M")> !do
            "Share of real imports from [?X] in total real imports to [?]"
            ?M_mm_sh_?X
        !end
    !end


!log-variables !all-but

    !for ?M=<areas> !do
        !for ?X=<setdiff(areas, "?M")> !do
            ?M_mm_sh_?X
            ?M_trm_?X
        !end
    !end


!parameters

    !for ?M=<areas> !do
        "Point of origination import adjustment costs !! $\xi_\mathit{mm}$"
        ?M_xi_mm

        !for ?X=<setdiff(areas, "?M")> !do
            "Share of nominal imports from [?X] in total [?M] nominal imports !! $\omega_\mathrm{?X}$"
            ?M_omega_?X
        !end
    !end

```


## Define equations


```matlab

!equations

    !for ?X=<areas> !do
        "Distribution of exports across areas"
        ?X_xx = !for ?M=<setdiff(areas, "?X")> !do + ?M_mm * ?M_mm_sh_?X !end ;
    !end


    !for ?M=<areas> !do
        "Assembly of total non-commodity imports"
        1 = 1 !for ?X=<setdiff(areas, "?M")> !do * (?M_mm_sh_?X / ?M_omega_?X)^?M_omega_?X !end;
        % 1 = 1 !for ?X=<areas> !do * ?M_mm_sh_?X^?M_omega_?X !end;

        !for ?X=<setdiff(areas, "?M")> !do
            "Demand for imports from [?X] in total [?M] non-commodity imports"
            ?M_omega_?X * ?M_pmm = ...
                (?M_e / ?X_e) * ?X_pxx * (1 + ?M_trm + ?M_trm_?X) * ?M_mm_sh_?X ...
                * [1 + ?M_xi_mm*(log(?M_mm_sh_?X)-log(?M_mm_sh_?X{-1})) - ?M_rdf*(log(?M_mm_sh_?X{+1})-log(?M_mm_sh_?X))] ...
            !! ?M_omega_?X * ?M_pmm = (?M_e / ?X_e) * ?X_pxx * (1 + ?M_trm + ?M_trm_?X) * ?M_mm_sh_?X;
        !end
        ?M_fob_pmm = !for ?X=<setdiff(areas, "?M")> !do + (?M_e / ?X_e) * ?X_pxx * ?M_mm_sh_?X !end; 
    !end



%% Tariffs 

!for ?M=<areas> !do
    !for ?X=<setdiff(areas, "?M")> !do
        !variables
            "Area specific import tariff rate" ?M_trm_?X

        !shocks
            "Shock to area specific import tariff rate" ?M_shk_trm_?X

        !parameters(:trade :steady)
            "S/S Area specific import tariff rate !! $\mathit{trm}_{\mathrm{?X},\ss}$" ?M_ss_trm_?X

        !parameters(:trade :dynamic)
            "A/E Area specific import tariff rate !! $\rho_{trm,\mathrm{?X}}$" ?M_rho_trm_?X

        !equations
            ?M_trm_?X ...
                = ?M_rho_trm_?X * ?M_trm_?X{-1} ...
                + (1 - ?M_rho_trm_?X) * ?M_ss_trm_?X ...
                + ?M_shk_trm_?X ...
            !! ?M_trm_?X = ?M_ss_trm_?X;
    !end
!end

```


## Postprocessing equations outside model 

```matlab

!postprocessor

    !for ?M=<areas> !do
        !for ?X=<setdiff(areas, "?M")> !do
            "Imports from [?X] to [?M]"
            ?M_mm_?X = ?M_mm_sh_?X * ?M_mm;
        !end
    !end


!log-variables !all-but

```

