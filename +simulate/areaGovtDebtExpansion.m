function [s, smc, m] = areaGovtDebtExpansion(m, area, simrange, size)

if nargin>=3 && strlength(area)>0
    area = area + "_";
else
    area = "";
end

d = steadydb(m, simrange);
m.(area+"ss_dg_to_ngdp") = m.(area+"ss_dg_to_ngdp") + size;
m.(area+"tau_cg") = 5;
m.(area+"tau_trl1") = 0;
p = Plan.forModel(m, simrange);
p = swap(p, simrange(1:2), [area+"trl1", area+"shk_trl1"]);

m = steady(m ...
    , "fixLevel", ["gg_a", "gg_nt", area+"pch"] ...
    , "blocks", false ...
);
checkSteady(m);
m = solve(m);

s = simulate( ...
    m, d, simrange ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
    ... , "solver", {"iris-newton", "skipJacobUpdate", 2} ...
);

smc = databank.minusControl(m, s, d);

end%

