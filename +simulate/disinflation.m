
close all
clear

load mat/createModel.mat m

T = 10;

d = steadydb(m, 1:T);

m.ss_roc_pch = m.ss_roc_pch - 0.01;

m = steady( ...
    m ...
    , "fixLevel", ["y", "nn", "pch", "ss_dg_to_ngdp"] ...
    , "blocks", false ...
);

checkSteady(m);
m = solve(m);

s = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

tiledlayout flow
nexttile
plot(cumsum(100*(s.ch/d.ch-1)));

nexttile
plot(cumsum(100*(s.ih/d.ih-1)));

nexttile
plot(100*(s.roc_pch-1));

nexttile
plot(100*(s.r-1), "marker", "s");

