

% Load the m4 model
load +model/+global4A/model.mat m4

% Create a copy of the model, and assign a higher ar productivity to RW
m4a = m4;
m4a.rw_ss_ar = m4a.rw_ss_ar + 0.10;

% Make sure that the autoregressive parameter for RW ar productivity is what you want
m4a.rw_rho_ar = 0.85;

% Recompute steady state of the new model, recompute solution matrices
m4a = steady(m4a, "fixLevel", ["gg_a", "gg_nt", "us_pc", "ea_pc", "cn_pc", "rw_pc"]);
m4a = solve(m4a);

% Create initial databank from the original model
d = databank.forModel(m4, 1:20);

%% Simulate the new model using initial databank from the original model

s = simulate(m4a, d, 1:20, "method", "stacked", "prependInput", true);

% Report the results as deviations from control scenario (no shock)
smc = databank.minusControl(m4, s, d, "range", 0:20);

steadyDb = databank.forModel(m4a, 1:20);
zeroDb = databank.minusControl(m4, steadyDb, d, "range", 0:20);

% report.basicWithSteady(m4, smc, zeroDb, 1:20, "RW Productivity Catchup", "RW@10%", "+sep2022/rw-productivity");

%% Increase current income channel and make forex markets fully efficient

m4b = m4a;
m4b.rw_chi_curr = 0.5;
m4b.rw_zeta_r = 1;
m4b = steady(m4b, "fixLevel", ["gg_a", "gg_nt", "us_pc", "ea_pc", "cn_pc", "rw_pc"]);
m4b = solve(m4b);

s2 = simulate(m4b, d, 1:20, "method", "stacked", "prependInput", true);
smc2 = databank.minusControl(m4, s2, d, "range", 0:20);


%% On-screen charts

ch = Chartpack();
ch.Range = 0:20;
ch.YLine = 0;
ch.Transform = @(x) 100*(x-1);

list = [
    "Relative productivity: rw_ar"
    "Consumption: rw_ch"
    "Investment: rw_ih"
    "Nonc exports: rw_xx"
    "Nonc imports: rw_mm"
    "Hours worked: rw_nh"
    "Real wage: rw_w_to_pc"
    "Real labor incom: rw_rli"
    "Nominal exchg rate: rw_e"
    "Inflation: rw_roc_pc"
    "Short rate: rw_r"
    "Asset prices: rw_pk"
    "Utilization: rw_u"
    "Capital: rw_k"
    "NFA to NGDP:^ 100*rw_nfa_to_ngdp"
    ];

ch + list;

chartDb  = databank.merge("horzcat", smc, smc2, zeroDb);
draw(ch, chartDb);
