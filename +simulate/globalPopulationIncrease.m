function [s, smc] = globalPopulationIncrease(m,simrange,anticipate)

d = steadydb(m, simrange);
d.gg_shk_nn(simrange(4)) = ((1-anticipate)*1i + anticipate)*log(1.05);

s = simulate( ...
    m, d, simrange ...
    , "prependInput", true ...
    , "method", "stacked" ...
    , "blocks", false ...
);

smc = databank.minusControl(m, s, d);

end%

