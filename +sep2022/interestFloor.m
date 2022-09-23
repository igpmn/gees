
close all
clear

load ./+model/+global4A/model.mat m4
m = m4;

m.gg_rho_a = 0.9;
checkSteady(m);
m = solve(m);
d = databank.forModel(m, 1:10);

m.us_floor = 0.0;
m.ea_floor = 0.0;
m.cn_floor = 0.0;
m.rw_floor = 0.0;
checkSteady(m);
m = solve(m);

d0 = d;
d0.gg_shk_a(1) = -0.12;
s0 = simulate(m, d0, 1:10, "prependInput", true, "method", "stacked");
smc0 = databank.minusControl(m, s0, d, "range", 0:10);

m.us_floor = 0.95;
m.ea_floor = 0.95;
m.cn_floor = 0.95;
m.rw_floor = 0.95;
m.us_theta_rh = 0.5;
m.ea_theta_rh = 0.5;
m.cn_theta_rh = 0.5;
m.rw_theta_rh = 0.5;
m.us_theta_rip = 0.5;
m.ea_theta_rip = 0.5;
m.cn_theta_rip = 0.5;
m.rw_theta_rip = 0.5;
checkSteady(m);
m = solve(m);

d1 = d;
d1.gg_shk_a(1) = -0.12;
s1 = simulate(m, d1, 1:10, "prependInput", true, "method", "stacked");
smc1 = databank.minusControl(m, s1, d, "range", 0:10);


%% Plot results

plotDb = databank.merge("horzcat", s0, s1);

ch = Chartpack();
ch.Range = 0:10;
ch.Transform = @(x) 100*(x-1);
ch.Tiles = [Inf, 4]
ch.YLine = 0;
ch + ["us_unc_r", "us_r", "us_roc_pc", "us_e"];
ch + ["ea_unc_r", "ea_r", "ea_roc_pc", "ea_e"];
ch + ["cn_unc_r", "cn_r", "cn_roc_pc", "cn_e"];
ch + ["rw_unc_r", "rw_r", "rw_roc_pc", "rw_e"];

draw(ch, plotDb);

