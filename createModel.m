
close all
clear

sourceFiles = [
    "source/real.model"
    "source/fiscal.model"
    "source/demography.model"
    "source/bop.model"
];

%{
f = model.File(sourceFiles);
us = clone(f, ["us_", ""], "namesToKeep", ["open"]);
save(us, "temp.model");


return
%}

sourceFiles = [
    sourceFiles
    "source/autonomous.model"
];

m = Model( ...
    sourceFiles ...
    , "growth", true ...
    , "assign", struct("open", true) ...
);

m.ss_roc_nn = 1; 1.01;
m.ss_roc_a = 1; 1.02;
m.ss_roc_pch = 1.01;

m.ss_nw_to_nn = 0.70;
m.ss_nf_to_nw = 0.70;
m.rho_nn = 0.9;
m.rho_nw = 0.9;
m.rho_nf = 0.5;


m.beta = 0.95;
m.beta_k = 0.90;
m.delta = 0.15;
m.eta = 0;
m.rho_w = 0.40; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m.kappa_1 = 0.1;
m.kappa_2 = 0.50;

m.chi = 1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m.chi_curr = 0.2;
m.chi_ch = 0; 0.2;

m.nu_0 = 0;
m.nu_1 = 0.01; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m.mu_y2 = 1; 1.4;

m.gamma_n0 = 1/3;
m.gamma_n = 0.7;
m.gamma_uk = 0.3;
m.gamma_z = 0.60;

% 0.40 0.60 2
% gamma_n = 0.6/2.60
% gamma_k = 0.4/3

m.xi_ch0 = 4;
m.xi_ch1 = 2;
m.xi_ch2 = 0.40; 0.30;

m.upsilon_0 = 1;
m.upsilon_1 = 0.2;

m.xi_y1 = 0.5;
m.xi_y2 = 0.5;
m.xi_k = 0.5;
m.xi_ih = 0.5; 0.2;

m.rho_a = 0.5;

% Price Setting
m.mu_py = 1.1;
m.xi_py = 25;
m.zeta_py = 0.5; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%k

% Monetary Policy
m.rho_r = 0.50;
m.psi_pch = 3; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fiscal Policy
m.ss_ncg_to_ngdp = 0.20;
m.ss_dg_to_ngdp = 0.40;
m.rho_cg = 0.5;
m.rho_txl1 = 0.5;
m.tau_txl1 = 2.5;
m.tau_cg = 0;
m.rho_txl2 = 0.5;

m.dg_to_ngdp = m.ss_dg_to_ngdp;
m.y = 1;
m.nn = 1;
m.pch = 1;

m = steady(m ...
    , "fixLevel", ["y", "nn", "pch", "dg_to_ngdp"] ...
    , "blocks", false ...
);

s = access(m, "steady");
s = postprocess(m, s, "steady");

checkSteady(m);

table(m, ["SteadyLevel", "SteadyChange", "Form", "Description"])

m = solve(m);
beenSolved(m)

save mat/createModel.mat m

