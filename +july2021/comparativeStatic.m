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
m4a = steady(m4a, "fixLevel", ["gg_a", "gg_nt", "us_pch", "ea_pch", "cn_pch", "rw_pch"], "blocks", false);

ta = compareSteady.globalGovtDebt.run(m4a, 0.20, "G4a");


%% Increase in CN productivity

compareSteady.areaProductivity.run(m4, "cn", 0.10, "G4");





