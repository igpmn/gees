%%%%%%%%%%%%%%%%%
%% Analyze international transmission of cost-push shocks


%% Prepare the stage

clear
close all

m2 = model.symmetric2A.create();

% m2.aa_gamma_m = 0.30;
% m2.bb_gamma_m = 0.30;
m2.aa_chi_ch = 0;
m2.bb_chi_ch = 0;
m2.aa_theta_1 = 1;
m2.bb_theta_1 = 1;
m2.aa_zeta_e = 0.4;
m2.bb_zeta_e = 0.4;


% Verify a valid steady state exists
m2 = steady(m2);
checkSteady(m2);


% Calculate first-order solution matrices
m2 = solve(m2);
d0 = steadydb(m2, 1:20);


%% Prepare simulation assumptions

d = d0;
p = Plan.forModel(m2, 1:20);
p = swap(p, 1, ["aa_roc_pc", "aa_shk_py"]);
d.aa_roc_pc(1) = d.aa_roc_pc(1) * 1.01; 


%% Simulate the shock


s = simulate( ...
    m2, d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
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


%% AA: Local prices -> export prices

figure();
plot(0:20, 100*([smc.aa_py, smc.aa_pxx, smc.aa_pmm]-1), "marker", "s");
legend("AA Local prices", "AA Export prices", "AA Import (reexport) prices");
title(["AA Pass-through to export price", "Percent level deviations from steady state"]);

m2.aa_alpha

figure();
plot(0:20, pct([smc.aa_py, smc.aa_pxx, smc.aa_pmm]), "marker", "s");
legend("AA Local prices Y/Y", "AA Export prices Y/Y", "AA Import (reexport) prices Y/Y");
title(["AA Pass-through to export price Y/Y", "Pp deviations from steady state"]);


%% BB: Import prices

figure();
plot(0:20, 100*([smc.aa_pxx, smc.bb_e, smc.bb_pmm]-1), "marker", "s");
legend("AA Export prices in AA currency", "BB Nominal exchange rate", "BB Import price");
title(["BB Impact on import prices", "Percent level deviations from steady state"]);



%% BB: T-3: Combine non-comm imports and labor -> y3

figure();
plot(0:20, 100*([smc.bb_pmm, smc.bb_w, smc.bb_py3]-1), "marker", "s");
legend("BB Import prices", "BB Wages", "BB Stage T-3 output price");
title(["BB Impact on T-3 production", "Percent level deviations from steady state"]);


%% BB: T-3: Import-labor substitution

figure();
plot(0:20, 100*([smc.bb_my, smc.bb_nv, smc.bb_y3]-1), "marker", "s");
legend("BB Imports", "BB Variable labor", "BB Stage T-3 output");
title(["BB Impact on T-3 production", "Percent level deviations from steady state"]);


%% Show commodity cycle

figure();

subplot(2, 2, 1);
plot(0:20, 100*([smc.aa_y, smc.bb_y]-1));
title("Area output");
legend("AA", "BB");

subplot(2, 2, 2);
plot(0:20, 100*([smc.aa_mq, smc.bb_mq, smc.gg_q]-1));
title("Area demand for commodities");
legend("AA", "BB", "Global");

subplot(2, 2, 3);
plot(0:20, 100*([smc.gg_q, smc.gg_qq, smc.gg_pq_to_pxx]-1));
title("Global commodity demand and supply");
legend("Demand", "Supply", "Real price");


%% Increase gamma_m


m2 = alter(m2, 2);
m2.bb_gamma_m(2) = 0.30;
m2.aa_gamma_m(2) = 0.30;

m2 = steady(m2);
checkSteady(m2);
m2 = solve(m2);

real(m2.bb_nmm_to_ngdp)


d = steadydb(m2, 1:20);

p = Plan.forModel(m2, 1:20);
p = swap(p, 1, ["aa_roc_pc", "aa_shk_py"]);
d.aa_roc_pc(1, :) = d.aa_roc_pc(1, :) * 1.01; 


%% Simulate the shock

s = simulate( ...
    m2, d, 1:20 ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
);

smc = databank.minusControl(m2, s, d0);


figure();
plot(0:20, 100*([smc.aa_roc_pc, smc.bb_roc_pc]-1));
h = legend( ...
    "AA CPI inflation, low aa_gamma_m" ...
    , "AA CPI inflation, high aa_gamma_m" ...
    , "BB CPI inflation, low aa_gamma_m" ...
    , "BB CPI inflation, high aa_gamma_m" ...
);
set(h, "interpreter", "none");






