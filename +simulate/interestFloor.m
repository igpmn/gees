function [s, smc] = interestFloor(m)

T = 20;

d = steadydb(m, 1:T);

d.gg_shk_a(4) = log(0.80);

s = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
    , "solver", {"iris-newton", "skipJacobUpdate", 0} ...
);

smc = databank.minusControl(m, s, d);

end%

