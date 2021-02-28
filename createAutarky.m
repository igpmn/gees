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
    "source/commodity.model"
    "source/wrapper-autarky.model"
];

ma = Model( ...
    sourceFiles ...
    , "growth", true ...
);


%% Calibrate Parameters

ma.gg_ss_roc_a = 1; 1.02; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ma.gg_rho_a = 0.5;

ma.gg_ss_roc_nn = 1.01;
ma.gg_rho_nn = 0.9;

ma.ss_roc_pch = 1.00;
ma.ss_ar = 1;
ma.ss_nr = 1;

ma.ss_nw_to_nn = 0.65;
ma.ss_nf_to_nw = 0.70;

ma.ss_beq_to_bass = 0.10;

ma.rho_nr = 0.9;
ma.rho_nw = 0.9;
ma.rho_nf = 0.5;

ma.beta = 0.98; 0.95; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ma.beta_k = 0.90;
ma.delta = 0.15;
ma.eta = 0;
ma.rho_w = 0.40;
ma.kappa_1 = 0.1;
ma.kappa_2 = 1;

ma.chi = 1;
ma.chi_curr = 0.6;
ma.chi_ch = 0;

ma.nu_0 = 0;
ma.nu_1 = 0.01;
ma.theta = 0.10;

ma.mu_y3 = 1.3;

ma.gamma_n0 = 1/3;
ma.gamma_n = 0.6;
ma.gamma_q = 0.05;
ma.gamma_uk = 0.3;
ma.gamma_z = 0.60;
ma.gamma_xx = 0.50;

ma.alpha = 0.50;

ma.xi_ch0 = 4;
ma.xi_ch1 = 2;
ma.xi_ch2 = 0.40; 0.30;

ma.upsilon_0 = 1;
ma.upsilon_1 = 0.2;

ma.xi_y3 = 0.5;
ma.xi_y2 = 0.5;
ma.xi_y1 = 2; %%%%%%%%%%%%%%%%%%%%%%%%%%

ma.xi_k = 0.5;
ma.xi_ih = 0.5;

ma.rho_ar = 0.5;

ma.zeta_e = 0.6;

% Price Setting
ma.mu_py = 1.1;
ma.xi_py = 25;
ma.zeta_py = 0.5;

% Monetary Policy
ma.rho_r = 0.50;
ma.psi_pch = 3;
ma.psi_r = 0.1;
ma.floor = 1;

% Fiscal Policy
ma.ss_ncg_to_ngdp = 0.20;
ma.ss_dg_to_ngdp = 0.40;
ma.rho_cg = 0.5;
ma.rho_trl1 = 0.5;
ma.tau_trl1 = 2.5;
ma.tau_cg = 0;
ma.rho_trl2 = 0.5;
ma.ss_trm = 0;
ma.rho_trm = 0;

% Commodity Sector
ma.lambda = 1;
ma.gg_rho_aqq = 0.7;
ma.iota_1 = 0;
ma.iota_2 = 10;
ma.gg_ss_aq = 1;

ma.theta_3 = 0;


%% Calculate Steady State

% Pin down the level of three independent stochastic trends
ma.gg_a = 0.5;
ma.gg_nt = 1;
ma.pch = 1;
ma.y = 1;

ma.ss_roc_pch = 1.0;
ma = steady(ma ...
    , "fixLevel", ["y", "gg_nt", "pch"] ...
    , "blocks", false ...
);
checkSteady(ma);

%{
ma.ss_roc_pch = 1.02;
ma = steady(ma ...
    , "fixLevel", ["y", "gg_nt", "pch"] ...
    , "blocks", false ...
);
checkSteady(ma);
%}

% Run postprocessor on steady state values

s = get(ma, "steady");
s = postprocess(ma, s, "steady");


% Check steady state on dynamic equations

checkSteady(ma);


% Report steady state

t = table( ...
    ma, ["steadyLevel", "steadyChange", "form", "description"] ...
    , "writeTable", "tables/createAutarky.xlsx" ...
);


%% Calculate First Order Solution

ma = solve(ma)


%% Create Economies with Different Population Levels
% us, ea, cn, rc
mas = alter(ma, 4);
mas.ss_nr = [0.331, 0.515, 1.439, 7.123-1.439];

mas = steady(mas ...
    , "fixLevel", ["gg_nt", "gg_a", "pch"] ...
    , "blocks", false ...
);

checkSteady(mas);


%% Save Model Object to MAT File

save mat/createAutarky.mat ma mas

