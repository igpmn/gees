%% Set of comparative static excercises

clear
close all
rehash path


%% Create a 4A version of the model

ma = model.autarky.create();
m2 = model.symmetric2A.create();
m4 = model.global4A.create();


%% Increase in global productivity

compareSteady.globalProductivity.run(m4, 0.10, "G4");


%% Increase in global population

compareSteady.globalPopulation.run(m4, 0.10, "G4");


%% Increase in CN price level

compareSteady.areaPriceLevel.run(m4, "cn", 0.10, "G4");


%% Increase in global level of govt debt

t = compareSteady.globalGovtDebt.run(m4, 0.20, "G4");

m4a = m4;
m4a.us_nu_1 = 0;
m4a.ea_nu_1 = 0;
m4a.cn_nu_1 = 0;
m4a.rw_nu_1 = 0;
m4a = steady(m4a, "fixLevel", ["gg_a", "gg_nt", "us_pc", "ea_pc", "cn_pc", "rw_pc"], "blocks", false);

ta = compareSteady.globalGovtDebt.run(m4a, 0.20, "G4a");


%% Increase in CN productivity

compareSteady.areaProductivity.run(m4, "cn", 0.10, "G4");


%% Change trade linkages

t4 = table(m4, ["steadyLevel", "steadyChange", "description"]);



m4a = m4;
m4a.us_gamma_m = m4a.us_gamma_m + 0.15;
m4a.ea_gamma_m = m4a.ea_gamma_m + 0.15;
m4a.cn_gamma_m = m4a.cn_gamma_m + 0.15;
m4a.rw_gamma_m = m4a.rw_gamma_m + 0.15;

m4a = steady(m4a);
checkSteady(m4a);
m4a = solve(m4a);

t4a = table(m4a, ["steadyLevel", "steadyChange", "description"]);

t4(["us", "ea", "cn", "rw"]+"_gamma_m", :)
t4(["us", "ea", "cn", "rw"]+"_nmm_to_ngdp", :)

t4a(["us", "ea", "cn", "rw"]+"_gamma_m", :)
t4a(["us", "ea", "cn", "rw"]+"_nmm_to_ngdp", :)

compareSteady.areaProductivity.run(m4a, "cn", 0.10, "G4a");



m4b = m4;
m4b.us_gamma_m = m4b.us_gamma_m + 0.15;
m4b.ea_gamma_m = m4b.ea_gamma_m + 0.15;
m4b.rw_gamma_m = m4b.rw_gamma_m + 0.15;

m4b = steady(m4b);
checkSteady(m4b);
m4b = solve(m4b);

compareSteady.areaProductivity.run(m4b, "cn", 0.10, "G4b");


%% Separate world: EA+CN vs US+RW

% m4c = m4;
% 
% m4c.ea_omega_us = 0.05;
% m4c.ea_omega_rw = 0.05;
% m4c.cn_omega_us = 0.05;
% m4c.cn_omega_rw = 0.05;
% 
% m4c.ea_omega_cn = 0.90;
% m4c.cn_omega_ea = 0.90;
% 
% m4c.us_omega_ea = 0.05;
% m4c.us_omega_cn = 0.05;
% m4c.rw_omega_ea = 0.05;
% m4c.rw_omega_cn = 0.05;
% 
% m4c.us_omega_rw = 0.90;
% m4c.rw_omega_us = 0.90;
% 
% m4c = steady(m4c, blocks=false);


%% Reverse engineer gamma_m parameter

m4d = m4;

m4d.us_nmm_to_ngdp = 0.50;
m4d.ea_nmm_to_ngdp = 0.50;
m4d.cn_nmm_to_ngdp = 0.50;
m4d.rw_nmm_to_ngdp = 0.50;

m4d = steady( ...
    m4d ...
    , "exogenize", ["us_nmm_to_ngdp", "ea_nmm_to_ngdp", "cn_nmm_to_ngdp", "rw_nmm_to_ngdp"] ...
    , "endogenize", ["us_gamma_m", "ea_gamma_m", "cn_gamma_m", "rw_gamma_m"] ...
);


t4d = table(m4d, ["steadyLevel", "steadyChange", "description"]);

t4d(["us", "ea", "cn", "rw"]+"_gamma_m", :)
t4d(["us", "ea", "cn", "rw"]+"_nmm_to_ngdp", :)

compareSteady.areaProductivity.run(m4d, "cn", 0.10, "G4d");














