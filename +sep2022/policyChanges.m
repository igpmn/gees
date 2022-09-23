
close all
clear

load +model/+global4A/model.mat m4

areas = accessUserData(m4, "areas");

m4.us_chi_curr = 0.4;
m4.ea_chi_curr = 0.4;
m4.cn_chi_curr = 0.4;
m4.rw_chi_curr = 0.4;
m4.us_nu_1 = 0.15;
m4.ea_nu_1 = 0.15;
m4.cn_nu_1 = 0.15;
m4.rw_nu_1 = 0.15;
m4.cn_tau_cg = 0;
m4.cn_rho_cg = 0.9;
m4 = steady(m4, "fixLevel", ["gg_a", "gg_nt", areas+"_pc"]);
m4 = solve(m4);

% [s, smc] = simulate.areaDisinflation.run(m4, "rw", 1:10, 0.01, "+sep2022/rw-disinflation.html");

[s, smc, ~, m4after] = simulate.areaGovtDebt.run(m4, "us", 1:20, 0.20, "+sep2022/us-government.html");
