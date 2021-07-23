function [s, smc, m1] = areaDisinflation(m, area, size, range)

area = utils.resolveArea(area, "prefix");
name = area + "ss_roc_pc";

checkSteady(m);
m = solve(m);

m1 = m;
m1.(name) = m1.(name) - size;
m1 = steady( ...
    m1 ...
   ...  , "fixLevel", ["gg_a", "gg_a", "gg_nt"] ...
    , "blocks", false ...
);
checkSteady(m1);
m1 = solve(m1);

d = steadydb(m, range);
s = simulate( ...
    m1, d, range ...
    , "method", "stacked" ...
    , "prependInput", true ...
);

smc = databank.minusControl(m, s, "range", range);

end%

