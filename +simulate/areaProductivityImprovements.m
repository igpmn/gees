function [s, smc] = areaProductivityImprovements(m, simrange, area)

d = steadydb(m, simrange);

m.(area+"_ss_ar") = m.(area+"_ss_ar") * 1.10;

m = steady( ...
    m ...
    , "fixLevel", ["gg_a", "gg_nt", "us_pch", "ea_pch", "cn_pch","rw_pch"] ...
    , "blocks", false ...
);

checkSteady(m);
m = solve(m);

p = Plan.forModel(m, simrange);
p = swap(p, simrange(1:3), [area+"_ar", area+"_shk_ar"]);

s = simulate( ...
    m, d, simrange ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
    , "plan", p ...
);

smc = databank.minusControl(m, s, d);

end%

