%% Create single-area autarky economy 

function [ma, ta] = create()

thisDir = string(fileparts(mfilename("fullpath")));

%% Create model object 

sourceFiles = [
    "model-source/demography.md"
    "model-source/households.md"
    "model-source/production.md"
    "model-source/monetary.md"
    "model-source/fiscal.md"
    "model-source/open.md"
    "model-source/commodity.md"
    "model-source/globals.md"
    "model-source/wrapper-autarky.md"
];

ma = Model.fromFile( ...
    sourceFiles ...
    , "growth", true ...
    , "comment", "Autarky economy" ...
    , "savePreparsed", fullfile(thisDir, "preparsed.md") ...
);

ma = assignUserData(ma, "areas", "");


%% Calibrate parameters 

% Steady-state growth rates

ma.gg_ss_roc_a = 1.02; 
ma.gg_ss_roc_nt = 1.01;
ma.ss_roc_pc = 1.03;
ma.gg_ss_zk = 0.90;
ma.gg_ss_zy = 1;

ma.gg_nu = 0;
ma.ss_ar = 1;
ma.ss_nr = 1;

ma.ss_nw_to_nn = 0.65;
ma.ss_nf_to_nw = 0.70;

ma.beta = 0.95;
ma.ss_zk = 0.90;
ma.ss_zy = 1;
ma.delta = 0.15;
ma.eta = 0;
ma.eta0 = 1;

ma.nu_0 = 0;
ma.nu_1 = 0.07;
ma.ss_zh_aut = 0;

ma.gg_rho_a = 0.5;
ma.gg_rho_nt = 0.9;
ma.gg_rho_zk = 0.90;
ma.gg_rho_zy = 0.90;

ma.rho_nr = 0.9;
ma.rho_nw = 0.9;
ma.rho_nf = 0.5;

ma.rho_w = 0.50;
ma.rho_zk = 0.90;
ma.rho_zy = 0.90;

ma.chi = 1;
ma.chi_curr = 0.60;
ma.chi_ch = 0.30;

ma.rho_zh_aut = 0.70;
ma.theta_1 = 0.10;
ma.theta_2 = 1;

ma.mu_y3 = 1.30;

ma.gamma_n0 = 1/3;
ma.gamma_m = 0.15;
ma.gamma_q = 0.05;
ma.gamma_uk = 0.30;
ma.gamma_yz = 0.60;
ma.gamma_xx = 0.50;

ma.alpha = 0.4;

ma.upsilon_0 = 1;
ma.upsilon_1 = 1/0.2;

ma.xi_y3 = 0.5;
ma.xi_y2 = 0.5;
ma.xi_y1 = 2;

ma.xi_k = 0.5;
ma.xi_ih1 = 0;
ma.xi_ih2 = 0.8;

ma.rho_ar = 0.5;

ma.zeta_e = 0.6;

% Price setting
ma.mu_py = 1.10;
ma.xi_py = 25;
ma.zeta_py = 0.5;

% Monetary policy
ma.rho_r = 0.50;
ma.psi_pc = 2.5;
ma.psi_e = 0;
ma.floor = 1;

% Fiscal policy
ma.ss_ncg_to_ngdp = 0.20;
ma.ss_dg_to_ngdp = 0.40;
ma.rho_cg = 0.5;
ma.rho_txls1 = 0.5;
ma.tau_txls1 = 2.5;
ma.tau_cg = 0;
ma.rho_txls2 = 0.5;
ma.ss_trm = 0;
ma.rho_trm = 0;

% Commodity sector
ma.lambda = 1;
ma.gg_iota_1 = 0.2;
ma.gg_rho_qq = 0.8;

% ma.gg_rho_aqq = 0.7;
% ma.gg_ss_aq = 1;

ma.theta_3 = 0;


%% Calculate steady state 

% Anchor the level of three independent stochastic trends

ma.gg_a = 1;
ma.gg_nt = 1;
ma.pc = 1;


% Initialize some values to help numerical convergence

ma.r = 1.05;
ma.nch_to_netw_minus_nu_0 = 0;
ma.upsilon_1_py_to_pu = 1;
ma.nh = 1;


homotopy = [
    struct("gg_nt", 0.5), ...
    struct("gg_nt", ma.gg_nt), ...
];

ma.eta = 0.5;

for h = homotopy
    ma = assign(ma, h);

    ma = steady(ma ...
        , "fixLevel", ["gg_a", "gg_nt", "pc"] ...
        , "exogenize", ["nh", "r", "nch_to_netw_minus_nu_0", "upsilon_1_py_to_pu"] ...
        , "endogenize", ["eta0", "gg_nu", "nu_0", "upsilon_0"] ...
        , "blocks", false ...
    );
end

checkSteady(ma);


%% Calculate first order solution

ma = solve(ma);


%% Report steady state

ta = table( ...
    ma, ["steady-level", "steady-change", "form", "description"] ...
    , "writeTable", fullfile(thisDir, "steady.xlsx") ...
);


%% Save model object to mat file

save(fullfile(thisDir, "model.mat"), "ma", "ta");

end%

