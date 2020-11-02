function [smc, s] = governmentDebtExpansion(m)

T = 20;

d = steadydb(m, 1:T);
m.ss_dg_to_ngdp = m.ss_dg_to_ngdp + 0.20;
m.tau_cg = 5;
m.tau_txl1 = 0;
p = Plan.forModel(m, 1:T);
p = swap(p, 1:2, ["txl1", "shk_txl1"]);

m = steady(m ...
    , "fixLevel", ["a", "nn", "pch"] ...
);
checkSteady(m);
m = solve(m);

s = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
    , "plan", p ...
);

smc = databank.minusControl(m, s, d);

end%

