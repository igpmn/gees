%% Create Closed Economy Model

close all
clear


%% Create Model Object

sourceFiles = [
    "source/local.model"
    "source/fiscal.model"
    "source/demography.model"
    "source/globals.model"
    "source/wrapper-closed.model"
];

m = Model( ...
    sourceFiles ...
    , "growth", true ...
    , "assign", struct("open", false) ...
);


%% Calibrate Parameters

m.gg_ss_roc_a = 1.02;
m.gg_rho_a = 0.5;

m.gg_ss_roc_nn = 1.01;
m.gg_rho_nn = 0.9;

m.ss_roc_pch = 1.01;
m.ss_ar = 1;
m.ss_nr = 1;

m.ss_nw_to_nn = 0.70;
m.ss_nf_to_nw = 0.70;
m.rho_nr = 0.9;
m.rho_nw = 0.9;
m.rho_nf = 0.5;

m.beta = 0.95;
m.beta_k = 0.90;
m.delta = 0.15;
m.eta = 0;
m.rho_w = 0.40;
m.kappa_1 = 0.1;
m.kappa_2 = 0.50;

m.chi = 1;
m.chi_curr = 0.2;
m.chi_ch = 0;

m.nu_0 = 0;
m.nu_1 = 0.01;

m.mu_y2 = 1; 1.4;

m.gamma_n0 = 1/3;
m.gamma_n = 0.7;
m.gamma_uk = 0.4;
m.gamma_z = 0.60;

m.xi_ch0 = 4;
m.xi_ch1 = 2;
m.xi_ch2 = 0.40; 0.30;

m.upsilon_0 = 1;
m.upsilon_1 = 0.2;

m.xi_y1 = 0.5;
m.xi_y2 = 0.5;
m.xi_k = 0.5;
m.xi_ih = 0.5; 0.2;

m.rho_ar = 0.5;

% Price Setting
m.mu_py = 1.1;
m.xi_py = 25;
m.zeta_py = 0.5;

% Monetary Policy
m.rho_r = 0.50;
m.psi_pch = 3;

% Fiscal Policy
m.ss_ncg_to_ngdp = 0.20;
m.ss_dg_to_ngdp = 0.40;
m.rho_cg = 0.5;
m.rho_txl1 = 0.5;
m.tau_txl1 = 2.5;
m.tau_cg = 0;
m.rho_txl2 = 0.5;


%% Calculate Steady State

% Starting Values for Steady State
m.dg_to_ngdp = m.ss_dg_to_ngdp;
m.y = 1;
m.ar = m.ss_ar;
m.gg_nn = 1;
m.nr = m.ss_nr;
m.nn = m.gg_nn * m.ss_nr;
m.pch = 1;

m = steady(m ...
    , "fixLevel", ["ar", "y", "gg_nn", "nr", "pch", "dg_to_ngdp"] ...
    , "blocks", false ...
);

s = access(m, "steady");
s = postprocess(m, s, "steady");

checkSteady(m);


%% Report Steady State

table( ...
    m, ["steadyLevel", "steadyChange", "form", "description"] ...
    , "writeTable", "tables/createClosed.xlsx" ...
)


%% First Order Solution

m = solve(m)


%% Save Model Object to MAT File

save mat/createClosed.mat m

