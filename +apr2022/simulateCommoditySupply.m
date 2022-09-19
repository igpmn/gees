%% Analyze international transmission of cost-push shocks


%% Prepare the stage

clear
close all

m2 = model.symmetric2A.create();

m2.aa_chi_ch = 0;
m2.bb_chi_ch = 0;
m2.aa_theta_1 = 1;
m2.bb_theta_1 = 1;
m2.aa_zeta_e = 0.4;
m2.bb_zeta_e = 0.4;

% m2.aa_nu_1 = 0;
% m2.bb_nu_1 = 0;
% m2.aa_xi_y1 = 10;
% m2.bb_xi_y1 = 10;
m2 = steady(m2);

% Verify a valid steady state exists
checkSteady(m2);

% Calculate first-order solution matrices
m2 = solve(m2);
d0 = steadydb(m2, 1:20);


%% Prepare simulation assumptions

d = d0;
d.gg_shk_pq(1) = 1.50;


%% Simulate the shock


s = simulate( ...
    m2, d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(m2, s, d0);


%% Basic results

close all

ch = databank.Chartpack();
ch.Range = 0:20;
ch.Round = 8;
ch.Expansion = {"?", ["aa", "bb"]};
ch.Transform = @(x) 100*(x-1);

ch < ["Private consumption: ?_ch", "CPI inflation: ?_roc_pc"];
ch < ["Nominal exchange rate: ?_e", "Policy rate: ?_r"];

draw(ch, smc);

visual.hlegend("bottom", "Area AA", "Area BB");

