function [s, smc, m] = areaWAP(m, area, size)

T = 20;
d = steadydb(m, 1:T);

m0 = m;
m.(area+"_ss_nw_to_nn") = m.(area+"_ss_nw_to_nn") - size;
m.(area+"_rho_nw") = 0.5;
m = steady(m);
checkSteady(m);
m = solve(m);

s = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
);

smc = databank.minusControl(m, s, d);

end%

