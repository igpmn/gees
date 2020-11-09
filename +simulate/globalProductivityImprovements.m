function [s, smc] = globalProductivityImprovements(m)

T = 20;

d = steadydb(m, 1:T, "numColumns", 2);
d.gg_shk_a(4) = [log(1.10), 1i*log(1.10)];

s = simulate( ...
    m, d, 1:T ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
);

smc = databank.minusControl(m, s, d);

end%

