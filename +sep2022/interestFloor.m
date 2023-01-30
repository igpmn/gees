
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
d0.gg_shk_a(1) = -0.15;
s0 = simulate(m, d0, 1:10, "prependInput", true, "method", "stacked");
smc0 = databank.minusControl(m, s0, d, "range", 0:10);

m1 = m;
m1.us_floor = 1.00;
m1.ea_floor = 1.00;
m1.cn_floor = 1.00;
m1.rw_floor = 1.00;
m1.us_theta_rh = 2*0.5;
m1.ea_theta_rh = 2*0.5;
m1.cn_theta_rh = 2*0.5;
m1.rw_theta_rh = 2*0.5;
m1.us_theta_rip = 2*0.5;
m1.ea_theta_rip = 2*0.5;
m1.cn_theta_rip = 2*0.5;
m1.rw_theta_rip = 2*0.5;

checkSteady(m1);
m1 = solve(m1);

d1 = d;
d1.gg_shk_a(1) = -0.15;
s1 = simulate(m1, d1, 1:10, "prependInput", true, "method", "stacked");
smc1 = databank.minusControl(m1, s1, d, "range", 0:10);


%% Plot results

% plotDb = databank.merge("horzcat", smc0, smc1, smc2);
plotDb = databank.merge("horzcat", smc0, smc1);

ch = Chartpack();
ch.Range = 0:10;
ch.Transform = @(x) 100*(x-1);
ch.Tiles = [Inf, 5];
ch.Round = 8;
ch + ["us_unc_r", "us_r", "us_roc_pc", "us_e", "us_ch"];
ch + ["ea_unc_r", "ea_r", "ea_roc_pc", "ea_e", "ea_ch"];
ch + ["cn_unc_r", "cn_r", "cn_roc_pc", "cn_e", "cn_ch"];
ch + ["rw_unc_r", "rw_r", "rw_roc_pc", "rw_e", "rw_ch"];

draw(ch, plotDb);

