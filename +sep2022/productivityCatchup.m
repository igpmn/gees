

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

% Simulate the new model using initial databank from the original model
s = simulate(m4a, d, 1:20, "method", "stacked");

% Report the results as deviations from control scenario (no shock)
smc = databank.minusControl(m4, s, d);

steadyDb = databank.forModel(m4a, 1:20);
zeroDb = databank.minusControl(m4, steadyDb, d, "range", 1:20);

report.basicWithSteady(m4, smc, zeroDb, 1:20, "RW Productivity Catchup", "RW@10%", "+sep2022/rw-productivity");
