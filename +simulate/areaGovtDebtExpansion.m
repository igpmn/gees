function [s, smc, m] = governmentDebtExpansion(m, area, size)

if nargin>=2 && strlength(area)>0
    area = area + "_";
else
    area = "";
end

T = 20;

d = steadydb(m, 1:T);
m.(area+"ss_dg_to_ngdp") = m.(area+"ss_dg_to_ngdp") + size;
m.(area+"tau_cg") = 5;
m.(area+"tau_trl1") = 0;
p = Plan.forModel(m, 1:T);
p = swap(p, 1:2, [area+"trl1", area+"shk_trl1"]);

m = steady(m ...
    , "fixLevel", ["gg_a", "gg_nt", area+"pch"] ...
    , "blocks", false ...
);
checkSteady(m);
m = solve(m);

s = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "plan", p ...
    ... , "solver", {"iris-newton", "skipJacobUpdate", 2} ...
);

smc = databank.minusControl(m, s, d);

end%

