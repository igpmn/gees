
close all
clear 

load mat/createModel.mat m

m = alter(m, 2);

m.nu_0 = 0;
m.nu_1 = [0.02, 0.02];
m.ss_dg_to_ngdp = [0.10, 0.50];

m = steady(m ...
    , "fixLevel", ["a", "nn", "pch"] ...
    , "blocks", false ...
);

table(m, ["SteadyLevel", "SteadyChange", "Form", "Description"])

