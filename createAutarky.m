%% Create Open Autarky Economy

close all
clear


%% Create Model Object

sourceFiles = [
    "source/demography.model"
    "source/local.model"
    "source/open.model"
    "source/fiscal.model"
    "source/globals.model"
    "source/wrapper-autarky.model"
];

autarkyModel = Model( ...
    sourceFiles ...
    , "growth", true ...
);


%% Calibrate Parameters

autarkyModel.gg_ss_roc_a = 1.0;
autarkyModel.gg_rho_a = 0.5;

autarkyModel.gg_ss_roc_nn = 1; 1.01;
autarkyModel.gg_rho_nn = 0.9;

autarkyModel.ss_roc_pch = 1; 1.01;
autarkyModel.ss_ar = 1;
autarkyModel.ss_nr = 1;

autarkyModel.ss_nw_to_nn = 0.70;
autarkyModel.ss_nf_to_nw = 0.70;
autarkyModel.rho_nr = 0.9;
autarkyModel.rho_nw = 0.9;
autarkyModel.rho_nf = 0.5;

autarkyModel.beta = 0.95;
autarkyModel.beta_k = 0.90;
autarkyModel.delta = 0.15;
autarkyModel.eta = 0;
autarkyModel.rho_w = 0.40;
autarkyModel.kappa_1 = 0.1;
autarkyModel.kappa_2 = 0.50;

autarkyModel.chi = 1;
autarkyModel.chi_curr = 0.2;
autarkyModel.chi_ch = 0; 0.2;

autarkyModel.nu_0 = 0;
autarkyModel.nu_1 = 0.01;

autarkyModel.mu_y3 = 1.3;

autarkyModel.gamma_n0 = 1/3;
autarkyModel.gamma_n = 0.7;
autarkyModel.gamma_q = 0.05;
autarkyModel.gamma_uk = 0.3;
autarkyModel.gamma_z = 0.60;
autarkyModel.gamma_xx = 0.50;

autarkyModel.alpha = 0.50;

autarkyModel.xi_ch0 = 4;
autarkyModel.xi_ch1 = 2;
autarkyModel.xi_ch2 = 0.40; 0.30;

autarkyModel.upsilon_0 = 1;
autarkyModel.upsilon_1 = 0.2;

autarkyModel.xi_y3 = 0.5;
autarkyModel.xi_y2 = 0.5;
autarkyModel.xi_y1 = 0.5;

autarkyModel.xi_k = 0.5;
autarkyModel.xi_ih = 0.5;

autarkyModel.rho_ar = 0.5;

autarkyModel.zeta_e = 0.6;
autarkyModel.theta = 0.1;

% Price Setting
autarkyModel.mu_py = 1.1;
autarkyModel.xi_py = 25;
autarkyModel.zeta_py = 0.5;

% Monetary Policy
autarkyModel.rho_r = 0.50;
autarkyModel.psi_pch = 3;

% Fiscal Policy
autarkyModel.ss_ncg_to_ngdp = 0.20;
autarkyModel.ss_dg_to_ngdp = 0.40;
autarkyModel.rho_cg = 0.5;
autarkyModel.rho_txl1 = 0.5;
autarkyModel.tau_txl1 = 2.5;
autarkyModel.tau_cg = 0;
autarkyModel.rho_txl2 = 0.5;

%% Calculate Steady State

% Pin down the level of three independent stochastic trends
autarkyModel.gg_nn = 1;
autarkyModel.pch = 1;
autarkyModel.y = 1;

autarkyModel = steady(autarkyModel ...
    , "fixLevel", ["y", "gg_nn", "pch"] ...
    , "blocks", false ...
);


% Run postprocessor on steady state values

s = get(autarkyModel, "steady");
s = postprocess(autarkyModel, s, "steady");


% Check steady state on dynamic equations

checkSteady(autarkyModel);


% Report steady state

table( ...
    autarkyModel, ["steadyLevel", "steadyChange", "form", "description"] ...
    , "writeTable", "tables/createAutarky.xlsx" ...
);


%% Calculate First Order Solution

autarkyModel = solve(autarkyModel)


%% Save Model Object to MAT File

save mat/createAutarky.mat autarkyModel

