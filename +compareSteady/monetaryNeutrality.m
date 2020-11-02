
close all
clear

load mat/createModel.mat m

m = alter(m, 2);
m.ss_roc_pch(2) = m.ss_roc_pch(1) + 0.01;

m = steady(m ...
    , "fixLevel", ["y", "nn", "pch"] ...
    , "blocks", false ...
);

columns = [
    "steadyLevel"
    "compareSteadyLevel"
    "steadyChange"
    "compareSteadyChange"
];

table(m, columns)

