%% Set of comparative static excercises 

close all
clear
rehash path


%% Create three basic versions of the model: 
%
% * ma - an autarky economy
% * m2 - a symmetric two-area economy
% * m4 - a global four-area economy
%

ma = model.autarky.create();
m2 = model.symmetric2A.create();
m4 = model.global4A.create();


%% Increase in global productivity 
%
% Steady state comparative XLS table is in
% +compareSteady/+globalProductivity
%

t = compareSteady.globalProductivity.run(m4, 0.10, "G4");
disp(t)


%% Increase in global population 
%
% Steady state comparative XLS table is in
% +compareSteady/+globalPopulation
%

t = compareSteady.globalPopulation.run(m4, 0.10, "G4");
disp(t)


%% Increase in CN price level
%
% Steady state comparative XLS table is in
% +compareSteady/+globalPopulation
%

us = compareSteady.areaPriceLevel.run(m4, "us", 0.10, "G4");
ea = compareSteady.areaPriceLevel.run(m4, "ea", 0.10, "G4");
cn = compareSteady.areaPriceLevel.run(m4, "cn", 0.10, "G4");
rw = compareSteady.areaPriceLevel.run(m4, "rw", 0.10, "G4");

disp(us)
disp(ea)
disp(cn)
disp(rw)


%% Increase in global level of govt debt 
%
% Steady state comparative XLS table is in
% +compareSteady/+globalGovtDebt
%

t1 = compareSteady.globalGovtDebt.run(m4, 0.20, "G4");
disp(t1)

% Run again, turn off current wealth effect globally

m4a = m4;
m4a.us_nu_1 = 0;
m4a.ea_nu_1 = 0;
m4a.cn_nu_1 = 0;
m4a.rw_nu_1 = 0;
m4a = steady(m4a, "fixLevel", ["gg_a", "gg_nt", "us_pc", "ea_pc", "cn_pc", "rw_pc"], "blocks", false);

t2 = compareSteady.globalGovtDebt.run(m4a, 0.20, "G4-no-wealth-effect");
disp(t2)


%% Increase in CN relative productivity 
%
% Steady state comparative XLS table is in
% +compareSteady/+areaProductivity
%

t = compareSteady.areaProductivity.run(m4, "cn", 0.10, "G4");
disp(t)


%% Change trade linkages 
%
% Steady state comparative XLS table is in
% +compareSteady/+areaProductivity
%

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
disp(t4)
disp(t4a)


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



%% Reverse engineer the gamma_m parameter 
%
% Steady state comparative XLS table is in
% +compareSteady/+areaProductivity
%

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

t = compareSteady.areaProductivity.run(m4d, "cn", 0.10, "G4d");
disp(t)



%% Global increase in risk appetite wrt capital
%
% Steady state comparative XLS table is in
% +compareSteady/+globalRiskAppetiteCapital
%

t = compareSteady.globalRiskAppetiteCapital.run(m4, 0.95, "G4");
disp(t)



%% Area specific increase in risk appetite wrt capital 
%
% Steady state comparative XLS table is in
% +compareSteady/+areaRiskAppetiteCapital
%

t = compareSteady.areaRiskAppetiteCapital.run(m4, "us", 0.95, "G4");
disp(t)

m4a = m4;

areas = accessUserData(m4, "areas");

for h = areas
    for k = areas
        if h==k
            m4a.(h+"_phi_"+k) = 0.50;
        else
            m4a.(h+"_phi_"+k) = 0.50/3;
        end
    end
end

m4a = steady( ...
    m4a ...
    , "fixLevel", ["gg_a", "gg_nt", areas+"_pc"] ...
    , "blocks", false ...
);

ta = compareSteady.areaRiskAppetiteCapital.run(m4a, "us", 0.95, "G4a");
disp(ta)


